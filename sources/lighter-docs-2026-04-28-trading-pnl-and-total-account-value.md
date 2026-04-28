---
type: source
id: lighter-docs-2026-04-28-trading-pnl-and-total-account-value
title: PnL And Total Account Value
publisher: Lighter Docs
author: Lighter team
date: null
original_url: https://docs.lighter.xyz/trading/pnl-and-total-account-value
mirror_snapshot: lighter-docs-2026-04-28
mirror_page: pages/trading-pnl-and-total-account-value.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# PnL And Total Account Value

## TL;DR
The PnL page formalizes Lighter's position accounting: Unrealized PnL = sum over positions of (markPrice_i − avgEntryPrice_i) × position_i. Realized PnL is the gain or loss already captured from closing trades plus all funding payments (which apply immediately to realized PnL, not unrealized). When closing partial position, avgEntryPrice is held constant and ΔCollateral = (exitPrice − avgEntryPrice) × Δposition; when adding to a position, no PnL is realized and avgEntryPrice updates by weighted-average with the trade. Total Account Value = Collateral + Unrealized PnL. Isolated positions hold an Allocated Margin balance that functions as collateral but is scoped to a single position. The Spot Trading subsection has a heading but no body in the mirror (gap to refresh later). Distinctively, funding goes to realized PnL immediately rather than accruing as a separate balance.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Unrealized PnL on Lighter shows how much a user would gain or lose if they closed their positions at the current mark price. | [[entities/perpdex/lighter]] | A6-PIV |
| #c2 | Unrealized PnL on Lighter equals the sum over positions of (markPrice_i − avgEntryPrice_i) × position_i. | [[entities/perpdex/lighter]] | A6-PIV |
| #c3 | Realized PnL on Lighter is the gain or loss already captured from a position after closing or due to funding payments. | [[entities/perpdex/lighter]] | A6-PIV |
| #c4 | Realized PnL is calculated based on the difference in USDC value between the user's average entry price and exit price. | [[entities/perpdex/lighter]] | A6-PIV |
| #c5 | All funding payments for a position on Lighter are immediately applied to its realized PnL. | [[entities/perpdex/lighter]] | A6-PIV |
| #c6 | When closing a portion of an existing long or short position on Lighter, the average entry price stays the same and the exchange realizes the difference between average exit and entry prices. | [[entities/perpdex/lighter]] | A6-PIV |
| #c7 | When closing a portion of a position on Lighter, ΔCollateral = (exitPrice_i − avgEntryPrice_i) × Δposition_i. | [[entities/perpdex/lighter]] | A6-PIV |
| #c8 | When increasing the size of an open position on Lighter, no PnL is realized. | [[entities/perpdex/lighter]] | A6-PIV |
| #c9 | When increasing position size on Lighter, the new average entry price is updated as avgEntryPrice_new = (avgEntryPrice_old × position_old + tradePrice × tradeSize) / position_new. | [[entities/perpdex/lighter]] | A6-PIV |
| #c10 | Total Account Value on Lighter represents the total USDC value of an account, including all open positions and collateral. | [[entities/perpdex/lighter]] | A6-PIV |
| #c11 | Total Account Value on Lighter equals Collateral + Unrealized PnL. | [[entities/perpdex/lighter]] | A6-PIV |
| #c12 | Isolated positions on Lighter use a separate collateral balance called Allocated Margin dedicated solely to that specific position. | [[entities/perpdex/lighter]] | A6-PIV |
| #c13 | Allocated Margin functions the same as collateral but applies only to the relevant isolated position and should be treated as collateral in TAV calculations. | [[entities/perpdex/lighter]] | A6-PIV |

## Conflicts raised
- (none)
