# Margin Calculations - Drift Protocol v2

Source: https://mintlify.com/drift-labs/protocol-v2/math/margin-calculations

# Margin Calculations

> Margin requirement formulas and leverage calculations in Drift Protocol v2

## Overview

Drift Protocol uses a cross-margined system where all collateral is shared across positions. Margin requirements are calculated based on position size, asset volatility, and market conditions.

## Margin Types

- Initial Margin - Required to open a new position
- Maintenance Margin - Minimum margin to keep position open
- Free Collateral - Available collateral for new positions

## Initial Margin Calculation

The margin required to open a trade is calculated based on the position's notional value:

```typescript
/**
 * Calculate margin required for a trade in USDC
 * 
 * @param driftClient - DriftClient instance
 * @param targetMarketIndex - Market index
 * @param baseSize - Position size (BASE_PRECISION: 10^9)
 * @param userMaxMarginRatio - Optional user max margin ratio override
 * @param userHighLeverageMode - Whether user has high leverage mode enabled
 * @param entryPrice - Optional entry price override
 * @returns Margin required (QUOTE_PRECISION: 10^6)
 */
export function calculateMarginUSDCRequiredForTrade(
  driftClient: DriftClient,
  targetMarketIndex: number,
  baseSize: BN,
  userMaxMarginRatio?: number,
  userHighLeverageMode?: boolean,
  entryPrice?: BN
): BN {
  const targetMarket = driftClient.getPerpMarketAccount(targetMarketIndex);

  const price = entryPrice ?? 
    driftClient.getOracleDataForPerpMarket(targetMarket.marketIndex).price;

  const perpLiabilityValue = calculatePerpLiabilityValue(
    baseSize,
    price,
    isVariant(targetMarket.contractType, 'prediction')
  );

  const marginRequired = new BN(
    calculateMarketMarginRatio(
      targetMarket,
      baseSize.abs(),
      'Initial',
      userMaxMarginRatio,
      userHighLeverageMode
    )
  )
    .mul(perpLiabilityValue)
    .div(MARGIN_PRECISION);

  return marginRequired;
}

```

### Formula

```
marginRequired = (marginRatio × liabilityValue) / MARGIN_PRECISION

where:
  liabilityValue = |baseAssetAmount| × price / BASE_PRECISION
  MARGIN_PRECISION = 10,000

```

### Example

```typescript
import { 
  calculateMarginUSDCRequiredForTrade,
  BASE_PRECISION,
  QUOTE_PRECISION,
  convertToNumber
} from '@drift-labs/sdk';

const driftClient = /* initialized DriftClient */;
const marketIndex = 0; // SOL-PERP
const positionSize = new BN(10).mul(BASE_PRECISION); // 10 SOL

// Calculate margin required
const marginBN = calculateMarginUSDCRequiredForTrade(
  driftClient,
  marketIndex,
  positionSize
);

const marginUSD = convertToNumber(marginBN, QUOTE_PRECISION);
console.log(`Margin required: $${marginUSD}`);

```

## Liability Value Calculation

For standard perpetuals:

```typescript
export function calculatePerpLiabilityValue(
  baseAssetAmount: BN,
  price: BN,
  isPredictionMarket: boolean
): BN {
  if (isPredictionMarket) {
    if (baseAssetAmount.gt(ZERO)) {
      return baseAssetAmount.mul(price).div(BASE_PRECISION);
    } else {
      return baseAssetAmount
        .abs()
        .mul(MAX_PREDICTION_PRICE.sub(price))
        .div(BASE_PRECISION);
    }
  } else {
    return baseAssetAmount.abs().mul(price).div(BASE_PRECISION);
  }
}

```

For prediction markets, short positions have different liability calculations based on the max price.

## Oracle Price for Margin

Margin calculations use conservative oracle prices with offsets:

```typescript
export function calculateOraclePriceForPerpMargin(
  perpPosition: PerpPosition,
  market: PerpMarketAccount,
  oraclePriceData: OraclePriceData
): BN {
  const oraclePriceOffset = BN.min(
    new BN(market.amm.maxSpread)
      .mul(oraclePriceData.price)
      .div(BID_ASK_SPREAD_PRECISION),
    oraclePriceData.confidence.add(
      new BN(market.amm.baseSpread)
        .mul(oraclePriceData.price)
        .div(BID_ASK_SPREAD_PRECISION)
    )
  );

  let marginPrice: BN;
  if (perpPosition.baseAssetAmount.gt(ZERO)) {
    // Long position: use lower price (more conservative)
    marginPrice = oraclePriceData.price.sub(oraclePriceOffset);
  } else {
    // Short position: use higher price (more conservative)
    marginPrice = oraclePriceData.price.add(oraclePriceOffset);
  }

  return marginPrice;
}

```

## Size-Based IMF Adjustments

Margin requirements scale with position size using the Initial Margin Fraction (IMF):

### Liability Weight (for shorts/liabilities)

```typescript
export function calculateSizePremiumLiabilityWeight(
  size: BN,
  imfFactor: BN,
  liabilityWeight: BN,
  precision: BN,
  isBounded = true
): BN {
  if (imfFactor.eq(ZERO)) {
    return liabilityWeight;
  }

  const sizeSqrt = squareRootBN(size.abs().mul(new BN(10)).add(new BN(1)));

  const liabilityWeightNumerator = liabilityWeight.sub(
    liabilityWeight.div(new BN(5))
  );

  const denom = new BN(100_000).mul(SPOT_MARKET_IMF_PRECISION).div(precision);

  const sizePremiumLiabilityWeight = liabilityWeightNumerator.add(
    sizeSqrt
      .mul(imfFactor)
      .div(denom)
  );

  let maxLiabilityWeight;
  if (isBounded) {
    maxLiabilityWeight = BN.max(liabilityWeight, sizePremiumLiabilityWeight);
  } else {
    maxLiabilityWeight = sizePremiumLiabilityWeight;
  }

  return maxLiabilityWeight;
}

```

### Asset Weight (for longs/assets)

```typescript
export function calculateSizeDiscountAssetWeight(
  size: BN,
  imfFactor: BN,
  assetWeight: BN
): BN {
  if (imfFactor.eq(ZERO)) {
    return assetWeight;
  }

  const sizeSqrt = squareRootBN(size.abs().mul(new BN(10)).add(new BN(1)));
  const imfNumerator = SPOT_MARKET_IMF_PRECISION.add(
    SPOT_MARKET_IMF_PRECISION.div(new BN(10))
  );

  const sizeDiscountAssetWeight = imfNumerator
    .mul(SPOT_MARKET_WEIGHT_PRECISION)
    .div(
      SPOT_MARKET_IMF_PRECISION.add(
        sizeSqrt
          .mul(imfFactor)
          .div(new BN(100_000))
      )
    );

  const minAssetWeight = BN.min(assetWeight, sizeDiscountAssetWeight);

  return minAssetWeight;
}

```

Larger positions require more margin due to:

- Increased liquidation risk
- Greater market impact
- Reduced liquidity for larger sizes

## Collateral Requirements

Calculate how much collateral is needed for a trade:

```typescript
export function calculateCollateralDepositRequiredForTrade(
  driftClient: DriftClient,
  targetMarketIndex: number,
  baseSize: BN,
  collateralIndex: number,
  userMaxMarginRatio?: number,
  userHighLeverageMode?: boolean,
  estEntryPrice?: BN
): BN {
  const marginRequiredUsdc = calculateMarginUSDCRequiredForTrade(
    driftClient,
    targetMarketIndex,
    baseSize,
    userMaxMarginRatio,
    userHighLeverageMode,
    estEntryPrice
  );

  const collateralMarket = driftClient.getSpotMarketAccount(collateralIndex);
  const collateralOracleData = 
    driftClient.getOracleDataForSpotMarket(collateralIndex);

  const scaledAssetWeight = calculateScaledInitialAssetWeight(
    collateralMarket,
    collateralOracleData.price
  );

  // baseAmountRequired = (marginRequiredUsdc / priceOfAsset) / assetWeight
  const baseAmountRequired = driftClient
    .convertToSpotPrecision(collateralIndex, marginRequiredUsdc)
    .mul(PRICE_PRECISION)
    .mul(SPOT_MARKET_WEIGHT_PRECISION)
    .div(collateralOracleData.price)
    .div(scaledAssetWeight)
    .div(QUOTE_PRECISION);

  return baseAmountRequired;
}

```

### Example: Calculate SOL Collateral Needed

```typescript
import { 
  calculateCollateralDepositRequiredForTrade,
  BASE_PRECISION,
  convertToNumber
} from '@drift-labs/sdk';

const driftClient = /* initialized DriftClient */;
const perpMarketIndex = 0;  // SOL-PERP
const spotMarketIndex = 1;  // SOL spot market
const positionSize = new BN(10).mul(BASE_PRECISION); // 10 SOL position

// How much SOL collateral needed?
const solNeededBN = calculateCollateralDepositRequiredForTrade(
  driftClient,
  perpMarketIndex,
  positionSize,
  spotMarketIndex
);

const solNeeded = convertToNumber(solNeededBN, BASE_PRECISION);
console.log(`SOL collateral needed: ${solNeeded} SOL`);

```

## Liquidation Price

Calculate the price at which a position would be liquidated:

```typescript
export function calculateLiquidationPrice(
  freeCollateral: BN,
  freeCollateralDelta: BN,
  oraclePrice: BN
): BN {
  const liqPriceDelta = freeCollateral
    .mul(QUOTE_PRECISION)
    .div(freeCollateralDelta);

  const liqPrice = oraclePrice.sub(liqPriceDelta);

  if (liqPrice.lt(ZERO)) {
    return new BN(-1);
  }

  return liqPrice;
}

```

### Example

```typescript
import { calculateLiquidationPrice } from '@drift-labs/sdk';

const user = /* User instance */;
const freeCollateral = user.getFreeCollateral();

// Calculate liquidation price for a specific position
const perpPosition = user.getPerpPosition(0); // SOL-PERP
const oraclePrice = driftClient.getOracleDataForPerpMarket(0).price;

// Would need to calculate free collateral delta based on price change
const freeCollateralDelta = /* calculated delta */;

const liqPrice = calculateLiquidationPrice(
  freeCollateral,
  freeCollateralDelta,
  oraclePrice
);

```

## High Leverage Mode

High leverage mode provides lower margin requirements:

```typescript
export function calcHighLeverageModeInitialMarginRatioFromSize(
  preSizeAdjMarginRatio: BN,
  sizeAdjMarginRatio: BN,
  defaultMarginRatio: BN
): BN {
  let result: BN;

  if (sizeAdjMarginRatio.lt(preSizeAdjMarginRatio)) {
    const sizePctDiscountFactor = PERCENTAGE_PRECISION.sub(
      preSizeAdjMarginRatio
        .sub(sizeAdjMarginRatio)
        .mul(PERCENTAGE_PRECISION)
        .div(preSizeAdjMarginRatio.div(new BN(5)))
    );

    const hlmMarginDelta = BN.max(
      preSizeAdjMarginRatio.sub(defaultMarginRatio),
      new BN(1)
    );

    const hlmMarginDeltaProportion = hlmMarginDelta
      .mul(sizePctDiscountFactor)
      .div(PERCENTAGE_PRECISION);

    result = hlmMarginDeltaProportion.add(defaultMarginRatio);
  } else if (sizeAdjMarginRatio.eq(preSizeAdjMarginRatio)) {
    result = defaultMarginRatio;
  } else {
    result = sizeAdjMarginRatio;
  }

  return result;
}

```

High leverage mode increases liquidation risk. Use with caution.

## Worst Case Position

Margin calculations consider open orders (worst case scenario):

```typescript
export function calculateWorstCasePerpLiabilityValue(
  perpPosition: PerpPosition,
  perpMarket: PerpMarketAccount,
  oraclePrice: BN,
  includeOpenOrders: boolean = true
): { worstCaseBaseAssetAmount: BN; worstCaseLiabilityValue: BN } {
  const isPredictionMarket = isVariant(perpMarket.contractType, 'prediction');
  
  if (!includeOpenOrders) {
    return {
      worstCaseBaseAssetAmount: perpPosition.baseAssetAmount,
      worstCaseLiabilityValue: calculatePerpLiabilityValue(
        perpPosition.baseAssetAmount,
        oraclePrice,
        isPredictionMarket
      ),
    };
  }
  
  const allBids = perpPosition.baseAssetAmount.add(perpPosition.openBids);
  const allAsks = perpPosition.baseAssetAmount.add(perpPosition.openAsks);

  const allBidsLiabilityValue = calculatePerpLiabilityValue(
    allBids,
    oraclePrice,
    isPredictionMarket
  );
  const allAsksLiabilityValue = calculatePerpLiabilityValue(
    allAsks,
    oraclePrice,
    isPredictionMarket
  );

  if (allAsksLiabilityValue.gte(allBidsLiabilityValue)) {
    return {
      worstCaseBaseAssetAmount: allAsks,
      worstCaseLiabilityValue: allAsksLiabilityValue,
    };
  } else {
    return {
      worstCaseBaseAssetAmount: allBids,
      worstCaseLiabilityValue: allBidsLiabilityValue,
    };
  }
}

```

## Practical Examples

### Check if User Can Open Position

```typescript
import { 
  calculateMarginUSDCRequiredForTrade,
  BASE_PRECISION,
  QUOTE_PRECISION,
  convertToNumber
} from '@drift-labs/sdk';

const user = /* User instance */;
const marketIndex = 0;
const desiredSize = new BN(5).mul(BASE_PRECISION); // 5 SOL

// Get user's free collateral
const freeCollateral = user.getFreeCollateral();
const freeCollateralNum = convertToNumber(freeCollateral, QUOTE_PRECISION);

// Calculate required margin
const requiredMargin = calculateMarginUSDCRequiredForTrade(
  driftClient,
  marketIndex,
  desiredSize
);
const requiredMarginNum = convertToNumber(requiredMargin, QUOTE_PRECISION);

if (freeCollateralNum >= requiredMarginNum) {
  console.log('Can open position');
  console.log(`Required: $${requiredMarginNum}`);
  console.log(`Available: $${freeCollateralNum}`);
} else {
  console.log('Insufficient collateral');
  console.log(`Need $${requiredMarginNum - freeCollateralNum} more`);
}

```

### Calculate Maximum Position Size

```typescript
import { User } from '@drift-labs/sdk';

const user = new User({
  driftClient,
  userAccountPublicKey: await driftClient.getUserAccountPublicKey(),
});

await user.subscribe();

const marketIndex = 0; // SOL-PERP
const direction = PositionDirection.LONG;

const { tradeSize } = user.getMaxTradeSizeUSDCForPerp(marketIndex, direction);

const maxSize = convertToNumber(tradeSize, BASE_PRECISION);
console.log(`Max position size: ${maxSize} SOL`);

```

## Related

- Precision Handling
- PnL Calculations
- AMM Calculations
