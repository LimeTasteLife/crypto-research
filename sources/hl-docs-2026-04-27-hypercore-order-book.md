---
type: source
id: hl-docs-2026-04-27-hypercore-order-book
title: HyperCore Order Book
publisher: Hyperliquid Docs
author: Hyperliquid team
date: null
original_url: https://hyperliquid.gitbook.io/hyperliquid-docs/hypercore/order-book
mirror_snapshot: hl-docs-2026-04-27
mirror_page: pages/hypercore-order-book.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-27
---

# HyperCore Order Book

## TL;DR
HyperCore maintains a CLOB per asset with price-time priority. Orders must be on tick-size and lot-size grids. For perp books, the matching engine references the clearinghouse for margin checks both at order submission and at the moment a resting order is matched, so margining stays consistent under oracle drift. A distinguishing feature is that the L1 mempool/consensus is semantically aware of HyperCore order-book actions: within a block, actions are ordered (1) non-GTC/non-IOC actions, (2) cancels, (3) GTC/IOC submissions, with proposer order preserved within each category. Modifies are categorized by the order they replace.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | HyperCore maintains a separate CLOB per asset, with orders matched in price-time priority. | [[concepts/market-structure/clob]], [[entities/perpdex/hyperliquid]] | A1-PI |
| #c2 | Orders must have price as an integer multiple of tick-size and size as an integer multiple of lot-size. | [[concepts/market-microstructure/tick-size]], [[concepts/market-microstructure/lot-size]] | A1-PI |
| #c3 | Margin checks happen on opening of new orders and on matching of each resting order. | [[concepts/operations/matching-engine]], [[concepts/risk/margin-tier]] | A6-PI |
| #c4 | The L1 mempool/consensus logic is semantically aware of HyperCore order-book transactions. | [[entities/perpdex/hyperliquid]], [[concepts/operations/matching-engine]] | A4-PIII |
| #c5 | Within a block, actions are ordered: (1) non-GTC/non-IOC actions, (2) cancels, (3) actions sending ≥1 GTC/IOC. | [[concepts/operations/matching-engine]] | A4-PIII |
| #c6 | Within each ordering category, actions are sorted in proposer order. | [[concepts/operations/matching-engine]] | A4-PIII |
| #c7 | Modify actions are categorized according to the new order they place (placement category drives ordering). | [[concepts/operations/matching-engine]] | A4-PIII |
