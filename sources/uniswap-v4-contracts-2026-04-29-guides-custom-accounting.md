---
type: source
id: uniswap-v4-contracts-2026-04-29-guides-custom-accounting
title: Uniswap v4 Custom Accounting Guide
publisher: Uniswap Docs
author: Uniswap team
date: 2026-04-29
original_url: https://docs.uniswap.org/contracts/v4/guides/custom-accounting
mirror_snapshot: uniswap-v4-contracts-2026-04-29
mirror_page: pages/guides-custom-accounting.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-29
---

# Uniswap v4 Custom Accounting Guide

## TL;DR
Detailed guide on v4's custom accounting system: delta accounting (net token transfer tracking via transient storage), hook fees (separate from pool/dynamic fees, implemented via beforeSwap using BeforeSwapDelta), custom curves (hooks can eject the concentrated liquidity pricing mechanism — v2 hardcoded x*y=k, v4 allows arbitrary models), and return deltas (programmatic adjustment of operation outcomes for both hook and swap router). Hook fees are calculated in beforeSwap, taken via poolManager.take(), and transferred via BeforeSwapDelta. Alternative: afterSwap fees compute on actual output for partial swaps.

## Claims extracted
| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Hook fees are entirely separate from pool fees and dynamic fees | [[parameters/uniswap-v4/fee-architecture]] | - |
| #c2 | Hook fees implemented in beforeSwap using BeforeSwapDelta; hook calculates fee, takes via poolManager.take(), returns delta transferring to swap router | [[parameters/uniswap-v4/fee-architecture]] | - |
| #c3 | Custom curves allow developers to eject the native concentrated liquidity pricing mechanism in favor of arbitrary pricing models | [[concepts/market-structure/amm]] | - |
| #c4 | Return deltas provide dual adjustment: simultaneously modifying balance changes for both hook and swap router | [[entities/dex/uniswap-v4]] | - |
| #c5 | Return deltas enable native pricing bypass: hooks can bypass Uniswap's native pricing mechanism | [[entities/dex/uniswap-v4]] | - |
| #c6 | afterSwap fees are an alternative for computing fees on actual output (useful for partial swaps) | [[parameters/uniswap-v4/fee-architecture]] | - |
| #c7 | Hook fee use cases include: monetization of hook development, withdrawal penalties (e.g. penalizing JIT liquidity), custom value distribution for LPs | [[parameters/uniswap-v4/fee-architecture]] | - |

## Conflicts raised
None.
