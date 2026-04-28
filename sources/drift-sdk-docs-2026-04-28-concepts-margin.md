---
type: source
id: drift-sdk-docs-2026-04-28-concepts-margin
title: Margin System
publisher: Drift Protocol v2 SDK Docs (Mintlify)
author: Drift Labs
date: null
original_url: https://mintlify.com/drift-labs/protocol-v2/concepts/margin
mirror_snapshot: drift-sdk-docs-2026-04-28
mirror_page: pages/concepts-margin.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Margin System

## TL;DR
MarginMode: DEFAULT (cross-margin), HIGH_LEVERAGE (high-leverage cross), HIGH_LEVERAGE_MAINTENANCE. Cross is default — pools all collateral, unrealized PnL contributes (with haircuts), most capital efficient. Isolated only available for ISOLATED-tier markets, separate collateral pool, no cross-contamination, introduced in v2.154.0. Total Collateral = Σ deposits × asset weight + positive perp PnL × pnlAssetWeight. Margin Requirement = Σ position size × price × marginRatio + Σ borrows × liabilityWeight. Initial vs Maintenance margin types. Health = totalCollateral / marginRequirement; <1.0 → liquidation eligible. Size scaling via IMF: `marginRatio = baseMarginRatio + imfFactor × sqrt(size × 10)`; asset-weight discount: `assetWeight_eff = (1.1 × assetWeight) / (1 + imfFactor × sqrt(size × 10))`. Strict oracle prices for spot: assets use `oracle − confidence`, liabilities use `oracle + confidence`. High Leverage Mode has user caps and may be reduce-only. Margin trading toggle: `isMarginTradingEnabled` boolean. Worked example in docs (10 SOL-PERP @$100, 1000 USDC, 500 USDC borrow): initial collateral $1000, requirement $625, free $375, maint requirement $562.5.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Drift MarginMode enum: DEFAULT (cross-margin), HIGH_LEVERAGE, HIGH_LEVERAGE_MAINTENANCE. | [[entities/perpdex/drift]] | A6-PI |
| #c2 | Cross-margin mode pools all collateral across positions; all deposits act as collateral for all positions; unrealized PnL contributes to margin (with haircuts). | [[concepts/risk/liquidation]] | A6-PI |
| #c3 | Isolated margin uses dedicated collateral per position; only available for ISOLATED-tier markets. | [[concepts/risk/margin-tier]] | A6-PI |
| #c4 | Total Collateral = Σ (token deposit × price × asset weight) + Σ positive perp PnL × pnlAssetWeight. | [[concepts/risk/liquidation]] | A6-PI |
| #c5 | Margin Requirement = Σ (perp position notional × marginRatio) + Σ (borrow × liabilityWeight). | [[concepts/risk/liquidation]] | A6-PI |
| #c6 | Initial margin is required to open new positions; maintenance margin determines liquidation threshold. | [[concepts/risk/liquidation]] | A6-PI |
| #c7 | Account is liquidatable when totalCollateral < marginRequirement (maintenance). | [[concepts/risk/liquidation]] | A6-PI |
| #c8 | Size-based margin scaling formula: `marginRatio = baseMarginRatio + imfFactor × sqrt(size × 10)`. | [[parameters/drift/risk-parameters]] | A6-PI |
| #c9 | Spot asset-weight discount for large deposits: `assetWeight_effective = (1.1 × assetWeight) / (1 + imfFactor × sqrt(size × 10))`. | [[parameters/drift/risk-parameters]] | A6-PI |
| #c10 | Spot liability weight scaling: `liabilityWeight_effective = liabilityWeight + imfFactor × sqrt(borrowSize × 10)`. | [[parameters/drift/risk-parameters]] | A6-PI |
| #c11 | Strict oracle prices for spot margin: assets (deposits) use `oraclePrice − confidence`; liabilities (borrows) use `oraclePrice + confidence`. | [[parameters/drift/oracle-config]] | A6-PI |
| #c12 | Worked example: 1000 USDC + long 10 SOL-PERP at $100 (10% IM, 5% MM) + 500 USDC borrow (1.05 init weight) — collateral $1000, initial req $625, free $375, maintenance req $562.5. | [[concepts/risk/liquidation]] | A6-PI |
| #c13 | High Leverage Mode (HighLeverageModeConfig) has `maxUsers` cap, current user count, and reduceOnly flag; provides lower IM/MM but higher liquidation risk. | [[parameters/drift/risk-parameters]] | A6-PI |
| #c14 | Users can disable margin trading (isMarginTradingEnabled: false) — prevents leveraged positions and spot borrows. | [[entities/perpdex/drift]] | - |
| #c15 | Open order treatment: reduce-only orders don't require additional margin; risk-increasing orders require margin for worst-case scenario; trigger orders require margin as if already filled. | [[concepts/risk/liquidation]] | A6-PI |
