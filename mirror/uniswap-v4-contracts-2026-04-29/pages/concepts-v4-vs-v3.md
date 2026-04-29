# v4 vs v3

While Uniswap v4's underlying concentrated liquidity is the same as Uniswap v3, there are some key differences in the architecture and accounting.

## Singleton Design

### Pool Creation
- v4: The singleton contract facilitates the creation of a pool and also stores its state. Pool creation is significantly cheaper (state update vs new contract deployment).
- v3: A factory contract is responsible for pool creation. The pool is a separate contract instance. Pool initialization is costly because contract creation is gas-intensive.

### Flash Accounting
- v4: The singleton uses flash accounting, meaning a caller that unlocks the PoolManager is allowed to cause balance-changing operations and only needs to perform token transfers at the very end of the sequence.
- v3: Because flash accounting is missing from v3, it is the responsibility of the integrating contract to perform token transfers after each individual call to each individual pool contract.

## Liquidity Fee Accounting
- v4: Accrued fees act like a credit when modifying liquidity. Increasing liquidity will convert the fee revenue to liquidity inside the position. Decreasing liquidity will automatically require the withdrawal of unclaimed fee revenue. An additional parameter `salt` can be provided when creating liquidity to distinguish positions of the same range on the same pool.
- v3: Liquidity positions of the same range and pool will share the same state. Integrating contracts will need to handle fee management since the state is shared on the core pool contract.

## Native ETH
- v4: Pool pairs support native tokens, so ETH swappers and liquidity providers benefit from gas cost reductions from cheaper transfers and removal of additional wrapping costs.
- v3: ETH needs to be wrapped first before being paired with other tokens, resulting in higher gas costs.

## Subscribers
- Only v4: Owners can now set a subscriber for their positions. A subscriber contract will get notified every time the position's liquidity or owner changes. Subscribers enable staking / liquidity-mining without transferring ERC-721 tokens.
- v3: Staking in v3 requires users to transfer their ERC-721 token to a contract, putting the underlying assets at risk.
