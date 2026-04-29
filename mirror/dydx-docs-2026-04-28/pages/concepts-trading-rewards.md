# Rewards, Fees and Parameters

Source: https://docs.dydx.xyz/concepts/trading/rewards

## Rewards

There are several reward mechanisms available with the protocol software.

| | Target Users | Rewards paid in | Claim Process | Frequency |
| --- | --- | --- | --- | --- |
| Staking Rewards | Validators & Stakers | USDC & NATIVE_TOKEN | Manual | Per Block |
| Trading Rewards | Traders | NATIVE_TOKEN | Automatic | Per Block (with trades) |

## Staking Rewards

- Rewards distributed to `Validators` and `Stakers` (= Delegators)
- `Staking Rewards = Trading Fees + Gas Fees - Community Tax - Validator Commission`
- Distributed automatically every block
- Must be claimed manually

## Trading Rewards (Note that C factor has been set to 0)

- Rewards distributed to `Traders` after each successful trade
- Based on a specified `formula` with several inputs
- Distributed automatically every block with successful trades
- Claimed automatically

## Fees

### Fee tiers

The basic structure for fees has been developed to reflect the following characteristics:

1. Fees differ based on side (maker/taker)
2. Users are eligible for lower fees based on their 30 day trading volume across sub accounts and markets
3. Fees are uniform across all markets

| Tier | 30d Trailing Volume | Taker (bps) | Maker (bps) |
| --- | --- | --- | --- |
| 1 | < $1M | 5.0 | 1.0 |
| 2 | ≥ $1M | 4.5 | 1.0 |
| 3 | ≥ $5M | 4.0 | 0.5 |
| 4 | ≥ $25M | 3.5 | 0 |
| 5 | ≥ $50M | 3.0 | 0 |
| 6 | ≥ $100M | 2.5 | -0.7 |
| 7 | ≥ $200M | 2.5 | -1.1 |

### Staking tier

- Fee discounts are based on fee tier and the amount of staked DYDX
- Discounts apply only to net positive trading fees
- Only staked tokens (status: bonded) count towards a given trader's staking fee discount. Unstaked DYDX in the unbonding period does not qualify.
- Staking discounts do not apply to maker rebates (negative fees)
- The dYdX community voted to set the staking fee discounts below. Staking fee discounts can be changed at any time with a dYdX governance proposal.

| Tier | Number of dYdX (Discount 1) | Discount 1 | Number of dYdX (Discount 2) | Discount 2 |
| --- | --- | --- | --- | --- |
| 1 | 3,000 | 25% | 20,000 | 50% |
| 2 | 20,000 | 20% | 80,000 | 45% |
| 3 | 80,000 | 20% | 200,000 | 40% |
| 4 | 200,000 | 15% | 800,000 | 30% |
| 5-7 | 800,000 | 5% | 5,000,000 | 10% |

## Parameters

### Bank Parameters

This parameter establishes whether transfers for any tokens are enabled at Genesis. Transfers will be enabled.

### Slashing Parameters

These parameters establish punishments for detrimental behavior by validators.

| Signed Blocks Window | Min Signed Per Window | Downtime Jail Duration | Slash Fraction Doublesign | Slash Fraction Downtime |
| --- | --- | --- | --- | --- |
| 8192 (~3 hrs) | 20% | 7200s | 0% | 0% |

- SignedBlocksWindow + MinSignedPerWindow: specifies the number of blocks a validator must sign within a sliding window. Failure leads to validator being jailed (removed from active validator set).
- SlashFractionDownTime: defines the slashing-penalty for downtime
- DownTimeJailDuration: how long before the validator can unjail themselves after being jailed for downtime.

Double-signing is severe — validator is slashed for SlashFractionDoubleSign, jailed (removed from validator set) and tombstoned (cannot rejoin validator set).

### Distribution Parameters

| Community Tax | WithdrawAddrEnable |
| --- | --- |
| 0% | True |

- CommunityTax: Fraction of fees that goes to the community treasury. The software will initially reflect a 0% community tax.
- WithdrawAddrEnabled: Whether a delegator can set a different withdrawal address for their rewards.

### Staking Parameters

| BondDenom | MaxValidators | MinCommissionRate | Unbonding Time |
| --- | --- | --- | --- |
| Decided at Genesis | 60 | 5% | 30 days |

- MaxValidators: Every block, the top MaxValidators validators by stake weight are included in the active validator set.
- UnbondingTime: Specifies the duration of the unbonding process, during which tokens are in a locked state and cannot be transferred or delegated (the tokens are still "at stake").
- MinCommissionRate: The chain-wide minimum commission rate that a validator can charge their delegators. The default commission rate will be 100%.

### Governance Parameters

| Min Deposit | MinInitialDepositRatio | Max Deposit Period | Voting Period | Quorum | Threshold | Veto |
| --- | --- | --- | --- | --- | --- | --- |
| 10,000 governance token | 20% | 1 Days | 4 Days | 33.4% | 50% | 33.4% |
