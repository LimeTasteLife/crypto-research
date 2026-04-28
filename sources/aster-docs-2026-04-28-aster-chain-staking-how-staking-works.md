---
type: source
id: aster-docs-2026-04-28-aster-chain-staking-how-staking-works
title: How Staking Works
publisher: Aster Docs
author: Aster team
date: null
original_url: https://docs.asterdex.com/aster-chain/staking/how-staking-works
mirror_snapshot: aster-docs-2026-04-28
mirror_page: pages/aster-chain-staking-how-staking-works.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# How Staking Works

## TL;DR
Aster Chain staking emits 450,000 $ASTER per Epoch at launch (150K Base + 300K Loyalty). Base APY is distributed proportionally across validators by share of network transactions processed; users then earn pro-rata within a validator after validator commission. Loyalty Rewards reward locked positions: User Power = veASTER × Trading Volume Boost, where veASTER = Locked Amount × (Remaining Lock / 208 weeks max). Trading Volume Boost is tiered: >$500K → 1.05x, >$50M → 1.15x, >$200M → 1.25x. Epochs run Monday 00:00 UTC to Sunday 00:00 UTC; snapshot at Monday 00:00 UTC. Staking changes (deposits, top-ups, lock extensions, redeem requests) take effect in the *next* Epoch. The dual-track design couples validator-PoS with veToken-style time-locked governance and ties staking yield to personal trading volume — a direct vehicle linking governance authority to platform usage.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Staking on Aster Chain requires choosing a validator and a lock period before confirming. | [[parameters/aster/staking-rewards]] | A7-PI |
| #c2 | A staking position becomes active and begins earning rewards in future Epochs once confirmed. | [[parameters/aster/staking-rewards]] | A7-PI |
| #c3 | Base Rewards pool emission at launch is 150,000 $ASTER per Epoch. | [[parameters/aster/staking-rewards]] | A7-PI |
| #c4 | Loyalty Rewards pool emission at launch is 300,000 $ASTER per Epoch. | [[parameters/aster/staking-rewards]] | A7-PI |
| #c5 | Total Aster staking emission at launch is 450,000 $ASTER per weekly Epoch. | [[parameters/aster/staking-rewards]] | A7-PI |
| #c6 | Each validator's share of the Base APY pool is proportional to the share of network transactions it processes (Validator Share = Validator Transactions ÷ Total Network Transactions). | [[parameters/aster/staking-rewards]] | A7-PI |
| #c7 | Validator Reward = Base APY Pool × Validator Share. | [[parameters/aster/staking-rewards]] | A7-PI |
| #c8 | User Base Reward = Validator Reward × (User Stake ÷ Total Validator Stake) × (1 − Validator Commission). | [[parameters/aster/staking-rewards]] | A7-PI |
| #c9 | Loyalty Rewards weight is computed as Power = veASTER × Trading Volume Boost. | [[parameters/aster/staking-rewards]] | A7-PI |
| #c10 | veASTER = Locked Amount × Time Weight, where Time Weight = Remaining Lock Duration ÷ Maximum Lock Duration. | [[parameters/aster/staking-rewards]] | A7-PI |
| #c11 | Maximum lock duration is 208 weeks (approximately 4 years). | [[parameters/aster/staking-rewards]] | A7-PI |
| #c12 | Trading Volume Boost is 1.05x for Epoch trading volume >$500,000. | [[parameters/aster/staking-rewards]] | A7-PI, A2-PIV |
| #c13 | Trading Volume Boost is 1.15x for Epoch trading volume >$50,000,000. | [[parameters/aster/staking-rewards]] | A7-PI, A2-PIV |
| #c14 | Trading Volume Boost is 1.25x for Epoch trading volume >$200,000,000. | [[parameters/aster/staking-rewards]] | A7-PI, A2-PIV |
| #c15 | User Loyalty Reward = Weekly Loyalty Pool × (User Power ÷ Total Network Power). | [[parameters/aster/staking-rewards]] | A7-PI |
| #c16 | Loyalty Rewards distribution couples staked governance power to personal trading volume, linking staking yield to platform usage. | [[parameters/aster/staking-rewards]] | A7-PV, A2-PIV |
| #c17 | Each Epoch runs Monday 00:00 UTC through Sunday 00:00 UTC. | [[parameters/aster/staking-rewards]] | A7-PI |
| #c18 | The Epoch staking-data snapshot is taken at Monday 00:00 UTC. | [[parameters/aster/staking-rewards]] | A7-PI |
| #c19 | Epoch settlement occurs at Sunday 00:00 UTC. | [[parameters/aster/staking-rewards]] | A7-PI |
| #c20 | New stake deposits take effect in the next Epoch (not immediately). | [[parameters/aster/staking-rewards]] | A7-PII |
| #c21 | Additional stake top-ups take effect in the next Epoch. | [[parameters/aster/staking-rewards]] | A7-PII |
| #c22 | Lock extensions take effect in the next Epoch. | [[parameters/aster/staking-rewards]] | A7-PII |
| #c23 | Redeem (unstake) requests take effect in the next Epoch. | [[parameters/aster/staking-rewards]] | A7-PII |
| #c24 | Aster combines validator-PoS Base APY with veToken-style time-locked Loyalty Rewards in a single staking system. | [[parameters/aster/staking-rewards]] | - |
