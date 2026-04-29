---
type: source
id: drift-sdk-docs-2026-04-28-concepts-positions
title: Positions
publisher: Drift Protocol v2 SDK Docs (Mintlify)
author: Drift Labs
date: null
original_url: https://mintlify.com/drift-labs/protocol-v2/concepts/positions
mirror_snapshot: drift-sdk-docs-2026-04-28
mirror_page: pages/concepts-positions.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Positions

## TL;DR
Two position types: Perpetual (long if `baseAssetAmount > 0`, short if < 0) and Spot (DEPOSIT or BORROW via `balanceType` enum). PositionFlag enum: IsolatedPosition = 1, BeingLiquidated = 2, Bankruptcy = 4. Isolated positions (introduced in v2.154.0) use dedicated collateral via `isolatedPositionScaledBalance`; only one isolated position allowed per market; must be in ISOLATED-tier market; cannot mix with cross-margin in same market; liquidated independently. PnL formula: `PnL = baseAssetValue × sign(baseAssetAmount) + quoteAssetAmount`. With funding: `PnL_total = PnL_position + fundingPayment`. Break-even price: `quoteBreakEvenAmount / |baseAssetAmount|`. LP positions: user receives `lpShares` proportional to deposit; LP earns trading fees; cooldown ~24 hours after add before remove allowed. Position limits per user account: 8 perp positions, 8 spot positions, 32 open orders. Markets may have `maxOpenInterest` caps: `currentOpenInterest = max(baseAssetAmountLong, abs(baseAssetAmountShort))`.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Drift PerpPosition direction: positive `baseAssetAmount` = long; negative = short. | [[entities/perpdex/drift]] | - |
| #c2 | Drift SpotPosition `balanceType` is DEPOSIT or BORROW. | [[entities/perpdex/drift]] | - |
| #c3 | PositionFlag enum: IsolatedPosition = 1, BeingLiquidated = 2, Bankruptcy = 4. | [[entities/perpdex/drift]] | - |
| #c4 | Isolated positions were introduced in Drift v2.154.0. | [[entities/perpdex/drift]] | A6-PI |
| #c5 | Isolated positions use dedicated collateral via `isolatedPositionScaledBalance`; only the isolated collateral backs the position. | [[entities/perpdex/drift]] | A6-PI |
| #c6 | Isolated position constraints: only one isolated position allowed per market; market must be ISOLATED tier; cannot mix with cross-margin positions in same market; liquidation only affects the isolated position. | [[concepts/risk/margin-tier]] | A6-PI |
| #c7 | Position PnL formula: `PnL = baseAssetValue × sign(baseAssetAmount) + quoteAssetAmount`. | [[concepts/risk/liquidation]] | - |
| #c8 | PnL with funding: `PnL_total = PnL_position + fundingPayment`. | [[concepts/fee-model/funding-rate]] | - |
| #c9 | Funding payment formula: `fundingPayment = baseAssetAmount × (cumulativeFundingRate_current − lastCumulativeFundingRate)`. | [[concepts/fee-model/funding-rate]] | A6-PI |
| #c10 | Break-even price formula: `quoteBreakEvenAmount / |baseAssetAmount|`. | [[entities/perpdex/drift]] | - |
| #c11 | LP positions: user receives `lpShares` proportional to deposit; the user's effective position is transferred to the AMM; LP earns a portion of trading fees and shares AMM PnL. | [[parameters/drift/lp-shares]] | A5-PI |
| #c12 | LP positions are subject to a cooldown period (typically 24 hours) after adding liquidity before removal is allowed. | [[parameters/drift/lp-shares]] | A5-PII |
| #c13 | Per-user-account limits: up to 8 perp positions, 8 spot positions, 32 open orders. | [[entities/perpdex/drift]] | - |
| #c14 | Markets may enforce maxOpenInterest caps: `currentOpenInterest = max(baseAssetAmountLong, abs(baseAssetAmountShort))`. | [[parameters/drift/risk-parameters]] | A6-PI |
| #c15 | Margin position value formula: `value = |baseAssetAmount| × oraclePrice`; for prediction-market shorts: `liabilityValue = |baseAssetAmount| × (MAX_PRICE − oraclePrice)`. | [[concepts/risk/liquidation]] | A6-PI |
