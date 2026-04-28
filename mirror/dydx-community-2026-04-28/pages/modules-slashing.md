# Slashing

Source: https://docs.dydx.community/dydx/modules/slashing

## Overview

The slashing module is a mechanism to penalize validators for a violation of protocol rules by slashing their bonded tokens. Penalties under the slashing module include burning a portion of a validator's bonded tokens and/or temporarily removing their ability to vote on future blocks.

## Summary

- Signing Info
- Liveness Tracking
- Messages
- Social Slashing

## Key Concepts and Definitions

- States: In the state machine, a variable number of validators are registered, and during each block, the top `max_validators` (defined in the Staking module) who are not jailed become bonded and can propose and vote on blocks.
- Double Signing: When a validator is proven to have signed two blocks at the same height, causing conflicting blocks or transactions on multiple branches of the dYdX Chain.
- Downtime: When a validator does not vote on a dYdX Chain block for a period of time.
- Jailed: A period of time when a validator is not allowed to rejoin the Active Set due to a violation of protocol rules.
- Staking Tombstone: When a validator is permanently removed from the Active Set due to a double signing infraction.

## Parameters

These parameters may be adjusted by the dYdX Community with an on-chain governance proposal.

| Title | Value | Definition |
| --- | --- | --- |
| `signed_blocks_window` | 8192 (~3 hours 11 minutes assuming 1.4s block time) | The window in terms of the number of blocks for which a validator's signing activity is monitored. |
| `min_signed_per_window` | 0.2 | The minimum of blocks in the `signed_blocks_window` that a validator must sign to avoid being jailed. |
| `downtime_jail_duration` | 7200s (2 hours) | The length of time a validator is temporarily removed from the Active Set. |
| `slash_fraction_double_sign` | 0.0 | The fraction of a validator's staked tokens that will be slashed in the event of a double signing violation. |
| `slash_fraction_downtime` | 0.0 | The fraction a validator will be slashed by if they miss a fraction (`min_signed_per_window`) of blocks within a sliding window (`signed_blocks_window`). |

## Signing Info

In every block, validators contribute to a set of precommits for the previous block, forming the `LastCommitInfo` in CometBFT. This `LastCommitInfo` is valid if it includes precommits from +2/3 of the total voting power.

If a validator fails to be included in the `LastCommitInfo` for a certain number of blocks, they will be automatically jailed, slashed or unbonded.

## Liveness Tracking

dYdX Chain stores Information about validator's liveness activity on `ValidatorSigningInfo`. The sliding window is defined by `signed_blocks_window` and the index is determined by the `IndexOffset` in each validator's `ValidatorSigningInfo`. To determine whether a validator falls below the liveness threshold:

```
maxMissed = signed_blocks_window - min_signed_per_window * signed_blocks_window
```

If the current block is past `minHeight` and the `MissedBlocksCounter` exceeds `maxMissed`, the validator is slashed by `slash_fraction_downtime`, jailed for `downtime_jail_duration`, and has their `MissedBlocksBitArray`, `MissedBlocksCounter`, and `IndexOffset` reset.

Slashing due to liveness tracking failure does not lead to tombstoning.

## Messages

- Unjail: Should a validator want to return after being removed due to Downtime, they must send a `MsgUnjail`.

```
message MsgUnjail {
string validator_addr = 1;
}
```

## Social Slashing

The MEV (Maximal Extractable Value) extraction by validators can undermine a fair and transparent trading environment. MEV refers to the profit a dishonest validator can gain by censoring and/or re-ordering orders and cancellations to their advantage.

To show how much MEV value could be extracted by each validator, dYdX Trading and Skip Protocol have collaborated to create a dashboard that displays data on orderbook discrepancies.

Currently, there is no protocol-level solution to mitigate MEV on the dYdX Chain, despite MEV extraction being considered a harmful validator behavior. However, the dYdX community, through a governance vote, could approve the implementation of a social slashing framework to penalize validators engaged in MEV extraction.
