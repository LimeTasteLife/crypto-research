---
type: source
id: drift-sdk-docs-2026-04-28-math-funding-rates
title: Funding Rate Calculations
publisher: Drift Protocol v2 SDK Docs (Mintlify)
author: Drift Labs
date: null
original_url: https://mintlify.com/drift-labs/protocol-v2/math/funding-rates
mirror_snapshot: drift-sdk-docs-2026-04-28
mirror_page: pages/math-funding-rates.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Funding Rate Calculations

## TL;DR
Funding rate (per hour) = `(markTwap − oracleTwap) / oracleTwap / 24`. Precision constants: FUNDING_RATE_BUFFER_PRECISION=1000 (10^3); FUNDING_RATE_PRECISION_EXP=9 (10^9); FUNDING_RATE_OFFSET_DENOMINATOR=5000. Funding payment formula (PnL contribution): `fundingPnL = -(cumulativeFundingRate − lastCumulativeFundingRate) × baseAssetAmount / (AMM_RESERVE_PRECISION × FUNDING_RATE_BUFFER_PRECISION)`. Positive value = receiving; negative = paying. Mark TWAP weighted by `lastMarkPriceTwap`, `lastMarkPriceTwapTs`, and current period (default 3600s). Funding pool size = `max(0, (totalFeeMinusDistributions − totalFee/2) × 1/3)`. Max price divergence by Contract Tier: A or B = oracle/33 (~3%); C = oracle/20 (~5%); below C = oracle/10 (~10%). Asymmetric funding when long-short imbalance: large side pays capped rate, small side receives interpolated rate; balanced sides receive interpolated. APR = rate × 24 × 365.25; annualized.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Funding rate formula: `fundingRate = (markTwap − oracleTwap) / oracleTwap / 24`, with division by 24 converting to hourly rate from daily. | [[parameters/drift/funding-config]], [[concepts/fee-model/funding-rate]] | A6-PI |
| #c2 | FUNDING_RATE precision constants: FUNDING_RATE_BUFFER_PRECISION=1000 (10^3); FUNDING_RATE_PRECISION_EXP=9 (10^9); FUNDING_RATE_OFFSET_DENOMINATOR=5000. | [[parameters/drift/funding-config]] | - |
| #c3 | Funding payment per position: `fundingPnL = -(cumulativeFundingRate − lastCumulativeFundingRate) × baseAssetAmount / (AMM_RESERVE_PRECISION × FUNDING_RATE_BUFFER_PRECISION)`. | [[parameters/drift/funding-config]] | A6-PI |
| #c4 | Funding pool size formula: `max(0, (totalFeeMinusDistributions − totalExchangeFee/2) × 1/3)`. | [[parameters/drift/funding-config]] | A6-PI |
| #c5 | Maximum price divergence for funding rate by Contract Tier: A or B = oracle/33 (~3%); C = oracle/20 (~5%); below C = oracle/10 (~10%). | [[parameters/drift/funding-config]] | A6-PI |
| #c6 | The protocol applies a small offset to encourage arbitrage: `twapSpread + (oracleTwap.abs() / FUNDING_RATE_OFFSET_DENOMINATOR)` (offset divisor = 5000). | [[parameters/drift/funding-config]] | A6-PI |
| #c7 | Asymmetric funding: when `baseAssetAmountLong > baseAssetAmountShort`, longs pay capped rate and shorts receive interpolated rate; when reversed, longs receive interpolated and shorts pay capped; balanced sides both receive interpolated. | [[parameters/drift/funding-config]] | A6-PI |
| #c8 | When open interest is imbalanced, the smaller side may receive more funding than the larger side pays, due to the funding pool mechanism. | [[parameters/drift/funding-config]] | A6-PI |
| #c9 | APR conversion: `paymentsPerYear = 24 × 365.25`, multiply hourly rate by paymentsPerYear for APR. | [[concepts/fee-model/funding-rate]] | - |
| #c10 | Mark TWAP calculation interpolates weighted by `period` (default 3600s) and time since last update. | [[parameters/drift/funding-config]] | A6-PI |
