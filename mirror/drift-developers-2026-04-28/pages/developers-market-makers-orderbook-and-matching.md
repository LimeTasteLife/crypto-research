# Orderbook & Matching – Drift Protocol
URL: https://docs.drift.trade/developers/market-makers/orderbook-and-matching

# Orderbook & Matching

## What is the DLOB?

The DLOB (Decentralized Limit Order Book) is Drift's offchain orderbook that aggregates all resting limit orders across user accounts. It provides a unified orderbook view for matching and price discovery while keeping order storage onchain.

Why offchain? Storing a sorted orderbook onchain would be prohibitively expensive. Drift stores orders in user accounts (up to 32 per user); the DLOB server scans all user accounts, extracts resting limit orders, sorts them into a bid/ask orderbook, and serves via WebSocket and HTTP.

## How matching works

Liquidity priority order:

1. JIT Auction (first ~10 slots / ~5 seconds) — taker order enters auction; market makers compete to fill at the best price. Auction price interpolates from start price toward end price (Dutch auction).
2. DLOB — unfilled portion matches against resting limit orders. Sorted by price-time priority.
3. AMM — remaining size executes against Drift's constant-product AMM (always provides liquidity but at worse prices).
4. External fulfillment (spot only) — Phoenix, OpenBook, Jupiter aggregator when better prices.

Example (10 SOL market buy):
- 4 SOL via JIT at oracle + 0.02%
- 3 SOL via DLOB at oracle + 0.05%
- 3 SOL via AMM at oracle + 0.12% (price impact)

## Indicative vs committed liquidity

When you query the DLOB orderbook, you'll see two types:
- Committed (DLOB) liquidity: real onchain resting limit orders, guaranteed to be available.
- Indicative liquidity: estimated AMM (vAMM) liquidity at various price levels + offchain indicative quotes from market makers (signal intent without onchain commitment).

In the L2 API response, the `sources` field on each price level tells you where the liquidity comes from.

## Accessing the DLOB

### REST API (L2/L3)

```
GET https://dlob.drift.trade/l2?marketName=SOL-PERP&depth=10&includeVamm=true&includeIndicative=true
```

L2 response:
```json
{
  "bids": [{"price": "99500000", "size": "15000000",
            "sources": {"dlob": "5000000", "vamm": "10000000"}}],
  "asks": [{"price": "100500000", "size": "12000000",
            "sources": {"dlob": "8000000", "vamm": "4000000"}}]
}
```

Prices in PRICE_PRECISION (1e6); sizes in BASE_PRECISION (1e9). The `sources` field is an object mapping source names to size strings.

```
GET https://dlob.drift.trade/l3?marketName=SOL-PERP
```

Returns individual orders with maker addresses.

### WebSocket

```
const ws = new WebSocket("wss://dlob.drift.trade/ws");
ws.send(JSON.stringify({
  type: "subscribe",
  channel: "orderbook",
  marketType: "perp",
  market: "SOL-PERP",
  grouping: 10
}));
```

### SDK DLOB class (local orderbook)

```typescript
import { DLOBSubscriber, OrderSubscriber, SlotSubscriber } from "@drift-labs/sdk";

const slotSubscriber = new SlotSubscriber(connection);
await slotSubscriber.subscribe();

const orderSubscriber = new OrderSubscriber({
  driftClient,
  subscriptionConfig: { type: "websocket" },
  fastDecode: true,
  decodeData: true,
});
await orderSubscriber.subscribe();

const dlobSubscriber = new DLOBSubscriber({
  driftClient,
  dlobSource: orderSubscriber,
  slotSource: slotSubscriber,
  updateFrequency: 1000,
});
await dlobSubscriber.subscribe();

const bestBid = dlobSubscriber.getBestBid(marketIndex);
const bestAsk = dlobSubscriber.getBestAsk(marketIndex);
```

## DLOB matching mechanics

After the JIT auction, remaining order size matches against DLOB using price-time priority: best price wins; among tied prices, earliest fills first; walk the book until filled or exhausted.

## Performance

DLOB hosted server: 1-2s latency, redundant servers. For low-latency bots, subscribe directly to onchain UserAccounts (via RPC or gRPC) using `OrderSubscriber` with `type: "websocket"`.

## Gotchas

- `includeVamm=true` is essential for realistic liquidity view
- `includeIndicative=true` for full picture (offchain MM quotes)
- Prices are raw precision (PRICE_PRECISION = 1e6, BASE_PRECISION = 1e9)
- L2 `sources` is an object, not a string
- DLOB hosted server can lag during high load — build locally for latency-sensitive strategies

Last updated on February 27, 2026
