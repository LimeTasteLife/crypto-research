---
type: parameter
entity: [[entities/dex/uniswap-v4]]
parameter: pool-creation-params
unit: mixed
last_change: 2025-Q1
last_reviewed: 2026-04-29
disputed: false
---

# Uniswap v4 Pool Creation Parameters

## Current (as of 2025-Q1)

Pools are created by calling `PoolManager.initialize()` with the following parameters[^uniswap-v4-contracts-2026-04-29-concepts-poolmanager]:

- **Token pair** — the two tokens for the pool[^uniswap-v4-contracts-2026-04-29-concepts-poolmanager]
- **Fee tier** — LP swap fee (0-100% in 0.0001% increments); static if no dynamic fee hook, dynamic if hook manages[^uniswap-v4-contracts-2026-04-29-concepts-architecture]
- **Tick spacing** — determines granularity of concentrated liquidity positions[^uniswap-v4-contracts-2026-04-29-concepts-poolmanager]
- **Hook contract address** — optional; encodes hook permissions in the address bits[^uniswap-v4-contracts-2026-04-29-concepts-hooks]

Pool creation is permissionless — anyone can create a pool[^uniswap-v4-contracts-2026-04-29-concepts-architecture]. Creation is a state update on the singleton PoolManager, significantly cheaper than v3's contract deployment model[^uniswap-v4-contracts-2026-04-29-concepts-v4-vs-v3]. Each pool gets a unique PoolId[^uniswap-v4-contracts-2026-04-29-concepts-poolmanager].

Pool initialization can happen outside the `unlock` context because it has no balance-changing operations[^uniswap-v4-contracts-2026-04-29-concepts-flash-accounting].

### Post-creation immutability

Once created, pool parameters (token pair, fee tier, tick spacing, hook address) are immutable[^uniswap-v4-contracts-2026-04-29-concepts-poolmanager]. Dynamic fee updates are allowed only if the pool's hook supports them[^uniswap-v4-contracts-2026-04-29-concepts-architecture]. A `salt` parameter can distinguish positions of the same range on the same pool[^uniswap-v4-contracts-2026-04-29-concepts-v4-vs-v3].

### v4 supports native token pairs

Pool pairs support native ETH directly, without WETH9 wrapping[^uniswap-v4-contracts-2026-04-29-concepts-architecture].

## Time series

| effective | change | source |
|-----------|--------|--------|
| 2025-Q1 | v4 launch: permissionless pool creation via PoolManager.initialize() with token pair, fee tier, tick spacing, optional hook | [^uniswap-v4-contracts-2026-04-29-concepts-poolmanager] |

## Disputed values
None.

## Sources
[^uniswap-v4-contracts-2026-04-29-concepts-architecture]: [[sources/uniswap-v4-contracts-2026-04-29-concepts-architecture]]
[^uniswap-v4-contracts-2026-04-29-concepts-hooks]: [[sources/uniswap-v4-contracts-2026-04-29-concepts-hooks]]
[^uniswap-v4-contracts-2026-04-29-concepts-poolmanager]: [[sources/uniswap-v4-contracts-2026-04-29-concepts-poolmanager]]
[^uniswap-v4-contracts-2026-04-29-concepts-flash-accounting]: [[sources/uniswap-v4-contracts-2026-04-29-concepts-flash-accounting]]
[^uniswap-v4-contracts-2026-04-29-concepts-v4-vs-v3]: [[sources/uniswap-v4-contracts-2026-04-29-concepts-v4-vs-v3]]
