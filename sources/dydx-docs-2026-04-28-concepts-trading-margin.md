---
type: source
id: dydx-docs-2026-04-28-concepts-trading-margin
title: Margining
publisher: dYdX Docs
author: dYdX team
date: null
original_url: https://docs.dydx.xyz/concepts/trading/margin
mirror_snapshot: dydx-docs-2026-04-28
mirror_page: pages/concepts-trading-margin.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Margining

## TL;DR
Two per-market risk parameters: IMF (initial margin fraction, can scale with OI) and MMF (maintenance margin fraction, fixed). Open-Interest-Based IMF: scales linearly between `open_notional_lower_cap` and `open_notional_upper_cap` from base IMF up to 100% (1:1 collateral). MMF stays constant. Per-position margin = abs(S × P × IMF/MMF). Total Account Value = USDC quote balance + Σ(Si × Pi). Account cannot open new positions or grow existing ones if it would push TAV below total IMR; if TAV ever falls below total MMR, the account becomes liquidatable. Free collateral = TAV − Total IMR.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Each market has two risk parameters: Initial Margin Fraction (IMF) and Maintenance Margin Fraction (MMF). | [[concepts/risk/margin-tier]], [[parameters/dydx-v4/margin-tiers]] | A6-PI |
| #c2 | The IMF determines the minimum collateral required to open or increase positions; the MMF determines the minimum collateral required to maintain positions and avoid liquidation. | [[concepts/risk/margin-tier]] | - |
| #c3 | The IMF of a market scales linearly according to the current open_notional, starting at open_notional_lower_cap and reaching 100% at open_notional_upper_cap. | [[parameters/dydx-v4/margin-tiers]] | A6-PI |
| #c4 | open_notional = open_interest × oracle_price. | [[parameters/dydx-v4/margin-tiers]] | - |
| #c5 | scaling_factor = (open_notional − open_notional_lower_cap) / (open_notional_upper_cap − open_notional_lower_cap). | [[parameters/dydx-v4/margin-tiers]] | A6-PI |
| #c6 | IMF_increase = scaling_factor × (1 − base_IMF); effective_IMF = Min(base_IMF + Max(IMF_increase, 0), 100%). | [[parameters/dydx-v4/margin-tiers]] | A6-PI |
| #c7 | MMF (Maintenance Margin Fraction) does not change with OI scaling — only IMF does. | [[parameters/dydx-v4/margin-tiers]] | A6-PI |
| #c8 | Per-position Initial Margin Requirement = abs(S × P × I); per-position Maintenance Margin Requirement = abs(S × P × M). | [[concepts/risk/margin-tier]] | - |
| #c9 | Total Account Value (equity) = Q + Σ(Si × Pi), where Q is USDC quoteBalance. | [[concepts/risk/liquidation]] | - |
| #c10 | quoteBalance changes on every transfer/deposit/withdrawal, position modification, funding payment, and liquidation. | [[entities/perpdex/dydx-v4]] | - |
| #c11 | An account cannot open new positions or increase existing position sizes if doing so would push total account value below the total initial margin requirement. | [[concepts/risk/margin-tier]] | A6-PI |
| #c12 | If total account value falls below the total maintenance margin requirement, the account may be liquidated. | [[concepts/risk/liquidation]] | A6-PI |
| #c13 | Free collateral = Total Account Value − Total Initial Margin Requirement. | [[concepts/risk/margin-tier]] | - |
