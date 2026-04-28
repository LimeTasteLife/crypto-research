# User
URL: https://mintlify.com/drift-labs/protocol-v2/api/user

# User

Class representing a single Drift user account (subaccount). Provides read-only computations on positions, PnL, and risk.

## Construction

```typescript
const user = new User({
  driftClient,
  userAccountPublicKey,
  accountSubscription: { type: 'polling', accountLoader },
});
await user.subscribe();
```

## Key Methods

### Subscription
- `subscribe()`, `unsubscribe()`, `fetchAccounts()`, `forceGetUserAccount()`, `exists()`

### Account access
- `getUserAccount()`, `getUserAccountAndSlot()`, `getUserAccountPublicKey()`

### Positions
- `getPerpPosition(marketIndex)`, `getPerpPositionAndSlot()`, `getPerpPositionOrEmpty()`
- `getSpotPosition(marketIndex)`, `getSpotPositionAndSlot()`, `getEmptySpotPosition()`
- `getActivePerpPositions()`, `getActiveSpotPositions()`, `getActivePositions()`
- `getTokenAmount(marketIndex)` — signed; positive deposit, negative borrow
- `getIsolatePerpPositionTokenAmount(perpMarketIndex)`
- `isPerpPositionIsolated(perpPosition)`

### Orders
- `getOrder(orderId)`, `getOrderByUserOrderId(userOrderId)`
- `getOpenOrders()`, `getOpenOrdersAndSlot()`

### Margin / Risk
- `getTotalCollateral(marginCategory?, strict?, includeOpenOrders?)`, `getFreeCollateral()`
- `getMarginRequirement(marginCategory, ...)`, `getInitialMarginRequirement()`, `getMaintenanceMarginRequirement()`
- `getHealth(perpMarketIndex?)`, `getMarginRatio()`, `getLeverage(includeOpenOrders?, perpMarketIndex?)`
- `getLeverageComponents()`, `getNetUsdValue()`, `getNetSpotMarketValue()`
- `getPerpBuyingPower(marketIndex, ...)`, `getMaxLeverageForPerp(perpMarketIndex)`, `getMaxLeverageForSpot(spotMarketIndex, direction)`
- `getMaxTradeSizeUSDCForPerp(targetMarketIndex, baseSize, ...)`, `getMaxTradeSizeUSDCForSpot()`, `getMaxSwapAmount(...)`
- `liquidationPrice(marketIndex, positionBaseSizeChange?, ...)`, `spotLiquidationPrice(marketIndex, ...)`
- `canBeLiquidated()`, `getLiquidationStatuses()`, `isBeingLiquidated()`, `isCrossMarginBeingLiquidated()`, `isBankrupt()`, `isHighLeverageMode()`
- `getMarginCalculation(marginCategory?, opts?)` — computes everything in one pass

### PnL
- `getUnrealizedPNL(withFunding?, marketIndex?, ...)`, `getUnrealizedFundingPNL(marketIndex?)`
- `getTotalAllTimePnl()`
- `getPositionEstimatedExitPriceAndPnl(position, amountToClose?, useAMMClose?)`

### Health components
- `getPerpPositionHealth({ marginCategory, perpPosition, ... })`
- `getHealthComponents({ marginCategory })`

### Account state
- `getUserFeeTier(marketType, now?)`, `calculateFeeForQuoteAmount(quoteAmount, marketIndex?, enteringHighLeverageMode?)`
- `getWithdrawalLimit(marketIndex, reduceOnly?)`, `canBypassWithdrawLimits(marketIndex)`
- `canMakeIdle(slot)`, `getSafestTiers()`, `needsToSettleFundingPayment()`, `hasStatus(status)`
