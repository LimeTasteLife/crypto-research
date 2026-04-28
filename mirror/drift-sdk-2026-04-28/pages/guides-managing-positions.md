# Managing Positions
URL: https://mintlify.com/drift-labs/protocol-v2/guides/managing-positions

# Managing Positions

## Read positions

```typescript
const user = driftClient.getUser();
await user.fetchAccounts();

// Specific
const perpPosition = user.getPerpPosition(marketIndex);
const spotPosition = user.getSpotPosition(0);

// All active
const activePerp = user.getActivePerpPositions();
const activeSpot = user.getActiveSpotPositions();
```

## PnL

```typescript
const upnl = user.getUnrealizedPNL(true); // withFunding
const fundingPnl = user.getUnrealizedFundingPNL();
const exitPnl = user.getPositionEstimatedExitPriceAndPnl(perpPosition);
```

## Settle PnL

```typescript
await driftClient.settlePNL(user.userAccountPublicKey, user.getUserAccount(), marketIndex);
```

## Risk metrics

```typescript
const health = user.getHealth();
const totalCollateral = user.getTotalCollateral();
const free = user.getFreeCollateral();
const leverage = user.getLeverage();
const liqPrice = user.liquidationPrice(marketIndex);
const canLiq = user.canBeLiquidated();
```

## Close position

```typescript
const closeParams = getMarketOrderParams({
  baseAssetAmount: perpPosition.baseAssetAmount.abs(),
  direction: PositionDirection.SHORT, // opposite of long
  marketIndex,
  reduceOnly: true,
});
await driftClient.placePerpOrder(closeParams);
```

## Transfer between subaccounts

```typescript
// Move spot deposit
await driftClient.transferDeposit(amount, marketIndex, fromSub, toSub);
// Move perp position
await driftClient.transferPerpPosition(fromSub, toSub, marketIndex, amount);
```

## LP positions

```typescript
// Provide AMM liquidity
await driftClient.addPerpLpShares(amount, marketIndex);

// Remove
await driftClient.removePerpLpShares(amount, marketIndex);
```

LP positions have ~24h cooldown after adding before removal is allowed.
