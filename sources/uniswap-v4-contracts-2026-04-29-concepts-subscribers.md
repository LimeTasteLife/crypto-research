---
type: source
id: uniswap-v4-contracts-2026-04-29-concepts-subscribers
title: Uniswap v4 Subscribers
publisher: Uniswap Docs
author: Uniswap team
date: 2026-04-29
original_url: https://docs.uniswap.org/contracts/v4/concepts/subscribers
mirror_snapshot: uniswap-v4-contracts-2026-04-29
mirror_page: pages/concepts-subscribers.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-29
---

# Uniswap v4 Subscribers

## TL;DR
Subscribers are a v4-only feature allowing LP position owners to opt-in to a notification contract. This enables liquidity mining without transferring ownership of the position (in v3, liquidity mining required fully transferring the ERC-721 position to an external contract). Subscriber notifications fire on four events: initial subscription, liquidity increase/decrease, position transfer, and unsubscription.

## Claims extracted
| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Subscribers allow position owners to opt-in to a contract that receives notifications without risking underlying assets | [[entities/dex/uniswap-v4]] | - |
| #c2 | In v3, liquidity mining required transferring ERC-721 position to external contract (full ownership transfer); v4 subscribers eliminate this | [[entities/dex/uniswap-v4]] | - |
| #c3 | Subscriber notifications fire on: initial subscription, liquidity increase/decrease, position transfer, unsubscription | [[entities/dex/uniswap-v4]] | - |

## Conflicts raised
None.
