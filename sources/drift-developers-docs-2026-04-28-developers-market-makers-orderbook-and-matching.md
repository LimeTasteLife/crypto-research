---
type: source
id: drift-developers-docs-2026-04-28-developers-market-makers-orderbook-and-matching
title: Orderbook and Matching
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/developers/market-makers/orderbook-and-matching
mirror_snapshot: drift-developers-docs-2026-04-28
mirror_page: pages/developers-market-makers-orderbook-and-matching.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Orderbook & Matching

## TL;DR
The DLOB (Decentralized Limit Order Book) is Drift's offchain orderbook that aggregates resting limit orders across all UserAccounts (storing orders onchain would be prohibitively expensive). Matching priority on a taker arrival: (1) JIT Auction (~10 slots / 5s) → (2) DLOB (price-time priority on resting orders) → (3) AMM (constant product, last-resort, more slippage) → (4) External fulfillment for spot only (Phoenix, OpenBook, Jupiter aggregator). Two liquidity types in the L2 view: "committed" (DLOB resting orders, firm) and "indicative" (AMM/vAMM curve projections + offchain MM quotes — informational, not firm commitments). REST: `GET https://dlob.drift.trade/l2?marketName=SOL-PERP&depth=10&includeVamm=true&includeIndicative=true`. WebSocket: `wss://dlob.drift.trade/ws`. Critical: `includeVamm=true` is essential for realistic depth; without it, only resting orders show. Prices in raw PRICE_PRECISION (1e6); sizes in BASE_PRECISION (1e9). DLOB server typically lags 1–2s; high load can stretch this — for low-latency strategies build DLOB locally via `DLOBSubscriber + OrderSubscriber`.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | The DLOB (Decentralized Limit Order Book) is Drift's offchain orderbook that aggregates all resting limit orders across user accounts. | [[concepts/operations/matching-engine]] | A1-PI |
| #c2 | Storing a sorted orderbook onchain would be prohibitively expensive on Solana; Drift stores orders in user accounts and DLOB sorts them offchain. | [[concepts/operations/matching-engine]] | A1-PI |
| #c3 | Liquidity matching priority: (1) JIT Auction → (2) DLOB → (3) AMM → (4) external fulfillment (spot only). | [[concepts/operations/matching-engine]] | A4-PI |
| #c4 | After the JIT auction, unfilled order portions match against DLOB resting orders by price-time priority (best price wins; FIFO at tied prices). | [[concepts/operations/matching-engine]] | A4-PI |
| #c5 | If DLOB doesn't fully fill the order, remainder executes against the AMM (constant product, oracle-adjusted) at worse prices (higher fees + price impact). | [[concepts/operations/matching-engine]], [[concepts/market-structure/vamm]] | A4-PI |
| #c6 | For spot markets, the matching engine can route through external DEXs (Phoenix, OpenBook) and Jupiter aggregator when they offer better prices. | [[concepts/operations/matching-engine]] | A1-PI |
| #c7 | DLOB liquidity has two types: committed (real onchain resting limit orders, guaranteed available) and indicative (AMM curve estimates + offchain MM quotes, projections not firm). | [[concepts/operations/matching-engine]] | A4-PI |
| #c8 | The L2 endpoint default URL is `https://dlob.drift.trade/l2`; supports `marketName`, `depth`, `includeVamm`, `includeIndicative` parameters. | [[entities/perpdex/drift]] | - |
| #c9 | DLOB WebSocket endpoint: `wss://dlob.drift.trade/ws`. | [[entities/perpdex/drift]] | - |
| #c10 | L2 prices are in raw PRICE_PRECISION (1e6); sizes are in BASE_PRECISION (1e9). | [[entities/perpdex/drift]] | - |
| #c11 | The L2 `sources` field is an object mapping source names ("dlob", "vamm") to size strings, NOT a flat string. | [[entities/perpdex/drift]] | - |
| #c12 | Hosted DLOB server typically updates within 1–2 seconds of onchain changes; under high load it can lag further. | [[concepts/operations/matching-engine]] | A4-PI |
| #c13 | If the DLOB server goes down, orders remain valid onchain — they're just temporarily not visible in the aggregated orderbook. | [[concepts/operations/matching-engine]] | A6-PI |
| #c14 | The DLOB never modifies onchain state; it is read-only. | [[concepts/operations/matching-engine]] | A6-PI |
