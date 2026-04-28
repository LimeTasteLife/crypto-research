---
type: source
id: drift-developers-docs-2026-04-28-developers-drift-sdk-dlob
title: SDK DLOB
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/developers/drift-sdk/dlob
mirror_snapshot: drift-developers-docs-2026-04-28
mirror_page: pages/developers-drift-sdk-dlob.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# DLOB (Decentralized Limit Order Book)

## TL;DR
The DLOB is Drift's on-chain representation of all resting limit orders across all users — but unlike a traditional centralized orderbook, it's constructed locally by reading on-chain user accounts and aggregating their open limit orders into a price-ordered book. SDK classes: `OrderSubscriber` (raw stream of all open user orders via WebSocket or polling), `DLOBSubscriber` (aggregates the order stream into a maintained L2/L3 orderbook with configurable `updateFrequency`), `SlotSubscriber` (tracks current Solana slot — required for JIT auction window timing and order expiry checks), `DLOB` (core data structure with bid/ask sides; usually accessed via `dlobSubscriber.getDLOB()`). A keeper or MM bot needs at minimum OrderSubscriber + DLOBSubscriber + SlotSubscriber to maintain a local view. The DLOB matching engine routes through JIT → DLOB → AMM as fallback.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | The DLOB is constructed locally by reading on-chain user accounts and aggregating their open limit orders into a price-ordered book. | [[concepts/operations/matching-engine]] | A1-PI |
| #c2 | Drift's matching engine executes fills between an incoming taker and resting makers on the DLOB, or routes to the AMM as a fallback. | [[concepts/operations/matching-engine]] | A4-PI |
| #c3 | `OrderSubscriber` provides the raw stream of all open user orders via WebSocket or polling; required for maintaining a local DLOB. | [[entities/perpdex/drift]] | - |
| #c4 | `DLOBSubscriber` builds and continuously maintains an aggregated orderbook from the order stream with configurable `updateFrequency`. | [[entities/perpdex/drift]] | - |
| #c5 | `SlotSubscriber` tracks the current Solana slot; required for timing-sensitive operations like JIT auction windows and order expiry checks. | [[entities/perpdex/drift]] | - |
| #c6 | The `DLOB` class is the core data structure with bid/ask sides and query methods; under normal usage accessed via `dlobSubscriber.getDLOB()` rather than instantiated directly. | [[entities/perpdex/drift]] | - |
