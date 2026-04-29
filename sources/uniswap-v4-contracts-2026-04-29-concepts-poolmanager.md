---
type: source
id: uniswap-v4-contracts-2026-04-29-concepts-poolmanager
title: Uniswap v4 PoolManager
publisher: Uniswap Docs
author: Uniswap team
date: 2026-04-29
original_url: https://developers.uniswap.org/docs/protocols/v4/concepts/poolmanager
mirror_snapshot: uniswap-v4-contracts-2026-04-29
mirror_page: pages/concepts-poolmanager.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-29
---

# Uniswap v4 PoolManager

## TL;DR
The PoolManager replaces v3's factory pattern with a singleton contract managing all pool state and logic. Pool creation is via the initialize function, specifying token pair, fee tier, tick spacing, and optional hook contract address, returning a unique PoolId. Swap execution: validate pool, call beforeSwap hook, perform swap updating state and fees, call afterSwap hook, return BalanceDelta. Liquidity modification follows a similar hook-wrapped pattern with ModifyLiquidity events. Transient storage (EIP-1153) provides gas-efficient temporary data for complex operations.

## Claims extracted
| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | PoolManager is a singleton contract; all pool state and logic encapsulated within it | [[entities/dex/uniswap-v4]] | - |
| #c2 | New pools created by calling initialize on the PoolManager specifying: token pair, fee tier, tick spacing, and optional hook contract address | [[parameters/uniswap-v4/pool-creation-params]] | - |
| #c3 | Each pool is associated with a unique PoolId | [[entities/dex/uniswap-v4]] | - |
| #c4 | Pool.State contains: current price, liquidity, tick bitmap, fee growth, position information | [[entities/dex/uniswap-v4]] | - |
| #c5 | Swap execution calls beforeSwap hook (if applicable), performs swap updating state and charging fees, then calls afterSwap hook | [[entities/dex/uniswap-v4]] | - |
| #c6 | Liquidity modification calls beforeAddLiquidity/beforeRemoveLiquidity, modifies state, emits ModifyLiquidity event, calls afterAddLiquidity/afterRemoveLiquidity | [[entities/dex/uniswap-v4]] | - |
| #c7 | PoolManager utilizes EIP-1153 transient storage for temporary data during complex operations | [[entities/dex/uniswap-v4]] | - |

## Conflicts raised
None.
