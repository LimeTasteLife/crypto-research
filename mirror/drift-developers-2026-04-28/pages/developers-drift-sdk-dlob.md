# DLOB (Decentralized Limit Order Book) – Drift Protocol
URL: https://docs.drift.trade/developers/drift-sdk/dlob

# DLOB (Decentralized Limit Order Book)

## What is the DLOB?

The Decentralized Limit Order Book (DLOB) is Drift's on-chain representation of all resting limit orders across all users. Unlike a traditional centralized order book maintained by an exchange, the DLOB is constructed locally by reading on-chain user accounts and aggregating their open limit orders into a price-ordered book.

When a new order arrives, keepers and market makers query the DLOB to find matching resting orders. Drift's matching engine then executes fills between the incoming taker and the resting makers on the DLOB, or routes to the AMM as a fallback.

When you'd use the DLOB:

- Market makers: quote against the current best bid/ask and respond to order flow
- Keeper/filler bots: identify and fill matchable orders for fee rewards
- Orderbook UIs: display a live aggregated L2 or L3 view of the market

## SDK Usage

### OrderSubscriber

Subscribes to all open user orders in real-time via WebSocket or polling. This is the raw data feed that the DLOB is built from.

```typescript
import { OrderSubscriber } from "@drift-labs/sdk";

const orderSubscriber = new OrderSubscriber({
  driftClient,
  subscriptionConfig: { type: "websocket" },
  fastDecode: true,
  decodeData: true,
});
await orderSubscriber.subscribe();
```

### DLOBSubscriber

Builds and continuously maintains an aggregated orderbook from the order stream.

```typescript
import { DLOBSubscriber } from "@drift-labs/sdk";

const dlobSubscriber = new DLOBSubscriber({
  driftClient,
  dlobSource: orderSubscriber,
  slotSource: slotSubscriber,
  updateFrequency: 1000,
});
await dlobSubscriber.subscribe();
```

### SlotSubscriber

Tracks the current Solana slot. Required for timing-sensitive operations like JIT auction windows and order expiry checks.

```typescript
import { SlotSubscriber } from "@drift-labs/sdk";

const slotSubscriber = new SlotSubscriber(connection);
await slotSubscriber.subscribe();
const currentSlot = slotSubscriber.getSlot();
```

### DLOB

The core data structure with bid/ask sides and query methods.

```typescript
const dlob = dlobSubscriber.getDLOB();
```

Key DLOB methods (see SDK reference for full signatures):
- `getBestBid()`, `getBestAsk()`
- `getRestingLimitBids()`, `getRestingLimitAsks()`
- `getTakingBids()`, `getTakingAsks()`
- `findNodesToFill()`, `findNodesToTrigger()`
- `getL2()`, `getL3()`
- `estimateFillExactBaseAmountInForSide()`, `estimateFillWithExactBaseAmount()`
- `getBestMakers()`

### UserMap

Efficiently tracks and caches the accounts of many users simultaneously. Used by liquidation bots and other applications.

### Setting Up a Local DLOB

```typescript
import { SlotSubscriber, OrderSubscriber, DLOBSubscriber } from "@drift-labs/sdk";

// 1. Track the current slot
const slotSubscriber = new SlotSubscriber(connection);
await slotSubscriber.subscribe();

// 2. Subscribe to all open orders
const orderSubscriber = new OrderSubscriber({
  driftClient,
  subscriptionConfig: { type: "websocket" },
  fastDecode: true,
  decodeData: true,
});
await orderSubscriber.subscribe();

// 3. Build and maintain the DLOB
const dlobSubscriber = new DLOBSubscriber({
  driftClient,
  dlobSource: orderSubscriber,
  slotSource: slotSubscriber,
  updateFrequency: 1000,
});
await dlobSubscriber.subscribe();
```

### Getting L2 Orderbook Data

```typescript
import { MarketType, PRICE_PRECISION, BASE_PRECISION, convertToNumber } from "@drift-labs/sdk";

const dlob = dlobSubscriber.getDLOB();
const marketIndex = 0; // SOL-PERP
const oraclePriceData = driftClient.getMMOracleDataForPerpMarket(marketIndex);
const slot = slotSubscriber.getSlot();

const l2 = dlob.getL2({
  marketIndex,
  marketType: MarketType.PERP,
  oraclePriceData,
  slot,
  depth: 10,
});
// l2.bids and l2.asks are arrays of { price: BN, size: BN }
```

### Getting Best Bid/Ask

```typescript
const bestBid = dlob.getBestBid(marketIndex, slot, MarketType.PERP, oraclePriceData);
const bestAsk = dlob.getBestAsk(marketIndex, slot, MarketType.PERP, oraclePriceData);
```

Last updated on February 27, 2026
