# Market Makers – Drift Protocol
URL: https://docs.drift.trade/developers/market-makers

# Market Makers

Market making on Drift involves providing liquidity through resting orders, JIT auctions, or both. This section covers strategies, architecture, and trading mechanisms.

## Choosing a Strategy

Drift supports three distinct market making approaches. The right choice depends on your latency infrastructure, capital efficiency goals, and operational complexity tolerance.

| | DLOB MM | JIT-only | SWIFT |
| --- | --- | --- | --- |
| How it works | Resting limit orders on the DLOB | React to taker auctions in real-time | Receive signed taker orders offchain before auction |
| Capital efficiency | Orders locked onchain | Capital deployed only when filling | Capital deployed only when filling |
| Maker rebates | Yes | Yes | Yes |

Recommendation: Start with DLOB MM using oracle offset orders (orders float with the oracle automatically, requiring very few transactions).

## Market Making Strategies

### DLOB MM (Resting orders)

Place limit orders that rest on the orderbook until filled. Use oracle offset orders to automatically track the oracle price with minimal transactions. Earn maker rebates while providing committed liquidity.

Best for: Passive market making, earning maker rebates, lower infrastructure requirements, traditional orderbook strategies.

### JIT-Only Market Making

React to incoming taker orders during JIT auctions without maintaining resting orders. Compete for fills at better prices. Capital is only deployed when you choose to fill.

Best for: Active market making, dynamic pricing strategies, avoiding adverse selection, selective flow participation.

### SWIFT Market Making

Receive signed taker orders over WebSocket before they hit the onchain auction. SWIFT is essentially an offchain JIT flow: takers sign their order and broadcast it offchain, and makers can fill it before or as the auction opens.

Best for: Makers who want earlier visibility into taker flow, competitive auction environments, flow selection with more time to decide.

## Production: Bot Architecture

Production patterns and best practices for building reliable market making bots: subscription loops, priority fees, health monitoring, graceful shutdown, error handling.

## Trading Mechanisms

- Orderbook & Matching: DLOB architecture, liquidity priority (JIT -> DLOB -> AMM), how to access orderbook data via HTTP, WebSocket, or SDK.
- JIT Auctions: how JIT auctions work, auction pricing, maker participation, place-and-make patterns.

## Advanced Features

- SWIFT API: 100-500ms faster than onchain feeds.
- Indicative Quotes: signal intent to provide liquidity at certain prices without committing onchain orders.

## Reference Implementations (keeper-bots-v2)

| Bot | Source | Strategy |
| --- | --- | --- |
| FloatingPerpMaker | src/bots/floatingMaker.ts | Oracle offset resting orders on DLOB |
| JitMaker | src/bots/jitMaker.ts | JIT auction fills using `JitterSniper`/`JitterShotgun` |

Last updated on February 27, 2026
