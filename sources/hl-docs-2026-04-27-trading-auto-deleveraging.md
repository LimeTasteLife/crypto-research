---
type: source
id: hl-docs-2026-04-27-trading-auto-deleveraging
title: Auto-deleveraging
publisher: Hyperliquid Docs
author: Hyperliquid team
date: null
original_url: https://hyperliquid.gitbook.io/hyperliquid-docs/trading/auto-deleveraging
mirror_snapshot: hl-docs-2026-04-27
mirror_page: pages/trading-auto-deleveraging.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-27
---

# Auto-deleveraging

## TL;DR
ADL is the final solvency safeguard. When a user's account value or isolated position becomes negative, opposite-side traders are ranked by `(mark_price/entry_price) * (notional/account_value)` and their positions are closed at the previous mark price against the underwater account. Backstop-liquidated positions get no special treatment in the queue. The platform asserts a strict invariant: a user with no open positions never socializes platform losses.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | ADL triggers when a user's account value or isolated-position value becomes negative. | [[concepts/risk/adl-waterfall]] | A6-PI |
| #c2 | ADL ranks opposite-side traders by `(mark_price / entry_price) * (notional_position / account_value)`. | [[concepts/risk/adl-waterfall]] | A6-PI |
| #c3 | Backstop-liquidated positions receive no special treatment in the ADL queue. | [[concepts/risk/adl-waterfall]] | A6-PI |
| #c4 | ADL closes affected traders' positions at the previous mark price against the underwater user. | [[concepts/risk/adl-waterfall]] | A6-PI |
| #c5 | Strict invariant: a user with no open positions cannot socialize any platform losses. | [[concepts/risk/adl-waterfall]] | A6-PI |
