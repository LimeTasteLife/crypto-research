---
type: source
id: uniswap-v4-contracts-2026-04-29-concepts-flash-accounting
title: Uniswap v4 Flash Accounting
publisher: Uniswap Docs
author: Uniswap team
date: 2026-04-29
original_url: https://docs.uniswap.org/contracts/v4/concepts/flash-accounting
mirror_snapshot: uniswap-v4-contracts-2026-04-29
mirror_page: pages/concepts-flash-accounting.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-29
---

# Uniswap v4 Flash Accounting

## TL;DR
Flash accounting is v4's gas optimization using EIP-1153 transient storage. Each balance-changing operation updates an internal net delta rather than transferring tokens. A locking mechanism ensures atomicity: periphery contracts must unlock the PoolManager, perform actions (swap, modifyLiquidity, donate, take, settle, mint, burn, sync) within unlockCallback, then resolve all deltas before returning. For multi-hop swaps, only input and output token transfers are needed regardless of hop count. Pool initialization can happen outside the unlock context since it has no balance-changing operations.

## Claims extracted
| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Flash accounting uses EIP-1153 transient storage to record balance changes as deltas in transient state | [[entities/dex/uniswap-v4]] | - |
| #c2 | Periphery contracts must unlock the PoolManager before performing key actions; integrators implement unlockCallback | [[entities/dex/uniswap-v4]] | - |
| #c3 | Eight actions available inside unlockCallback: swap, modifyLiquidity, donate, take, settle, mint, burn, sync | [[entities/dex/uniswap-v4]] | - |
| #c4 | Pool initialization can happen outside the unlock context (no balance-changing operations) | [[parameters/uniswap-v4/pool-creation-params]] | - |
| #c5 | For multi-hop swaps, any number of arbitrary hops only requires two token transfers: input and output tokens | [[entities/dex/uniswap-v4]] | - |
| #c6 | Deltas represent debts and credits of assets owed to or from the PoolManager | [[entities/dex/uniswap-v4]] | - |

## Conflicts raised
None.
