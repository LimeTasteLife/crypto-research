---
type: source
id: drift-developers-docs-2026-04-28-developers-drift-sdk-markets
title: SDK Markets
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/developers/drift-sdk/markets
mirror_snapshot: drift-developers-docs-2026-04-28
mirror_page: pages/developers-drift-sdk-markets.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Markets, Oracles, and Positions

## TL;DR
Drift has two market types: perp (perpetual futures with funding rates) and spot (token deposits/borrows that serve as collateral). Each market has a unique numeric `marketIndex`. Conventional indices: perp 0 = SOL-PERP, spot 0 = USDC, perp 1 might be BTC-PERP. Bots typically build their own symbol↔index mapping at startup. Each market has an oracle (Pyth or Switchboard) providing real-time price; SDK lets bots read prices, validity flags, confidence intervals. PRICE_PRECISION = 1e6. SDK accessors: `getPerpMarketAccount(idx)`, `getSpotMarketAccount(idx)`, `getPerpMarketAccounts()`, `getSpotMarketAccounts()`, `getOracleDataForPerpMarket(idx)`, `getOracleDataForSpotMarket(idx)`, `getMMOracleDataForPerpMarket(idx)` (recommended for MMs — has validity + confidence). Position accessors: `getPerpPosition(idx)`, `getSpotPosition(idx)`. Protocol state: `getStateAccount()` returns the singleton State account.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Drift has two market types: perp markets (perpetual futures with funding rates) and spot markets (token deposits/borrows that serve as collateral). | [[entities/perpdex/drift]] | A1-PI |
| #c2 | Markets are identified by a numeric index starting from 0; convention: perp market 0 is typically SOL-PERP, spot market 0 is USDC. | [[entities/perpdex/drift]] | - |
| #c3 | Each market integrates with an oracle (Pyth or Switchboard) providing real-time price data, validity, and confidence intervals. | [[parameters/drift/oracle-config]] | A6-PI |
| #c4 | Prices in the SDK are stored in fixed-point precision (PRICE_PRECISION = 1e6). | [[entities/perpdex/drift]] | - |
| #c5 | Perp markets track funding rates, open interest, and AMM liquidity pools; spot markets track total deposits, borrows, and utilization rates. | [[entities/perpdex/drift]] | A6-PI |
| #c6 | `getMMOracleDataForPerpMarket` is the recommended oracle accessor for market-maker DLOB/JIT pricing flows. | [[parameters/drift/oracle-config]] | A4-PI |
