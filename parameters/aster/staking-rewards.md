---
type: parameter
entity: [[aster]]
parameter: staking-rewards
unit: tokens / week
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: false
---

# Aster staking rewards

## Current (as of 2026-04-28)

**Emission at launch.** Aster Chain emits **450,000 $ASTER per weekly Epoch** at launch — split into **150,000 Base** + **300,000 Loyalty**[^aster-docs-2026-04-28-aster-chain-staking-how-staking-works].

**Base APY (validator-PoS).** Each validator's share of the Base APY pool is proportional to its share of network transactions processed[^aster-docs-2026-04-28-aster-chain-staking-how-staking-works]:

- `Validator Share = Validator Transactions / Total Network Transactions`
- `Validator Reward = Base APY Pool × Validator Share`
- `User Base Reward = Validator Reward × (User Stake / Total Validator Stake) × (1 − Validator Commission)`

**Loyalty Rewards (veToken-style).** Loyalty Rewards weight time-locked positions and tie staking yield to personal trading volume[^aster-docs-2026-04-28-aster-chain-staking-how-staking-works]:

- `User Power = veASTER × Trading Volume Boost`
- `veASTER = Locked Amount × (Remaining Lock Duration / 208 weeks)` (Time Weight)
- Maximum lock = **208 weeks (~4 years)**
- `User Loyalty Reward = Weekly Loyalty Pool × (User Power / Total Network Power)`

**Trading Volume Boost tiers**[^aster-docs-2026-04-28-aster-chain-staking-how-staking-works]:

| Epoch trading volume | Boost |
|---|---|
| > $500,000 | 1.05× |
| > $50,000,000 | 1.15× |
| > $200,000,000 | 1.25× |

**Epoch timing.** Epochs run **Monday 00:00 UTC → Sunday 00:00 UTC**; snapshot at Monday 00:00 UTC, settlement at Sunday 00:00 UTC[^aster-docs-2026-04-28-aster-chain-staking-how-staking-works].

**Lifecycle delays.** Deposits, top-ups, lock extensions, and redeem requests **all take effect in the next Epoch** (no immediate effect)[^aster-docs-2026-04-28-aster-chain-staking-how-staking-works]. Staking on Aster Chain requires choosing a validator and a lock period before confirming; positions become active and begin earning rewards in future Epochs[^aster-docs-2026-04-28-aster-chain-staking-how-staking-works].

**Source bucket.** After January 2026, the Ecosystem & Community allocation is distributed via the staking emission model — staking rewards are the sole active use of the Ecosystem & Community bucket[^aster-docs-2026-04-28-usdaster-tokenomics][^aster-docs-2026-04-28-aster-chain-staking-how-staking-works]. See [[parameters/aster/tokenomics]].

## Time series

| effective | Base / Loyalty pool (per Epoch) | TVB tiers (1.05× / 1.15× / 1.25×) | max lock | epoch | source |
|---|---|---|---|---|---|
| 2026-04-28 | 150K / 300K = 450K $ASTER | $500K / $50M / $200M | 208 weeks | Mon 00:00 UTC → Sun 00:00 UTC | [^aster-docs-2026-04-28-aster-chain-staking-how-staking-works] |

## Tiering rules / formulae

- `Validator Reward = BaseAPYPool × (ValidatorTx / TotalNetworkTx)`[^aster-docs-2026-04-28-aster-chain-staking-how-staking-works]
- `UserBaseReward = ValidatorReward × (UserStake / TotalValidatorStake) × (1 − Commission)`[^aster-docs-2026-04-28-aster-chain-staking-how-staking-works]
- `veASTER = LockedAmount × (RemainingLock / 208 weeks)`[^aster-docs-2026-04-28-aster-chain-staking-how-staking-works]
- `UserPower = veASTER × TradingVolumeBoost(1.05× | 1.15× | 1.25×)`[^aster-docs-2026-04-28-aster-chain-staking-how-staking-works]
- `UserLoyaltyReward = WeeklyLoyaltyPool × (UserPower / TotalNetworkPower)`[^aster-docs-2026-04-28-aster-chain-staking-how-staking-works]

## Disputed values
None.

## Sources
[^aster-docs-2026-04-28-aster-chain-staking-how-staking-works]: [[sources/aster-docs-2026-04-28-aster-chain-staking-how-staking-works]]
[^aster-docs-2026-04-28-usdaster-tokenomics]: [[sources/aster-docs-2026-04-28-usdaster-tokenomics]]
