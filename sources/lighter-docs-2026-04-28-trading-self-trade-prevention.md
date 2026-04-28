---
type: source
id: lighter-docs-2026-04-28-trading-self-trade-prevention
title: Self-Trade Prevention
publisher: Lighter Docs
author: Lighter team
date: null
original_url: https://docs.lighter.xyz/trading/self-trade-prevention
mirror_snapshot: lighter-docs-2026-04-28
mirror_page: pages/trading-self-trade-prevention.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Self-Trade Prevention

## TL;DR
The Self-Trade Prevention page is a one-paragraph stub. Lighter's STP rule is: when a same-account taker order would match against a same-account maker order, the resting maker is canceled instead of executing the trade. The page's stated rationale is to avoid the no-position-change-but-fees-paid degenerate outcome of a self-cross. This is a "cancel-resting" STP variant (as distinct from cancel-newest, decrement-and-cancel, or cancel-both), which is meaningful for order management strategy (a self-cross silently knocks out the older maker quote rather than the newer one). No carve-outs for sub-accounts, fees-only-skip mode, or master-account scoping are documented here.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Lighter imposes a self-trade prevention mechanism. | [[entities/perpdex/lighter]] | A4-PIII |
| #c2 | Trades between the same account on Lighter cancel the resting (maker) order instead of executing the trade. | [[entities/perpdex/lighter]] | A4-PIII |
| #c3 | Without self-trade prevention, self-trades would result in no position change and fees being paid unnecessarily, per Lighter's stated rationale. | [[entities/perpdex/lighter]] | A4-PIII |

## Conflicts raised
- (none)
