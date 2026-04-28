# Funding Rate Calculations
URL: https://mintlify.com/drift-labs/protocol-v2/math/funding-rates

# Funding Rate Calculations

Funding rates align mark price with oracle price for perpetual markets.

## Funding Rate Formula

`fundingRate = (markTwap - oracleTwap) / (oracleTwap * 24)`

- 24 = funding period normalization (hourly, 24 per day)
- Positive: longs pay shorts
- Negative: shorts pay longs

## Funding Payment

`fundingPayment = baseAssetAmount * (cumulativeFundingRate_market - lastCumulativeFundingRate_user)`

## Funding Rate Magnitude Clamps

By contract tier:
- B or greater: 0.125% per hour
- C: 0.208% per hour
- Below C: 0.4167% per hour

## Capped Symmetric Funding

If long-short imbalance exists, market-specific Rebate Pool can cover the cost delta. If insufficient (2/3 of pool available per interval), receipts are capped.

## TWAP Updates

Mark TWAP and oracle TWAP updated on each trade. EMA span = funding period (1 hour).
