# PnL Calculations
URL: https://mintlify.com/drift-labs/protocol-v2/math/pnl

# PnL Calculations

## Unrealized PnL

`PnL = baseAssetValue * sign(baseAssetAmount) + quoteAssetAmount`

```typescript
calculatePositionPNL(market, perpPosition, withFunding, oraclePriceData): BN
```

## Including Funding

```
PnL_total = PnL_position + fundingPayment
fundingPayment = baseAssetAmount * (cumulativeFundingRate_current - lastCumulativeFundingRate)
```

## Base Asset Value

```typescript
calculateBaseAssetValue(market, userPosition, mmOraclePriceData, useSpread, skipUpdate, latestSlot): BN
```

Simulates swapping the position through the AMM with spread; provides the exit quote amount.

## Realized PnL

When position partially or fully closed, realized PnL = closingPrice - entryPrice scaled by size, accumulated in `settledPnl`.

## Break-Even Price

`breakEvenPrice = quoteBreakEvenAmount / |baseAssetAmount|`

quoteBreakEvenAmount tracks entry + fees + funding.

## All-Time PnL

```
totalPnl = netDeposits + netSpotMarketValue + unrealizedPnL - cumulativeFees
```

(Simplified — actual formula in SDK accounts for borrows, settled PnL, fees, and funding payments.)
