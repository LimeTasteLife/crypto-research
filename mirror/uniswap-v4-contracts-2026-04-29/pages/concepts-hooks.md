# Hooks

Uniswap v4 introduces Hooks, a system that allows developers to customize and extend the behavior of liquidity pools.

Hooks are external smart contracts that can be attached to individual pools. Every pool can have one hook but a hook can serve an infinite amount of pools to intercept and modify the execution flow at specific points during pool-related actions.

## Key Concepts

### Pool-specific hooks

- Each liquidity pool in Uniswap v4 can have its own hook contract attached to it. Hooks are optional for Uniswap v4 pools.
- The hook contract is specified when creating a new pool in the `PoolManager.initialize` function.
- Having pool-specific hooks allows for fine-grained control and customization of individual pools.

## Core Hook Functions

Uniswap v4 provides a set of core hook functions that can be implemented by developers. Developers do not have to implement every hook, you can mix & match them.

- Hook contracts specify the permissions that determine which hook functions they implement, which is encoded in the address of the contract.
- The `PoolManager` uses these permissions to determine which hook functions to call for a given pool based on its Key.

### Initialize hooks
- `beforeInitialize`: Called before a new pool is initialized.
- `afterInitialize`: Called after a new pool is initialized.

### Liquidity modification hooks
- `beforeAddLiquidity`: Called before liquidity is added to a pool.
- `afterAddLiquidity`: Called after liquidity is added to a pool.
- `beforeRemoveLiquidity`: Called before liquidity is removed from a pool.
- `afterRemoveLiquidity`: Called after liquidity is removed from a pool.

### Swap hooks
- `beforeSwap`: Called before a swap is executed in a pool.
- `afterSwap`: Called after a swap is executed in a pool.

### Donate hooks
- `beforeDonate`: Called before a donation is made to a pool.
- `afterDonate`: Called after a donation is made to a pool.

## Innovation and Potential

The introduction of hooks in Uniswap v4 opens up a world of possibilities for developers to innovate and build new DeFi protocols. Some potential use cases include:
- Customized AMMs with different pricing curves than xy = k.
- Yield farming and liquidity mining protocols that incentivize liquidity provision.
- Derivative and synthetic asset platforms built on top of Uniswap v4 liquidity.
- Lending hooks integrated with Uniswap v4 pools.

As a hook developer you can easily bootstrap the codebase of an entirely new DeFi protocol through hook designs. However, just because you made a hook, that does not mean you will get liquidity routed to your hook from the Uniswap frontend.
