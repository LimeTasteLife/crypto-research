---
type: source
id: dydx-docs-2026-04-28-concepts-trading-limit-orderbook
title: Limit Order Book and Matching
publisher: dYdX Docs
author: dYdX team
date: null
original_url: https://docs.dydx.xyz/concepts/trading/limit-orderbook
mirror_snapshot: dydx-docs-2026-04-28
mirror_page: pages/concepts-trading-limit-orderbook.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Limit Order Book and Matching

## TL;DR
Each full node maintains an in-memory order book, mutated in real time by trader instructions. Block proposers use price-time priority on their local book to construct blocks; books may diverge across nodes, so post-commit each node syncs to the just-committed block. Cancels are stored until they expire (per the GTB field). On each new order: fail if already cancelled, else match/place with optimistic local matches. On block processing, local state is replayed on top of new state. GTB (good-til-block) is the only guarantee an order will become unfillable; recommend setting current+3 for short-term orders. Replacements (same OrderId, larger GTB) are recommended over cancel+place to avoid double-fills.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Each full node maintains an in-memory order book that mutates in real time as traders submit instructions. | [[entities/perpdex/dydx]] | A1-PI |
| #c2 | Block proposers build blocks from their local order book using price-time priority. | [[concepts/operations/matching-engine]], [[entities/perpdex/dydx]] | A1-PI |
| #c3 | The local order book may differ across nodes at any given point in time; nodes sync local books with block contents upon a consensus-committed block. | [[entities/perpdex/dydx]] | A1-PI |
| #c4 | Clients can subscribe to a node's book state via the Full Node Streaming API. | [[entities/perpdex/dydx]] | - |
| #c5 | On a cancel: the node cancels the order unless it's already matched locally; the cancel instruction is stored until it expires per the GTB field. | [[entities/perpdex/dydx]] | A1-PI |
| #c6 | On an order: the order fails to place if already cancelled; otherwise it is matched and/or placed with optimistic matches stored locally. | [[entities/perpdex/dydx]] | A1-PI |
| #c7 | Each limit order placement or cancellation includes a Good-Til-Block (GTB) field specifying the block height after which the instruction expires. | [[entities/perpdex/dydx]] | A1-PI |
| #c8 | A cancel may be seen by the current proposer but not by subsequent proposers (if not gossiped in time); the order could still match after the sender expects cancellation. | [[entities/perpdex/dydx]] | A1-PI, A8-PI |
| #c9 | API traders should set tight GTB values (e.g. current chain height + 3) because expiry due to GTB is the only guaranteed way for an order to become unfillable. | [[entities/perpdex/dydx]] | A4-PI |
| #c10 | Consensus does not permit any order to fill at a height greater than its GTB. | [[entities/perpdex/dydx]] | A1-PI |
| #c11 | Replacing an order (same OrderId with a larger GTB) is recommended over cancelling-then-placing to avoid double-fill races. | [[entities/perpdex/dydx]] | A4-PI |
| #c12 | Two orders share the same OrderId if they match on Subaccount ID, Client ID, Order Flags, and CLOB pair ID. | [[entities/perpdex/dydx]] | - |
