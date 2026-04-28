# JIT-only MM – Drift Protocol
URL: https://docs.drift.trade/developers/market-makers/jit-only

# JIT-only MM

JIT-only market making means you do not keep a standing book. Instead, you compete in JIT auctions by reacting to incoming taker orders in real-time.

Why JIT-only?

- No adverse selection from stale quotes: you only commit capital when you choose to fill
- Selective flow: inspect each taker order and decide if it's profitable to fill
- Capital efficiency: no capital locked in resting orders that may never fill
- Dynamic pricing: price each fill based on current oracle, inventory, and market conditions

Tradeoff: Lower-latency infrastructure required than DLOB MM (must react within the auction window).

## Architecture overview

Loop: Subscribe -> Filter -> Price -> Fill

## Subscribe to auctions / orders

`AuctionSubscriber` streams active JIT auctions. Use `commitment: "processed"` for lowest latency.

```typescript
import { AuctionSubscriber } from "@drift-labs/sdk";

const auctionSubscriber = new AuctionSubscriber({
  driftClient,
  opts: { commitment: "processed" },
});
await auctionSubscriber.subscribe();
```

For lower latency, subscribe to SWIFT to receive signed taker orders 100-500ms before they land onchain.

## Compute auction prices

```typescript
import { getAuctionPrice, convertToNumber, PRICE_PRECISION } from "@drift-labs/sdk";

const currentSlot = await connection.getSlot();
const oracle = driftClient.getOracleDataForPerpMarket(marketIndex);

const auctionPriceBN = getAuctionPrice(takerOrder, currentSlot, oracle.price);
const auctionPrice = convertToNumber(auctionPriceBN, PRICE_PRECISION);
```

## Fill as maker (atomic place-and-make)

```typescript
import { OrderType, PositionDirection, PostOnlyParams } from "@drift-labs/sdk";

const makerOrderParams = {
  orderType: OrderType.LIMIT,
  marketIndex: takerOrder.marketIndex,
  direction: PositionDirection.SHORT, // opposite of taker
  baseAssetAmount: takerOrder.baseAssetAmount,
  price: driftClient.convertToPricePrecision(myFillPrice),
  postOnly: PostOnlyParams.MUST_POST_ONLY,
};

const takerInfo = {
  taker: takerPubkey,
  takerStats: takerStatsPubkey,
  takerUserAccount: takerUserAccount,
  order: takerOrder,
};

await driftClient.placeAndMakePerpOrder(makerOrderParams, takerInfo);
```

## Practical filters

- Oracle validation: reject if `!oracle.isValid` or confidence too wide
- Position limits: skip if fill would exceed max position or leverage
- Toxic flow: skip orders that increase risk
- SWIFT dedup: when subscribed to both SWIFT and onchain, use `isSignedMsgOrder(order)` to avoid double-handling

`getMMOracleDataForPerpMarket` is the recommended oracle getter for market makers (returns `isValid` flag and `confidence`).

## Using JIT Proxy (JitterSniper / JitterShotgun)

```typescript
import { JitterSniper, PriceType } from "@drift-labs/jit-proxy/lib";

const jitter = new JitterSniper({
  auctionSubscriber,
  driftClient,
  slotSubscriber,
});
await jitter.subscribe();
```

The JitMaker reference bot uses `JitterSniper`/`JitterShotgun` with:
- Per-market subaccount isolation (1 subaccount per market)
- Volatility-based fill rejection (`isMarketVolatile`)
- DLOB-aware pricing (excludes own orders from best bid/ask calculation)

## Gotchas

- Don't poll `getSlot()` per auction — use `SlotSubscriber`.
- `isSignedMsgOrder` filtering when also subscribed to SWIFT.
- One subaccount per market: JIT fills can conflict if two markets share a subaccount.
- Track fill success rate; below ~20% your pricing or latency may need adjustment.

Last updated on February 27, 2026
