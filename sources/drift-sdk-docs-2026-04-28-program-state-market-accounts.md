---
type: source
id: drift-sdk-docs-2026-04-28-program-state-market-accounts
title: Market Accounts
publisher: Drift Protocol v2 SDK Docs (Mintlify)
author: Drift Labs
date: null
original_url: https://mintlify.com/drift-labs/protocol-v2/program/state/market-accounts
mirror_snapshot: drift-sdk-docs-2026-04-28
mirror_page: pages/program-state-market-accounts.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Market Accounts

## TL;DR
PerpMarket account stores: marketIndex, AMM (reserves, oracle, funding), marginRatioInitial / marginRatioMaintenance, imfFactor, marketStatus (ACTIVE / PAUSED / etc.), contractType (PERPETUAL / FUTURE), contractTier (A / B / C / SPECULATIVE / ISOLATED). SpotMarket account stores: marketIndex, mint, vault, initialAssetWeight, maintenanceAssetWeight, depositBalance, borrowBalance, optimalUtilization. Two thin Mintlify reference cards rather than full schemas.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | PerpMarket account fields include marketIndex, AMM state, marginRatioInitial, marginRatioMaintenance, imfFactor, marketStatus, contractType, contractTier. | [[parameters/drift/risk-parameters]] | A6-PI |
| #c2 | PerpMarket contractTier values: A, B, C, SPECULATIVE, ISOLATED. | [[concepts/risk/margin-tier]] | A6-PI |
| #c3 | SpotMarket account fields include marketIndex, mint (SPL token), vault (token vault holding deposits), initialAssetWeight, maintenanceAssetWeight, depositBalance, borrowBalance, optimalUtilization. | [[parameters/drift/risk-parameters]] | A6-PI |
| #c4 | SpotMarket optimalUtilization is the target utilization rate for interest rate calculations. | [[entities/perpdex/drift]] | A6-PI |
