---
type: source
id: uniswap-v4-contracts-2026-04-29-concepts-architecture
title: Uniswap v4 Architecture
publisher: Uniswap Docs
author: Uniswap team
date: 2026-04-29
original_url: https://developers.uniswap.org/docs/protocols/v4/concepts/architecture
mirror_snapshot: uniswap-v4-contracts-2026-04-29
mirror_page: pages/concepts-architecture.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-29
---

# Uniswap v4 Architecture

## TL;DR
Uniswap v4 inherits concentrated liquidity from v3 but introduces six architectural innovations: (1) Hooks — external smart contracts attached to pools for custom swap lifecycle logic; (2) Dynamic Fees — pools can adjust fees without opinionated calculation, at any frequency; (3) Singleton Design — all pool state in a single PoolManager.sol contract for gas savings; (4) Flash Accounting — EIP-1153 transient storage for net-only token transfers; (5) Native ETH support (no WETH9 wrapping); (6) Custom Accounting — hooks can alter token amounts, enabling custom curves and hook swap fees.

## Claims extracted
| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Uniswap v4 inherits all capital efficiency gains of Uniswap v3 | [[entities/dex/uniswap-v4]] | - |
| #c2 | Hooks are external smart contracts that execute before and/or after major operations: pool creation, liquidity addition/removal, swapping, donations | [[concepts/market-structure/amm]] | - |
| #c3 | Hooks are deployed contracts called by the PoolManager for permissionless execution | [[entities/dex/uniswap-v4]] | - |
| #c4 | Hooks can enable: limit orders, custom oracles, fee management, automated liquidity management | [[parameters/uniswap-v4/hook-security-framework]] | - |
| #c5 | v4 supports dynamic fees — pools can adjust fees up or down with no opinionated calculation; frequency is flexible (every swap, every block, or arbitrary schedule) | [[parameters/uniswap-v4/fee-architecture]] | - |
| #c6 | All pool state and operations managed by single contract PoolManager.sol (Singleton design) | [[entities/dex/uniswap-v4]] | - |
| #c7 | Creating a pool is now a state update instead of deploying a new contract | [[parameters/uniswap-v4/pool-creation-params]] | - |
| #c8 | Swapping through multiple pools no longer requires transferring tokens for intermediate pools | [[entities/dex/uniswap-v4]] | - |
| #c9 | Flash accounting leverages EIP-1153 transient storage; balance changes are netted and only final balance change requires token transfer | [[entities/dex/uniswap-v4]] | - |
| #c10 | v4 supports native token assets (Ether) without wrapping to WETH9 | [[entities/dex/uniswap-v4]] | - |
| #c11 | Custom accounting allows developers to alter token amounts for swaps and liquidity modifications | [[entities/dex/uniswap-v4]] | - |
| #c12 | Custom curves: hooks can opt out of the concentrated liquidity curve in favor of independent pricing mechanisms | [[concepts/market-structure/amm]] | - |
| #c13 | Hook swap fees: hooks can charge and collect fees on swaps | [[parameters/uniswap-v4/fee-architecture]] | - |
| #c14 | Liquidity withdrawal fees: hooks can penalize and/or redistribute fee revenue on withdrawals | [[parameters/uniswap-v4/fee-architecture]] | - |

## Conflicts raised
None.
