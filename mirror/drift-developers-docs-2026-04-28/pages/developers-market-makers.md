# Market Makers – Drift Protocol

Source: https://docs.drift.trade/developers/market-makers

Market Makers – Drift Protocol

Skip to Content

Developers Market MakersMarket Makers

Copy page

# Market Makers

Market making on Drift involves providing liquidity through resting orders, JIT auctions, or both. This section covers strategies, architecture, and trading mechanisms.

## Getting Started

### Quickstart Guide

Learn how to place two-sided quotes that automatically update with oracle prices. Perfect for understanding the basics.

Understand quickstart guide ↗

## Choosing a Strategy

Drift supports three distinct market making approaches. The right choice depends on your latency infrastructure, capital efficiency goals, and operational complexity tolerance.

| DLOB MM | JIT-only | SWIFT |
| --- | --- | --- |
| How it works | Resting limit orders on the DLOB | React to taker auctions in real-time | Receive signed taker orders offchain before auction |
| Capital efficiency | Orders locked onchain | Capital deployed only when filling | Capital deployed only when filling |
| Maker rebates | ✅ Yes | ✅ Yes | ✅ Yes |

Recommendation: Start with DLOB MM using oracle offset orders (orders float with the oracle automatically, requiring very few transactions).

## Market Making Strategies

### DLOB MM

Resting orders on the DLOB

Place limit orders that rest on the orderbook until filled. Use oracle offset orders to automatically track the oracle price with minimal transactions. Earn maker rebates while providing committed liquidity.

Best for:

- Passive market making
- Earning maker rebates
- Lower infrastructure requirements
- Traditional orderbook strategies

Understand DLOB MM ↗

### JIT-Only Market Making

Active market making through auctions

React to incoming taker orders during JIT auctions without maintaining resting orders. Compete for fills at better prices. Capital is only deployed when you choose to fill.

Best for:

- Active market making
- Dynamic pricing strategies
- Avoiding adverse selection
- Selective flow participation

Understand JIT-only market making ↗

### SWIFT Market Making

Offchain JIT market making via signed order delivery

Receive signed taker orders over WebSocket before they hit the onchain auction. SWIFT is essentially an offchain JIT flow: takers sign their order and broadcast it offchain, and makers can fill it before or as the auction opens. Capital is only deployed when you choose to fill.

Best for:

- Makers who want earlier visibility into taker flow
- Competitive auction environments
- Flow selection with more time to decide

Understand SWIFT market making ↗

## Production

### Bot Architecture

Production patterns and best practices for building reliable market making bots. Covers subscription loops, priority fees, health monitoring, graceful shutdown, error handling, and operational considerations. Applies to all strategies.

Understand bot architecture ↗

## Understanding Drift’s Trading Mechanisms

### Orderbook & Matching

How orders are matched and filled

Learn about the DLOB architecture, liquidity priority (JIT → DLOB → AMM), and how to access orderbook data via HTTP, WebSocket, or SDK.

Essential reading for understanding execution flow

Understand orderbook & matching ↗

### JIT Auctions

Just-In-Time auction mechanics

Deep dive into how JIT auctions work, auction pricing, maker participation, and place-and-make patterns.

Critical for competitive market making

Understand JIT auctions ↗

## Advanced Features

### SWIFT API

Receive signed taker orders offchain via WebSocket before they hit the auction.

Latency advantage: 100-500ms faster than onchain feeds

Understand SWIFT API ↗

### Indicative Quotes

Offchain liquidity signaling

Signal intent to provide liquidity at certain prices without committing onchain orders. Helps with price discovery for takers and aggregator routing.

Use case: Show liquidity for UI/aggregators

Understand indicative quotes ↗

## Reference Implementations

Drift maintains open-source reference bots in keeper-bots-v2:

| Bot | Source | Strategy |
| --- | --- | --- |
| FloatingPerpMaker | src/bots/floatingMaker.ts | Oracle offset resting orders on DLOB |
| JitMaker | src/bots/jitMaker.ts | JIT auction fills using`JitterSniper`/`JitterShotgun` |

Tip: The`FloatingPerpMaker` is the best starting point for understanding oracle offset orders in production. The`JitMaker` shows how to use the@drift-labs/jit-proxy library for auction participation.

## Related Resources

- Drift SDK- SDK reference for orders and positions
- Protocol Concepts- Understanding accounts and onchain data
- Keeper Bots- Open source keeper bot infrastructure
- @drift-labs/jit-proxy- JIT proxy SDK with`JitterSniper` and`JitterShotgun`

Last updated on February 27, 2026

Data API Glossary Market Maker Quickstart
