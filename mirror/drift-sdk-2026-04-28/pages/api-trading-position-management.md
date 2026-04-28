# Position Management API
URL: https://mintlify.com/drift-labs/protocol-v2/api/trading/position-management

# Position Management

Position tracking, PnL calculation, and position management utilities.

## Reading positions

```typescript
user.getPerpPosition(marketIndex): PerpPosition | undefined
user.getPerpPositionOrEmpty(marketIndex): PerpPosition
user.getActivePerpPositions(): PerpPosition[]
user.getSpotPosition(marketIndex): SpotPosition | undefined
user.getActiveSpotPositions(): SpotPosition[]
user.getActivePositions(): { activePerpPositions, activeSpotPositions }
user.getTokenAmount(marketIndex): BN  // signed
```

## PnL helpers

```typescript
user.getUnrealizedPNL(withFunding?, marketIndex?, marginCategory?, strict?): BN
user.getUnrealizedFundingPNL(marketIndex?): BN
user.getPositionEstimatedExitPriceAndPnl(position, amountToClose?, useAMMClose?): [BN, BN]
user.getTotalAllTimePnl(): BN
```

## Position transfers

```typescript
driftClient.transferDeposit(amount, marketIndex, fromSubAccountId, toSubAccountId)
driftClient.transferPerpPosition(fromSubAccountId, toSubAccountId, marketIndex, amount)
driftClient.transferIsolatedPerpPositionDeposit(amount, perpMarketIndex, subAccountId?)
```

## Closing

Use `reduceOnly: true` when closing. Place opposite-direction order with `position.baseAssetAmount.abs()`.

```typescript
const closeParams = getMarketOrderParams({
  baseAssetAmount: position.baseAssetAmount.abs(),
  direction: PositionDirection.SHORT, // for closing long
  marketIndex,
  reduceOnly: true,
});
await driftClient.placePerpOrder(closeParams);
```
