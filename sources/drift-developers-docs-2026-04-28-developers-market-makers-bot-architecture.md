---
type: source
id: drift-developers-docs-2026-04-28-developers-market-makers-bot-architecture
title: Bot Architecture Patterns
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/developers/market-makers/bot-architecture
mirror_snapshot: drift-developers-docs-2026-04-28
mirror_page: pages/developers-market-makers-bot-architecture.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Bot Architecture Patterns

## TL;DR
Production patterns from keeper-bots-v2 applicable to MM, filling, and triggering bots. (1) Subscription resync: `OrderSubscriber` with `resubTimeoutMs: 30_000` and `resyncIntervalMs: 300_000` — WebSocket can silently miss updates, periodic resync corrects drift. (2) Mutex-guarded periodic tasks via `async-mutex` to prevent concurrent execution. (3) Throttling: cooldown between attempts on same node. (4) Priority fees via `PriorityFeeSubscriber` + `ComputeBudgetProgram.setComputeUnitPrice`; place-and-make typically uses 200–400k CU. (5) Address Lookup Tables (ALTs) compress transactions under Solana's 1232-byte limit. (6) Health monitoring: cancel-all if free-collateral or leverage thresholds breach. (7) Graceful shutdown on SIGINT/SIGTERM/uncaughtException — cancel all orders before exit (avoid being picked off offline). (8) Error patterns: BlockhashNotFound (retry), exceeded CUs (raise budget), insufficient lamports (don't retry), PostOnlyOrderWouldBeFilled (price moved, skip). (9) Risk filters: oracle validity + confidence, position limits, toxic flow, divergence checks. (10) Subaccount isolation: 1 subaccount per market for multi-market strategies. Gotchas: WebSocket silent failures (>60s no update → force reconnect), priority-fee spike caps, blockhash 60s expiry.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Production Drift bots should use `OrderSubscriber` with `resubTimeoutMs: 30_000` (auto-resubscribe after 30s of no update) and `resyncIntervalMs: 300_000` (full resync every 5 minutes). | [[parameters/drift/mm-rebate-tiers]] | A4-PI |
| #c2 | WebSocket subscriptions can silently miss updates (dropped messages, RPC hiccups); periodic resync prevents local-state drift from onchain reality. | [[parameters/drift/mm-rebate-tiers]] | A4-PI |
| #c3 | Use a mutex (e.g. `async-mutex`) to prevent overlapping execution of periodic bot tasks (quote refresh, risk checks, rebalancing). | [[parameters/drift/mm-rebate-tiers]] | A4-PI |
| #c4 | Place-and-make transactions typically use 200–400k compute units; explicit setting avoids both 200k default failures and 1.4M overpayment. | [[parameters/drift/mm-rebate-tiers]] | A4-PI |
| #c5 | Drift transactions reference many accounts; Address Lookup Tables (ALTs) are required to stay under Solana's 1232-byte transaction limit. | [[entities/perpdex/drift]] | - |
| #c6 | Solana blockhashes expire after ~60 seconds; bots should set `lastValidBlockHeight` for reliable expiry detection. | [[entities/perpdex/drift]] | - |
| #c7 | MM bots should monitor free collateral and leverage and emergency-cancel all orders if thresholds are breached. | [[parameters/drift/mm-rebate-tiers]] | A4-PI |
| #c8 | MM bots should cancel all resting orders on graceful shutdown (SIGINT/SIGTERM/uncaughtException) to avoid being picked off while offline (adverse selection). | [[parameters/drift/mm-rebate-tiers]] | A4-PII |
| #c9 | Common Solana tx errors with handling: BlockhashNotFound (retry), exceeded CUs (raise CU limit), insufficient lamports (don't retry, top up), PostOnlyOrderWouldBeFilled (price moved, skip). | [[entities/perpdex/drift]] | - |
| #c10 | Risk filters for JIT/SWIFT fills: oracle validity, oracle confidence threshold, position limits, toxic flow detection, divergence checks. | [[parameters/drift/mm-rebate-tiers]] | A4-PIII, A6-PI |
| #c11 | For multi-market MM strategies, use 1:1 subaccount-to-market isolation to avoid order conflicts and simplify position tracking. | [[parameters/drift/mm-rebate-tiers]] | A4-PI |
| #c12 | During congestion, Solana priority fees can spike 100x; bots must enforce a `maxPriorityFee` cap to avoid draining SOL balance. | [[parameters/drift/mm-rebate-tiers]] | A4-PI |
| #c13 | Solana WebSocket connections can stop delivering updates without disconnecting; bots should monitor last-update timestamp and force-reconnect if stale >60s. | [[parameters/drift/mm-rebate-tiers]] | A4-PI |
