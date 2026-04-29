---
type: source
id: uniswap-v4-contracts-2026-04-29-concepts-v4-vs-v3
title: Uniswap v4 vs v3
publisher: Uniswap Docs
author: Uniswap team
date: 2026-04-29
original_url: https://docs.uniswap.org/contracts/v4/concepts/v4-vs-v3
mirror_snapshot: uniswap-v4-contracts-2026-04-29
mirror_page: pages/concepts-v4-vs-v3.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-29
---

# Uniswap v4 vs v3

## TL;DR
Compares v4 and v3 across four dimensions. Singleton Design: v4 uses a single PoolManager contract (cheap state-update pool creation) vs v3's factory + per-pool contracts (expensive contract deployment). Flash Accounting: v4 defers all token transfers to end of sequence vs v3 requiring per-operation transfers. Liquidity Fee Accounting: v4 converts accrued fee credits to liquidity on increase, auto-withdraws on decrease, supports salt-based position disambiguation vs v3's shared position state. Native ETH: v4 supports native ETH pairs directly vs v3's WETH9 requirement. Subscribers: v4-only staking via notification contracts vs v3's ERC-721 transfer requirement.

## Claims extracted
| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | v4 pool creation is significantly cheaper than v3: state update vs new contract deployment | [[entities/dex/uniswap-v4]] | - |
| #c2 | v4 accrued fees act like a credit when modifying liquidity: increasing converts fees to liquidity, decreasing auto-withdraws unclaimed fees | [[parameters/uniswap-v4/fee-architecture]] | - |
| #c3 | Additional salt parameter can distinguish positions of the same range on the same pool | [[entities/dex/uniswap-v4]] | - |
| #c4 | v3 liquidity positions of the same range and pool share the same state (integrating contracts handle fee management) | [[entities/dex/uniswap-v4]] | - |
| #c5 | v4 pool pairs support native tokens (ETH) directly; v3 requires WETH9 wrapping | [[entities/dex/uniswap-v4]] | - |
| #c6 | v4 subscribers enable staking/liquidity-mining without transferring ERC-721 tokens; v3 requires ERC-721 transfer to staking contract | [[concepts/lp/concentrated-liquidity]] | - |

## Conflicts raised
None.
