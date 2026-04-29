# PoolManager

In Uniswap v3, each liquidity pool was represented by a separate smart contract deployed through the UniswapV3Factory contract. Uniswap v4 introduces the Singleton design pattern. The PoolManager contract now serves as a single entry point for all liquidity pools.

## Purpose

The primary purpose of the PoolManager is to:
- Efficiently manage liquidity pools
- Facilitate token swaps
- Reduce gas costs compared to the factory-based approach in Uniswap v3
- Enable extensibility through hooks

## Architecture

### Singleton design
- Uniswap v4 uses a Singleton design pattern for the PoolManager
- All pool state and logic are encapsulated within the PoolManager contract

### Locking mechanism
- The PoolManager uses a locking mechanism to allow for flash accounting (deferred balance accounting)
- When unlocked, the calling contract can perform various operations and zero-out outstanding balances before returning control to the PoolManager for final solvency checks

### Pool state
The Pool.State struct contains information such as:
- Current price
- Liquidity
- Tick bitmap
- Fee growth
- Position information

## Core Functionality

### Pool creation
- New pools are created by calling the `initialize` function on the PoolManager
- The pool creator specifies the token pair, fee tier, tick spacing, and optional hook contract address
- The PoolManager initializes the pool state and associates it with a unique PoolId

### Swaps
The PoolManager executes the following steps:
1. Checks if the pool is valid and initialized
2. Executes the `beforeSwap` hook, if applicable
3. Performs the actual swap, updating the pool state and charging fees
4. Executes the `afterSwap` hook, if applicable
5. Calculates the net token amounts owed to the user and the pool, represented by the BalanceDelta struct

### Liquidity management
The PoolManager executes the following steps:
1. Checks if the pool is valid and initialized
2. Determines if the modification is an addition or removal of liquidity
3. Executes the appropriate `beforeAddLiquidity` or `beforeRemoveLiquidity` hook, if applicable
4. Performs the actual liquidity modification and updates the pool state
5. Emits the `ModifyLiquidity` event
6. Executes the appropriate `afterAddLiquidity` or `afterRemoveLiquidity` hook, if applicable
7. Calculates the balance delta and returns it to the caller

### Flash accounting
- The PoolManager employs flash accounting to reduce gas costs and simplify multi-hop swaps
- Tokens are moved into the PoolManager contract, and all subsequent actions are performed within the contract's context
- Only the final output tokens are withdrawn from the PoolManager at the end of the transaction

#### Transient storage
- The PoolManager utilizes transient storage (EIP-1153) to store temporary data during complex operations
- Transient storage reduces gas costs by avoiding regular storage operations for data only needed within a single transaction
