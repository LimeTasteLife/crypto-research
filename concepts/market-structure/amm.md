---
type: concept
domain: market-structure
name: AMM
last_reviewed: 2026-04-29
disputed: false
---

# AMM

## Definition
An automated market maker (AMM) is a market-structure model in which a deterministic pricing function (e.g. x*y=k, concentrated liquidity curves, or custom hook-defined curves) replaces the traditional order book for price discovery and trade execution[^uniswap-v4-contracts-2026-04-29-concepts-architecture]. Liquidity providers deposit assets into pools and earn fees from swaps; the AMM algorithm determines the exchange rate based on pool reserves and the curve formula.

## Variants in the wild

| venue | curve model | extensibility | LP position standard | notes |
|---|---|---|---|---|
| [[entities/dex/uniswap-v4]] | concentrated liquidity (inherited from v3) + custom curves via hooks[^uniswap-v4-contracts-2026-04-29-concepts-architecture] | hooks can eject CL model entirely for arbitrary pricing[^uniswap-v4-contracts-2026-04-29-guides-custom-accounting] | ERC-6909 claims (replaces v3's ERC-721)[^uniswap-v4-contracts-2026-04-29-concepts-erc-6909] | singleton PoolManager; flash accounting (EIP-1153); 10 hook lifecycle callbacks[^uniswap-v4-contracts-2026-04-29-concepts-hooks] |

(Other DEX venues to be added in subsequent ingest passes.)

## Edge cases
- Hooks that implement custom curves bypass the concentrated liquidity math entirely — the AMM is effectively whatever the hook defines[^uniswap-v4-contracts-2026-04-29-guides-custom-accounting]
- Hook fees (via BeforeSwapDelta) are separate from the AMM's LP swap fees[^uniswap-v4-contracts-2026-04-29-guides-custom-accounting]

## Disputed claims
None.

## Related
[[concepts/market-structure/clob]] · [[concepts/lp/concentrated-liquidity]] · [[entities/dex/uniswap-v4]]

## Sources
[^uniswap-v4-contracts-2026-04-29-concepts-architecture]: [[sources/uniswap-v4-contracts-2026-04-29-concepts-architecture]]
[^uniswap-v4-contracts-2026-04-29-concepts-hooks]: [[sources/uniswap-v4-contracts-2026-04-29-concepts-hooks]]
[^uniswap-v4-contracts-2026-04-29-concepts-erc-6909]: [[sources/uniswap-v4-contracts-2026-04-29-concepts-erc-6909]]
[^uniswap-v4-contracts-2026-04-29-guides-custom-accounting]: [[sources/uniswap-v4-contracts-2026-04-29-guides-custom-accounting]]
