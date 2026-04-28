---
type: source
id: dydx-docs-2026-04-28-concepts-trading-rewards-staking-rewards
title: Staking Rewards
publisher: dYdX Docs
author: dYdX team
date: null
original_url: https://docs.dydx.xyz/concepts/trading/rewards/staking-rewards
mirror_snapshot: dydx-docs-2026-04-28
mirror_page: pages/concepts-trading-rewards-staking-rewards.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Staking Rewards

## TL;DR
Staking rewards source = trading fees (USDC) + gas fees (USDC + native token). Distribution flow: per-block fee accrual in `fee_collector` → next block transfer to `distribution` module → community_tax + validator_commission subtracted → remainder distributed proportionally by stake. Stakers must claim manually; unclaimed rewards remain in the distribution module account. Formula: `Staking Rewards = fee_pool × (delegator_stake / total_stake) × (1 − community_tax) × (1 − validator_commission)`.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Staking rewards are designed to reward Validators and Stakers (Delegators); sources are trading fees and gas fees collected by the protocol. | [[parameters/dydx-v4/staking-rewards]] | A2-PI |
| #c2 | The protocol uses CosmosSDK's x/distribution module to allocate accrued trading and gas fees to validators and stakers. | [[parameters/dydx-v4/staking-rewards]] | - |
| #c3 | All trading fees (USDC) and gas fees (USDC + NATIVE_TOKEN) are accrued and distributed within a block. | [[parameters/dydx-v4/staking-rewards]] | A2-PI |
| #c4 | For each block, fees collect in the fee_collector module account and are sent to the distribution module account in the following block. | [[parameters/dydx-v4/staking-rewards]] | A2-PI |
| #c5 | community_tax and validator_commission are subtracted from the collected pool before distribution to validators and stakers proportionally to staked tokens. | [[parameters/dydx-v4/staking-rewards]] | A2-PI |
| #c6 | Stakers must claim rewards manually; unclaimed rewards remain in the distribution module account. | [[parameters/dydx-v4/staking-rewards]] | A2-PI |
| #c7 | Staking Rewards = fee_pool × (delegator_staked_tokens / total_staked_tokens) × (1 − community_tax_rate) × (1 − validator_commission_rate). | [[parameters/dydx-v4/staking-rewards]] | A2-PI |
| #c8 | x/staking validator_commission is configured per validator and can be updated by the validator. | [[parameters/dydx-v4/staking-rewards]] | A8-PI |
| #c9 | x/distribution community_tax is the proportion of the fee pool sent to community_treasury before staking rewards are distributed; configurable via governance. | [[parameters/dydx-v4/tokenomics]] | A7-PI |
