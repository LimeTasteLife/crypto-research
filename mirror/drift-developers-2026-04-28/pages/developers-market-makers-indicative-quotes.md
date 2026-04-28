# Indicative Quotes – Drift Protocol
URL: https://docs.drift.trade/developers/market-makers/indicative-quotes

# Indicative Quotes

Indicative quotes let market makers signal liquidity offchain without committing onchain orders. You publish bid/ask prices and sizes to Drift's WebSocket endpoint, where they're used for:

- UI display: takers see available liquidity before placing orders
- Aggregator routing: Jupiter and other aggregators factor indicative liquidity into routing decisions
- Price discovery: helps establish fair prices in thin markets

When to use:
- Show liquidity without paying transaction fees for onchain orders
- Market making in lower-volume markets
- Attract taker flow with competitive prices
- JIT-only strategy but still want to be visible in the orderbook

Important: Indicative quotes are NOT firm commitments. They signal intent, but you're not obligated to fill at these prices.

## Setup

```typescript
import { IndicativeQuotesSender, PRICE_PRECISION, BASE_PRECISION, BN, loadKeypair } from "@drift-labs/sdk";

const keypair = loadKeypair("<KEYPAIR_PATH>");
const quoter = new IndicativeQuotesSender(
  "wss://dlob.drift.trade/quotes/ws",
  keypair
);
await quoter.connect();
```

## Publishing quotes

```typescript
quoter.setQuote({
  bidPrice: new BN(bid * PRICE_PRECISION.toNumber()),
  askPrice: new BN(ask * PRICE_PRECISION.toNumber()),
  bidBaseAssetAmount: new BN(bidSize * BASE_PRECISION.toNumber()),
  askBaseAssetAmount: new BN(askSize * BASE_PRECISION.toNumber()),
  marketIndex,
  isOracleOffset: false,
});
```

### Track oracle (periodic update)

```typescript
setInterval(() => {
  const oracle = driftClient.getOracleDataForPerpMarket(marketIndex);
  const oraclePrice = convertToNumber(oracle.price, PRICE_PRECISION);

  quoter.setQuote({
    bidPrice: new BN(Math.round((oraclePrice - 0.25) * PRICE_PRECISION.toNumber())),
    askPrice: new BN(Math.round((oraclePrice + 0.25) * PRICE_PRECISION.toNumber())),
    bidBaseAssetAmount: new BN(10 * BASE_PRECISION.toNumber()),
    askBaseAssetAmount: new BN(10 * BASE_PRECISION.toNumber()),
    marketIndex: 0,
    isOracleOffset: false,
  });
}, 1_000);
```

### Oracle offset mode

`isOracleOffset: true` interprets `bidPrice`/`askPrice` as offsets from oracle. Quote floats automatically.

```typescript
quoter.setQuote({
  bidPrice: new BN(-0.25 * PRICE_PRECISION.toNumber()), // oracle - $0.25
  askPrice: new BN(0.25 * PRICE_PRECISION.toNumber()),  // oracle + $0.25
  bidBaseAssetAmount: new BN(10 * BASE_PRECISION.toNumber()),
  askBaseAssetAmount: new BN(10 * BASE_PRECISION.toNumber()),
  marketIndex: 0,
  isOracleOffset: true,
});
```

## Stopping quotes

```typescript
// Send a quote with any required field set to null to delete
quoter.setQuote({
  bidPrice: null,
  askPrice: null,
  bidBaseAssetAmount: null,
  askBaseAssetAmount: null,
  marketIndex: 0,
});
```

## How indicative quotes appear

Show up in the L2 orderbook when `includeIndicative=true`. Merged with DLOB and vAMM liquidity at each price level.

## Gotchas

- Indicative != committed: aggregators display these as available liquidity but no onchain enforcement.
- WebSocket reconnection: dropped connection means quotes disappear; auto-reconnect required.
- Oracle offset mode simplifies maintenance.
- Rate limiting: ~1s update cadence is sufficient.
- Null fields to clear quotes (important for graceful shutdown).

Last updated on March 20, 2026
