---
type: source
id: drift-sdk-docs-2026-04-28-math-amm
title: AMM Calculations
publisher: Drift Protocol v2 SDK Docs (Mintlify)
author: Drift Labs
date: null
original_url: https://mintlify.com/drift-labs/protocol-v2/math/amm
mirror_snapshot: drift-sdk-docs-2026-04-28
mirror_page: pages/math-amm.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# AMM Calculations

## TL;DR
Constant product invariant: `k = baseAssetReserve × quoteAssetReserve`, with `k` stored as `sqrtK`. Price formula: `price = (quoteAssetReserve × pegMultiplier × PRICE_PRECISION) / (baseAssetReserve × PEG_PRECISION)`. AMM applies dynamic spread with five components: (1) Base Spread (minimum), (2) Volatility Spread (oracle confidence + market stddev), (3) Inventory Spread (inventory imbalance scale), (4) Effective Leverage Spread (rises with AMM leverage), (5) Revenue Retreat (additional spread when AMM has losses). Inventory scale formula caps inventory-skew effect on spread. Reference Price Offset for high-liquidity-intensity markets uses three premium periods (minute, hour, 24h-funding-derived) averaged. Terminal Price = price at which AMM inventory would be fully closed. Peg adjustment: `peg = max(targetPrice × baseReserve / quoteReserve + PRICE_DIV_PEG/2 / PRICE_DIV_PEG, ONE)`. Practical examples: trade impact and slippage calculation via `calculateAmmReservesAfterSwap`.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Drift's AMM follows the constant product invariant: `k = baseAssetReserve × quoteAssetReserve`, with k stored as `sqrtK`. | [[concepts/market-structure/vamm]] | - |
| #c2 | Price formula: `price = (quoteAssetReserve × pegMultiplier × PRICE_PRECISION) / (baseAssetReserve × PEG_PRECISION)`. | [[concepts/market-microstructure/mark-price-formula]] | - |
| #c3 | Drift AMM spread has five components: Base Spread (minimum), Volatility Spread (oracle confidence + market stddev), Inventory Spread (inventory imbalance scale), Effective Leverage Spread (scales with AMM leverage), Revenue Retreat (additional spread when AMM has losses). | [[concepts/market-structure/vamm]] | A4-PI, A6-PI |
| #c4 | The Inventory Scale function adjusts spread based on inventory imbalance, capped by `MAX_BID_ASK_INVENTORY_SKEW_FACTOR`. | [[concepts/market-structure/vamm]] | A4-PIII |
| #c5 | High-liquidity-intensity markets apply a Reference Price Offset based on premium-from-three-periods (minute mark-oracle TWAP diff, hour TWAP diff, 24h funding-derived). | [[concepts/market-structure/vamm]] | A6-PI |
| #c6 | Terminal Price is the price at which the AMM's inventory would be fully closed; computed by simulating swap of full `baseAssetAmountWithAmm` in the closing direction. | [[concepts/market-structure/vamm]] | A6-PI |
| #c7 | The AMM's pegMultiplier can be adjusted: `peg = max(targetPrice × baseAssetReserve / quoteAssetReserve + PRICE_DIV_PEG/2 / PRICE_DIV_PEG, ONE)`. | [[concepts/market-structure/vamm]] | A6-PI |
| #c8 | Reserve updates after a trade follow the constant product formula: `newOutputAssetReserve = invariant / newInputAssetReserve` where `invariant = sqrtK × sqrtK`. | [[concepts/market-structure/vamm]] | - |
| #c9 | The `calculateBidAskPrice` function updates AMM reserves toward oracle (with `withUpdate=true`), calculates spread, and applies it to bid/ask reserves. | [[concepts/market-structure/vamm]] | A4-PI |
