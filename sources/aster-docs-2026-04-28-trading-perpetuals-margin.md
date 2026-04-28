---
type: source
id: aster-docs-2026-04-28-trading-perpetuals-margin
title: Margin
publisher: Aster Docs
author: Aster team
date: null
original_url: https://docs.asterdex.com/trading/perpetuals/margin
mirror_snapshot: aster-docs-2026-04-28
mirror_page: pages/trading-perpetuals-margin.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Margin

## TL;DR
Aster Perps offers two margin modes: Cross (default; collateral is pooled across all positions, allowing offsetting PnL but exposing the entire balance) and Isolated (margin is locked to one position only). Initial margin is computed as (Position size × Mark price) / Leverage. Each asset has its own maximum leverage cap. Maintenance margin is tier-based on total position size, with progressively higher rates as size increases — meaning leverage selection alone does not determine maintenance requirements; size does. Margin mode cannot be changed after a position or open order has been submitted.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Margin trading on Aster Perps lets users amplify positions using leverage. | [[entities/perpdex/aster]] | - |
| #c2 | With 10× leverage, a $100 margin allows opening a $1,000 position. | [[concepts/risk/margin-tier]] | - |
| #c3 | Each asset has its own maximum leverage limit. | [[parameters/aster/listed-markets-roster]] | A6-PIV |
| #c4 | Initial margin formula: (Position size × Mark price) / Leverage. | [[concepts/risk/margin-tier]] | - |
| #c5 | Aster supports two margin modes: Cross Margin and Isolated Margin. | [[concepts/risk/margin-tier]] | - |
| #c6 | Cross Margin is the default mode on Aster. | [[concepts/risk/margin-tier]] | A6-PIV |
| #c7 | In Cross Margin, margin is shared across all open positions. | [[concepts/risk/margin-tier]] | - |
| #c8 | In Cross Margin, profits from one trade can offset losses in another. | [[concepts/risk/margin-tier]] | - |
| #c9 | In Cross Margin, the entire margin balance is at stake across positions. | [[concepts/risk/margin-tier]] | - |
| #c10 | In Isolated Margin, margin is applied to a single position only. | [[concepts/risk/margin-tier]] | - |
| #c11 | In Isolated Margin, only the margin tied to that position is at risk if the trade moves against the trader. | [[concepts/risk/margin-tier]] | - |
| #c12 | Margin mode cannot be changed after submitting a position or placing an open order. | [[concepts/risk/margin-tier]] | A6-PIV |
| #c13 | Maintenance margin is the minimum amount required to keep a position open. | [[concepts/risk/margin-tier]] | - |
| #c14 | Maintenance margin is based on total position size rather than leverage selected. | [[concepts/risk/margin-tier]] | A6-PIV |
| #c15 | As position size increases, higher portions fall into higher maintenance margin tiers with progressively higher rates. | [[concepts/risk/margin-tier]] | A6-PIV |
| #c16 | Used margin, liquidation price, and available balance are displayed in real time in the position panel. | [[entities/perpdex/aster]] | - |
| #c17 | If margin falls below maintenance requirement, the position may be liquidated. | [[concepts/risk/liquidation]] | - |
