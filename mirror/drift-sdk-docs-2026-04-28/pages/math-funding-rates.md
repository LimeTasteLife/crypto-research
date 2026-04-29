# Funding Rate Calculations - Drift Protocol v2

Source: https://mintlify.com/drift-labs/protocol-v2/math/funding-rates

# Funding Rate Calculations

> Funding rate formulas and payment calculations in Drift Protocol v2

## Overview

Funding rates in Drift Protocol perpetuals ensure the mark price stays anchored to the oracle price. Funding payments are exchanged between longs and shorts every hour based on the difference between the mark TWAP and oracle TWAP.

## Funding Rate Formula

The funding rate is calculated based on the Time-Weighted Average Price (TWAP) spread:

```
fundingRate = (markTwap - oracleTwap) / oracleTwap / 24

```

Where:

- `markTwap` - Time-weighted average mark price
- `oracleTwap` - Time-weighted average oracle price
- Division by 24 converts to hourly rate (from daily)

## Precision Constants

```typescript
// From numericConstants.ts
export const FUNDING_RATE_BUFFER_PRECISION = new BN(1000);        // 10^3
export const FUNDING_RATE_PRECISION_EXP = new BN(9);              // 10^9
export const FUNDING_RATE_PRECISION = new BN(10).pow(
  FUNDING_RATE_PRECISION_EXP
); // 10^9

export const FUNDING_RATE_OFFSET_DENOMINATOR = new BN(5000);

```

## Calculate Live Funding Rate

```typescript
/**
 * Calculate current funding rates for longs and shorts
 * 
 * @param market - PerpMarketAccount
 * @param mmOraclePriceData - Oracle price data with market maker info
 * @param oraclePriceData - Oracle price data
 * @param markPrice - Optional override mark price
 * @param now - Current timestamp (default: now)
 * @returns [longFundingRate, shortFundingRate] in FUNDING_RATE_PRECISION
 */
export function calculateLongShortFundingRate(
  market: PerpMarketAccount,
  mmOraclePriceData?: MMOraclePriceData,
  oraclePriceData?: OraclePriceData,
  markPrice?: BN,
  now?: BN
): [BN, BN] {
  const [_1, _2, _, cappedAltEst, interpEst] = calculateAllEstimatedFundingRate(
    market,
    mmOraclePriceData,
    oraclePriceData,
    markPrice,
    now
  );

  if (market.amm.baseAssetAmountLong.gt(market.amm.baseAssetAmountShort)) {
    return [cappedAltEst, interpEst];
  } else if (
    market.amm.baseAssetAmountLong.lt(market.amm.baseAssetAmountShort)
  ) {
    return [interpEst, cappedAltEst];
  } else {
    return [interpEst, interpEst];
  }
}

```

### Example

```typescript
import { 
  calculateLongShortFundingRate,
  FUNDING_RATE_BUFFER_PRECISION,
  FUNDING_RATE_PRECISION_EXP,
  BigNum
} from '@drift-labs/sdk';

const market = driftClient.getPerpMarketAccount(0);
const oracleData = driftClient.getOracleDataForPerpMarket(0);

const [longRate, shortRate] = calculateLongShortFundingRate(
  market,
  oracleData,
  oracleData
);

// Convert to percentage
const longRatePct = BigNum.from(
  longRate.mul(FUNDING_RATE_BUFFER_PRECISION),
  FUNDING_RATE_PRECISION_EXP
).toNum();

const shortRatePct = BigNum.from(
  shortRate.mul(FUNDING_RATE_BUFFER_PRECISION),
  FUNDING_RATE_PRECISION_EXP
).toNum();

console.log(`Long funding rate: ${longRatePct.toFixed(5)}%`);
console.log(`Short funding rate: ${shortRatePct.toFixed(5)}%`);

```

## Formatted Funding Rate

Get human-readable funding rate information:

```typescript
/**
 * Calculate formatted funding rates
 * 
 * @param market - PerpMarketAccount
 * @param mmOraclePriceData - Oracle price data with market maker info
 * @param oraclePriceData - Oracle price data  
 * @param period - 'hour' for hourly rate, 'year' for APR
 * @returns Formatted funding rate info
 */
export function calculateFormattedLiveFundingRate(
  market: PerpMarketAccount,
  mmOraclePriceData: MMOraclePriceData,
  oraclePriceData: OraclePriceData,
  period: 'hour' | 'year'
): {
  longRate: number;
  shortRate: number;
  fundingRateUnit: string;
  formattedFundingRateSummary: string;
} {
  const nowBN = new BN(Date.now() / 1000);

  const [_markTwapLive, _oracleTwapLive, longFundingRate, shortFundingRate] =
    calculateLongShortFundingRateAndLiveTwaps(
      market,
      mmOraclePriceData,
      oraclePriceData,
      undefined,
      nowBN
    );

  let longFundingRateNum = getFundingRatePct(longFundingRate);
  let shortFundingRateNum = getFundingRatePct(shortFundingRate);

  if (period == 'year') {
    const paymentsPerYear = 24 * 365.25;
    longFundingRateNum *= paymentsPerYear;
    shortFundingRateNum *= paymentsPerYear;
  }

  const longsArePaying = longFundingRateNum > 0;
  const shortsArePaying = !(shortFundingRateNum > 0);

  const longsAreString = longsArePaying ? 'pay' : 'receive';
  const shortsAreString = !shortsArePaying ? 'receive' : 'pay';

  const absoluteLongFundingRateNum = Math.abs(longFundingRateNum);
  const absoluteShortFundingRateNum = Math.abs(shortFundingRateNum);

  const formattedLongRatePct = absoluteLongFundingRateNum.toFixed(
    period == 'hour' ? 5 : 2
  );
  const formattedShortRatePct = absoluteShortFundingRateNum.toFixed(
    period == 'hour' ? 5 : 2
  );

  const fundingRateUnit = period == 'year' ? '% APR' : '%';

  const formattedFundingRateSummary = `At this rate, longs would ${longsAreString} ${formattedLongRatePct} ${fundingRateUnit} and shorts would ${shortsAreString} ${formattedShortRatePct} ${fundingRateUnit} at the end of the hour.`;

  return {
    longRate: longsArePaying
      ? -absoluteLongFundingRateNum
      : absoluteLongFundingRateNum,
    shortRate: shortsArePaying
      ? -absoluteShortFundingRateNum
      : absoluteShortFundingRateNum,
    fundingRateUnit: fundingRateUnit,
    formattedFundingRateSummary,
  };
}

```

### Example

```typescript
import { calculateFormattedLiveFundingRate } from '@drift-labs/sdk';

const market = driftClient.getPerpMarketAccount(0);
const oracleData = driftClient.getOracleDataForPerpMarket(0);

// Hourly rate
const hourly = calculateFormattedLiveFundingRate(
  market,
  oracleData,
  oracleData,
  'hour'
);

console.log(hourly.formattedFundingRateSummary);
// "At this rate, longs would pay 0.00123 % and shorts would receive 0.00123 % at the end of the hour."

// Annualized rate (APR)
const yearly = calculateFormattedLiveFundingRate(
  market,
  oracleData,
  oracleData,
  'year'
);

console.log(`Long APR: ${yearly.longRate.toFixed(2)}%`);
console.log(`Short APR: ${yearly.shortRate.toFixed(2)}%`);

```

## TWAP Calculations

### Mark Price TWAP

```typescript
function calculateLiveMarkTwap(
  market: PerpMarketAccount,
  mmOraclePriceData?: MMOraclePriceData,
  markPrice?: BN,
  now?: BN,
  period = new BN(3600)
): BN {
  now = now || new BN((Date.now() / 1000).toFixed(0));

  const lastMarkTwapWithMantissa = market.amm.lastMarkPriceTwap;
  const lastMarkPriceTwapTs = market.amm.lastMarkPriceTwapTs;

  const timeSinceLastMarkChange = now.sub(lastMarkPriceTwapTs);
  const markTwapTimeSinceLastUpdate = BN.max(
    period,
    BN.max(ZERO, period.sub(timeSinceLastMarkChange))
  );

  if (!markPrice) {
    const [bid, ask] = calculateBidAskPrice(market.amm, mmOraclePriceData);
    markPrice = bid.add(ask).div(new BN(2));
  }

  const markTwapWithMantissa = markTwapTimeSinceLastUpdate
    .mul(lastMarkTwapWithMantissa)
    .add(timeSinceLastMarkChange.mul(markPrice))
    .div(timeSinceLastMarkChange.add(markTwapTimeSinceLastUpdate));

  return markTwapWithMantissa;
}

```

### Oracle Price TWAP

Similar calculation using oracle price data from `market.amm.historicalOracleData`.

## Funding Payment Calculation

Calculate funding payment for a position:

```typescript
/**
 * Calculate unsettled funding payment
 * 
 * @param market - PerpMarketAccount
 * @param perpPosition - User's perp position
 * @returns Funding payment in QUOTE_PRECISION (10^6)
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
fundingPayment = -(cumulativeFundingRate - lastCumulativeFundingRate) 
                 × baseAssetAmount 
                 / AMM_RESERVE_PRECISION 
                 / FUNDING_RATE_BUFFER_PRECISION

```

Positive funding payment means the user receives funding. Negative means they pay funding.

### Example

```typescript
import { 
  calculateUnsettledFundingPnl,
  QUOTE_PRECISION,
  convertToNumber
} from '@drift-labs/sdk';

const position = user.getPerpPosition(0);
const market = driftClient.getPerpMarketAccount(0);

const fundingPaymentBN = calculateUnsettledFundingPnl(market, position);
const fundingPayment = convertToNumber(fundingPaymentBN, QUOTE_PRECISION);

if (fundingPayment > 0) {
  console.log(`Receiving $${fundingPayment.toFixed(2)} in funding`);
} else {
  console.log(`Paying $${Math.abs(fundingPayment).toFixed(2)} in funding`);
}

```

## Funding Pool

The protocol maintains a funding pool to cover imbalances:

```typescript
/**
 * Calculate funding pool size
 * 
 * @param market - PerpMarketAccount
 * @returns Funding pool size in QUOTE_PRECISION
 */
export function calculateFundingPool(market: PerpMarketAccount): BN {
  const totalFeeLB = market.amm.totalExchangeFee.div(new BN(2));
  const feePool = BN.max(
    ZERO,
    market.amm.totalFeeMinusDistributions
      .sub(totalFeeLB)
      .mul(new BN(1))
      .div(new BN(3))
  );
  return feePool;
}

```

## Max Price Divergence

Funding rate is capped based on contract tier:

```typescript
function getMaxPriceDivergenceForFundingRate(
  market: PerpMarketAccount,
  oracleTwap: BN
) {
  if (isVariant(market.contractTier, 'a')) {
    return oracleTwap.divn(33);  // ~3%
  } else if (isVariant(market.contractTier, 'b')) {
    return oracleTwap.divn(33);  // ~3%
  } else if (isVariant(market.contractTier, 'c')) {
    return oracleTwap.divn(20);  // ~5%
  } else {
    return oracleTwap.divn(10);  // ~10%
  }
}

```

## Funding Rate with Offset

The protocol applies a small offset to encourage arbitrage:

```typescript
const twapSpread = markTwap.sub(oracleTwap);
const twapSpreadWithOffset = twapSpread.add(
  oracleTwap.abs().div(FUNDING_RATE_OFFSET_DENOMINATOR)  // Divide by 5000
);

```

## Asymmetric Funding

When there's an imbalance between longs and shorts, funding rates can be asymmetric:

```typescript
if (market.amm.baseAssetAmountLong.gt(market.amm.baseAssetAmountShort.abs())) {
  // More longs than shorts
  return [cappedAltEst, interpEst];  // Longs pay capped rate, shorts receive interpolated
} else if (
  market.amm.baseAssetAmountLong.lt(market.amm.baseAssetAmountShort.abs())
) {
  // More shorts than longs  
  return [interpEst, cappedAltEst];  // Longs receive interpolated, shorts pay capped
} else {
  // Balanced
  return [interpEst, interpEst];
}

```

When open interest is imbalanced, the smaller side may receive more funding than the larger side pays due to the funding pool mechanism.

## Practical Examples

### Monitor Funding Rates

```typescript
import { calculateFormattedLiveFundingRate } from '@drift-labs/sdk';

const market = driftClient.getPerpMarketAccount(0);
const oracleData = driftClient.getOracleDataForPerpMarket(0);

setInterval(() => {
  const funding = calculateFormattedLiveFundingRate(
    market,
    oracleData,
    oracleData,
    'hour'
  );
  
  console.log('Current Funding Rates:');
  console.log(`Longs: ${funding.longRate.toFixed(5)}${funding.fundingRateUnit}`);
  console.log(`Shorts: ${funding.shortRate.toFixed(5)}${funding.fundingRateUnit}`);
  console.log(funding.formattedFundingRateSummary);
}, 60000); // Update every minute

```

### Calculate Expected Funding Payment

```typescript
import { 
  calculateLongShortFundingRate,
  BASE_PRECISION,
  AMM_RESERVE_PRECISION,
  FUNDING_RATE_BUFFER_PRECISION,
  convertToNumber
} from '@drift-labs/sdk';

const market = driftClient.getPerpMarketAccount(0);
const oracleData = driftClient.getOracleDataForPerpMarket(0);
const positionSize = new BN(10).mul(BASE_PRECISION); // 10 SOL
const isLong = true;

const [longRate, shortRate] = calculateLongShortFundingRate(
  market,
  oracleData,
  oracleData
);

const rate = isLong ? longRate : shortRate;

// expectedPayment = -rate × positionSize / (AMM_RESERVE_PRECISION × FUNDING_RATE_BUFFER_PRECISION)
const expectedPaymentBN = rate
  .mul(positionSize)
  .div(AMM_RESERVE_PRECISION)
  .div(FUNDING_RATE_BUFFER_PRECISION)
  .mul(new BN(-1));

const expectedPayment = convertToNumber(expectedPaymentBN, QUOTE_PRECISION);

if (expectedPayment > 0) {
  console.log(`Expected to receive $${expectedPayment.toFixed(2)} next hour`);
} else {
  console.log(`Expected to pay $${Math.abs(expectedPayment).toFixed(2)} next hour`);
}

```

### Historical Funding Analysis

```typescript
import { calculateFormattedLiveFundingRate } from '@drift-labs/sdk';

const market = driftClient.getPerpMarketAccount(0);
const oracleData = driftClient.getOracleDataForPerpMarket(0);

// Get 24-hour funding rate (from market data)
const last24hRate = market.amm.last24HAvgFundingRate;
const last24hRatePct = convertToNumber(
  last24hRate,
  FUNDING_RATE_BUFFER_PRECISION
);

// Get current rate
const current = calculateFormattedLiveFundingRate(
  market,
  oracleData,
  oracleData,
  'year'
);

console.log('Funding Rate Analysis:');
console.log(`24h Avg: ${last24hRatePct.toFixed(5)}%`);
console.log(`Current Long APR: ${current.longRate.toFixed(2)}%`);
console.log(`Current Short APR: ${current.shortRate.toFixed(2)}%`);

```

## Related

- PnL Calculations
- AMM Calculations
- Precision Handling
