# PnL Calculations - Drift Protocol v2

Source: https://mintlify.com/drift-labs/protocol-v2/math/pnl

# PnL Calculations

> Profit and Loss calculation formulas for positions in Drift Protocol v2

## Overview

Drift Protocol calculates Profit and Loss (PnL) for perpetual positions based on the difference between entry and exit prices, including funding payments and fees.

## Position PnL Formula

The basic PnL formula:

```
PnL = baseAssetAmount × (exitPrice - entryPrice) + quoteAssetAmount

```

Where:

- `baseAssetAmount` - Position size (positive for long, negative for short)
- `exitPrice` - Current market price or oracle price
- `entryPrice` - Average entry price
- `quoteAssetAmount` - Accumulated quote changes from trades

## Calculating Position PnL

```typescript
/**
 * Calculate position PnL including optional funding payments
 * 
 * @param market - PerpMarketAccount
 * @param perpPosition - User's perp position
 * @param withFunding - Include unsettled funding payment in PnL
 * @param oraclePriceData - Oracle price data
 * @returns PnL in QUOTE_PRECISION (10^6)
 */
export function calculatePositionPNL(
  market: PerpMarketAccount,
  perpPosition: PerpPosition,
  withFunding = false,
  oraclePriceData: Pick<OraclePriceData, 'price'>
): BN {
  if (perpPosition.baseAssetAmount.eq(ZERO)) {
    return perpPosition.quoteAssetAmount;
  }

  const baseAssetValue = calculateBaseAssetValueWithOracle(
    market,
    perpPosition,
    oraclePriceData
  );

  const baseAssetValueSign = perpPosition.baseAssetAmount.isNeg()
    ? new BN(-1)
    : new BN(1);
  
  let pnl = baseAssetValue
    .mul(baseAssetValueSign)
    .add(perpPosition.quoteAssetAmount);

  if (withFunding) {
    const fundingRatePnL = calculateUnsettledFundingPnl(market, perpPosition);
    pnl = pnl.add(fundingRatePnL);
  }

  return pnl;
}

```

### Example

```typescript
import { 
  calculatePositionPNL,
  QUOTE_PRECISION,
  convertToNumber
} from '@drift-labs/sdk';

const user = /* User instance */;
const position = user.getPerpPosition(0); // SOL-PERP
const market = driftClient.getPerpMarketAccount(0);
const oracleData = driftClient.getOracleDataForPerpMarket(0);

// Calculate PnL without funding
const pnlBN = calculatePositionPNL(market, position, false, oracleData);
const pnl = convertToNumber(pnlBN, QUOTE_PRECISION);
console.log(`PnL: $${pnl}`);

// Calculate PnL with funding
const pnlWithFundingBN = calculatePositionPNL(market, position, true, oracleData);
const pnlWithFunding = convertToNumber(pnlWithFundingBN, QUOTE_PRECISION);
console.log(`PnL with funding: $${pnlWithFunding}`);

```

## Base Asset Value

Calculate the value of the base asset amount at current prices:

```typescript
export function calculateBaseAssetValue(
  market: PerpMarketAccount,
  userPosition: PerpPosition,
  mmOraclePriceData: MMOraclePriceData,
  useSpread = true,
  skipUpdate = false,
  latestSlot?: BN
): BN {
  if (userPosition.baseAssetAmount.eq(ZERO)) {
    return ZERO;
  }

  const directionToClose = findDirectionToClose(userPosition);
  let prepegAmm: Parameters<typeof calculateAmmReservesAfterSwap>[0];

  if (!skipUpdate) {
    if (market.amm.baseSpread > 0 && useSpread) {
      const { baseAssetReserve, quoteAssetReserve, sqrtK, newPeg } =
        calculateUpdatedAMMSpreadReserves(
          market.amm,
          directionToClose,
          mmOraclePriceData,
          undefined,
          latestSlot
        );
      prepegAmm = {
        baseAssetReserve,
        quoteAssetReserve,
        sqrtK: sqrtK,
        pegMultiplier: newPeg,
      };
    } else {
      prepegAmm = calculateUpdatedAMM(market.amm, mmOraclePriceData);
    }
  } else {
    prepegAmm = market.amm;
  }

  const [newQuoteAssetReserve, _] = calculateAmmReservesAfterSwap(
    prepegAmm,
    'base',
    userPosition.baseAssetAmount.abs(),
    getSwapDirection('base', directionToClose)
  );

  switch (directionToClose) {
    case PositionDirection.SHORT:
      return prepegAmm.quoteAssetReserve
        .sub(newQuoteAssetReserve)
        .mul(prepegAmm.pegMultiplier)
        .div(AMM_TIMES_PEG_TO_QUOTE_PRECISION_RATIO);

    case PositionDirection.LONG:
      return newQuoteAssetReserve
        .sub(prepegAmm.quoteAssetReserve)
        .mul(prepegAmm.pegMultiplier)
        .div(AMM_TIMES_PEG_TO_QUOTE_PRECISION_RATIO)
        .add(ONE);
  }
}

```

Base asset value represents the market value of closing the entire position at current AMM prices.

## Oracle-Based Asset Value

Simpler calculation using oracle price directly:

```typescript
export function calculateBaseAssetValueWithOracle(
  market: PerpMarketAccount,
  perpPosition: PerpPosition,
  oraclePriceData: Pick<OraclePriceData, 'price'>,
  includeOpenOrders = false
): BN {
  let price = oraclePriceData.price;
  if (isVariant(market.status, 'settlement')) {
    price = market.expiryPrice;
  }

  const baseAssetAmount = includeOpenOrders
    ? calculateWorstCaseBaseAssetAmount(
        perpPosition,
        market,
        oraclePriceData.price
      )
    : perpPosition.baseAssetAmount;

  return baseAssetAmount.abs().mul(price).div(AMM_RESERVE_PRECISION);
}

```

## Funding PnL

Funding payments are settled periodically between longs and shorts:

```typescript
/**
 * Calculate unsettled funding payment PnL
 * 
 * @param market - PerpMarketAccount  
 * @param perpPosition - User's perp position
 * @returns Unsettled funding PnL in QUOTE_PRECISION (10^6)
 */
export function calculateUnsettledFundingPnl(
  market: PerpMarketAccount,
  perpPosition: PerpPosition
): BN {
  if (perpPosition.baseAssetAmount.eq(ZERO)) {
    return ZERO;
  }

  let ammCumulativeFundingRate: BN;
  if (perpPosition.baseAssetAmount.gt(ZERO)) {
    ammCumulativeFundingRate = market.amm.cumulativeFundingRateLong;
  } else {
    ammCumulativeFundingRate = market.amm.cumulativeFundingRateShort;
  }

  const perPositionFundingRate = ammCumulativeFundingRate
    .sub(perpPosition.lastCumulativeFundingRate)
    .mul(perpPosition.baseAssetAmount)
    .div(AMM_RESERVE_PRECISION)
    .div(FUNDING_RATE_BUFFER_PRECISION)
    .mul(new BN(-1));

  return perPositionFundingRate;
}

```

### Formula

```
fundingPnL = -(cumulativeFundingRate - lastCumulativeFundingRate) × baseAssetAmount / (AMM_RESERVE_PRECISION × FUNDING_RATE_BUFFER_PRECISION)

```

### Example

```typescript
import { 
  calculateUnsettledFundingPnl,
  QUOTE_PRECISION,
  convertToNumber
} from '@drift-labs/sdk';

const position = user.getPerpPosition(0);
const market = driftClient.getPerpMarketAccount(0);

const fundingPnlBN = calculateUnsettledFundingPnl(market, position);
const fundingPnl = convertToNumber(fundingPnlBN, QUOTE_PRECISION);

if (fundingPnl > 0) {
  console.log(`Receiving $${fundingPnl} in funding`);
} else {
  console.log(`Paying $${Math.abs(fundingPnl)} in funding`);
}

```

## Fees and Funding Combined

Get total fees and funding for a position:

```typescript
/**
 * Calculate total fees and funding PnL
 * 
 * @param market - PerpMarketAccount
 * @param perpPosition - User's perp position  
 * @param includeUnsettled - Include unsettled funding (default: true)
 * @returns Total fees and funding in QUOTE_PRECISION (10^6)
 */
export function calculateFeesAndFundingPnl(
  market: PerpMarketAccount,
  perpPosition: PerpPosition,
  includeUnsettled = true
): BN {
  const settledFundingAndFeesPnl = perpPosition.quoteBreakEvenAmount.sub(
    perpPosition.quoteEntryAmount
  );

  if (!includeUnsettled) {
    return settledFundingAndFeesPnl;
  }

  const unsettledFundingPnl = calculateUnsettledFundingPnl(
    market,
    perpPosition
  );

  return settledFundingAndFeesPnl.add(unsettledFundingPnl);
}

```

## Entry Price

Calculate the average entry price of a position:

```typescript
/**
 * Calculate average entry price
 * 
 * @param userPosition - User's perp position
 * @returns Entry price in PRICE_PRECISION (10^6)
 */
export function calculateEntryPrice(userPosition: PerpPosition): BN {
  if (userPosition.baseAssetAmount.eq(ZERO)) {
    return ZERO;
  }

  return userPosition.quoteEntryAmount
    .mul(PRICE_PRECISION)
    .mul(AMM_TO_QUOTE_PRECISION_RATIO)
    .div(userPosition.baseAssetAmount)
    .abs();
}

```

### Formula

```
entryPrice = |quoteEntryAmount × PRICE_PRECISION × AMM_TO_QUOTE_PRECISION_RATIO / baseAssetAmount|

```

## Break-Even Price

Calculate the break-even price (including fees and funding):

```typescript
/**
 * Calculate break-even price (entry price + fees + funding)
 * 
 * @param userPosition - User's perp position
 * @returns Break-even price in PRICE_PRECISION (10^6)
 */
export function calculateBreakEvenPrice(userPosition: PerpPosition): BN {
  if (userPosition.baseAssetAmount.eq(ZERO)) {
    return ZERO;
  }

  return userPosition.quoteBreakEvenAmount
    .mul(PRICE_PRECISION)
    .mul(AMM_TO_QUOTE_PRECISION_RATIO)
    .div(userPosition.baseAssetAmount)
    .abs();
}

```

### Example

```typescript
import { 
  calculateEntryPrice,
  calculateBreakEvenPrice,
  PRICE_PRECISION,
  convertToNumber
} from '@drift-labs/sdk';

const position = user.getPerpPosition(0);

const entryPrice = convertToNumber(
  calculateEntryPrice(position),
  PRICE_PRECISION
);

const breakEvenPrice = convertToNumber(
  calculateBreakEvenPrice(position),
  PRICE_PRECISION
);

const feesAndFunding = breakEvenPrice - entryPrice;

console.log(`Entry: $${entryPrice}`);
console.log(`Break-even: $${breakEvenPrice}`);
console.log(`Fees + Funding: $${feesAndFunding}`);

```

## Cost Basis

Calculate the current cost basis of a position:

```typescript
/**
 * Calculate cost basis (current quote value per unit of base)
 * 
 * @param userPosition - User's perp position
 * @param includeSettledPnl - Include settled PnL in cost basis
 * @returns Cost basis in PRICE_PRECISION (10^6)
 */
export function calculateCostBasis(
  userPosition: PerpPosition,
  includeSettledPnl = false
): BN {
  if (userPosition.baseAssetAmount.eq(ZERO)) {
    return ZERO;
  }

  return userPosition.quoteAssetAmount
    .add(includeSettledPnl ? userPosition.settledPnl : ZERO)
    .mul(PRICE_PRECISION)
    .mul(AMM_TO_QUOTE_PRECISION_RATIO)
    .div(userPosition.baseAssetAmount)
    .abs();
}

```

## Claimable PnL

Not all unrealized PnL can be immediately settled:

```typescript
export function calculateClaimablePnl(
  market: PerpMarketAccount,
  spotMarket: SpotMarketAccount,
  perpPosition: PerpPosition,
  oraclePriceData: Pick<OraclePriceData, 'price'>
): BN {
  const unrealizedPnl = calculatePositionPNL(
    market,
    perpPosition,
    true,
    oraclePriceData
  );

  let unsettledPnl = unrealizedPnl;
  if (unrealizedPnl.gt(ZERO)) {
    const excessPnlPool = BN.max(
      ZERO,
      calculateNetUserPnlImbalance(market, spotMarket, oracleData).mul(
        new BN(-1)
      )
    );

    const maxPositivePnl = BN.max(
      perpPosition.quoteAssetAmount.sub(perpPosition.quoteEntryAmount),
      ZERO
    ).add(excessPnlPool);

    unsettledPnl = BN.min(maxPositivePnl, unrealizedPnl);
  }
  return unsettledPnl;
}

```

Claimable PnL may be less than unrealized PnL due to the PnL pool mechanism that prevents bank runs.

## Practical Examples

### Complete Position Summary

```typescript
import { 
  calculatePositionPNL,
  calculateEntryPrice,
  calculateBreakEvenPrice,
  calculateFeesAndFundingPnl,
  PRICE_PRECISION,
  QUOTE_PRECISION,
  BASE_PRECISION,
  convertToNumber
} from '@drift-labs/sdk';

const marketIndex = 0; // SOL-PERP
const position = user.getPerpPosition(marketIndex);
const market = driftClient.getPerpMarketAccount(marketIndex);
const oracleData = driftClient.getOracleDataForPerpMarket(marketIndex);

// Position details
const size = convertToNumber(position.baseAssetAmount, BASE_PRECISION);
const currentPrice = convertToNumber(oracleData.price, PRICE_PRECISION);
const entryPrice = convertToNumber(calculateEntryPrice(position), PRICE_PRECISION);
const breakEven = convertToNumber(calculateBreakEvenPrice(position), PRICE_PRECISION);

// PnL breakdown
const totalPnl = convertToNumber(
  calculatePositionPNL(market, position, true, oracleData),
  QUOTE_PRECISION
);
const feesAndFunding = convertToNumber(
  calculateFeesAndFundingPnl(market, position),
  QUOTE_PRECISION
);
const tradePnl = totalPnl - feesAndFunding;

console.log('Position Summary:');
console.log(`Size: ${size} SOL`);
console.log(`Entry: $${entryPrice}`);
console.log(`Current: $${currentPrice}`);
console.log(`Break-even: $${breakEven}`);
console.log('\nPnL Breakdown:');
console.log(`Trade PnL: $${tradePnl}`);
console.log(`Fees + Funding: $${feesAndFunding}`);
console.log(`Total PnL: $${totalPnl}`);

```

### Calculate Return on Investment (ROI)

```typescript
import { 
  calculatePositionPNL,
  calculateMarginUSDCRequiredForTrade,
  QUOTE_PRECISION,
  convertToNumber
} from '@drift-labs/sdk';

const position = user.getPerpPosition(0);
const market = driftClient.getPerpMarketAccount(0);
const oracleData = driftClient.getOracleDataForPerpMarket(0);

const pnl = convertToNumber(
  calculatePositionPNL(market, position, true, oracleData),
  QUOTE_PRECISION
);

const marginUsed = convertToNumber(
  calculateMarginUSDCRequiredForTrade(
    driftClient,
    0,
    position.baseAssetAmount.abs()
  ),
  QUOTE_PRECISION
);

const roi = (pnl / marginUsed) * 100;
console.log(`ROI: ${roi.toFixed(2)}%`);

```

## Related

- Funding Rate Calculations
- Margin Calculations
- AMM Calculations
- Precision Handling
