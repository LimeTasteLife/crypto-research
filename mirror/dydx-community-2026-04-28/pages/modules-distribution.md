# Distribution

Source: https://docs.dydx.community/dydx/modules/distribution

## Overview

The distribution module enables a simple collection and distribution mechanism to passively distribute rewards between validators and delegators.

## Summary

- How staking rewards are calculated
- How rewards are distributed on dYdX Chain
- Staking Rewards

## Key Concepts and Definitions

- Block Rewards: fees distributed to validators and delegators for successfully proposing and validating a new block on the blockchain.
- Total Bonded Power: the sum of all tokens that are currently staked by validators to themselves and tokens staked to validators by DYDX holders.
- Staking Rewards Withdrawal: a DYDX staker may claim their portion of the Fee Pool for each block. If a DYDX staker does not claim staking rewards, their respective rewards will accrue in the Distribution `ModuleAccount` Account.
- Fee Pool: fee pool from maker trading fees (USDC), taker trading fees (USDC), DYDX-denominated gas fees from transactions, and USDC-denominated gas fees from transactions for a given block.
- Staking Rewards: the total portion of the Fee Pool that a DYDX staker can claim at a given block.
- Distribution `ModuleAccount` Account: an account that collects and distributes trading and transaction fees among validators, delegators, and the community pool.
- Community Pool: a pool of tokens funded by a portion of staking rewards (`community_tax`) that the dYdX community could use to fund contributor grants, community initiatives, liquidity mining, and other initiatives.

## Staking Rewards

On the dYdX Chain, all transaction fees (trading fees denominated in USDC, DYDX-denominated gas fees from transactions, and USDC-denominated gas fees from transactions) collected by the protocol will be distributed to validators and DYDX holders that stake to dYdX Chain validators.

## How rewards are distributed on dYdX Chain

DYDX holders who stake to (a) validator(s) are entitled to a portion of the following fees:

- USDC taker trading fees
- USDC maker trading fees
- USDC-denominated gas fees from transactions
- DYDX-denominated gas fees from transactions

Fees will accrue in the `Distribution ModuleAccount Account` each block. Each block a DYDX staker may claim their portion of Staking Rewards. If a DYDX staker does not claim Staking Rewards, their respective rewards will accrue in the `Distribution ModuleAccount Account`.

Note, Staking Rewards are not automatically staked to a dYdX Chain validator. Any DYDX earned by a staker as Staking Rewards will need to be claimed from the `Distribution ModuleAccount Account` and staked to a dYdX Chain validator to contribute to the security of the network.

## How staking rewards are calculated

- Validator commission rate = commission set by each validator and applied to the staking rewards of each delegator.
- Community tax = A tax that directs a percentage of the fee pool to the community pool.
- Staking Rewards = the total portion of the Fee Pool that a DYDX staker can claim at a given block.
- Total bonded power = the sum of all DYDX that are currently staked by validators to themselves and DYDX staked to validators by DYDX holders.
- Number of DYDX staked by DYDX holder = total DYDX tokens that a dYdX Chain address has staked to (a) validator(s) at a given block.
- Fee Pool = fee pool from maker trading fees (USDC), taker trading fees (USDC), DYDX-denominated gas fees from transactions, and USDC-denominated gas fees from transactions for a given block.
