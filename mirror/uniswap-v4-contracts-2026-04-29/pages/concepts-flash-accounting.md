# Flash Accounting

In previous versions of Uniswap, every time a swap was made - including multi-hop swap - tokens were transferred between Pool contracts for intermediate steps.

With the singleton architecture, a better design was possible and is referred to as Flash Accounting. The design became practical with gas efficiencies of Transient Storage (EIP-1153). Flash Accounting further reduces the gas cost of trades that cross multiple pools and supports more complex integrations with Uniswap v4.

With flash accounting, each balance-changing operation (e.g. swap and liquidity modification) updates an internal net balance known as `delta`. Only the final balance-changes require token transfers.

## Mechanism

### Locking

To ensure correctness and atomicity in complex operations like a multi-hop swap, v4 uses a locking mechanism. Anytime key actions need to take place within the PoolManager - e.g. swaps and liquidity modification - a periphery contract must `unlock` the PoolManager first. Then integrators implement the `unlockCallback` and proceed with any of the following actions on the pools:

- swap
- modifyLiquidity
- donate
- take
- settle
- mint
- burn
- sync

Note that pool initialization can happen outside the context of unlocking the PoolManager, as there are no balance-changing operations associated with pool creation.

### Balance delta

Inside `unlockCallback`, a periphery contract performs balance-changing operations i.e. conduct swaps, modify positions, etc. After returning execution context back to PoolManager, the core contract checks that balances are resolved - nothing is owed to or from the PoolManager.

The balances resolved above is what we refer as the `delta`, a field held in the transient state. The values represent the debts and credits of assets owed to or from the PoolManager.

## Swapping

For multi-hop swaps (e.g. ETH → USDC → DAI):

### Previously on v3
- ETH is transferred to ETH/USDC pool contract
- USDC is withdrawn from ETH/USDC contract and transferred to USDC/DAI contract
- DAI is withdrawn from USDC/DAI contract and transferred to the user

### Now on v4
- Call swap() on ETH/USDC
- Call swap() on USDC/DAI, with the credit of USDC from above being used as the input amount
- User resolves deltas by paying ETH and receiving DAI

The optimization scales infinitely - any number of arbitrary hops only requires two token transfers: input and output tokens.

## Liquidity Management

The optimization becomes more evident for complex liquidity operations. For example, a user wanted to add liquidity to ETH/DAI but does not have DAI. The user can swap some ETH to DAI in order to add liquidity with both tokens. If properly integrated, the user would only need to transfer ETH once.
