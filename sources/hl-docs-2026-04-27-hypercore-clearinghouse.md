---
type: source
id: hl-docs-2026-04-27-hypercore-clearinghouse
title: HyperCore Clearinghouse
publisher: Hyperliquid Docs
author: Hyperliquid team
date: null
original_url: https://hyperliquid.gitbook.io/hyperliquid-docs/hypercore/clearinghouse
mirror_snapshot: hl-docs-2026-04-27
mirror_page: pages/hypercore-clearinghouse.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-27
---

# HyperCore Clearinghouse

## TL;DR
Defines the perps and spot clearinghouses as components of HyperCore execution state. The perps clearinghouse tracks per-address balance and positions. Cross margin is the default mode; isolated margin is supported as an opt-in to bound liquidation risk to a specific position. Spot clearinghouse mirrors this pattern for token balances and holds.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | The perps clearinghouse manages per-address margin state including balance and positions. | [[entities/perpdex/hyperliquid]], [[concepts/operations/settlement]] |  |
| #c2 | Deposits are credited by default to cross-margin balance. | [[entities/perpdex/hyperliquid]] |  |
| #c3 | Positions default to cross-margin mode. | [[concepts/risk/margin-tier]] |  |
| #c4 | Isolated margin is supported and disassociates a position's liquidation risk from all other positions. | [[concepts/risk/margin-tier]] | A6-PII |
| #c5 | Spot clearinghouse manages per-address spot user state including token balances and holds. | [[entities/perpdex/hyperliquid]] |  |
