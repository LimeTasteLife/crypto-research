---
type: source
id: orderly-docs-2026-04-29-isolated-margin
title: Isolated Margin
publisher: Orderly Network Docs
author: Orderly team
date: 2026-04-29
original_url: https://orderly.network/docs/introduction/trade-on-orderly/perpetual-futures/isolated-margin
mirror_snapshot: orderly-docs-2026-04-29
mirror_page: pages/isolated-margin.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Isolated Margin

## TL;DR
Orderly supports two margin modes: Cross Margin (default, all positions share entire account balance) and Isolated Margin (dedicated margin per position, capping max loss at assigned margin). Both modes can be used simultaneously; users specify mode per order. Independent leverage per symbol per mode. Can hold both Cross and Isolated positions on the same symbol. Liquidation of an Isolated position does not affect other positions.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Two margin modes: Cross Margin (default, shares entire balance) and Isolated Margin (per-position dedicated margin) | [[parameters/orderly/margin-tiers]] | A6-PI |
| #c2 | Both modes usable simultaneously; margin mode specified per order | [[parameters/orderly/margin-tiers]] | A6-PI |
| #c3 | Independent leverage per symbol per mode; can hold both Cross and Isolated on same symbol | [[parameters/orderly/margin-tiers]] | A6-PI |
| #c4 | Liquidation of Isolated position does not touch other positions (risk isolation) | [[concepts/risk/liquidation]] | A6-PI |
| #c5 | All symbols default to Cross Margin | [[parameters/orderly/margin-tiers]] | A6-PI |

## Conflicts raised
None.
