---
type: source
id: dydx-docs-2026-04-28-concepts-trading-orders
title: Orders
publisher: dYdX Docs
author: dYdX team
date: null
original_url: https://docs.dydx.xyz/concepts/trading/orders
mirror_snapshot: dydx-docs-2026-04-28
mirror_page: pages/concepts-trading-orders.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Orders

## TL;DR
Orders split by lifetime: short-term orders (in-memory, ≤20-block GTB, ~30s; intended for MMs and market orders; cancellation is best-effort gossip) vs stateful (long-term + conditional; on-chain, GTBT up to 95 days). Long-term orders are placed in the next block (N+1). Conditional orders trigger when oracle price crosses an LTE/GTE threshold. Six order types: Market, Limit, Stop Market, Stop Limit, Take Profit Market, Take Profit Limit. TWAP orders added in v9.0 with OrderFlags=128.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Short-term orders are short-lived orders that are not stored on-chain unless filled; they stay in-memory of validators for up to 20 blocks. | [[entities/perpdex/dydx-v4]] | A1-PI |
| #c2 | Short-term orders are mainly intended for market makers with high throughput or market orders. | [[entities/perpdex/dydx-v4]] | A4-PI |
| #c3 | Long-term orders are stateful orders committed to the blockchain, surviving longer than the short block window. | [[entities/perpdex/dydx-v4]] | A1-PI |
| #c4 | The default short block window is 20 blocks (~30 seconds). | [[entities/perpdex/dydx-v4]] | A1-PI |
| #c5 | Short-term order expirations use Good-Till-Block (GTB), maximum of current block height + ShortBlockWindow. | [[entities/perpdex/dydx-v4]] | A1-PI |
| #c6 | IoC and FoK orders are short-term orders and do not survive a network restart. | [[entities/perpdex/dydx-v4]] | A1-PI |
| #c7 | Short-term order cancellation is best-effort: only gossiped, not in MsgProposedOperations. | [[entities/perpdex/dydx-v4]] | A4-PI |
| #c8 | Long-Term orders are placed in the block after they are written to state (e.g. MsgPlaceOrder in block N → matching in block N+1). | [[entities/perpdex/dydx-v4]] | A1-PI |
| #c9 | Long-term orders disallow IoC/FoK time-in-force values (since they require immediate execution). | [[entities/perpdex/dydx-v4]] | A1-PI |
| #c10 | Conditional orders execute when the oracle price becomes either LTE (stop-loss sell) or GTE (take-profit buy) the trigger price. | [[entities/perpdex/dydx-v4]] | A1-PI |
| #c11 | Stateful order expirations use Good-Till-Block-Time (GTBT), maximum of current block time + StatefulOrderTimeWindow (currently 95 days). | [[entities/perpdex/dydx-v4]] | A1-PI |
| #c12 | Valid OrderFlags for stateful orders: 32 (conditional), 64 (long-term), 128 (TWAP). | [[entities/perpdex/dydx-v4]] | A1-PI |
| #c13 | dYdX supports six order types: Market, Limit, Stop Market, Stop Limit, Take Profit Market, Take Profit Limit. | [[entities/perpdex/dydx-v4]] | A1-PI |
| #c14 | Stop Market orders trigger when either the Oracle Price or the last traded price crosses the trigger price. | [[entities/perpdex/dydx-v4]] | A1-PI |
| #c15 | TWAP (Time-Weighted Average Price) orders were released in v9.0; OrderFlags must be set to 128. | [[entities/perpdex/dydx-v4]], [[parameters/dydx-v4/upgrade-history]] | A1-PI |
| #c16 | Front-end submits market orders as Immediate-or-Cancel by default (any unfilled portion is cancelled). | [[entities/perpdex/dydx-v4]] | A1-PI |
