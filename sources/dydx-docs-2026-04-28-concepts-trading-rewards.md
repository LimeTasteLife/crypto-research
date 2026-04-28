---
type: source
id: dydx-docs-2026-04-28-concepts-trading-rewards
title: Rewards, Fees and Parameters
publisher: dYdX Docs
author: dYdX team
date: null
original_url: https://docs.dydx.xyz/concepts/trading/rewards
mirror_snapshot: dydx-docs-2026-04-28
mirror_page: pages/concepts-trading-rewards.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Rewards, Fees and Parameters

## TL;DR
The single best-fee-tier-source in dYdX docs. 7 fee tiers from <$1M/30d (5.0bps taker / 1.0bps maker) up to ≥$200M (2.5bps taker / -1.1bps maker rebate). Staking discounts: 5 tier groups (1, 2, 3, 4, 5-7), each with two discount levels (e.g. tier 1 = 25% at 3k DYDX or 50% at 20k DYDX). Discounts apply only to net positive trading fees; no discount on rebates. Slashing parameters: 8192-block window (~3h), 20% min signed, 7200s downtime jail, 0% slash for downtime AND doublesign (the latter is unusual — but doublesign still triggers tombstoning). Distribution: 0% community tax. Staking: 60 max validators, 5% min commission, 30-day unbonding. Governance: 10k token min deposit, 4-day vote, 33.4% quorum, 50% threshold, 33.4% veto.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | dYdX has two reward mechanisms: Staking Rewards (paid to validators and stakers in USDC and NATIVE_TOKEN, claimed manually, distributed per block) and Trading Rewards (paid to traders in NATIVE_TOKEN, claimed automatically, distributed per block when trading). | [[parameters/dydx-v4/staking-rewards]], [[parameters/dydx-v4/trading-rewards-config]] | A2-PI |
| #c2 | Staking Rewards = Trading Fees + Gas Fees − Community Tax − Validator Commission. | [[parameters/dydx-v4/staking-rewards]] | A2-PI |
| #c3 | Trading Rewards constant C has been set to 0. | [[parameters/dydx-v4/trading-rewards-config]] | A2-PI, A7-PII |
| #c4 | Fee tier 1 (<$1M 30d volume): 5.0 bps taker, 1.0 bps maker. | [[parameters/dydx-v4/fee-schedule]] | A2-PI |
| #c5 | Fee tier 2 (≥$1M): 4.5 bps taker, 1.0 bps maker. | [[parameters/dydx-v4/fee-schedule]] | A2-PI |
| #c6 | Fee tier 3 (≥$5M): 4.0 bps taker, 0.5 bps maker. | [[parameters/dydx-v4/fee-schedule]] | A2-PI |
| #c7 | Fee tier 4 (≥$25M): 3.5 bps taker, 0 bps maker. | [[parameters/dydx-v4/fee-schedule]] | A2-PI |
| #c8 | Fee tier 5 (≥$50M): 3.0 bps taker, 0 bps maker. | [[parameters/dydx-v4/fee-schedule]] | A2-PI |
| #c9 | Fee tier 6 (≥$100M): 2.5 bps taker, -0.7 bps maker (rebate). | [[parameters/dydx-v4/fee-schedule]] | A2-PI |
| #c10 | Fee tier 7 (≥$200M): 2.5 bps taker, -1.1 bps maker (rebate). | [[parameters/dydx-v4/fee-schedule]] | A2-PI, A4-PI |
| #c11 | Fees are uniform across all markets. | [[parameters/dydx-v4/fee-schedule]] | A2-PI |
| #c12 | Fees differ by side (maker vs taker) and by 30-day trailing volume across sub-accounts and markets. | [[parameters/dydx-v4/fee-schedule]] | A2-PI |
| #c13 | Staking discount tier 1: 25% off at 3,000 DYDX or 50% off at 20,000 DYDX. | [[parameters/dydx-v4/fee-schedule]] | A2-PIV |
| #c14 | Staking discount tier 2: 20% off at 20,000 DYDX or 45% off at 80,000 DYDX. | [[parameters/dydx-v4/fee-schedule]] | A2-PIV |
| #c15 | Staking discount tier 3: 20% off at 80,000 DYDX or 40% off at 200,000 DYDX. | [[parameters/dydx-v4/fee-schedule]] | A2-PIV |
| #c16 | Staking discount tier 4: 15% off at 200,000 DYDX or 30% off at 800,000 DYDX. | [[parameters/dydx-v4/fee-schedule]] | A2-PIV |
| #c17 | Staking discount tiers 5-7: 5% off at 800,000 DYDX or 10% off at 5,000,000 DYDX. | [[parameters/dydx-v4/fee-schedule]] | A2-PIV |
| #c18 | Staking fee discounts apply only to net positive trading fees and only count bonded (staked) DYDX; unbonding DYDX does not qualify. | [[parameters/dydx-v4/fee-schedule]] | A2-PIV |
| #c19 | Staking fee discounts do not apply to maker rebates (negative fees). | [[parameters/dydx-v4/fee-schedule]] | A2-PIV |
| #c20 | The dYdX community voted to set the staking fee discounts and can change them at any time via dYdX governance. | [[parameters/dydx-v4/fee-schedule]] | A7-PI |
| #c21 | Slashing: signed_blocks_window = 8192 (~3h), min_signed_per_window = 20%, downtime_jail_duration = 7200s. | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c22 | Slash fraction for double-signing is 0% per default settings; slash fraction for downtime is 0%. | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c23 | Double-signing remains severe: validator is jailed (removed from active validator set) and tombstoned (cannot rejoin), even at 0% slash fraction. | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c24 | The default community tax is 0%; WithdrawAddrEnabled is True. | [[parameters/dydx-v4/tokenomics]] | A2-PI |
| #c25 | Staking parameters: MaxValidators = 60; MinCommissionRate = 5%; UnbondingTime = 30 days; default validator commission rate is 100%. | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c26 | Governance parameters: MinDeposit = 10,000 governance tokens; MinInitialDepositRatio = 20%; MaxDepositPeriod = 1 day; VotingPeriod = 4 days; Quorum = 33.4%; Threshold = 50%; VetoThreshold = 33.4%. | [[parameters/dydx-v4/governance-params]] | A7-PI |

## Conflicts raised
- #c25 Unbonding 30d (this page) vs `dydx-community-2026-04-28-modules-staking`#? (community page describes 21-day unbonding). Flag for Phase 2 reconciliation — likely community-docs page is stale or refers to a different epoch; canonical chain spec needed.
- #c26 Governance MinDeposit 10k tokens / MaxDepositPeriod 1 day (this page) vs `dydx-community-2026-04-28-modules-governance`#c (community page lists 2,000 DYDX min_deposit / 7-day max_deposit_period). Flag for Phase 2 — community page values appear to be the current on-chain values; this page may reflect initial defaults from genesis.
