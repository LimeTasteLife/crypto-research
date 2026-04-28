# DriftClient
URL: https://mintlify.com/drift-labs/protocol-v2/api/drift-client

# DriftClient

Main client for interacting with Drift Protocol v2.

## Construction

```typescript
const driftClient = new DriftClient({
  connection,
  wallet,
  env: 'mainnet-beta', // or 'devnet'
  programID,
  accountSubscription: { type: 'websocket' | 'polling' | 'grpc', accountLoader? },
  perpMarketIndexes,
  spotMarketIndexes,
  oracleInfos,
  activeSubAccountId,
  subAccountIds,
  authority,
});
await driftClient.subscribe();
```

## Key Methods

- Subscription: `subscribe()`, `unsubscribe()`, `addUser(subAccountId)`, `hasUser(subAccountId)`
- Account access: `getStateAccount()`, `getPerpMarketAccount(idx)`, `getSpotMarketAccount(idx)`, `getUser()`, `getUserAccount()`, `getOracleDataForPerpMarket(idx)`, `getMMOracleDataForPerpMarket(idx)`
- Subaccount management: `initializeUserAccount()`, `initializeUserAccountAndDepositCollateral()`, `switchActiveUser(id)`, `getNextSubAccountId()`, `deleteUser(id)`, `updateUserDelegate()`, `updateUserMarginTradingEnabled()`, `updateUserCustomMarginRatio()`
- Orders: `placePerpOrder()`, `placeSpotOrder()`, `placeOrders()`, `cancelOrder()`, `cancelOrdersByIds()`, `cancelOrders()`, `cancelAndPlaceOrders()`, `modifyOrder()`, `modifyOrderByUserOrderId()`, `placeAndTakePerpOrder()`, `placeAndMakePerpOrder()`, `placeAndMakeSignedMsgPerpOrder()`
- Collateral: `deposit()`, `withdraw()`, `transferDeposit()`, `transferPerpPosition()`, `transferIsolatedPerpPositionDeposit()`
- Settlement: `settlePNL()`, `settlePNLs()`
- LP: `addPerpLpShares()`, `removePerpLpShares()`
- Swaps: `swap()`, `getSwapQuote()`, `getJupiterSwapIxV6()`
- IX builders (raw transaction instructions): `getPlacePerpOrderIx()`, `getPlaceSpotOrderIx()`, `getCancelOrdersIx()`, `getFillPerpOrderIx()`, `getFillSpotOrderIx()`, `getTriggerOrderIx()`, `getRevertFillIx()`, `getSettlePNLsIxs()`
- SWIFT (signed message): `signSignedMsgOrderParamsMessage()`, `decodeSignedMsgOrderParamsMessage()`, `getPlaceSignedMsgTakerPerpOrderIxs()`, `getPlaceAndMakeSignedMsgPerpOrderIxs()`, `initializeSignedMsgUserOrders()`
- Builder codes: `initializeRevenueShare()`, `initializeRevenueShareEscrow()`, `changeApprovedBuilder()`
- Conversion helpers: `convertToPerpPrecision()`, `convertToPricePrecision()`, `convertToSpotPrecision()`, `getAssociatedTokenAccount()`, `getUserAccountPublicKey()`

## Account Subscription Modes

- `polling` — periodic `getAccountInfo`. Use `BulkAccountLoader`.
- `websocket` — Solana `onAccountChange` notifications.
- `grpc` — Yellowstone gRPC plugin (lowest latency, requires endpoint+token).

See `guides/account-subscriptions` and `api/account-subscribers/*` for details.
