# JIT Auctions – Drift Protocol
URL: https://docs.drift.trade/developers/market-makers/jit-auctions

# JIT Auctions

JIT (Just-In-Time) auctions are Drift's price discovery mechanism. When a taker order arrives, it enters an auction where market makers compete to fill it before it hits the DLOB or AMM.

## Why JIT auctions?

- Improve price execution for takers (makers offer better prices)
- Reduce adverse selection (makers react to toxic flow)
- Increase competition among makers
- Enable offchain quoting without resting orders

## Auction parameters

| Parameter | Description |
| --- | --- |
| `auctionDuration` | Number of slots the auction runs (typically 10 slots ~5 seconds) |
| `auctionStartPrice` | Best price for the taker at slot 0 |
| `auctionEndPrice` | Worst price for the taker at slot N (closer to limit/oracle) |

The auction starts at the taker's best price and deteriorates toward their worst. Reverse Dutch auction: early auction = makers must offer great prices; late auction = bar lowers, more makers can compete.

## Auction pricing formula

```
Auction Price(slot) = start_price + (end_price - start_price) * progress
where progress = min(1, (current_slot - auction_start_slot) / auction_duration)
```

Example (long market order, oracle at $100):
- `auctionStartPrice`: $100.10 (oracle + 0.1%)
- `auctionEndPrice`: $100.00 (oracle)
- `auctionDuration`: 10 slots
- At slot 3: $100.07
- At slot 7: $100.03

## Auction lifecycle

1. Taker places order with auction params
2. Auction starts (price interpolates start -> end over duration)
3. Market makers compete (submit fills at prices within range)
4. Auction resolves (best maker fills; if partially filled, remaining continues; if unfilled, falls to DLOB then AMM)

## Maker participation

```typescript
import { AuctionSubscriber } from "@drift-labs/sdk";

const auctionSubscriber = new AuctionSubscriber({
  driftClient,
  opts: { commitment: "processed" }
});
await auctionSubscriber.subscribe();
```

Filter and price auctions, then check oracle validity, position limits, toxic-flow patterns, inventory skew before submitting fills.

## Place-and-make pattern

`placeAndMakePerpOrder` atomically:
1. Places your maker order onchain
2. Fills against the taker order
3. Settles PnL in a single transaction

```typescript
const makerOrderParams = {
  orderType: OrderType.LIMIT,
  marketIndex: auction.order.marketIndex,
  direction: PositionDirection.SHORT, // opposite of taker's LONG
  price: driftClient.convertToPricePrecision(myFillPrice),
  baseAssetAmount: auction.order.baseAssetAmount,
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

## Multi-maker fills

Multiple makers can fill the same taker order. Better-priced makers get priority (pro-rata allocation).

## Auction vs DLOB

| | JIT Auction | DLOB |
| --- | --- | --- |
| Duration | 5-10 slots (~2-5s) | Indefinite |
| Pricing | Dynamic, interpolates toward oracle | Fixed price at placement |
| Commitment | None until fill | Onchain, committed |
| Best for | Active makers | Passive makers |
| Priority | Runs first | Fallback |

## JIT Proxy library

`@drift-labs/jit-proxy`:
- `JitterSniper`: waits for optimal slot, single fill tx (precise pricing, lower compute)
- `JitterShotgun`: submits at multiple slots simultaneously (higher fill rate, more compute/SOL)

```typescript
import { JitterSniper, JitterShotgun, PriceType } from "@drift-labs/jit-proxy/lib";

const jitter = new JitterSniper({ auctionSubscriber, driftClient });
```

The JitMaker bot in keeper-bots-v2 demonstrates both with volatility checks, position sizing, DLOB-aware pricing.

## Gotchas

- Auction slots != wall-clock time (~400ms each, can stretch under congestion)
- Partial fills are common — handle `baseAssetAmountFilled < baseAssetAmount`
- Compute budget: 400-800k CU for place-and-make (JitMaker defaults to 800k)
- Stale `takerInfo`: check `order.baseAssetAmount - order.baseAssetAmountFilled`

Last updated on February 27, 2026
