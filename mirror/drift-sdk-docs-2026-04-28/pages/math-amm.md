# AMM Calculations - Drift Protocol v2

Source: https://mintlify.com/drift-labs/protocol-v2/math/amm

# AMM Calculations

> Automated Market Maker formulas and calculations in Drift Protocol v2

## Overview

Drift Protocol v2 uses a virtual Automated Market Maker (vAMM) with a constant product formula to determine prices and execute trades. The AMM maintains reserves of base and quote assets that determine the market price.

## Core AMM Formula

The AMM follows the constant product invariant:

```
k = baseAssetReserve × quoteAssetReserve

```

Where `k` (stored as `sqrtK`) remains constant during swaps (before accounting for fees and funding).

## Price Calculation

The mark price is calculated from the AMM reserves:

```typescript
/**
 * Calculate price from AMM reserves
 * 
 * @param baseAssetReserves - Base asset reserve (AMM_RESERVE_PRECISION: 10^9)
 * @param quoteAssetReserves - Quote asset reserve (AMM_RESERVE_PRECISION: 10^9) 
 * @param pegMultiplier - Peg multiplier (PEG_PRECISION: 10^6)
 * @returns price - Price with PRICE_PRECISION (10^6)
 */
export function calculatePrice(
  baseAssetReserves: BN,
  quoteAssetReserves: BN,
  pegMultiplier: BN
): BN {
  if (baseAssetReserves.abs().lte(ZERO)) {
    return new BN(0);
  }

  return quoteAssetReserves
    .mul(PRICE_PRECISION)
    .mul(pegMultiplier)
    .div(PEG_PRECISION)
    .div(baseAssetReserves);
}

```

### Formula

```
Price = (quoteAssetReserve × pegMultiplier × PRICE_PRECISION) / (baseAssetReserve × PEG_PRECISION)

```

### Example

```typescript
import { calculatePrice, PRICE_PRECISION, convertToNumber } from '@drift-labs/sdk';

const baseReserve = new BN(500_000_000_000);  // 500 SOL (in 10^9)
const quoteReserve = new BN(50_000_000_000_000); // 50,000 USDC (in 10^9)
const peg = new BN(1_000_000); // 1.0 (in 10^6)

const priceBN = calculatePrice(baseReserve, quoteReserve, peg);
const price = convertToNumber(priceBN, PRICE_PRECISION);
// Result: 100.0 (50,000 / 500 = $100 per SOL)

```

## Bid-Ask Price Calculation

The AMM applies spreads to quote bid and ask prices:

```typescript
import { calculateBidAskPrice } from '@drift-labs/sdk';

const market = driftClient.getPerpMarketAccount(marketIndex);
const oracleData = driftClient.getOracleDataForPerpMarket(marketIndex);

const [bidPrice, askPrice] = calculateBidAskPrice(
  market.amm,
  oracleData,
  true  // withUpdate - update AMM to current oracle price
);

```

The function:

1. Updates AMM reserves based on oracle price (if `withUpdate = true`)
2. Calculates spread based on volatility, inventory, and market conditions
3. Applies spread to get bid/ask reserves
4. Calculates prices from bid/ask reserves

## Reserve Updates After Swap

When a trade occurs, the AMM reserves change according to the constant product formula:

```typescript
/**
 * Calculate AMM reserves after a swap
 * 
 * @param amm - AMM state
 * @param inputAssetType - 'quote' or 'base'
 * @param swapAmount - Amount to swap (in respective PRECISION)
 * @param swapDirection - SwapDirection.ADD or SwapDirection.REMOVE
 * @returns [newQuoteAssetReserve, newBaseAssetReserve]
 */
export function calculateAmmReservesAfterSwap(
  amm: Pick<AMM, 'pegMultiplier' | 'quoteAssetReserve' | 'sqrtK' | 'baseAssetReserve'>,
  inputAssetType: AssetType,
  swapAmount: BN,
  swapDirection: SwapDirection
): [BN, BN] {
  let newQuoteAssetReserve;
  let newBaseAssetReserve;

  if (inputAssetType === 'quote') {
    swapAmount = swapAmount
      .mul(AMM_TIMES_PEG_TO_QUOTE_PRECISION_RATIO)
      .div(amm.pegMultiplier);

    [newQuoteAssetReserve, newBaseAssetReserve] = calculateSwapOutput(
      amm.quoteAssetReserve,
      swapAmount,
      swapDirection,
      amm.sqrtK.mul(amm.sqrtK)
    );
  } else {
    [newBaseAssetReserve, newQuoteAssetReserve] = calculateSwapOutput(
      amm.baseAssetReserve,
      swapAmount,
      swapDirection,
      amm.sqrtK.mul(amm.sqrtK)
    );
  }

  return [newQuoteAssetReserve, newBaseAssetReserve];
}

```

### Swap Output Formula

```typescript
export function calculateSwapOutput(
  inputAssetReserve: BN,
  swapAmount: BN,
  swapDirection: SwapDirection,
  invariant: BN
): [BN, BN] {
  let newInputAssetReserve;
  if (swapDirection === SwapDirection.ADD) {
    newInputAssetReserve = inputAssetReserve.add(swapAmount);
  } else {
    newInputAssetReserve = inputAssetReserve.sub(swapAmount);
  }
  const newOutputAssetReserve = invariant.div(newInputAssetReserve);
  return [newInputAssetReserve, newOutputAssetReserve];
}

```

### Example: Calculating Trade Impact

```typescript
import { 
  calculateAmmReservesAfterSwap,
  calculatePrice,
  getSwapDirection,
  PositionDirection,
  SwapDirection,
  BASE_PRECISION,
  PRICE_PRECISION,
  convertToNumber
} from '@drift-labs/sdk';

const market = driftClient.getPerpMarketAccount(0);
const tradeSize = new BN(10).mul(BASE_PRECISION); // 10 SOL

// Going long (buying base)
const direction = PositionDirection.LONG;
const swapDir = getSwapDirection('base', direction);

// Calculate new reserves
const [newQuoteReserve, newBaseReserve] = calculateAmmReservesAfterSwap(
  market.amm,
  'base',
  tradeSize,
  swapDir
);

// Calculate new price after trade
const newPrice = calculatePrice(
  newBaseReserve,
  newQuoteReserve,
  market.amm.pegMultiplier
);

const priceDecimal = convertToNumber(newPrice, PRICE_PRECISION);
console.log(`Price after 10 SOL buy: $${priceDecimal}`);

```

## Spread Calculation

The AMM calculates dynamic spreads based on multiple factors:

```typescript
export function calculateSpread(
  amm: AMM,
  oraclePriceData: OraclePriceData,
  now?: BN,
  reservePrice?: BN
): [number, number] {
  if (amm.baseSpread == 0 || amm.curveUpdateIntensity == 0) {
    return [amm.baseSpread / 2, amm.baseSpread / 2];
  }

  const reservePrice = calculatePrice(
    amm.baseAssetReserve,
    amm.quoteAssetReserve,
    amm.pegMultiplier
  );

  const targetPrice = oraclePriceData?.price || reservePrice;
  const targetMarkSpreadPct = reservePrice
    .sub(targetPrice)
    .mul(BID_ASK_SPREAD_PRECISION)
    .div(reservePrice);

  const confIntervalPct = getNewOracleConfPct(
    amm,
    oraclePriceData,
    reservePrice,
    now
  );

  const [longSpread, shortSpread] = calculateSpreadBN(
    amm.baseSpread,
    targetMarkSpreadPct,
    confIntervalPct,
    amm.maxSpread,
    // ... more parameters
  );

  return [longSpread, shortSpread];
}

```

### Spread Components

1. Base Spread - Minimum spread set by the market
2. Volatility Spread - Based on oracle confidence and market standard deviation
3. Inventory Spread - Scales with AMM's inventory imbalance
4. Effective Leverage Spread - Increases with AMM's leverage
5. Revenue Retreat - Additional spread when AMM has losses

## Inventory Scale

The AMM adjusts spreads based on inventory imbalance:

```typescript
export function calculateInventoryScale(
  baseAssetAmountWithAmm: BN,
  baseAssetReserve: BN,
  minBaseAssetReserve: BN,
  maxBaseAssetReserve: BN,
  directionalSpread: number,
  maxSpread: number
): number {
  if (baseAssetAmountWithAmm.eq(ZERO)) {
    return 1;
  }

  const inventoryScaleBN = calculateInventoryLiquidityRatio(
    baseAssetAmountWithAmm,
    baseAssetReserve,
    minBaseAssetReserve,
    maxBaseAssetReserve
  );

  const inventoryScaleMaxBN = BN.max(
    MAX_BID_ASK_INVENTORY_SKEW_FACTOR,
    new BN(maxSpread)
      .mul(BID_ASK_SPREAD_PRECISION)
      .div(new BN(Math.max(directionalSpread, 1)))
  );

  const inventoryScaleCapped = BN.min(
    inventoryScaleMaxBN,
    BID_ASK_SPREAD_PRECISION.add(
      inventoryScaleMaxBN.mul(inventoryScaleBN).div(PERCENTAGE_PRECISION)
    )
  ).toNumber() / BID_ASK_SPREAD_PRECISION.toNumber();

  return inventoryScaleCapped;
}

```

## Reference Price Offset

For markets with high liquidity intensity, the AMM applies a reference price offset:

```typescript
export function calculateReferencePriceOffset(
  reservePrice: BN,
  last24hAvgFundingRate: BN,
  liquidityFraction: BN,
  oracleTwapFast: BN,
  markTwapFast: BN,
  oracleTwapSlow: BN,
  markTwapSlow: BN,
  maxOffsetPct: number
): BN {
  if (last24hAvgFundingRate.eq(ZERO) || liquidityFraction.eq(ZERO)) {
    return ZERO;
  }

  const maxOffsetInPrice = new BN(maxOffsetPct)
    .mul(reservePrice)
    .div(PERCENTAGE_PRECISION);

  // Calculate premiums from different time periods
  const markPremiumMinute = clampBN(
    markTwapFast.sub(oracleTwapFast),
    maxOffsetInPrice.mul(new BN(-1)),
    maxOffsetInPrice
  );

  const markPremiumHour = clampBN(
    markTwapSlow.sub(oracleTwapSlow),
    maxOffsetInPrice.mul(new BN(-1)),
    maxOffsetInPrice
  );

  const markPremiumDay = clampBN(
    last24hAvgFundingRate.div(FUNDING_RATE_BUFFER_PRECISION).mul(new BN(24)),
    maxOffsetInPrice.mul(new BN(-1)),
    maxOffsetInPrice
  );

  // Average the premiums
  const markPremiumAvg = markPremiumMinute
    .add(markPremiumHour)
    .add(markPremiumDay)
    .div(new BN(3));

  const markPremiumAvgPct = markPremiumAvg
    .mul(PRICE_PRECISION)
    .div(reservePrice);

  // Only apply when inventory is consistent with premium
  let offsetPct = markPremiumAvgPct.mul(liquidityFraction.abs()).divn(2);

  if (!sigNum(liquidityFraction).eq(sigNum(markPremiumAvgPct))) {
    offsetPct = ZERO;
  }

  return clampBN(offsetPct, new BN(-maxOffsetPct), new BN(maxOffsetPct));
}

```

## Terminal Price

The terminal price is the price at which the AMM's inventory would be fully closed:

```typescript
export function calculateTerminalPrice(market: PerpMarketAccount): BN {
  const directionToClose = market.amm.baseAssetAmountWithAmm.gt(ZERO)
    ? PositionDirection.SHORT
    : PositionDirection.LONG;

  const [newQuoteAssetReserve, newBaseAssetReserve] = 
    calculateAmmReservesAfterSwap(
      market.amm,
      'base',
      market.amm.baseAssetAmountWithAmm.abs(),
      getSwapDirection('base', directionToClose)
    );

  const terminalPrice = newQuoteAssetReserve
    .mul(PRICE_PRECISION)
    .mul(market.amm.pegMultiplier)
    .div(PEG_PRECISION)
    .div(newBaseAssetReserve);

  return terminalPrice;
}

```

## Peg Adjustment

The AMM can adjust its peg multiplier to keep the mark price close to the oracle price:

```typescript
export function calculatePegFromTargetPrice(
  targetPrice: BN,
  baseAssetReserve: BN,
  quoteAssetReserve: BN
): BN {
  return BN.max(
    targetPrice
      .mul(baseAssetReserve)
      .div(quoteAssetReserve)
      .add(PRICE_DIV_PEG.div(new BN(2)))
      .div(PRICE_DIV_PEG),
    ONE
  );
}

```

## Practical Examples

### Get Current Market Price

```typescript
import { calculatePrice, convertToNumber, PRICE_PRECISION } from '@drift-labs/sdk';

const market = driftClient.getPerpMarketAccount(0);
const priceBN = calculatePrice(
  market.amm.baseAssetReserve,
  market.amm.quoteAssetReserve,
  market.amm.pegMultiplier
);

const price = convertToNumber(priceBN, PRICE_PRECISION);
console.log(`Mark price: $${price}`);

```

### Calculate Slippage

```typescript
import { 
  calculateAmmReservesAfterSwap,
  calculatePrice,
  BASE_PRECISION,
  PRICE_PRECISION,
  convertToNumber
} from '@drift-labs/sdk';

const market = driftClient.getPerpMarketAccount(0);
const tradeSize = new BN(100).mul(BASE_PRECISION); // 100 SOL

// Current price
const currentPrice = calculatePrice(
  market.amm.baseAssetReserve,
  market.amm.quoteAssetReserve,
  market.amm.pegMultiplier
);

// Price after trade
const [newQuoteReserve, newBaseReserve] = calculateAmmReservesAfterSwap(
  market.amm,
  'base',
  tradeSize,
  SwapDirection.REMOVE // buying base, removing from reserve
);

const newPrice = calculatePrice(
  newBaseReserve,
  newQuoteReserve,
  market.amm.pegMultiplier
);

const slippage = convertToNumber(
  newPrice.sub(currentPrice).mul(new BN(10000)).div(currentPrice),
  new BN(100)
);
console.log(`Slippage: ${slippage}%`);

```

## Related

- Precision Handling
- PnL Calculations
- Funding Rate Calculations
