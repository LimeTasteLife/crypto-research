---
type: source
id: dydx-docs-2026-04-28-concepts-trading-limits-rate-limits
title: Rate Limits
publisher: dYdX Docs
author: dYdX team
date: null
original_url: https://docs.dydx.xyz/concepts/trading/limits/rate-limits
mirror_snapshot: dydx-docs-2026-04-28
mirror_page: pages/concepts-trading-limits-rate-limits.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Rate Limits

## TL;DR
Two layers. Block rate limits (CLOB, queryable via `/dydxprotocol/clob/block_rate`): max stateful orders per N blocks (2/block AND 20/100 blocks), max combined short-term orders + cancels per N blocks (4000/5 blocks). Indexer limits: 100 req/10s per IP. WebSocket per-connection channel limits: accounts/parent_accounts 256, candles/markets/orderbook/trades 32 each.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | All rate limits are subject to change; the latest can be queried via `https://.../dydxprotocol/clob/block_rate`. | [[parameters/dydx-v4/rate-limits]] | A1-PI |
| #c2 | Default `max_stateful_orders_per_n_blocks`: 2 stateful order place attempts per block AND 20 per 100 blocks. | [[parameters/dydx-v4/rate-limits]] | A1-PI |
| #c3 | Rate limits are applied in an AND fashion (an order placement must pass all configured rate-limit checks). | [[parameters/dydx-v4/rate-limits]] | A1-PI |
| #c4 | Default `max_short_term_orders_and_cancels_per_n_blocks`: 4,000 per 5 blocks. | [[parameters/dydx-v4/rate-limits]] | A1-PI |
| #c5 | The deprecated fields `max_short_term_order_cancellations_per_n_blocks` and `max_short_term_orders_per_n_blocks` are not used at this time. | [[parameters/dydx-v4/rate-limits]] | A1-PI |
| #c6 | Indexer calls are rate-limited per IP at 100 requests / 10 seconds. | [[parameters/dydx-v4/rate-limits]] | A1-PI |
| #c7 | WebSocket per-connection channel limits: V4_ACCOUNTS_CHANNEL_LIMIT 256, V4_PARENT_ACCOUNTS_CHANNEL_LIMIT 256, V4_CANDLES_CHANNEL_LIMIT 32, V4_MARKETS_CHANNEL_LIMIT 32, V4_ORDERBOOK_CHANNEL_LIMIT 32, V4_TRADES_CHANNEL_LIMIT 32. | [[parameters/dydx-v4/rate-limits]] | A1-PI |
