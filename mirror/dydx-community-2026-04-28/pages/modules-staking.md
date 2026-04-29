# Staking

Source: https://docs.dydx.community/dydx/modules/staking

## Overview

dYdX Chain leverages the Cosmos SDK Staking module which supports a Proof-of-Stake blockchain and enables DYDX holders to become validators and/or delegate the validation rights (stake) of their DYDX to a dYdX Chain validator.

## Summary

- Redelegation
- Unbonding delegations / Unstaking
- Staking to a dYdX Chain Validator

## Key Concepts and Definitions

- Validator Commission: Commission set by each validator and applied to the staking rewards of each delegator. Validators are required to follow the `min_commission_rate` parameter but are otherwise free to set their own commission rates.
- Unbonded Validator: The validator (1) is not in the Active Set, (2) cannot sign blocks and (3) does not earn rewards, but they can receive delegations.
- Inactive Set: Validators who are not in the Active Set, do not participate in consensus and do not receive rewards.
- EndBlock: A function called after all transactions in a block have been processed. `EndBlock` is generally used to execute logic that should happen after a block is executed to finalize state transitions, such as determining the active validator set.
- Active Set: the validators that can participate in consensus, receive rewards, and secure the dYdX Chain at a given time. The active set includes the top validators according to staked tokens (delegated from third parties and self-delegation) and is determined by the `max_validators` parameter. The Active Set is updated during `EndBlock` by retrieving `validatorsbypower` and the `max_validators` parameter.
- Bonded Validator: once the validator receives sufficient bonded tokens they automatically join the Active Set `EndBlock` and their status is updated to Bonded. A bonded validator (1) is signing blocks and receiving rewards (2) can receive further delegations, and (3) can be slashed for misbehavior.
- Staking: the act of delegating and locking up ('bonding') DYDX tokens to a dYdX Chain validator to secure and govern the network.

## Staking to a dYdX Chain Validator

On the dYdX Chain, DYDX holders can serve as validators or delegate their stake to existing validators. Such delegation increases the likelihood of the chosen validator(s) entering or staying in the active validator set.

## Unbonding delegations / Unstaking

DYDX holders who stake DYDX to a validator can send a transaction to unstake and remove their tokens (fully or partially) from being staked to a validator. After this transaction is sent, the DYDX tokens enter an unbonding period which lasts for the duration of the unbonding_time parameter.

## Redelegation

Redelegation in the Cosmos SDK is a feature that allows a delegator to shift their staked tokens (delegations) from one validator to another without having to wait for the unbonding period.

During the redelegation process, the tokens remain staked, meaning they continue contributing to the network's security and potentially earning rewards for the delegator.

However, a user's slashing risk with the original validator remains until the unbonding period concludes. After redelegating, you must wait 30 days before redelegating again from this new validator.

## Winding Down Validator

Validators operating a node on the dYdX Chain may choose to wind down their operations at any time. Best practices:

1. Update Your Validator Moniker — reflect that you are winding down.
2. Notify the dYdX Operations SubDAO so they can remove your node from monitoring tools.
3. Provide Advance Notice. The unbonding period on dYdX Chain is currently 21 days. Allow at least 45–60 days after the announcement before fully winding down.
4. Announce on the dYdX Forum, Your Website and Social Media.
