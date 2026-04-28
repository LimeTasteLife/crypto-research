---
type: source
id: drift-sdk-docs-2026-04-28-math-margin-calculations
title: Margin Calculations
publisher: Drift Protocol v2 SDK Docs (Mintlify)
author: Drift Labs
date: null
original_url: https://mintlify.com/drift-labs/protocol-v2/math/margin-calculations
mirror_snapshot: drift-sdk-docs-2026-04-28
mirror_page: pages/math-margin-calculations.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Margin Calculations

## TL;DR
Margin types: Initial (open new positions), Maintenance (keep open), Free Collateral (available for new positions). Margin USDC required for trade = `(marginRatio × liabilityValue) / MARGIN_PRECISION` where `MARGIN_PRECISION = 10,000`; `liabilityValue = |baseAssetAmount| × price / BASE_PRECISION`. Prediction-market shorts: `liabilityValue = |baseAssetAmount| × (MAX_PREDICTION_PRICE − price) / BASE_PRECISION`. Conservative margin oracle price: long uses `oracle − offset`, short uses `oracle + offset`, where `offset = min(maxSpread × oracle, confidence + baseSpread × oracle)`. Liquidation price formula: `liqPriceDelta = freeCollateral × QUOTE_PRECISION / freeCollateralDelta`; `liqPrice = oraclePrice − liqPriceDelta` (returns -1 if would be negative). High Leverage Mode formula uses `sizePctDiscountFactor` to interpolate between default and size-adjusted margin ratios. Worst-case position liability considers all open bids and asks — returns scenario with maximum liability value for `includeOpenOrders=true`.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Margin types: Initial Margin (required to open new positions); Maintenance Margin (minimum to keep position open); Free Collateral (available for new positions). | [[concepts/risk/liquidation]] | A6-PI |
| #c2 | Margin required formula: `marginRequired = (marginRatio × liabilityValue) / MARGIN_PRECISION`, where MARGIN_PRECISION = 10,000. | [[concepts/risk/liquidation]] | A6-PI |
| #c3 | Liability value (standard perpetuals): `liabilityValue = |baseAssetAmount| × price / BASE_PRECISION`. | [[concepts/risk/liquidation]] | - |
| #c4 | Prediction-market shorts have different liability calculation: `liabilityValue = |baseAssetAmount| × (MAX_PREDICTION_PRICE − price) / BASE_PRECISION`. | [[concepts/risk/liquidation]] | A6-PI |
| #c5 | Conservative margin oracle price: long position uses `oraclePrice − priceOffset`; short uses `oraclePrice + priceOffset`. | [[parameters/drift/oracle-config]] | A6-PI |
| #c6 | Margin price offset: `priceOffset = min(maxSpread × oraclePrice, confidence + baseSpread × oraclePrice)`. | [[parameters/drift/oracle-config]] | A6-PI |
| #c7 | Liquidation price formula: `liqPriceDelta = freeCollateral × QUOTE_PRECISION / freeCollateralDelta`; `liqPrice = oraclePrice − liqPriceDelta`. | [[concepts/risk/liquidation]] | A6-PI |
| #c8 | A negative liquidation price returns -1 (sentinel for "no liquidation possible at any positive price"). | [[concepts/risk/liquidation]] | - |
| #c9 | Worst-case position size (when `includeOpenOrders=true`) considers current position plus all open bids (could increase position) and all open asks (could decrease position); returns the scenario with maximum liability value. | [[concepts/risk/liquidation]] | A6-PI |
| #c10 | Larger positions require more margin due to: increased liquidation risk, greater market impact, and reduced liquidity for larger sizes. | [[parameters/drift/risk-parameters]] | A6-PI |
| #c11 | High Leverage Mode initial-margin formula uses `sizePctDiscountFactor = 1 − (preSizeAdjMarginRatio − sizeAdjMarginRatio) × PERCENTAGE_PRECISION / (preSizeAdjMarginRatio / 5)` to interpolate between default and size-adjusted margin ratios. | [[parameters/drift/risk-parameters]] | A6-PI |
