# ERC-6909

Uniswap v4 uses ERC-6909 to further improve gas-efficiency on token claims and redemptions.

ERC-6909 is a minimal and gas-efficient standard for managing multiple ERC-20 tokens from a single contract. It provides a simplified alternative to the more complex ERC-1155 multi-token standard.

### ERC-6909 vs ERC-1155

ERC-6909 offers several advantages over ERC-1155:
1. Simplified interface: removes unnecessary safe transfer callbacks and batching constraints.
2. Improved transfer delegation: more efficient system for transfer delegation.
3. Gas efficiency: reduces gas costs for deployment, transfers, and burning operations.
4. Reduced code size: smaller contract sizes compared to ERC-1155.

## How It Works

Instead of choosing to move tokens in/out of the PoolManager, developers can opt-in and leave the ERC-20 tokens within the PoolManager. In exchange, the PoolManager can mint them an ERC-6909 token representing their claim. In subsequent interactions requiring paying tokens, users can simply burn some (or all) of their claim tokens.

Minting and burning ERC-6909 tokens are more gas-efficient because they don't require external function calls and have a constant-size gas overhead regardless of the underlying ERC-20 token.

## Examples

### High-frequency traders / MEV bots
These users conduct many swaps in short durations while staying within the Uniswap Protocol. They can trade using ERC-6909 tokens for improved gas-efficiency.

### Liquidity management
For power-users that may be opening and closing liquidity positions frequently, liquidity managers can opt-in and receive their capital as ERC-6909.
