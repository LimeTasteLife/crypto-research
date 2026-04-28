---
type: source
id: drift-developers-docs-2026-04-28-developers-concepts-account-model
title: Account Model
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/developers/concepts/account-model
mirror_snapshot: drift-developers-docs-2026-04-28
mirror_page: pages/developers-concepts-account-model.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Account Model

## TL;DR
Drift is implemented as a Solana program with five core account types. **State** (singleton): admin, oracle guards, perp & spot fee structures, sequencer settings, emergency flags. **PerpMarketAccount** (one per perp market): AMM state, funding rates, oracle integration, fee config, margin ratios + IMF factor, liquidator fee, IF liquidation fee, market status, contractTier (A/B/C/Speculative/Highly Speculative/Isolated). **SpotMarketAccount** (one per spot market): interest rates, utilization, insurance fund stake, oracle, deposit/borrow limits, asset/liability weights, IMF factor, optimalUtilization/optimalBorrowRate/maxBorrowRate. **UserAccount** (per subaccount): perp/spot positions, up to 32 orders, margin settings, delegate. **UserStatsAccount** (per wallet): fee tracking, 30-day maker/taker/filler volume, referrer info, fuel points. PDAs deterministically derived: `[b"user", authority, subaccount_id]`, `[b"user_stats", authority]`, `[b"perp_market", market_index]`, `[b"spot_market", market_index]`. Markets identified by numeric indices.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | The Drift protocol is implemented as a Solana program (smart contract) managing user accounts, positions, orders, and markets. | [[entities/perpdex/drift]] | A1-PI |
| #c2 | The State account is a singleton holding protocol-wide configuration: oracle guards, perpFeeStructure, spotFeeStructure, sequencer settings, admin controls, emergency flags. | [[entities/perpdex/drift]] | A7-PI, A6-PI |
| #c3 | PerpMarketAccount fields include AMM state, funding rates, oracle integration, fee config, marginRatioInitial, marginRatioMaintenance, imfFactor, liquidatorFee, ifLiquidationFee, contractTier, marketStatus. | [[parameters/drift/risk-parameters]] | A1-PI, A6-PI |
| #c4 | SpotMarketAccount fields include oracle, mint, vault, insurance fund, depositBalance, borrowBalance, cumulativeDepositInterest, cumulativeBorrowInterest, totalSocialLoss, asset/liability weights, imfFactor, optimalUtilization, optimalBorrowRate, maxBorrowRate. | [[parameters/drift/risk-parameters]] | A6-PI |
| #c5 | UserAccount stores up to 32 active orders, perpPositions, spotPositions, margin settings, delegate addresses, totalDeposits/Withdraws, settledPerpPnl, isMarginTradingEnabled flag. | [[entities/perpdex/drift]] | - |
| #c6 | UserStatsAccount tracks lifetime stats: total fees paid, makerVolume30d, takerVolume30d, fillerVolume30d, ifStakedQuoteAssetAmount, referrer info, fuel (maker incentive points). | [[parameters/drift/fee-schedule]] | A2-PI, A4-PV |
| #c7 | PDA derivation rules: User = `[b"user", authority, subaccount_id]`; UserStats = `[b"user_stats", authority]`; PerpMarket = `[b"perp_market", market_index]`; SpotMarket = `[b"spot_market", market_index]`. | [[entities/perpdex/drift]] | - |
| #c8 | Each wallet can have multiple subaccounts (0, 1, 2…) sharing cross-margin via the UserStats account. | [[entities/perpdex/drift]] | A6-PI |
| #c9 | Markets are identified by numeric indices (market 0, market 1, etc.). | [[entities/perpdex/drift]] | - |
| #c10 | Many Drift instructions use a "remaining accounts" pattern to dynamically pass oracle, market, and user accounts. | [[entities/perpdex/drift]] | - |
