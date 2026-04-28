---
type: source
id: drift-developers-docs-2026-04-28-developers-concepts-program-structure
title: Program Structure
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/developers/concepts/program-structure
mirror_snapshot: drift-developers-docs-2026-04-28
mirror_page: pages/developers-concepts-program-structure.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Program Structure

## TL;DR
Drift's account model design principles: cross-margin (positions in a wallet share collateral), subaccounts (multiple isolated accounts per wallet 0..N), interest-bearing scaled balance for spot, inline orders stored in UserAccount (no separate order accounts), and fixed limits (8 perp, 8 spot, 32 orders) for predictable transactions. PerpPosition tracks long/short via signed `baseAssetAmount`; entry price = `quoteEntryAmount / baseAssetAmount`; unrealized PnL = `(oraclePrice − entryPrice) × baseAssetAmount`; funding via `lastCumulativeFundingRate`. SpotPosition uses `scaledBalance × cumulativeIndex` for interest-compounding. Order types: limit (postOnly / IoC), market, oracle (price = `oraclePrice + oraclePriceOffset`), trigger (market or limit). JIT auctions on every order: `auctionStartPrice` → `auctionEndPrice` linearly over `auctionDuration` slots. Asset weights <1.0 (collateral haircut), liability weights >1.0 (borrow buffer). Initial margin opens positions, maintenance margin (~half) triggers liquidation. Health = totalCollateral / marginRequirement; <1.0 → liquidation eligible. Liquidation fee 2–5%.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Drift uses cross-margin: all positions within a wallet share collateral. | [[entities/perpdex/drift]] | A6-PI |
| #c2 | Each wallet can have multiple isolated trading subaccounts (0, 1, 2, …) sharing the same cross-margin pool. | [[entities/perpdex/drift]] | A6-PI |
| #c3 | Spot balances accrue interest via a scaled balance mechanism. | [[entities/perpdex/drift]] | - |
| #c4 | Orders are stored inline in the UserAccount (no separate order accounts). | [[entities/perpdex/drift]] | - |
| #c5 | Fixed account-size limits per subaccount: 8 perp positions, 8 spot positions, 32 orders. | [[entities/perpdex/drift]] | - |
| #c6 | Position size in PerpPosition is `baseAssetAmount` (positive = long, negative = short). | [[entities/perpdex/drift]] | - |
| #c7 | Entry price = `quoteEntryAmount / baseAssetAmount`. | [[entities/perpdex/drift]] | - |
| #c8 | Unrealized PnL = `(oraclePrice − entryPrice) × baseAssetAmount`. | [[entities/perpdex/drift]] | - |
| #c9 | Funding payments are tracked via `lastCumulativeFundingRate` on the position. | [[concepts/fee-model/funding-rate]] | A6-PI |
| #c10 | Spot position real balance = `scaledBalance × cumulativeIndex`, avoiding per-user interest calculations onchain. | [[entities/perpdex/drift]] | - |
| #c11 | Order types: Limit (postOnly / IoC flags), Market, Oracle (`oraclePrice + oraclePriceOffset`), Trigger (triggerMarket or triggerLimit on oracle crossing trigger price). | [[concepts/operations/matching-engine]] | A4-PI |
| #c12 | Up to 32 orders per user including resting and trigger orders. | [[entities/perpdex/drift]] | - |
| #c13 | Every order goes through a JIT auction parameterized by auctionStartPrice (most aggressive), auctionEndPrice (least aggressive), and auctionDuration (slots). | [[concepts/market-microstructure/jit-auction]] | A4-PI |
| #c14 | JIT auction price linearly improves from start to end over the auction duration. | [[concepts/market-microstructure/jit-auction]] | A4-PI |
| #c15 | Order flags: reduceOnly (only decrease size), postOnly (must be maker), immediateOrCancel (fill or cancel). | [[concepts/operations/matching-engine]] | A4-PI |
| #c16 | Total Collateral = Σ(spot deposits × asset weight) − Σ(spot borrows × liability weight) + unrealized perp PnL. | [[concepts/risk/liquidation]] | A6-PI |
| #c17 | Asset weights are below 1.0 to provide a safety buffer (e.g. SOL might have 0.9 weight = 90% counted). | [[parameters/drift/risk-parameters]] | A6-PI |
| #c18 | Liability weights are above 1.0 to add a buffer for borrowed funds (e.g. SOL borrow at 1.1 = 110% of debt counted). | [[parameters/drift/risk-parameters]] | A6-PI |
| #c19 | Margin Requirement = Σ(position notional × initial margin ratio). | [[concepts/risk/liquidation]] | A6-PI |
| #c20 | Initial margin ratio determines minimum collateral to open a position; example: 5% for BTC-PERP = 20x max leverage. | [[parameters/drift/risk-parameters]] | A6-PI |
| #c21 | Maintenance margin ratio (typically ~half of initial margin) triggers liquidation; example: 2.5% maintenance if 5% initial. | [[parameters/drift/risk-parameters]] | A6-PI |
| #c22 | Account Health = Total Collateral / Margin Requirement; >1.0 healthy, <1.0 liquidation-eligible, <0.0 underwater (negative collateral). | [[concepts/risk/liquidation]] | A6-PI |
| #c23 | Liquidator fee on Drift is 2–5%. | [[parameters/drift/liquidation-params]] | A6-PI |
| #c24 | Cross-margin liquidation considers all subaccounts together; if total health < 1.0, liquidation affects all subaccounts. | [[concepts/risk/liquidation]] | A6-PI |
