# Proposal Lifecycle

Source: https://docs.dydx.community/dydx/modules/governance/proposal-lifecycle

## Proposal Stages

Below outlines the flow of dYdX Chain governance, from the idea's inception to implementation.

## Summary

- Forum Discussion
- (Off-chain) DRC Creation
- (Off-chain) DRC Discussion and Feedback
- (Off-chain) DIP Creation
- (On-chain) Submitting a Proposal
- (On-chain) Proposal Deposits
- (On-chain) DIP Voting
- (On-chain) Proposal Tallying and Execution

## 0. Forum Discussion

Anyone can sign up and set up a thread on any topic on dYdX's governance forums hosted at https://dydx.forum/.

## 1. (Off-chain) DRC Creation

dYdX Request for Comments (DRCs) creation is the first step in the governance improvement process.

## 2. (Off-chain) DRC Discussion and Feedback

The DRC Discussion and Feedback step aims to establish a rough consensus before a vote starts. Four days likely makes sense.

## 3. (Off-chain) DIP Creation

Before submitting a transaction to create a governance proposal, the prospective proposer must create a `json` file containing relevant information for the governance proposal. Depending on the type of proposal:

1. Text Proposals: title, description, and deposit (in aDYDX units).
2. Community Spending Proposals: title, description, recipient, number of tokens, and deposit (in `aDYDX` units).
3. Parameter Change Proposals: title, description, changes, subspace (module with the parameter that is being changed), key (the parameter that is being changed), value, and deposit.
4. Software Upgrade Proposals: title, description, deposit and plan. The plan outlines when the update will occur (block height), the name of the new version of the software, and the `UpgradeHandler`.

Below is a template `json` file for a Text proposal:

```json
{
  "title": "Title",
  "deposit": "2000000000000000000000adydx",
  "summary": "Summary [max 255 characters]",
  "messages": [
    {
      "@type": "/cosmos.gov.v1.MsgExecLegacyContent",
      "content": {
        "@type": "/cosmos.gov.v1beta1.TextProposal",
        "title": "Title goes here.",
        "description": "Additional summary or blank if not needed."
      },
      "authority": "dydx10d07y265gmmuvt4z0w9aw880jnsr700jnmapky"
    }
  ]
}
```

The description must at least contain a short summary of the DRC, a link to the completed DIP template, and a link to the forum post.

## 4. (On-chain) Submitting a Proposal

An on-chain DIP may be submitted by a dYdX community member using the following generic command format:

```sh
dydxprotocold tx gov submit-proposal <proposal type> \
-- <json file> \
--from <submitter address> \
--chain-id <chain id> \
--gas <max gas allocated> \
--fees <fees allocated> \
--node <node address>
```

If `<proposal type>` is left blank, the type will be a Text proposal. Otherwise, it can be set to `param-change`, `software-upgrade`, or `community-treasury-spend`.

To submit the proposal on-chain, the proposer will need to deposit a number of DYDX that is equal to or greater than the `min_initial_deposit_ratio`.

## 5. (On-chain) Proposal Deposits

As soon as the proposal is created the `max_deposit_period` begins and the `min_deposit` must be satisfied before the `max_deposit_period` concludes for the vote to start. Anyone can contribute to the deposit:

```sh
dydxprotocold tx gov deposit <proposal-id> <deposit> --from <key>
```

If a proposal fails to satisfy the `min_deposit` within the `max_deposit_period` and the `burn_proposal_deposit_prevote` parameter is set "False", any DYDX holder who contributed to the respective deposit of a proposal will have their deposit refunded.

If the `min_deposit` is satisfied within the `max_deposit_period`, the vote will start and the deposit is kept in escrow and held by the governance `ModuleAccount` until the proposal is finalized. Depositors will have their deposit refunded, unless enough voters vote `NoWithVeto` and satisfy the `veto_threshold`.

## 6. (On-chain) DIP Voting

If the `min_deposit` is satisfied, voting will last for the `voting_period`. Only staked DYDX tokens can vote on dYdX Chain governance proposals. If a DYDX staker does not vote, they will inherit the vote of their validator.

## 7. (On-chain) Proposal Tallying and Execution

When the `voting_period` ends, the `TallyParams` (`quorum`, `threshold`, and `veto_threshold`) determine whether the proposal is approved and implemented or rejected.

Execution by vote type:

- Text Proposals: no on-chain changes, but could result in an off-chain action.
- Community Spending Proposals: the number of DYDX encoded in the proposal will be transferred from the dYdX community account to the address encoded in the proposal.
- Parameter Change Proposals: the parameter update goes into effect without a hard fork.
- Software Upgrade Proposals: validators upgrade their software to the new version and signal that they are ready; at the specified block height, the chain pauses; validators apply the upgrade and restart their nodes.
