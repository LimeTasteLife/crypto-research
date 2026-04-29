---
type: parameter
entity: [[dydx-v4]]
parameter: staking-rewards
unit: mixed
last_change: 2026-04-28
last_reviewed: 2026-04-29
disputed: false
---

# dYdX v4 staking-rewards

## Current (as of 2026-04-28)
- Source: trading fees (USDC) + gas fees (USDC + DYDX)[^dydx-docs-2026-04-28-concepts-trading-rewards-staking-rewards][^dydx-community-2026-04-28-modules-distribution]
- Flow: per-block accrual in `fee_collector` -> next-block transfer to `distribution` module -> community_tax + validator_commission subtracted -> remainder distributed proportionally by stake[^dydx-docs-2026-04-28-concepts-trading-rewards-staking-rewards]
- Formula: `Staking Rewards = fee_pool * (delegator_stake / total_stake) * (1 - community_tax) * (1 - validator_commission)`[^dydx-docs-2026-04-28-concepts-trading-rewards-staking-rewards]
- Stakers must claim manually; unclaimed rewards remain in distribution module account[^dydx-docs-2026-04-28-concepts-trading-rewards-staking-rewards][^dydx-community-2026-04-28-modules-distribution]
- Rewards NOT auto-restaked[^dydx-docs-2026-04-28-concepts-trading-rewards-staking-rewards]
- community_tax default: 0%[^dydx-docs-2026-04-28-concepts-trading-rewards]
- WithdrawAddrEnabled: True[^dydx-docs-2026-04-28-concepts-trading-rewards]

## Time series

| effective | community_tax | reward_source | source |
|---|---|---|---|
| 2026-04-28 (snapshot) | 0% | USDC trading fees + USDC/DYDX gas fees | [^dydx-docs-2026-04-28-concepts-trading-rewards-staking-rewards] |

## Tiering rules / formulae
- `Rewards = fee_pool * (delegator_stake/total_stake) * (1 - community_tax) * (1 - validator_commission)`[^dydx-docs-2026-04-28-concepts-trading-rewards-staking-rewards]

## Disputed values
None.

## Sources
[^dydx-docs-2026-04-28-concepts-trading-rewards-staking-rewards]: [[sources/dydx-docs-2026-04-28-concepts-trading-rewards-staking-rewards]]
[^dydx-community-2026-04-28-modules-distribution]: [[sources/dydx-community-2026-04-28-modules-distribution]]
[^dydx-docs-2026-04-28-concepts-trading-rewards]: [[sources/dydx-docs-2026-04-28-concepts-trading-rewards]]
