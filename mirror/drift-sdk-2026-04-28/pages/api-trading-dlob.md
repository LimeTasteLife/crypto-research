# DLOB API
URL: https://mintlify.com/drift-labs/protocol-v2/api/trading/dlob

# DLOB (Decentralized Limit Order Book)

Order matching and liquidity discovery in Drift Protocol v2.

## Classes

- `OrderSubscriber` — subscribe to all open user orders (data feed for DLOB)
- `DLOBSubscriber` — build/maintain aggregated orderbook from order stream
- `SlotSubscriber` — track current Solana slot
- `DLOB` — core orderbook data structure
- `UserMap` — efficiently track many user accounts
- `AuctionSubscriber` — stream active JIT auctions
- `SwiftOrderSubscriber` — subscribe to SWIFT signed orders

## DLOB Methods

```typescript
dlob.getBestBid(marketIndex, slot, marketType, oraclePriceData): BN | undefined
dlob.getBestAsk(marketIndex, slot, marketType, oraclePriceData): BN | undefined
dlob.getRestingLimitBids(marketIndex, slot, marketType, oraclePriceData, filterFn?): Generator
dlob.getRestingLimitAsks(marketIndex, slot, marketType, oraclePriceData, filterFn?): Generator
dlob.getTakingBids(marketIndex, marketType, slot, oraclePriceData, filterFn?): Generator
dlob.getTakingAsks(marketIndex, marketType, slot, oraclePriceData, filterFn?): Generator
dlob.findNodesToFill(marketIndex, fallbackBid, fallbackAsk, slot, ts, marketType, oraclePriceData, stateAccount, marketAccount): NodeToFill[]
dlob.findNodesToTrigger(marketIndex, slot, triggerPrice, marketType, stateAccount): NodeToTrigger[]
dlob.findExpiredNodesToFill(marketIndex, ts, marketType, slot?): NodeToFill[]
dlob.getL2({ marketIndex, marketType, slot, oraclePriceData, depth, fallbackL2Generators? }): L2OrderBook
dlob.getL3({ marketIndex, marketType, slot, oraclePriceData }): L3OrderBook
dlob.estimateFillExactBaseAmountInForSide({ marketIndex, marketType, baseAmount, orderDirection, slot, oraclePriceData }): BN
dlob.estimateFillWithExactBaseAmount(...): BN
dlob.getBestMakers({ marketIndex, marketType, direction, slot, oraclePriceData, numMakers }): PublicKey[]
```

## Setup pattern

```typescript
const slotSub = new SlotSubscriber(connection); await slotSub.subscribe();
const orderSub = new OrderSubscriber({ driftClient, subscriptionConfig: { type: 'websocket' } }); await orderSub.subscribe();
const dlobSub = new DLOBSubscriber({ driftClient, dlobSource: orderSub, slotSource: slotSub, updateFrequency: 1000 }); await dlobSub.subscribe();

const dlob = dlobSub.getDLOB();
```
