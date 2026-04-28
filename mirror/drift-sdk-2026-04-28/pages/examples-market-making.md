# Market Making Bot
URL: https://mintlify.com/drift-labs/protocol-v2/examples/market-making

# Market Making Bot

Build a simple market making bot for Drift.

## Two-sided oracle-offset quotes (preferred)

```typescript
import {
  BN, PRICE_PRECISION, MarketType, OrderType, PositionDirection, PostOnlyParams
} from '@drift-labs/sdk';

const spreadOffset = new BN(0.5 * PRICE_PRECISION.toNumber());

await driftClient.placeOrders([
  {
    orderType: OrderType.ORACLE,
    marketType: MarketType.PERP,
    marketIndex: 0,
    direction: PositionDirection.LONG,
    baseAssetAmount: driftClient.convertToPerpPrecision(1),
    oraclePriceOffset: spreadOffset.neg().toNumber(), // bid: oracle - $0.50
    postOnly: PostOnlyParams.MUST_POST_ONLY,
  },
  {
    orderType: OrderType.ORACLE,
    marketType: MarketType.PERP,
    marketIndex: 0,
    direction: PositionDirection.SHORT,
    baseAssetAmount: driftClient.convertToPerpPrecision(1),
    oraclePriceOffset: spreadOffset.toNumber(), // ask: oracle + $0.50
    postOnly: PostOnlyParams.MUST_POST_ONLY,
  },
]);
```

Oracle-offset orders auto-track the oracle without re-quoting.

## JIT-only market making

```typescript
import { AuctionSubscriber, getAuctionPrice } from '@drift-labs/sdk';

const auctionSubscriber = new AuctionSubscriber({
  driftClient, opts: { commitment: 'processed' },
});
await auctionSubscriber.subscribe();

auctionSubscriber.eventEmitter.on('onAccountUpdate', async (userAccount, pubkey, slot) => {
  for (const order of userAccount.orders) {
    // Filter and price; submit placeAndMakePerpOrder if profitable
  }
});
```

## Reference Implementations

- `drift-labs/keeper-bots-v2/src/bots/floatingMaker.ts` — DLOB maker with oracle offsets
- `drift-labs/keeper-bots-v2/src/bots/jitMaker.ts` — JIT maker using `JitterSniper`/`JitterShotgun`

See `examples/arbitrage` for arbitrage-style strategies, `concepts/orders` for full order semantics.
