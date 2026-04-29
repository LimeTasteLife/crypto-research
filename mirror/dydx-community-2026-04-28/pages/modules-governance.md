# Governance

Source: https://docs.dydx.community/dydx/modules/governance

## Overview

dYdX Chain is a proof-of-stake blockchain network and holders of DYDX can participate in governing the dYdX Chain. dYdX Chain uses the standard x/gov module in the Cosmos SDK.

The governance module empowers DYDX holders to propose and vote on proposals, directly influencing the evolution of the dYdX Chain through a democratic process. The subject matter of proposals can vary from changing a governable parameter on the dYdX Chain, spending dYdX community funds, and updating the software that dYdX Chain nodes are running.

## Summary

- Proposal Submission and Deposits
- Proposal Types: Text Proposals, Community Spending Proposals, Parameter Change Proposals, Software Upgrade Proposals
- Proposal Voting Options
- Expedited Proposals

## Key Concepts and Definitions

- Deposits: Unstaked DYDX tokens pledged by the proposer and potentially other DYDX holders in support of the creation of a governance proposal.
- Inheritance: If a DYDX staker does not vote on a proposal, they will inherit the vote of their validator for the respective proposal.
- Vote Weight: A DYDX holder's vote weight is equal to the amount of DYDX the user has actively staked (1-1). DYDX tokens that are not staked or are in the unbonding period will not count towards a DYDX holder's vote weight.
- Tallying: After the voting period concludes, the TallyParams aggregate the vote results to determine if the proposal was accepted or rejected by the dYdX community.
- Execution: If a proposal passes, the execution process depends on the type of proposal.

## Parameters

These parameters may be adjusted by the dYdX Community with an on-chain governance proposal.

| Title | Value | Description |
| --- | --- | --- |
| `min_deposit` | 2000000000000000000000 adydx (2,000 DYDX) | The minimum token deposit for a governance proposal to enter the voting period. |
| `max_deposit_period` | 604800s (7 days) | The maximum time permitted for DYDX holders to deposit enough DYDX tokens. |
| `min_initial_deposit_ratio` | 0.20000 | The percentage of the `min_deposit` that needs to be submitted by the address that creates the proposal. |
| `voting_period` | 345600s (~4 days) | The duration of the voting period. |
| `quorum` | 0.33400 | The parameters for tallying votes on governance proposals. |
| `threshold` | 0.50000 | The minimum proportion of `Yes` votes for a proposal to pass. (`Abstain` votes are not counted.) |
| `veto_threshold` | 0.33400 | The minimum percentage of `NoWithVeto` votes required to reject a proposal, regardless of the number of `Yes` votes. |
| `burn_vote_veto` | True | If `True`, this boolean parameter will burn the proposal deposit for any proposals that are vetoed. |
| `burn_vote_quorum` | False | Burn the proposal deposit if the proposal vote does not reach `quorum`. |
| `burn_proposal_deposit_prevote` | False | Burn the proposal deposit if the proposal does not enter the voting period. |
| `expedited_threshold` | 0.75000 | The minimum proportion of `Yes` votes for an expedited proposal to pass. |
| `expedited_voting_period` | 86400s (~1 day) | The duration of expedited proposal's voting period. |

## Proposal Submission and Deposits

All DYDX holders have the right to create a proposal. A DYDX holder can only use unstaked DYDX tokens to contribute to a given proposal deposit.

To create a proposal, a DYDX holder needs to send a `msgsubmitproposal` transaction and satisfy the `min_initial_deposit_ratio` parameter by sending a `deposit` transaction.

After the proposal is created, any DYDX holder can contribute to the deposit by sending a `deposit` transaction. The voting period will start as soon as the `min_deposit` is reached.

If a proposal fails to satisfy the `min_deposit` within the `max_deposit_period` and the `burn_proposal_deposit_prevote` parameter is set "False", any DYDX holder who contributed to the respective deposit of a proposal will have their deposit refunded.

## Proposal Types

Governance of the dYdX Chain includes 5 distinct types of proposals: text proposals, parameter change proposals, community spending proposals, software upgrade proposals, and new market proposals.

### Text Proposals

Text proposals are votes that occur on-chain without directly triggering any changes on the dYdX Chain.

### Community Spending Proposals

Community Spending Proposals involve a request to spend DYDX from the community treasury, community pool, or any other community-controlled account. The inputs are (1) the number of DYDX and (2) the recipient address.

### Parameter Change Proposals

Parameter change proposals are for changing one or more of the dYdX Chain parameters that are controlled by the governance module. If successful, the parameter change takes effect in the block after the voting period ends.

### Software Upgrade Proposals

The upgrade module facilitates smoothly upgrading a live Cosmos chain to a new (breaking) software version. Software Upgrade Proposals need to be created with a `plan`. Such a plan outlines when the update will occur (`block height`), the name of the new version of the software, and the `UpgradeHandler`.

After the dYdX community accepts a software upgrade proposal there are two important steps:

- Signal — After a `SoftwareUpgradeProposal` is accepted, validators are expected to download and install the new version of the software while continuing to run the previous version.
- Switch — Once a block contains more than 2/3rd precommits where a common `SoftwareUpgradeProposal` is signaled, all the nodes are expected to switch to the new version of the software.

## Proposal Voting Options

The voting options for governance proposals on dYdX Chain are:

- `Yes`
- `No`
- `NoWithVeto` — allows voters to express strong disagreement with a proposal to the extent that if burn_vote_veto is "True" and the veto_threshold is reached the respective deposit in the governance module account for the proposal is burned.
- `Abstain` — allows voters to signal that they do not intend to vote in favor or against the proposal but accept the result of the vote.

## Expedited Proposals

A proposal can be expedited, which shortens the voting duration to 1 day and sets a higher tally threshold by default. The expedited proposal threshold is `0.75` (75%) and the quorum is `0.334` (33.4%). If the expedited proposal does not meet the threshold within the shortened voting period, it is converted to a regular proposal, and the voting restarts under standard conditions.

Users can set their proposal to expedited proposal by setting the `expedited` field in the proposal submission JSON file to `true`. Expedited proposals can be used for any vote type, including Text, Community Spend, Parameter Change, Adding Markets, and Software Upgrades.
