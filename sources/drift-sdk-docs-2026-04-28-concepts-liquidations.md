---
type: source
id: drift-sdk-docs-2026-04-28-concepts-liquidations
title: Liquidations
publisher: Drift Protocol v2 SDK Docs (Mintlify)
author: Drift Labs
date: null
original_url: https://mintlify.com/drift-labs/protocol-v2/concepts/liquidations
mirror_snapshot: drift-sdk-docs-2026-04-28
mirror_page: pages/concepts-liquidations.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Liquidations

## TL;DR
Trigger: `totalCollateral < maintenanceMarginRequirement`. UserStatus bitflags: BeingLiquidated=1, Bankrupt=2, ReduceOnly=4, AdvancedLp=8, ProtectedMaker=16. LiquidationType enum: LIQUIDATE_PERP, LIQUIDATE_SPOT, LIQUIDATE_BORROW_FOR_PERP_PNL, LIQUIDATE_PERP_PNL_FOR_DEPOSIT, PERP_BANKRUPTCY, SPOT_BANKRUPTCY. Per-market `liquidatorFee` (e.g. 0.5%) + `ifLiquidationFee` (e.g. 0.1%) — example: $1000 position liquidation = $5 to liquidator + $1 to IF. Spot liquidation multipliers: liability=1.0, asset=0.95 (the 5% gap is split liquidator-profit + IF-fee). Progressive liquidation formula: `maxPct = min(slotsElapsed/liquidationDuration + initialPct, 100%)`. Defaults: `initialPctToLiquidate ≈ 10%`, `liquidationDuration ≈ 150 slots = ~1 minute`. Bankruptcy waterfall: insurance fund covers what it can; remaining loss socialized via funding rate adjustment (perp) or cumulative deposit interest adjustment (spot). Liquidation cancels all risk-increasing orders.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Liquidation trigger: `totalCollateral < maintenanceMarginRequirement`. | [[concepts/risk/liquidation]] | A6-PI |
| #c2 | UserStatus bitflag values: BeingLiquidated=1, Bankrupt=2, ReduceOnly=4, AdvancedLp=8, ProtectedMaker=16. | [[entities/perpdex/drift]] | - |
| #c3 | LiquidationType enum: LIQUIDATE_PERP, LIQUIDATE_SPOT, LIQUIDATE_BORROW_FOR_PERP_PNL, LIQUIDATE_PERP_PNL_FOR_DEPOSIT, PERP_BANKRUPTCY, SPOT_BANKRUPTCY. | [[concepts/risk/liquidation]] | A6-PI |
| #c4 | Drift relies on permissionless liquidators (keepers) to identify and liquidate underwater positions. | [[entities/perpdex/drift]] | A4-PI, A6-PI |
| #c5 | Per-market perp liquidator fee example: 500 (0.5%); ifLiquidationFee example: 100 (0.1%); a $1000 liquidation gives $5 to liquidator + $1 to IF. | [[parameters/drift/liquidation-params]] | A6-PI |
| #c6 | Spot liquidation multipliers: liabilityLiquidationMultiplier = 1.0; assetLiquidationMultiplier = 0.95; the 5% difference is split between liquidator profit and IF fee. | [[parameters/drift/liquidation-params]] | A6-PI |
| #c7 | Progressive liquidation max-percentage formula: `maxPct = min(slotsElapsed / liquidationDuration + initialPctToLiquidate, 100%)`. | [[parameters/drift/liquidation-params]] | A6-PI |
| #c8 | Default liquidation parameters: `initialPctToLiquidate ≈ 10%`, `liquidationDuration ≈ 150 slots ≈ 1 minute`. | [[parameters/drift/liquidation-params]] | A6-PI |
| #c9 | Progressive liquidation gives users time to add margin and prevents excessive position closure during brief volatility. | [[concepts/risk/liquidation]] | A6-PI |
| #c10 | When a user's collateral is insufficient even after full liquidation, bankruptcy procedures activate. | [[concepts/risk/liquidation]] | A6-PI |
| #c11 | Perp bankruptcy resolution: calculate remaining negative PnL → insurance fund covers what it can → remaining loss is socialized via funding rate adjustment → optionally clawback from recent profitable traders. | [[concepts/risk/insurance-fund-sizing]] | A6-PI |
| #c12 | Spot bankruptcy resolution: calculate remaining borrow → insurance fund covers what it can → remaining loss is socialized to depositors via cumulative deposit interest adjustment. | [[concepts/risk/insurance-fund-sizing]] | A6-PI |
| #c13 | When liquidation begins all risk-increasing orders are cancelled; reduce-only orders may remain. | [[concepts/risk/liquidation]] | A6-PI |
| #c14 | Isolated position liquidation: only the isolated collateral is at risk; cross-margin positions remain unaffected. | [[concepts/risk/margin-tier]] | A6-PI |
| #c15 | Bankruptcy clawbacks reach back to recent profitable traders if applicable (clawbackUser, clawbackUserPayment fields in PerpBankruptcyRecord). | [[concepts/risk/insurance-fund-sizing]] | A6-PI |
