# DLOB MM – Drift Protocol
URL: https://docs.drift.trade/developers/market-makers/dlob-mm

# DLOB MM

DLOB market making on Drift means placing resting two-sided quotes on the decentralized orderbook (DLOB) and earning maker rebates when takers trade against you. You can also participate in JIT when relevant.

### Maker vs taker

- Maker: provides liquidity (resting order), earns rebate.
- Taker: removes liquidity (crosses spread), pays fee.

### Always use post-only for maker quotes

| Flag | Behavior | Use case |
| --- | --- | --- |
| `MUST_POST_ONLY` | Rejects the order if it would cross the spread and fill as taker | Default for MM, guarantees maker-only execution |
| `TRY_POST_ONLY` | Amends the price to the best non-crossing price if it would cross | Useful when you want the order placed regardless |
| `SLIDE` | Slides price to the best bid/ask | Ensures placement at the top of book without crossing |

Recommendation: Use `MUST_POST_ONLY` for all quotes.

### Two-sided quotes (place in one tx)

```typescript
import { MarketType, OrderType, PositionDirection, PostOnlyParams } from "@drift-labs/sdk";

await driftClient.placeOrders([
  { orderType: OrderType.LIMIT, marketType: MarketType.PERP, marketIndex: 0,
    direction: PositionDirection.LONG,
    baseAssetAmount: driftClient.convertToPerpPrecision(1),
    price: driftClient.convertToPricePrecision(99.5),
    postOnly: PostOnlyParams.MUST_POST_ONLY },
  { orderType: OrderType.LIMIT, marketType: MarketType.PERP, marketIndex: 0,
    direction: PositionDirection.SHORT,
    baseAssetAmount: driftClient.convertToPerpPrecision(1),
    price: driftClient.convertToPricePrecision(100.5),
    postOnly: PostOnlyParams.MUST_POST_ONLY },
]);
```

### Oracle offset orders

Most efficient way to quote on Drift. Set an offset from the oracle price; the order automatically floats with the oracle.

Why this matters: With fixed price limit orders, you need to cancel and replace every time the oracle moves (thousands of transactions per day). With oracle offset orders, ~30 transactions per day suffices.

How:
- `orderType: OrderType.ORACLE` (not `LIMIT`)
- `oraclePriceOffset` in PRICE_PRECISION (1e6) units. Positive = above oracle, negative = below.
- Onchain program evaluates `oracle_price + offset` at fill time.

```typescript
import { BN, PRICE_PRECISION, MarketType, OrderType, PositionDirection, PostOnlyParams } from "@drift-labs/sdk";

const spreadOffset = 0.5; // $0.50 from oracle on each side
const offsetBN = new BN(spreadOffset * PRICE_PRECISION.toNumber());

await driftClient.placeOrders([
  { orderType: OrderType.ORACLE, marketType: MarketType.PERP, marketIndex: 0,
    direction: PositionDirection.LONG,
    baseAssetAmount: driftClient.convertToPerpPrecision(1),
    oraclePriceOffset: offsetBN.neg().toNumber(), // bid: oracle - $0.50
    postOnly: PostOnlyParams.MUST_POST_ONLY },
  { orderType: OrderType.ORACLE, marketType: MarketType.PERP, marketIndex: 0,
    direction: PositionDirection.SHORT,
    baseAssetAmount: driftClient.convertToPerpPrecision(1),
    oraclePriceOffset: offsetBN.toNumber(),
    postOnly: PostOnlyParams.MUST_POST_ONLY },
]);
```

### Atomic cancel-and-replace

```typescript
const txSig = await driftClient.cancelAndPlaceOrders(
  { marketType: MarketType.PERP, marketIndex: 0 },
  [/* new orders */]
);
```

### Inventory-aware quoting

Widen the bid (less eager to buy more) and tighten the ask (more eager to sell) when long; vice versa when short.

### JIT maker (place-and-make)

```typescript
await driftClient.placeAndMakePerpOrder(makerOrderParams, takerInfo);
```

### Risk management basics

```typescript
// Cancel all orders for a specific market
await driftClient.cancelOrders(MarketType.PERP, 0);
// Cancel ALL orders across all markets (emergency)
await driftClient.cancelOrders();
```

## Reference implementation

The FloatingPerpMaker in keeper-bots-v2:
- Slot-based cooldown: waits MARKET_UPDATE_COOLDOWN_SLOTS (30 slots)
- Mutex-guarded periodic tasks
- Position-aware sizing using MAX_POSITION_EXPOSURE
- Watchdog timer

## Gotchas

- Oracle offset precision: `oraclePriceOffset` is in raw PRICE_PRECISION units (1e6). Offset of `500000` = $0.50.
- Oracle offset orders still need updates when changing spread width / size / level count.
- 32 order limit per subaccount: use multiple subaccounts for multi-market strategies.
- `MUST_POST_ONLY` rejection: if oracle moves sharply, your order is rejected (not silently filled as taker).

Last updated on February 27, 2026
