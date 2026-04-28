---
type: source
id: lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund
title: Liquidations & LLP (Insurance Fund)
publisher: Lighter Docs
author: Lighter team
date: null
original_url: https://docs.lighter.xyz/trading/liquidations-and-llp-insurance-fund
mirror_snapshot: lighter-docs-2026-04-28
mirror_page: pages/trading-liquidations-and-llp-insurance-fund.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Liquidations & LLP (Insurance Fund)

## TL;DR
Lighter defines a 3-level margin schedule per market: IMR > MMR > CMR (initial > maintenance > close-out). Account Value = Collateral + Σ(markPrice − avgEntryPrice)·position. The liquidation waterfall has 5 states: Healthy (TAV ≥ all reqs); Pre-Liquidation (TAV < IMR, ≥ MMR — only health-improving operations allowed); Partial Liquidation (TAV < MMR, ≥ CMR — open orders cancelled, IoC limit orders sent at zero price; if filled at a better price, up to 1% liquidation fee accrues to LLP); Full Liquidation (TAV < CMR — LLP takes over positions in ascending unrealized PnL order, only if LLP stays above its own IMR); ADL (LLP undercapitalized — bankrupt-account positions matched against opposite-side accounts ranked by leverage and unrealized PnL). User-set leverage caps initial margin at min(user, market-min). Isolated positions follow the same flow but use AllocatedMargin instead of cross collateral.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Each Lighter market has its own margin requirement configuration that defines maximum leverage per position. | [[concepts/risk/margin-tier]], [[parameters/lighter/margin-tiers]] | A6-PI |
| #c2 | Lighter defines three margin requirement levels: Initial (I_i), Maintenance (M_i), Close-Out (C_i), with the strict ordering C_i < M_i < I_i. | [[concepts/risk/margin-tier]] | A6-PI |
| #c3 | Account Value = Collateral + Σ_i (markPrice_i − avgEntryPrice_i) · position_i. | [[concepts/risk/liquidation]] | - |
| #c4 | Initial Margin Requirement = Σ_i |pos_i| · mark_i · I_i; Maintenance Margin Requirement = Σ_i |pos_i| · mark_i · M_i; Close-Out Margin Requirement = Σ_i |pos_i| · mark_i · C_i. | [[concepts/risk/liquidation]] | A6-PI |
| #c5 | When a user changes leverage, the effective initial margin fraction is min(user-set fraction, minimum fraction allowed for the market). | [[concepts/risk/margin-tier]] | A6-PI |
| #c6 | A Healthy account has Account Value greater than all margin requirements; it can execute any operation as long as the post-trade position remains healthy. | [[concepts/risk/liquidation]] | - |
| #c7 | An account is in Pre-Liquidation when Account Value is below IMR but above MMR; only operations that do not decrease the account-value/MMR ratio and do not increase any position size are permitted. | [[concepts/risk/liquidation]] | A6-PI |
| #c8 | In Partial Liquidation, the liquidation engine first cancels all open orders. | [[concepts/risk/liquidation]] | A6-PI |
| #c9 | In Partial Liquidation, after cancelling orders, the engine orders the underwater account's open positions by a heuristic and sends IoC limit orders for the full position amount one by one at the corresponding zero price. | [[concepts/risk/liquidation]] | A6-PI |
| #c10 | The liquidation engine stops liquidations as soon as the user rises above the Maintenance Margin Requirement. | [[concepts/risk/liquidation]] | A6-PI |
| #c11 | If a partial-liquidation trade fills at a better price than the zero price, the liquidation engine takes up to a 1% liquidation fee and sends it to LLP (insurance fund). | [[parameters/lighter/fee-schedule]], [[parameters/lighter/insurance-fund]] | A2-PI, A6-PI |
| #c12 | A trade executed at the zero price preserves the total-account-value to maintenance-margin ratio (i.e. zero price is a health-preserving fill). | [[concepts/risk/liquidation]] | A6-PI |
| #c13 | Zero price (short) = markPrice · (1 + M_i · TAV / MMR). | [[concepts/risk/liquidation]] | A6-PI |
| #c14 | Zero price (long) = markPrice · (1 − M_i · TAV / MMR). | [[concepts/risk/liquidation]] | A6-PI |
| #c15 | Full Liquidation triggers when a user goes below CMR; LLP closes all positions by taking them over in ascending order of unrealized PnL. | [[concepts/risk/liquidation]], [[parameters/lighter/llp]] | A4-PI, A6-PI |
| #c16 | During Full Liquidation, LLP only takes a position over if doing so keeps LLP's total account value above its own Initial Margin Requirement; positions that would push LLP below this threshold are auto-deleveraged instead. | [[parameters/lighter/llp]], [[concepts/risk/adl-waterfall]] | A4-PI, A6-PI |
| #c17 | Auto-Deleveraging (ADL) triggers when an account has negative value AND LLP lacks capital to cover the losses. | [[concepts/risk/adl-waterfall]] | A6-PI |
| #c18 | ADL identifies positions on the opposite side of the bankrupt account's positions and executes trades between them when their zero prices align. | [[concepts/risk/adl-waterfall]] | A6-PI |
| #c19 | ADL execution price cannot be worse than the zero price of the position, ensuring ADL never decreases the health of the counterparty account. | [[concepts/risk/adl-waterfall]] | A6-PI |
| #c20 | ADL counterparty selection ranks users on the opposite side by their leverage and unrealized PnL. | [[concepts/risk/adl-waterfall]] | A6-PI |
| #c21 | Isolated-mode positions are treated as a separate account and are unaffected by other positions; the calculations follow the same waterfall but use AllocatedMargin as the collateral input. | [[concepts/risk/liquidation]] | A6-PI |

## Conflicts raised
- #c11 (1% liquidation fee on partial liquidation fills routed to LLP) vs `lighter-docs-2026-04-28-trading-prelaunch-markets`#c6 (prelaunch markets have no liquidation fee). Not a contradiction — prelaunch is an exception carve-out from the standard fee. Recorded for downstream cross-link.
