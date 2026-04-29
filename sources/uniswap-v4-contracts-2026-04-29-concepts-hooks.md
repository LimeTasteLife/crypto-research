---
type: source
id: uniswap-v4-contracts-2026-04-29-concepts-hooks
title: Uniswap v4 Hooks
publisher: Uniswap Docs
author: Uniswap team
date: 2026-04-29
original_url: https://docs.uniswap.org/contracts/v4/concepts/hooks
mirror_snapshot: uniswap-v4-contracts-2026-04-29
mirror_page: pages/concepts-hooks.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-29
---

# Uniswap v4 Hooks

## TL;DR
Hooks are external smart contracts that customize and extend liquidity pool behavior in Uniswap v4. Each pool can have one hook, but a single hook can serve an infinite number of pools. Hooks are specified at pool creation and encode their permissions in their contract address. Ten hook functions are available across four lifecycle stages: initialize (before/after), liquidity modification (before/after add and remove), swap (before/after), and donate (before/after). Use cases include customized AMMs, yield farming protocols, derivative platforms, and lending hooks.

## Claims extracted
| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Every pool can have one hook but a hook can serve an infinite amount of pools | [[entities/dex/uniswap-v4]] | - |
| #c2 | Hooks are optional for Uniswap v4 pools | [[entities/dex/uniswap-v4]] | - |
| #c3 | Hook contract is specified when creating a new pool via PoolManager.initialize | [[parameters/uniswap-v4/pool-creation-params]] | - |
| #c4 | Hook contracts specify permissions encoded in the address of the contract | [[entities/dex/uniswap-v4]] | - |
| #c5 | Ten hook functions across four stages: beforeInitialize, afterInitialize, beforeAddLiquidity, afterAddLiquidity, beforeRemoveLiquidity, afterRemoveLiquidity, beforeSwap, afterSwap, beforeDonate, afterDonate | [[entities/dex/uniswap-v4]] | - |
| #c6 | Hook use cases include derivative and synthetic asset platforms built on top of Uniswap v4 liquidity | [[entities/dex/uniswap-v4]] | - |
| #c7 | Hook existence does not guarantee routing from the Uniswap frontend | [[entities/dex/uniswap-v4]] | - |

## Conflicts raised
None.
