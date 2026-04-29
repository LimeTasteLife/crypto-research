---
type: source
id: drift-developers-docs-2026-04-28-developers-market-makers-swift-api
title: SWIFT API
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/developers/market-makers/swift-api
mirror_snapshot: drift-developers-docs-2026-04-28
mirror_page: pages/developers-market-makers-swift-api.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# SWIFT API

## TL;DR
SWIFT (Signed Wrapped Instant Fulfillment Transactions) lets MMs receive signed taker orders offchain via WebSocket BEFORE they hit the JIT auction. Latency advantage: 100–500ms head-start on standard onchain auction flow (which takes 1–2s minimum from taker tx submission). Flow: taker signs order offchain → broadcasts to SWIFT WebSocket simultaneously with submitting onchain → maker receives via WebSocket → maker submits `placeAndMakeSignedMsgPerpOrder` (atomic, includes ed25519 verification of taker's signature). Default endpoint: `wss://swift.drift.trade/ws`. Subscribe via `SwiftOrderSubscriber` with keypair (used for WebSocket auth). Pair with `UserMap` `userAccountGetter` to inspect taker positions/health for toxic flow filtering. Same maker rebates as standard fills, no additional fees. ed25519 instruction must be FIRST in the transaction (SDK handles, but manual builders must order correctly — silent verification failures otherwise). Latency advantage is perishable — needs dedicated RPC node with staked connections. Fallback to `AuctionSubscriber` if SWIFT WebSocket disconnects.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | SWIFT (Signed Wrapped Instant Fulfillment Transactions) allows market makers to receive signed taker orders offchain via WebSocket before they hit the JIT auction. | [[concepts/market-microstructure/jit-auction]] | A4-PIII |
| #c2 | SWIFT provides a 100–500ms head-start: makers see orders before they land onchain. | [[concepts/market-microstructure/jit-auction]] | A4-PIII |
| #c3 | Standard onchain auction flow takes 1–2 seconds minimum from taker tx submission to maker visibility (vs. 100–500ms via SWIFT). | [[concepts/market-microstructure/jit-auction]] | A4-PI |
| #c4 | The taker broadcasts the signed order to the SWIFT WebSocket SIMULTANEOUSLY with submitting it onchain. | [[concepts/operations/matching-engine]] | A4-PIII |
| #c5 | SWIFT fills use the special instruction `placeAndMakeSignedMsgPerpOrder` which includes ed25519 signature verification. | [[concepts/operations/matching-engine]] | A4-PI |
| #c6 | Default SWIFT WebSocket endpoint is `wss://swift.drift.trade/ws` (or environment-derived from driftEnv). | [[concepts/operations/matching-engine]] | - |
| #c7 | The ed25519 verification instruction MUST be the first instruction in the transaction; manual builders that mis-order it cause silent verification failures. | [[concepts/operations/matching-engine]] | A4-PI |
| #c8 | SWIFT fills pay the same maker rebates as regular fills; no additional SWIFT-specific fees. | [[parameters/drift/mm-rebate-tiers]] | A2-PI, A4-PI |
| #c9 | SWIFT is not guaranteed flow: not all taker orders go through SWIFT (takers using the standard SDK flow submit directly onchain). | [[concepts/operations/matching-engine]] | A4-PI |
| #c10 | Makers should subscribe to both SWIFT and `AuctionSubscriber` for complete coverage and use `isSignedMsgOrder()` to deduplicate. | [[concepts/operations/matching-engine]] | A4-PI |
| #c11 | The SWIFT latency advantage is perishable — needs dedicated RPC node with staked connections to capitalize on it. | [[concepts/operations/matching-engine]] | A4-PI |
| #c12 | SWIFT signed orders carry a `maxTs` field; fill transactions landing after this timestamp will fail. | [[concepts/operations/matching-engine]] | A4-PI |
| #c13 | If the SWIFT WebSocket disconnects, MM bots should fall back seamlessly to `AuctionSubscriber` — a SWIFT outage shouldn't prevent fills. | [[parameters/drift/mm-rebate-tiers]] | A4-PII |
