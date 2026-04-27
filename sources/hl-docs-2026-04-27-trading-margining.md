---
type: source
id: hl-docs-2026-04-27-trading-margining
title: Margining
publisher: Hyperliquid Docs
author: Hyperliquid team
date: null
original_url: https://hyperliquid.gitbook.io/hyperliquid-docs/trading/margining
mirror_snapshot: hl-docs-2026-04-27
mirror_page: pages/trading-margining.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-27
---

# Margining

## TL;DR
Margin computations follow CEX-style formulas. Cross margin is default; isolated margin is opt-in. Some assets are "strict isolated" (margin removal disabled). HIP-3 introduces additional cross-margin behavior depending on account abstraction (unified vs portfolio-margin pools cross-DEX collateral; standard abstraction limits cross to within-DEX). Initial margin = position_size * mark_price / leverage. Leverage is checked only at order submission; users self-monitor afterward. Unrealized PnL is withdrawable subject to a transfer floor: max(initial_margin_required, 0.1 * total_position_value). Cross liquidations trigger when account value < maintenance_margin × open_notional; maintenance margin = half of initial margin at max leverage.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Cross margin shares collateral across all cross positions; isolated margin bounds collateral and risk to a single position. | [[concepts/risk/margin-tier]] |  |
| #c2 | "Strict isolated" margin mode disables removal of margin from the position; margin only releases proportionally as the position is closed. | [[concepts/risk/margin-tier]] |  |
| #c3 | Under unified or portfolio-margin account abstraction, cross-margin positions in HIP-3 DEXs with the same collateral share margin across DEXs. | [[concepts/risk/margin-tier]], [[entities/perpdex/hyperliquid]] | A6-PI |
| #c4 | Under standard account abstraction, cross-margin only applies to assets within the same DEX. | [[concepts/risk/margin-tier]] | A6-PI |
| #c5 | HIP-3 DEXs support a "no cross" margin mode (isolated with margin removal, no cross). | [[concepts/risk/margin-tier]] |  |
| #c6 | Leverage may be set to any integer in [1, max_leverage]; max leverage is per-asset. | [[concepts/risk/leverage-cap]] |  |
| #c7 | Initial margin to open = position_size * mark_price / leverage. | [[concepts/risk/margin-tier]] |  |
| #c8 | Leverage is only checked on opening a position; users are responsible for monitoring afterward to avoid liquidation. | [[concepts/risk/margin-tier]] | A6-PI |
| #c9 | Leverage of an existing position can be increased without closing it. | [[concepts/risk/leverage-cap]] |  |
| #c10 | Cross unrealized PnL is automatically available as initial margin for new positions; isolated unrealized PnL acts as additional margin on the open position. | [[concepts/risk/margin-tier]] |  |
| #c11 | Transfer-margin floor: transfer_margin_required = max(initial_margin_required, 0.1 * total_position_value). | [[concepts/risk/margin-tier]] | A6-PI |
| #c12 | "Transferring" margin includes withdrawals, transfers to spot wallet, and isolated-margin transfers (any non-trading margin removal). | [[concepts/risk/margin-tier]] |  |
| #c13 | Cross positions liquidate when account_value (incl. unrealized PnL) < maintenance_margin × total_open_notional. | [[concepts/risk/liquidation]] | A6-PI |
| #c14 | Maintenance margin is set to half of the initial margin at max leverage. | [[concepts/risk/liquidation]] | A6-PI |
| #c15 | Isolated positions liquidate using the same maintenance-margin rule restricted to the isolated margin and notional. | [[concepts/risk/liquidation]] |  |
