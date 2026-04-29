---
type: concept
domain: market-structure
name: CLOB
last_reviewed: 2026-04-28
disputed: false
---

# CLOB

## Definition
A central limit order book (CLOB) is a market-structure model in which all bids and offers are aggregated into a single shared book per asset, with deterministic priority (typically price-time) for matching[^hl-docs-2026-04-27-hypercore-order-book]. CLOB contrasts with AMM (constant-product / concentrated-liquidity), RFQ (negotiated quote), and vAMM (synthetic-book derived-price) models.

## Mechanism on Hyperliquid

HyperCore maintains a separate CLOB per asset, with orders matched in **price-time priority**[^hl-docs-2026-04-27-hypercore-order-book]. The book lives in the L1 state machine — there is no off-chain matching server[^hl-docs-2026-04-27-hypercore-overview]. Order arrival order within a block is determined by HyperBFT proposer ordering plus the [[concepts/operations/matching-engine|matching engine's]] category rule (cancels resolved before aggressive submissions).

## Variants in the wild

| venue | implements? | priority rule | match location |
|---|---|---|---|
| [[entities/perpdex/hyperliquid]] | yes[^hl-docs-2026-04-27-hypercore-order-book] | price-time[^hl-docs-2026-04-27-hypercore-order-book] | on-chain[^hl-docs-2026-04-27-hypercore-overview] |
| [[entities/perpdex/aster]] | yes — Perpetuals + Spot CLOB; Shield Mode (AMM, separate) and 1001x (on-chain liquidity, separate) coexist[^aster-docs-2026-04-28-overview-what-is-aster][^aster-docs-2026-04-28-trading-perpetuals] | not surfaced (encrypted-order pipeline, cryptographic primitive unspecified)[^aster-docs-2026-04-28-overview-what-is-aster] | on-chain (Aster Chain L1)[^aster-docs-2026-04-28-overview-what-is-aster] |
| [[entities/perpdex/lighter]] | SNARK-proven verifiable CLOB[^lighter-docs-2026-04-28-trading-order-types-and-matching] | price-time; executes at maker's price[^lighter-docs-2026-04-28-trading-order-types-and-matching] | off-chain sequencer + on-chain SNARK proof verification (Ethereum)[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core] |
| [[entities/perpdex/dydx]] | yes — off-chain in-memory CLOB; each validator holds an in-memory order book; block proposers build blocks via price-time priority on local book[^dydx-docs-2026-04-28-concepts-trading-limit-orderbook] | price-time[^dydx-docs-2026-04-28-concepts-trading-limit-orderbook] | off-chain (in-memory per validator, synced to consensus block)[^dydx-docs-2026-04-28-concepts-trading-limit-orderbook] |

(Other perpdex venues to be added in subsequent ingest passes.)

## Disputed claims
None.

## Related
[[concepts/operations/matching-engine]] · [[concepts/market-microstructure/tick-size]] · [[concepts/market-microstructure/lot-size]]

## Sources
[^hl-docs-2026-04-27-hypercore-order-book]: [[sources/hl-docs-2026-04-27-hypercore-order-book]]
[^hl-docs-2026-04-27-hypercore-overview]: [[sources/hl-docs-2026-04-27-hypercore-overview]]
[^aster-docs-2026-04-28-overview-what-is-aster]: [[sources/aster-docs-2026-04-28-overview-what-is-aster]]
[^aster-docs-2026-04-28-trading-perpetuals]: [[sources/aster-docs-2026-04-28-trading-perpetuals]]
[^lighter-docs-2026-04-28-trading-order-types-and-matching]: [[sources/lighter-docs-2026-04-28-trading-order-types-and-matching]]
[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]: [[sources/lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]]
