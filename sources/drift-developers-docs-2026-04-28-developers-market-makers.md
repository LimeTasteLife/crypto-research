---
type: source
id: drift-developers-docs-2026-04-28-developers-market-makers
title: Market Makers
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/developers/market-makers
mirror_snapshot: drift-developers-docs-2026-04-28
mirror_page: pages/developers-market-makers.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Market Makers

## TL;DR
Drift documents three distinct MM strategies: (1) DLOB MM — resting limit orders on the orderbook (capital locked onchain, lower latency requirements; oracle offset orders strongly recommended); (2) JIT-only — react to taker auctions in real-time (capital deployed only on fill, requires lower-latency infra); (3) SWIFT — receive signed taker orders offchain via WebSocket BEFORE the auction lands onchain (100–500ms latency advantage). All three earn maker rebates. Drift maintains open-source reference bots in keeper-bots-v2: FloatingPerpMaker (oracle offset DLOB strategy) and JitMaker (JIT auction fills via JitterSniper / JitterShotgun from `@drift-labs/jit-proxy`). Recommendation: start with DLOB MM using oracle offset orders.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Drift supports three distinct market making approaches: DLOB MM (resting orders), JIT-only (auction reaction), and SWIFT (offchain signed orders). | [[concepts/mm-agreement/quote-obligation]] | A4-PI |
| #c2 | DLOB MM places resting limit orders on the decentralized orderbook; capital is locked onchain. | [[concepts/mm-agreement/quote-obligation]] | A4-PI |
| #c3 | JIT-only MM reacts to taker auctions in real-time; capital is deployed only when filling. | [[concepts/mm-agreement/quote-obligation]] | A4-PI, A4-PIII |
| #c4 | SWIFT MM receives signed taker orders offchain BEFORE the onchain auction. | [[concepts/mm-agreement/quote-obligation]] | A4-PI, A4-PIII |
| #c5 | All three MM strategies (DLOB, JIT-only, SWIFT) earn maker rebates. | [[parameters/drift/mm-rebate-tiers]] | A2-PI, A4-PI |
| #c6 | Drift's recommendation: start with DLOB MM using oracle offset orders (orders float with oracle automatically, requiring few transactions). | [[concepts/mm-agreement/quote-obligation]] | A4-PI |
| #c7 | SWIFT API gives makers a 100–500ms latency advantage over onchain feeds. | [[parameters/drift/mm-rebate-tiers]] | A4-PIII |
| #c8 | Indicative quotes let makers signal liquidity offchain without committing onchain orders, used by UIs and aggregators. | [[concepts/mm-agreement/quote-obligation]] | A4-PI |
| #c9 | Drift maintains open-source reference bots in keeper-bots-v2: FloatingPerpMaker (`src/bots/floatingMaker.ts`) for oracle-offset DLOB and JitMaker (`src/bots/jitMaker.ts`) for JIT auction fills. | [[parameters/drift/mm-rebate-tiers]] | A4-PI |
| #c10 | The JitMaker uses `@drift-labs/jit-proxy` library with `JitterSniper` (single precise fill) and `JitterShotgun` (multiple fill attempts) helpers. | [[parameters/drift/mm-rebate-tiers]] | A4-PI |
