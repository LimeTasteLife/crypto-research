---
type: source
id: dydx-docs-2026-04-28-concepts-trading-liquidations
title: Liquidations
publisher: dYdX Docs
author: dYdX team
date: null
original_url: https://docs.dydx.xyz/concepts/trading/liquidations
mirror_snapshot: dydx-docs-2026-04-28
mirror_page: pages/concepts-trading-liquidations.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Liquidations

## TL;DR
Accounts below maintenance margin are auto-liquidated by protocol-generated liquidation matches that use a calculated "Fillable Price" as the limit. Profits/losses go to the insurance fund. Maximum Liquidation Penalty is 1.5% (governance-adjustable). Isolated liquidation price formula: `p' = (e − s × p) / (|s| × MMF − s)`. Cross uses the same with subtracted other-position MMR. Fillable price formula: `Fillable = P × (1 − ((SMMR × MMF) × (BA × (1 − Q))))` where Q = TotalAccountValue / TotalMaintenanceMarginRequirement. The "close price" is the actual maker-side fill, not the fillable price (so fills can be better than the limit). Oracle price (not last-trade) drives liquidation eligibility.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Accounts whose total value falls below maintenance margin requirement may have positions automatically closed by the liquidation engine. | [[concepts/risk/liquidation]] | A6-PI |
| #c2 | Liquidation orders use a calculated "Fillable Price" as the limit price, matched against liquidity resting on the order book. | [[concepts/risk/liquidation]] | A6-PI |
| #c3 | Profits/losses from liquidations are taken on by the insurance fund. | [[parameters/dydx-v4/insurance-fund]] | A6-PI |
| #c4 | A liquidated subaccount may have its position partially or fully closed, determined by the liquidations configuration. | [[concepts/risk/liquidation]] | A6-PI |
| #c5 | The Maximum Liquidation Penalty default is 1.5%; the entire remaining account value may be taken as penalty up to this limit and transferred to insurance fund. | [[parameters/dydx-v4/liquidation-params]] | A2-PI, A6-PI |
| #c6 | The 1.5% liquidation fee is subject to adjustment by the applicable Governance Community. | [[parameters/dydx-v4/liquidation-params]] | A7-PI |
| #c7 | Isolated liquidation price formula: `p' = (e − s × p) / (|s| × MMF − s)`, where e=equity, s=position size (signed), p=position entry price, MMF=maintenance margin fraction. | [[concepts/risk/liquidation]] | A6-PI |
| #c8 | Cross liquidation price formula: `p' = (e − s × p − MMR_o) / (|s| × MMF − s)`, where MMR_o is the maintenance margin requirement of all other positions. | [[concepts/risk/liquidation]] | A6-PI |
| #c9 | Fillable Price = P × (1 − ((SMMR × MMF) × (BA × (1 − Q)))), where SMMR=spread to maintenance margin ratio, BA=bankruptcy adjustment ≥1, Q=V/TMMR. | [[concepts/risk/liquidation]] | A6-PI |
| #c10 | The actual close price is the sub-tick of whatever maker order(s) the liquidation order matches against; the fillable price is only the limit. | [[concepts/risk/liquidation]] | A6-PI |
| #c11 | Oracle Price (not last traded) is used to estimate the value of an account's positions for liquidation eligibility. | [[concepts/risk/liquidation]] | A6-PI |
| #c12 | The insurance fund receives liquidation fees/penalty; the applicable Governance Community needs to initially fund the insurance fund from the community treasury. | [[parameters/dydx-v4/insurance-fund]] | A2-PI, A6-PI |
