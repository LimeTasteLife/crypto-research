---
type: source
id: orderly-docs-2026-04-29-insurance-fund-and-adl
title: Insurance Fund & ADL
publisher: Orderly Network Docs
author: Orderly team
date: 2026-04-29
original_url: https://orderly.network/docs/introduction/trade-on-orderly/perpetual-futures/insurance-fund-and-adl
mirror_snapshot: orderly-docs-2026-04-29
mirror_page: pages/insurance-fund-and-adl.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Insurance Fund & ADL

## TL;DR
The Insurance Fund absorbs bad debt when traders go underwater, funded by liquidation fees. Key parameters: min_insurance_fund_margin_ratio (maintenance margin for IF) and min_margin_ratio_solvency (absolute floor). ADL is the last resort — triggered when (1) liquidators don't take over positions, (2) no claims from IF for some time, and (3) IF Margin Ratio falls below min_insurance_fund_margin_ratio. ADL selects traders with most profit and highest leverage. Per-Builder IF isolation for permissionlessly listed markets with $50k minimum per symbol; ADL scoped to that specific market only.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Insurance Fund absorbs bad debt when trader losses exceed collateral, funded by collecting a portion of liquidation fees | [[parameters/orderly/insurance-fund]] | A6-PI |
| #c2 | If remaining margin too low for minimum liquidator fee: all positions and USDC balance transferred to IF; liquidators can claim from IF at discount | [[parameters/orderly/insurance-fund]] | A6-PI |
| #c3 | Key IF parameters: min_insurance_fund_margin_ratio (maintenance margin for IF) and min_margin_ratio_solvency (absolute floor) | [[parameters/orderly/insurance-fund]] | A6-PI |
| #c4 | ADL triggered when ALL three conditions met: (1) liquidators don't take positions, (2) no IF claims for some time, (3) IF Margin Ratio below min_insurance_fund_margin_ratio | [[concepts/risk/adl-waterfall]] | A6-PI |
| #c5 | ADL selects traders with the most profit and the most leverage; offsets IF positions market by market | [[concepts/risk/adl-waterfall]] | A6-PI |
| #c6 | Per-Builder Insurance Fund isolation for permissionlessly listed markets: minimum $50,000 per active symbol; ADL scoped to that specific market only; separate from platform IF | [[parameters/orderly/insurance-fund]] | A6-PI, A1-PI |

## Conflicts raised
None.
