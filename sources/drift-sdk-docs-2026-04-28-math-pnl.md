---
type: source
id: drift-sdk-docs-2026-04-28-math-pnl
title: PnL Calculations
publisher: Drift Protocol v2 SDK Docs (Mintlify)
author: Drift Labs
date: null
original_url: https://mintlify.com/drift-labs/protocol-v2/math/pnl
mirror_snapshot: drift-sdk-docs-2026-04-28
mirror_page: pages/math-pnl.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# PnL Calculations

## TL;DR
Position PnL formula: `PnL = baseAssetAmount × (exitPrice − entryPrice) + quoteAssetAmount`. Implementation: `PnL = baseAssetValue × sign(baseAssetAmount) + quoteAssetAmount`, with optional funding inclusion via `withFunding=true`. Base asset value via AMM: simulates closing entire position through AMM (with spread) to get exit quote. Oracle-based asset value: `value = |baseAssetAmount| × price / AMM_RESERVE_PRECISION` (uses expiryPrice if market in settlement). Funding PnL = `-(cumulativeFundingRate − lastCumulativeFundingRate) × baseAssetAmount / (AMM_RESERVE_PRECISION × FUNDING_RATE_BUFFER_PRECISION)`. Entry price = `|quoteEntryAmount × PRICE_PRECISION × AMM_TO_QUOTE_PRECISION_RATIO / baseAssetAmount|`. Break-even price = same formula but with `quoteBreakEvenAmount`. Cost basis = same formula with `quoteAssetAmount` (optionally + settledPnl). Claimable PnL is capped: positive unrealized PnL is bounded by the PnL pool — prevents bank runs. `min(maxPositivePnl, unrealizedPnl)` where maxPositivePnl includes excess PnL pool surplus.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Position PnL formula: `PnL = baseAssetAmount × (exitPrice − entryPrice) + quoteAssetAmount`. | [[concepts/risk/liquidation]] | - |
| #c2 | Implementation: `PnL = baseAssetValue × sign(baseAssetAmount) + quoteAssetAmount`. | [[entities/perpdex/drift]] | - |
| #c3 | Base asset value computation simulates closing the entire position through the AMM (with spread if applicable) to get exit quote amount. | [[concepts/market-structure/vamm]] | A4-PI |
| #c4 | Oracle-based asset value: `value = |baseAssetAmount| × price / AMM_RESERVE_PRECISION`; uses `market.expiryPrice` if market is in settlement. | [[concepts/risk/liquidation]] | A6-PI |
| #c5 | Funding PnL formula: `fundingPnL = -(cumulativeFundingRate − lastCumulativeFundingRate) × baseAssetAmount / (AMM_RESERVE_PRECISION × FUNDING_RATE_BUFFER_PRECISION)`. | [[parameters/drift/funding-config]] | A6-PI |
| #c6 | Entry price formula: `entryPrice = |quoteEntryAmount × PRICE_PRECISION × AMM_TO_QUOTE_PRECISION_RATIO / baseAssetAmount|`. | [[entities/perpdex/drift]] | - |
| #c7 | Break-even price = entry-price formula with `quoteBreakEvenAmount` (includes fees and funding). | [[entities/perpdex/drift]] | - |
| #c8 | `quoteBreakEvenAmount` is updated when opening/closing positions (includes trading fees), settling funding payments, and taking maker rebates. | [[concepts/fee-model/funding-rate]] | A2-PI |
| #c9 | Claimable PnL is capped to `min(maxPositivePnl, unrealizedPnl)` where `maxPositivePnl = max(quoteAssetAmount − quoteEntryAmount, 0) + excessPnlPool`. | [[concepts/risk/insurance-fund-sizing]] | A6-PI |
| #c10 | Claimable PnL may be less than unrealized PnL due to the PnL pool mechanism that prevents bank runs. | [[concepts/risk/insurance-fund-sizing]] | A6-PI |
