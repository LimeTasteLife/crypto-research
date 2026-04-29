---
type: source
id: uniswap-v4-contracts-2026-04-29-concepts-erc-6909
title: Uniswap v4 ERC-6909
publisher: Uniswap Docs
author: Uniswap team
date: 2026-04-29
original_url: https://developers.uniswap.org/docs/protocols/v4/concepts/erc-6909
mirror_snapshot: uniswap-v4-contracts-2026-04-29
mirror_page: pages/concepts-erc-6909.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-29
---

# Uniswap v4 ERC-6909

## TL;DR
Uniswap v4 uses ERC-6909 as a gas-efficient multi-token standard (replacing ERC-1155) for token claims within the PoolManager. Instead of transferring ERC-20 tokens in/out, users can leave tokens in the PoolManager and receive ERC-6909 claim tokens. ERC-6909 offers simplified interface, more efficient transfer delegation, reduced gas costs, and smaller contract sizes compared to ERC-1155. Primary beneficiaries: high-frequency traders/MEV bots and frequent liquidity managers.

## Claims extracted
| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | ERC-6909 is a minimal and gas-efficient standard for managing multiple ERC-20 tokens from a single contract | [[entities/dex/uniswap-v4]] | - |
| #c2 | ERC-6909 provides a simplified alternative to ERC-1155: removes unnecessary safe transfer callbacks and batching constraints | [[entities/dex/uniswap-v4]] | - |
| #c3 | Instead of transferring ERC-20 tokens in/out, PoolManager mints ERC-6909 claim tokens representing the user's credit | [[entities/dex/uniswap-v4]] | - |
| #c4 | ERC-6909 token minting/burning is more gas-efficient than ERC-20 transfers: no external function calls, constant-size gas overhead | [[entities/dex/uniswap-v4]] | - |
| #c5 | High-frequency traders and MEV bots benefit from ERC-6909 by trading within the protocol without external transfers | [[entities/dex/uniswap-v4]] | - |

## Conflicts raised
None.
