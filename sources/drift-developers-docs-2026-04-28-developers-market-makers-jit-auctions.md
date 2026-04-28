---
type: source
id: drift-developers-docs-2026-04-28-developers-market-makers-jit-auctions
title: JIT Auctions
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/developers/market-makers/jit-auctions
mirror_snapshot: drift-developers-docs-2026-04-28
mirror_page: pages/developers-market-makers-jit-auctions.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# JIT Auctions

## TL;DR
JIT (Just-In-Time) auctions are Drift's primary price-discovery mechanism. When a taker arrives, the order enters an auction where MMs compete to fill at better prices BEFORE it falls through to DLOB or AMM. Three auction parameters: `auctionDuration` (typically 10 slots ≈ 5s), `auctionStartPrice` (taker's BEST price — highest a long would pay), `auctionEndPrice` (taker's WORST acceptable price, closer to limit/oracle). Reverse-Dutch dynamic: starts at taker's best price, deteriorates toward worst. Linear interpolation: `Auction Price(slot) = start + (end − start) × min(1, (current − start_slot) / duration)`. Multi-maker fills supported, pro-rata by best price. After unfilled, falls through to DLOB then AMM. JitterSniper (one precise fill attempt) vs JitterShotgun (multiple slot attempts; higher fill rate, higher compute cost). Compute budget for place-and-make: 400–800k CU (JitMaker defaults to 800k). Auction slots are Solana slots (~400ms), not wall-clock seconds — congestion stretches timing.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | JIT auctions are Drift's price-discovery mechanism: taker orders enter an auction where market makers compete to fill at better prices before the order hits DLOB or AMM. | [[concepts/market-microstructure/jit-auction]] | A4-PI |
| #c2 | Auction parameters: `auctionDuration` (slots, typically 10 ≈ 5 seconds), `auctionStartPrice` (taker's best price), `auctionEndPrice` (taker's worst acceptable price). | [[concepts/market-microstructure/jit-auction]] | A4-PI |
| #c3 | Auction is a reverse Dutch auction: starts at the taker's best price and deteriorates toward their worst acceptable price. | [[concepts/market-microstructure/jit-auction]] | A4-PI |
| #c4 | Auction price interpolation: `Auction Price(slot) = start_price + (end_price − start_price) × min(1, (current_slot − start_slot) / duration)`. | [[concepts/market-microstructure/jit-auction]] | A4-PI |
| #c5 | Multiple makers can fill the same taker order; better prices get priority (pro-rata best-price allocation). | [[concepts/market-microstructure/jit-auction]] | A4-PI |
| #c6 | After auction expiry, unfilled taker size matches against DLOB, then against AMM as last-resort fill. | [[concepts/operations/matching-engine]] | A4-PI |
| #c7 | JIT first vs DLOB second priority: JIT auction runs first, DLOB is fallback if auction doesn't fully fill. | [[concepts/operations/matching-engine]] | A4-PI |
| #c8 | Auction slots are measured in Solana slots (~400ms), not wall-clock seconds; network congestion stretches slot times and affects auction timing. | [[concepts/market-microstructure/jit-auction]] | A4-PI |
| #c9 | Place-and-make compute budget should be 400–800k CU; JitMaker defaults to 800k; under-budgeting causes silent failures. | [[parameters/drift/mm-rebate-tiers]] | A4-PI |
| #c10 | `JitterSniper`: waits for the optimal auction slot before submitting a single fill transaction (precise pricing, lower compute cost). | [[parameters/drift/mm-rebate-tiers]] | A4-PI |
| #c11 | `JitterShotgun`: submits fill transactions at multiple auction slots simultaneously (higher fill rate, more compute and SOL fees). | [[parameters/drift/mm-rebate-tiers]] | A4-PI |
| #c12 | Auction adds 5–10 slot delay (~2–5 seconds) before taker execution but provides better prices. | [[concepts/market-microstructure/jit-auction]] | A4-PI |
| #c13 | Limit orders that don't cross the spread bypass the auction entirely. | [[concepts/operations/matching-engine]] | A4-PI |
