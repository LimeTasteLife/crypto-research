# DLOB (Decentralized Limit Order Book) – Drift Protocol

Source: https://docs.drift.trade/developers/drift-sdk/dlob

DLOB (Decentralized Limit Order Book) – Drift Protocol

Skip to Content

Developers Drift SDK DLOB (Decentralized Limit Order Book)

Copy page

# DLOB (Decentralized Limit Order Book)

## What is the DLOB?

The Decentralized Limit Order Book (DLOB) is Drift’s on-chain representation of all resting limit orders across all users. Unlike a traditional centralized order book maintained by an exchange, the DLOB is constructed locally by reading on-chain user accounts and aggregating their open limit orders into a price-ordered book.

When a new order arrives, keepers and market makers query the DLOB to find matching resting orders. Drift’s matching engine then executes fills between the incoming taker and the resting makers on the DLOB, or routes to the AMM as a fallback.

When you’d use the DLOB:

- Market makers: quote against the current best bid/ask and respond to order flow
- Keeper/filler bots: identify and fill matchable orders for fee rewards
- Orderbook UIs: display a live aggregated L2 or L3 view of the market

## SDK Usage

The SDK provides several classes to subscribe to and query the DLOB.

### OrderSubscriber

Subscribes to all open user orders in real-time via WebSocket or polling. This is the raw data feed that the DLOB is built from. You need this running before you can maintain a local DLOB.

TypeScript

```
import { OrderSubscriber } from "@drift-labs/sdk";
 
const orderSubscriber = new OrderSubscriber({
  driftClient,
  subscriptionConfig: { type: "websocket" },
  fastDecode: true,
  decodeData: true,
});
await orderSubscriber.subscribe();
```

`Class OrderSubscriber` Reference ↗

`DriftClient`

`Map `

`PollingSubscription | WebsocketSubscription | grpcSubscription`

`Commitment`

`StrictEventEmitter `

`Promise `

`() => void`

`number`

`(name: string, data: Buffer) => UserAccount`

`boolean`

`boolean`

`() => Promise `

`() => Promise `

`(key: string, dataType: "raw" | "decoded" | "buffer", data: UserAccount | Buffer | string[], slot: number) => void`

`(protectedMakerParamsMap?: ProtectMakerParamsMap | undefined) => DLOB`

Creates a new DLOB for the order subscriber to fill. This will allow a caller to extend the DLOB Subscriber with a custom DLOB type.

`(slot: number, protectedMakerParamsMap?: ProtectMakerParamsMap | undefined) => Promise `

`() => number`

`(userAccountPublicKey: PublicKey) => Promise `

`(key: string) => Promise `

`() => Promise `

| Property | Type | Required |
| --- | --- | --- |
| `driftClient` | Yes |
| `usersAccounts` | Yes |
| `subscription` | Yes |
| `commitment` | Yes |
| `eventEmitter` | Yes |
| `fetchPromise` | No |
| `fetchPromiseResolver` | Yes |
| `mostRecentSlot` | Yes |
| `decodeFn` | Yes |
| `decodeData` | No |
| `fetchAllNonIdleUsers` | No |
| `subscribe` | Yes |
| `fetch` | Yes |
| `tryUpdateUserAccount` | Yes |
| `createDLOB` | Yes |
| `getDLOB` | Yes |
| `getSlot` | Yes |
| `addPubkey` | Yes |
| `mustGetUserAccount` | Yes |
| `unsubscribe` | Yes |

### DLOBSubscriber

Builds and continuously maintains an aggregated orderbook from the order stream. Use this when you need a live L2/L3 view without manually managing the DLOB state.

TypeScript

```
import { DLOBSubscriber } from "@drift-labs/sdk";
 
const dlobSubscriber = new DLOBSubscriber({
  driftClient,
  dlobSource: orderSubscriber,   // feeds from your OrderSubscriber
  slotSource: slotSubscriber,    // needed for order expiry/timing
  updateFrequency: 1000,         // rebuild the book every 1000ms
});
await dlobSubscriber.subscribe();
```

`Class DLOBSubscriber` Reference ↗

`DriftClient`

`DLOBSource`

`SlotSource`

`number`

`Timeout`

`DLOB`

`StrictEventEmitter `

`boolean`

`() => Promise `

`() => ProtectMakerParamsMap | undefined`

`() => Promise `

`() => DLOB`

`({ marketName, marketIndex, marketType, depth, includeVamm, numVammOrders, fallbackL2Generators, latestSlot, }: { marketName?: string; marketIndex?: number; marketType?: MarketType; depth?: number; includeVamm?: boolean; numVammOrders?: number; fallbackL2Generators?: L2OrderBookGenerator[]; latestSlot?: any; }) => L...`

Get the L2 order book for a given market.

`({ marketName, marketIndex, marketType, }: { marketName?: string; marketIndex?: number; marketType?: MarketType; }) => L3OrderBook`

Get the L3 order book for a given market.

`() => Promise `

| Property | Type | Required |
| --- | --- | --- |
| `driftClient` | Yes |
| `dlobSource` | Yes |
| `slotSource` | Yes |
| `updateFrequency` | Yes |
| `intervalId` | No |
| `dlob` | Yes |
| `eventEmitter` | Yes |
| `protectedMakerView` | Yes |
| `subscribe` | Yes |
| `getProtectedMakerParamsMap` | Yes |
| `updateDLOB` | Yes |
| `getDLOB` | Yes |
| `getL2` | Yes |
| `getL3` | Yes |
| `unsubscribe` | Yes |

### SlotSubscriber

Tracks the current Solana slot. Required for timing-sensitive operations like JIT auction windows and order expiry checks.

TypeScript

```
import { SlotSubscriber } from "@drift-labs/sdk";
 
const slotSubscriber = new SlotSubscriber(connection);
await slotSubscriber.subscribe();
 
const currentSlot = slotSubscriber.getSlot();
```

`Class SlotSubscriber` Reference ↗

`any`

`number`

`number`

`StrictEventEmitter `

`Timeout`

`number`

`boolean`

`boolean`

`() => Promise `

`any`

`any`

`() => number`

`(onResub?: boolean | undefined) => Promise `

| Property | Type | Required |
| --- | --- | --- |
| `connection` | Yes |
| `currentSlot` | Yes |
| `subscriptionId` | Yes |
| `eventEmitter` | Yes |
| `timeoutId` | No |
| `resubTimeoutMs` | No |
| `isUnsubscribing` | Yes |
| `receivingData` | Yes |
| `subscribe` | Yes |
| `updateCurrentSlot` | Yes |
| `setTimeout` | Yes |
| `getSlot` | Yes |
| `unsubscribe` | Yes |

### DLOB

The core data structure with bid/ask sides and query methods. Under normal usage you access this via`dlobSubscriber.getDLOB()` rather than instantiating it directly.

TypeScript

```
import { DLOB } from "@drift-labs/sdk";
 
// Access via DLOBSubscriber (recommended)
const dlob = dlobSubscriber.getDLOB();
```

`Class DLOB` Reference ↗

`Map >`

`Map >`

`number`

`boolean`

`ProtectMakerParamsMap`

`any`

`() => void`

`(userMap: UserMap, slot: number) => Promise `

initializes a new DLOB instance

`(order: Order, userAccount: string, slot: number, isUserProtectedMaker: boolean, baseAssetAmount: BN, onInsert?: OrderBookCallback | undefined) => void`

`(order: Order, userAccount: string, isUserProtectedMaker: boolean, baseAssetAmount?: any, onInsert?: OrderBookCallback | undefined) => void`

`(marketType: MarketTypeStr, marketIndex: number) => void`

`(order: Order, userAccount: PublicKey, slot: number, isUserProtectedMaker: boolean, onDelete?: OrderBookCallback | undefined) => void`

`(order: Order, slot: number, isProtectedMaker: boolean) => NodeList | undefined`

`(slot: number) => void`

`(slot: number, marketTypeStr: MarketTypeStr) => void`

`(orderId: number, userAccount: PublicKey) => Order | undefined`

` (marketIndex: number, fallbackBid: any, fallbackAsk: any, slot: number, ts: number, marketType: T, oraclePriceData: T extends { spot: unknown; } ? OraclePriceData : MMOraclePriceData, stateAccount: StateAccount, marketAccount: T extends { ...; } ? SpotMarketAccount : PerpMarketAccount) => NodeT...`

`(marketType: MarketType, stateAccount: StateAccount, marketAccount: SpotMarketAccount | PerpMarketAccount) => { ...; }`

`(restingLimitOrderNodesToFill: NodeToFill[], takingOrderNodesToFill: NodeToFill[]) => NodeToFill[]`

` (marketIndex: number, slot: number, marketType: T, oraclePriceData: T extends { spot: unknown; } ? OraclePriceData : MMOraclePriceData, isAmmPaused: boolean, stateAccount: StateAccount, marketAccount: T extends { ...; } ? SpotMarketAccount : PerpMarketAccount, makerRebateNumerator: number, make...`

` (marketIndex: number, slot: number, marketType: T, oraclePriceData: T extends { spot: unknown; } ? OraclePriceData : MMOraclePriceData, isAmmPaused: boolean, state: StateAccount, marketAccount: T extends { ...; } ? SpotMarketAccount : PerpMarketAccount, fallbackAsk: any, fallbackBid?: any) => N...`

` (marketIndex: number, slot: number, marketType: T, oraclePriceData: T extends { spot: unknown; } ? OraclePriceData : MMOraclePriceData, takerNodeGenerator: Generator<...>, makerNodeGeneratorFn: (marketIndex: number, slot: number, marketType: MarketType, oraclePriceData: T extends { ...; } ? Ora...`

` (marketType: T, slot: number, oraclePriceData: T extends { spot: unknown; } ? OraclePriceData : MMOraclePriceData, nodeGenerator: Generator, doesCross: (nodePrice: any) => boolean, state: StateAccount, marketAccount: T extends { ...; } ? SpotMarketAccount : PerpMarketAccount...`

`(marketIndex: number, ts: number, marketType: MarketType, slot?: any) => NodeToFill[]`

`(marketIndex: number, marketType: MarketType, stepSize: BN) => NodeToFill[]`

` (marketIndex: number, marketType: T, slot: number, oraclePriceData: T extends { spot: unknown; } ? OraclePriceData : MMOraclePriceData, filterFcn?: DLOBFilterFcn | undefined) => Generator<...>`

` (marketIndex: number, marketType: T, slot: number, oraclePriceData: T extends { spot: unknown; } ? OraclePriceData : MMOraclePriceData, filterFcn?: DLOBFilterFcn | undefined) => Generator<...>`

`(signedMsgOrderList: NodeList<"signedMsg">, filter: (x: DLOBNode) => boolean) => Generator `

` (generatorList: Generator [], oraclePriceData: T extends "spot" ? OraclePriceData : MMOraclePriceData, slot: number, compareFcn: (bestDLOBNode: DLOBNode, currentDLOBNode: DLOBNode, slot: number, oraclePriceData: T extends "spot" ? OraclePriceData : MMOraclePriceData) => bo...`

` (marketIndex: number, slot: number, marketType: T, oraclePriceData: T extends { spot: unknown; } ? OraclePriceData : MMOraclePriceData, filterFcn?: DLOBFilterFcn | undefined) => Generator<...>`

` (marketIndex: number, slot: number, marketType: T, oraclePriceData: T extends { spot: unknown; } ? OraclePriceData : MMOraclePriceData, filterFcn?: DLOBFilterFcn | undefined) => Generator<...>`

` (marketIndex: number, _fallbackAsk: any, slot: number, marketType: T, oraclePriceData: T extends { spot: unknown; } ? OraclePriceData : MMOraclePriceData, filterFcn?: DLOBFilterFcn | undefined) => Generator<...>`

This will look at both the taking and resting limit asks

` (marketIndex: number, _fallbackBid: any, slot: number, marketType: T, oraclePriceData: T extends { spot: unknown; } ? OraclePriceData : MMOraclePriceData, filterFcn?: DLOBFilterFcn | undefined) => Generator<...>`

This will look at both the taking and resting limit bids

` (marketIndex: number, slot: number, marketType: T, oraclePriceData: T extends { spot: unknown; } ? OraclePriceData : MMOraclePriceData) => NodeToFill[]`

`(askNode: DLOBNode, bidNode: DLOBNode) => { takerNode: DLOBNode; makerNode: DLOBNode; } | undefined`

` (marketIndex: number, slot: number, marketType: T, oraclePriceData: T extends { spot: unknown; } ? OraclePriceData : MMOraclePriceData) => any`

` (marketIndex: number, slot: number, marketType: T, oraclePriceData: T extends { spot: unknown; } ? OraclePriceData : MMOraclePriceData) => any`

`(marketIndex: number, marketType: MarketType, direction: PositionDirection) => Generator `

`(marketIndex: number, marketType: MarketType, direction: PositionDirection) => Generator `

`(marketIndex: number, marketType: MarketType, direction: PositionDirection) => Generator `

`(marketIndex: number, marketType: MarketType, direction: PositionDirection) => Generator `

`(marketIndex: number, marketType: MarketType, direction: PositionDirection) => Generator `

`(marketIndex: number, marketType: MarketType, direction: PositionDirection) => Generator `

`(marketIndex: number, slot: number, triggerPrice: BN, marketType: MarketType, stateAccount: StateAccount) => NodeToTrigger[]`

`(driftClient: DriftClient, slotSubscriber: SlotSubscriber, marketIndex: number, marketType: MarketType) => void`

`() => DLOBOrders`

`() => Generator, any, any>`

` ({ marketIndex, marketType, slot, oraclePriceData, depth, fallbackL2Generators, }: { marketIndex: number; marketType: T; slot: number; oraclePriceData: T extends { spot: unknown; } ? OraclePriceData : MMOraclePriceData; depth: number; fallbackL2Generators?: L2OrderBookGenerator[]; }) => L2Order...`

Get an L2 view of the order book for a given market.

` ({ marketIndex, marketType, slot, oraclePriceData, }: { marketIndex: number; marketType: T; slot: number; oraclePriceData: T extends { spot: unknown; } ? OraclePriceData : MMOraclePriceData; }) => L3OrderBook`

Get an L3 view of the order book for a given market. Does not include fallback liquidity sources

`any`

` ({ marketIndex, marketType, baseAmount, orderDirection, slot, oraclePriceData, }: { marketIndex: number; marketType: T; baseAmount: BN; orderDirection: PositionDirection; slot: number; oraclePriceData: T extends { spot: unknown; } ? OraclePriceData : MMOraclePriceData; }) => BN`

` ({ marketIndex, marketType, direction, slot, oraclePriceData, numMakers, }: { marketIndex: number; marketType: T; direction: PositionDirection; slot: number; oraclePriceData: T extends { spot: unknown; } ? OraclePriceData : MMOraclePriceData; numMakers: number; }) => PublicKey[]`

| Property | Type | Required |
| --- | --- | --- |
| `openOrders` | Yes |
| `orderLists` | Yes |
| `maxSlotForRestingLimitOrders` | Yes |
| `initialized` | Yes |
| `protectedMakerParamsMap` | Yes |
| `init` | Yes |
| `clear` | Yes |
| `initFromUserMap` | Yes |
| `insertOrder` | Yes |
| `insertSignedMsgOrder` | Yes |
| `addOrderList` | Yes |
| `delete` | Yes |
| `getListForOnChainOrder` | Yes |
| `updateRestingLimitOrders` | Yes |
| `updateRestingLimitOrdersForMarketType` | Yes |
| `getOrder` | Yes |
| `findNodesToFill` | Yes |
| `getMakerRebate` | Yes |
| `mergeNodesToFill` | Yes |
| `findRestingLimitOrderNodesToFill` | Yes |
| `findTakingNodesToFill` | Yes |
| `findTakingNodesCrossingMakerNodes` | Yes |
| `findNodesCrossingFallbackLiquidity` | Yes |
| `findExpiredNodesToFill` | Yes |
| `findUnfillableReduceOnlyOrdersToCancel` | Yes |
| `getTakingBids` | Yes |
| `getTakingAsks` | Yes |
| `signedMsgGenerator` | Yes |
| `getBestNode` | Yes |
| `getRestingLimitAsks` | Yes |
| `getRestingLimitBids` | Yes |
| `getAsks` | Yes |
| `getBids` | Yes |
| `findCrossingRestingLimitOrders` | Yes |
| `determineMakerAndTaker` | Yes |
| `getBestAsk` | Yes |
| `getBestBid` | Yes |
| `getStopLosses` | Yes |
| `getStopLossMarkets` | Yes |
| `getStopLossLimits` | Yes |
| `getTakeProfits` | Yes |
| `getTakeProfitMarkets` | Yes |
| `getTakeProfitLimits` | Yes |
| `findNodesToTrigger` | Yes |
| `printTop` | Yes |
| `getDLOBOrders` | Yes |
| `getNodeLists` | Yes |
| `getL2` | Yes |
| `getL3` | Yes |
| `estimateFillExactBaseAmountInForSide` | Yes |
| `estimateFillWithExactBaseAmount` | Yes |
| `getBestMakers` | Yes |

### UserMap

Efficiently tracks and caches the accounts of many users simultaneously. Used by liquidation bots and other applications that need to monitor positions across the whole protocol, rather than just orders.

TypeScript

```
import { UserMap } from "@drift-labs/sdk";
```

`Class UserMap` Reference ↗

`any`

`DriftClient`

`StrictEventEmitter `

`any`

`any`

`any`

`any`

`any`

`any`

`any`

`any`

`any`

`any`

`any`

`any`

`any`

`any`

`any`

`() => Promise `

`(userAccountPublicKey: PublicKey, userAccount?: UserAccount | undefined, slot?: number | undefined, accountSubscription?: UserSubscriptionConfig | undefined) => Promise<...>`

`(key: string) => boolean`

`(key: string) => User | undefined`

gets the User for a particular userAccountPublicKey, if no User exists, undefined is returned

`(key: string) => DataAndSlot | undefined`

`(key: string, accountSubscription?: UserSubscriptionConfig | undefined) => Promise `

gets the User for a particular userAccountPublicKey, if no User exists, new one is created

`(key: string, accountSubscription?: UserSubscriptionConfig | undefined) => Promise >`

`(key: string) => Promise `

`(key: string) => PublicKey | undefined`

gets the Authority for a particular userAccountPublicKey, if no User exists, undefined is returned

`(slot: number, protectedMakerParamsMap?: ProtectMakerParamsMap | undefined) => Promise `

implements the DLOBSource interface create a DLOB from all the subscribed users

`(record: OrderRecord) => Promise `

`(record: any) => Promise `

`() => IterableIterator `

`() => IterableIterator >`

`() => IterableIterator<[string, User]>`

`() => IterableIterator<[string, DataAndSlot]>`

`() => number`

`(filterCriteria?: UserAccountFilterCriteria | undefined) => PublicKey[]`

Returns a unique list of authorities for all users in the UserMap that meet the filter criteria

`() => Promise `

`any`

`any`

Syncs the UserMap using the default sync method (single getProgramAccounts call with filters). This method may fail when drift has too many users. (nodejs response size limits)

`any`

Syncs the UserMap using the paginated sync method (multiple getMultipleAccounts calls with filters). This method is more reliable when drift has many users.

`() => Promise `

`(key: string, userAccount: UserAccount, slot: number) => Promise `

`(slot: number) => void`

`() => number`

| Property | Type | Required |
| --- | --- | --- |
| `userMap` | Yes |
| `driftClient` | Yes |
| `eventEmitter` | Yes |
| `connection` | Yes |
| `commitment` | Yes |
| `includeIdle` | Yes |
| `filterByPoolId` | No |
| `additionalFilters` | No |
| `disableSyncOnTotalAccountsChange` | Yes |
| `lastNumberOfSubAccounts` | Yes |
| `subscription` | Yes |
| `stateAccountUpdateCallback` | Yes |
| `decode` | Yes |
| `mostRecentSlot` | Yes |
| `syncConfig` | Yes |
| `syncPromise` | No |
| `syncPromiseResolver` | Yes |
| `throwOnFailedSync` | Yes |
| `subscribe` | Yes |
| `addPubkey` | Yes |
| `has` | Yes |
| `get` | Yes |
| `getWithSlot` | Yes |
| `mustGet` | Yes |
| `mustGetWithSlot` | Yes |
| `mustGetUserAccount` | Yes |
| `getUserAuthority` | Yes |
| `getDLOB` | Yes |
| `updateWithOrderRecord` | Yes |
| `updateWithEventRecord` | Yes |
| `values` | Yes |
| `valuesWithSlot` | Yes |
| `entries` | Yes |
| `entriesWithSlot` | Yes |
| `size` | Yes |
| `getUniqueAuthorities` | Yes |
| `sync` | Yes |
| `getFilters` | Yes |
| `defaultSync` | Yes |
| `paginatedSync` | Yes |
| `unsubscribe` | Yes |
| `updateUserAccount` | Yes |
| `updateLatestSlot` | Yes |
| `getSlot` | Yes |

### Setting Up a Local DLOB

This is the full setup sequence to get a live, continuously-updated orderbook running:

TypeScript

```
import { SlotSubscriber, OrderSubscriber, DLOBSubscriber } from "@drift-labs/sdk";
 
// 1. Track the current slot (needed for order expiry)
const slotSubscriber = new SlotSubscriber(connection);
await slotSubscriber.subscribe();
 
// 2. Subscribe to all open orders across all users
const orderSubscriber = new OrderSubscriber({
  driftClient,
  subscriptionConfig: { type: "websocket" },
  fastDecode: true,
  decodeData: true,
});
await orderSubscriber.subscribe();
 
// 3. Build and maintain the DLOB from the order stream
const dlobSubscriber = new DLOBSubscriber({
  driftClient,
  dlobSource: orderSubscriber,
  slotSource: slotSubscriber,
  updateFrequency: 1000,
});
await dlobSubscriber.subscribe();
```

`Example DLOB setup` Reference ↗

TypeScript docs unavailable for `DLOB setup`.

### Getting L2 Orderbook Data

Once subscribed, query the aggregated L2 orderbook (price levels with cumulative size):

TypeScript

```
import { MarketType, PRICE_PRECISION, BASE_PRECISION, convertToNumber } from "@drift-labs/sdk";
 
const dlob = dlobSubscriber.getDLOB();
const marketIndex = 0; // SOL-PERP
// For perp markets, use getMMOracleDataForPerpMarket (returns MMOraclePriceData)
const oraclePriceData = driftClient.getMMOracleDataForPerpMarket(marketIndex);
const slot = slotSubscriber.getSlot();
 
const l2 = dlob.getL2({
  marketIndex,
  marketType: MarketType.PERP,
  oraclePriceData,
  slot,
  depth: 10, // number of price levels per side
});
 
// l2.bids and l2.asks are arrays of { price: BN, size: BN }
console.log("Top bid:", convertToNumber(l2.bids[0].price, PRICE_PRECISION),
            "size:", convertToNumber(l2.bids[0].size, BASE_PRECISION));
console.log("Top ask:", convertToNumber(l2.asks[0].price, PRICE_PRECISION),
            "size:", convertToNumber(l2.asks[0].size, BASE_PRECISION));
```

`Example L2 orderbook` Reference ↗

TypeScript docs unavailable for `L2 orderbook`.

### Getting Best Bid/Ask

For quick access to the best bid and ask prices without fetching the full orderbook:

TypeScript

```
import { MarketType, PRICE_PRECISION, convertToNumber } from "@drift-labs/sdk";
 
const dlob = dlobSubscriber.getDLOB();
const marketIndex = 0;
const oraclePriceData = driftClient.getMMOracleDataForPerpMarket(marketIndex);
const slot = slotSubscriber.getSlot();
 
// Returns BN | undefined (undefined if no orders on that side)
const bestBid = dlob.getBestBid(marketIndex, slot, MarketType.PERP, oraclePriceData);
const bestAsk = dlob.getBestAsk(marketIndex, slot, MarketType.PERP, oraclePriceData);
 
if (bestBid && bestAsk) {
  console.log("Best bid:", convertToNumber(bestBid, PRICE_PRECISION));
  console.log("Best ask:", convertToNumber(bestAsk, PRICE_PRECISION));
  console.log("Spread:", convertToNumber(bestAsk.sub(bestBid), PRICE_PRECISION));
}
```

`Example Best bid/ask` Reference ↗

TypeScript docs unavailable for `Best bid/ask`.

Last updated on February 27, 2026

SDK Internals Data API Playground
