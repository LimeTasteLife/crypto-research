---
type: parameter
entity: [[dydx]]
parameter: governance-params
unit: mixed
last_change: 2026-04-28
last_reviewed: 2026-04-29
disputed: true
---

# dYdX v4 governance-params

## Current (as of 2026-04-28)
- CosmosSDK `x/gov` module with 5 proposal types (text, parameter change, community spending, software upgrade, new market)[^dydx-community-2026-04-28-modules-governance][^dydx-docs-2026-04-28-concepts-trading-governance]
- Vote weight = actively-staked DYDX (1:1); unstaked/unbonding does not count; non-voting staker inherits validator vote[^dydx-community-2026-04-28-modules-governance]
- Voting options: Yes / No / NoWithVeto / Abstain[^dydx-community-2026-04-28-modules-governance]
- min_deposit: 2,000 DYDX (disputed: 10k per docs.dydx.xyz)[^dydx-community-2026-04-28-modules-governance][^dydx-docs-2026-04-28-concepts-trading-rewards]
- max_deposit_period: 7 days (disputed: 1 day per docs.dydx.xyz)[^dydx-community-2026-04-28-modules-governance][^dydx-docs-2026-04-28-concepts-trading-rewards]
- min_initial_deposit_ratio: 20%[^dydx-community-2026-04-28-modules-governance]
- voting_period: ~4 days[^dydx-community-2026-04-28-modules-governance]
- quorum: 33.4%[^dydx-community-2026-04-28-modules-governance]
- threshold: 50%[^dydx-community-2026-04-28-modules-governance]
- veto_threshold: 33.4%[^dydx-community-2026-04-28-modules-governance]
- Expedited: threshold 75%, quorum 33.4%, 1-day voting period[^dydx-community-2026-04-28-modules-governance]
- burn_vote_veto: True; burn_vote_quorum: False; burn_proposal_deposit_prevote: False[^dydx-community-2026-04-28-modules-governance]
- 8-stage proposal lifecycle: Forum Discussion -> DRC Creation -> DRC Discussion (~4d) -> DIP Creation -> On-chain Submission -> Deposits -> Voting -> Tallying & Execution[^dydx-community-2026-04-28-modules-governance-proposal-lifecycle]
- Parameter Change Proposals take effect in the block AFTER voting period ends[^dydx-community-2026-04-28-modules-governance-proposal-lifecycle]

## Time series

| effective | param | value | source |
|---|---|---|---|
| 2026-04-28 (community docs) | min_deposit | 2,000 DYDX | [^dydx-community-2026-04-28-modules-governance] |
| 2026-04-28 (docs.dydx.xyz) | min_deposit | 10,000 tokens | [^dydx-docs-2026-04-28-concepts-trading-rewards] |
| 2026-04-28 (community docs) | max_deposit_period | 7 days | [^dydx-community-2026-04-28-modules-governance] |
| 2026-04-28 (docs.dydx.xyz) | max_deposit_period | 1 day | [^dydx-docs-2026-04-28-concepts-trading-rewards] |

## Tiering rules / formulae
- Governance-adjustable parameter surface: Stats Module look-back, FeeTiers, Insurance Fund send-out, LiquidationsConfig, Funding Rate clamps, Liquidity Tier table, Bridge Module, Community Pool/Treasury, equity-tier limits[^dydx-docs-2026-04-28-concepts-trading-governance][^dydx-community-2026-04-28-modules-governance-adjustable-parameters]

## Disputed values

### #dispute-governance-min-deposit

**Claim A** . confidence: high . recency: 2026-04 . authority: high
  min_deposit = 2,000 DYDX[^dydx-community-2026-04-28-modules-governance].

**Claim B** . confidence: medium . recency: 2026-04 . authority: high
  MinDeposit = 10,000 governance tokens[^dydx-docs-2026-04-28-concepts-trading-rewards].
  status: likely_superseded

### #dispute-governance-max-deposit-period

**Claim A** . confidence: high . recency: 2026-04 . authority: high
  max_deposit_period = 7 days[^dydx-community-2026-04-28-modules-governance].

**Claim B** . confidence: medium . recency: 2026-04 . authority: high
  MaxDepositPeriod = 1 day[^dydx-docs-2026-04-28-concepts-trading-rewards].
  status: likely_superseded

## Sources
[^dydx-community-2026-04-28-modules-governance]: [[sources/dydx-community-2026-04-28-modules-governance]]
[^dydx-docs-2026-04-28-concepts-trading-governance]: [[sources/dydx-docs-2026-04-28-concepts-trading-governance]]
[^dydx-docs-2026-04-28-concepts-trading-rewards]: [[sources/dydx-docs-2026-04-28-concepts-trading-rewards]]
[^dydx-community-2026-04-28-modules-governance-proposal-lifecycle]: [[sources/dydx-community-2026-04-28-modules-governance-proposal-lifecycle]]
[^dydx-community-2026-04-28-modules-governance-adjustable-parameters]: [[sources/dydx-community-2026-04-28-modules-governance-adjustable-parameters]]
