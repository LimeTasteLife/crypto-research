# Custom Accounting

Uniswap v4 introduces custom accounting patterns including deltas, hook fees, and custom curves.

## Introduction

Custom accounting, hook fees, custom curves, and return deltas form a cohesive system that enables unprecedented flexibility in decentralized exchange mechanisms.

## Delta accounting in v4

Uniswap v4 tracks net token transfers with transient storage. Unlike previous versions that tracked absolute token balances, v4 records changes to these balances (deltas). The PoolManager manages credits or debits per address.

Benefits:
1. More efficient state management for complex operations.
2. Easier integration with hooks for custom logic.
3. Improved gas efficiency, reducing storage writes.

## Hook fees in v4

Hook fees allow hook developers to monetize their hooks or implement custom value distribution mechanisms. Unlike pool fees or dynamic fees, hook fees are entirely separate.

Key characteristics:
- Separate from Pool Fees: distinct from standard pool fees.
- Implemented in beforeSwap: calculated and applied in the beforeSwap function.
- Use of BeforeSwapDelta: adjusts swap amounts and transfers deltas between hook and swap router.
- Flexible Implementation: developers have full control over calculation, collection, and distribution.

Potential use cases:
- Monetization of hook development
- Withdrawal penalties (e.g., to penalize JIT liquidity provision)
- Custom value distribution for LPs

## Custom curves in v4

Custom curves allow developers to eject the native concentrated liquidity pricing mechanism. Unlike v2 where x*y=k was hardcoded, v4 allows developers to implement a wide variety of pricing models through hooks.

Examples:
- Stable asset pairs with minimal price impact
- Curves for special token types like rebasing tokens, RWAs, vault tokens

## Return deltas in v4

Return deltas allow for precise, programmatic adjustments to operation outcomes:
1. Dual Adjustment: simultaneously modifies balance changes for both the hook and the swap router.
2. Credits and Debts Modification: alters credits and debts owed by hook and swap router.
3. Native Pricing Bypass: enables hooks to bypass Uniswap's native pricing mechanism.
4. Hook Fee Implementation: enables hooks to implement their own fee structures.

## Implementing Hook Fees

Hook fees are typically implemented through beforeSwap using BeforeSwapDelta. The hook calculates a fee on the swap amount, takes it via poolManager.take(), and returns a BeforeSwapDelta that transfers the hook's delta to the swap router.

Alternative: afterSwap fees compute fees on actual output (useful for partial swaps).
