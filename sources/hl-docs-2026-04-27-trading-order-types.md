---
type: source
id: hl-docs-2026-04-27-trading-order-types
title: Order Types
publisher: Hyperliquid Docs
author: Hyperliquid team
date: null
original_url: https://hyperliquid.gitbook.io/hyperliquid-docs/trading/order-types
mirror_snapshot: hl-docs-2026-04-27
mirror_page: pages/trading-order-types.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-27
---

# Order Types

## TL;DR
Documents Hyperliquid's order-type catalog: Market, Limit, Stop Market, Stop Limit, Take Market, Take Limit, Scale, and TWAP. Order options include Reduce Only, GTC, Post Only / ALO, IOC, Take Profit, and Stop Loss. TWAPs are split into 30-second sub-orders, each capped at 3% slippage and at 3× normal sub-order size when catching up. TP/SL orders are automatically routed as market orders; users can also configure limit-price and partial-position TP/SL. TWAP and other market orders do not fill during the post-only period of a network upgrade.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Hyperliquid supports Market, Limit, Stop Market, Stop Limit, Take Market, Take Limit, Scale, and TWAP order types. | [[entities/perpdex/hyperliquid]] |  |
| #c2 | TWAP splits a large order into sub-orders executed every 30 seconds. | [[entities/perpdex/hyperliquid]] |  |
| #c3 | TWAP sub-orders have a maximum slippage of 3% per sub-order. | [[entities/perpdex/hyperliquid]] | A4-PIII |
| #c4 | When TWAP sub-orders fall behind their execution target, later sub-orders are larger but capped at 3× the normal sub-order size. | [[entities/perpdex/hyperliquid]] |  |
| #c5 | TWAP sub-orders (like normal market orders) do not fill during the post-only period of a network upgrade. | [[entities/perpdex/hyperliquid]] | A8-PII |
| #c6 | Order options include Reduce Only, GTC, Post Only (ALO), IOC, Take Profit, and Stop Loss. | [[entities/perpdex/hyperliquid]] |  |
| #c7 | TP and SL orders are automatically market orders; users can configure a limit price and partial-position size. | [[entities/perpdex/hyperliquid]] |  |
| #c8 | Stop-market triggers require trigger > mid for longs and trigger < mid for shorts; Take-market triggers are the inverse. | [[entities/perpdex/hyperliquid]] |  |
