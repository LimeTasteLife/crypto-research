---
type: source
id: drift-docs-2026-04-28-protocol-trading-oracles
title: Oracles
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/protocol/trading/oracles
mirror_snapshot: drift-docs-2026-04-28
mirror_page: pages/protocol-trading-oracles.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Oracles

## TL;DR
Each Drift market tracks last-seen oracle values and updates an EMA TWAP over both 1hr (funding period) and 5min intervals. The protocol runs four validity guard checks per oracle update: Stale (last update >10 slots back for AMM, >120 for margin), InvalidPrice (negative price), TooVolatile (TWAP/price ratio out of [0.2, 5]), TooUncertain (confidence > 10% of price). When invalid, the perpetual market may block fills, withdraws, liquidations, and funding updates that increase protocol risk. During the invalid period, the on-chain oracle TWAP shrinks toward mark TWAP to prevent erroneous funding magnitudes.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Each Drift market tracks the last-seen oracle values and updates an EMA TWAP over both 1hr (funding period) and 5min intervals. | [[parameters/drift/oracle-config]] | A6-PI |
| #c2 | Drift validates oracle data per-check and per-action to determine whether to block actions. | [[parameters/drift/oracle-config]] | A6-PI |
| #c3 | Stale-for-AMM threshold: last slot update more than 10 slots behind current slot. | [[parameters/drift/oracle-config]] | A6-PI |
| #c4 | Stale-for-Margin threshold: last slot update more than 120 slots behind current slot. | [[parameters/drift/oracle-config]] | A6-PI |
| #c5 | InvalidPrice rule: any price field below 0 (negative price) is invalid. | [[parameters/drift/oracle-config]] | A6-PI |
| #c6 | TooVolatile rule: TWAP/price ratio out of bounds — 5x or 1/5x. | [[parameters/drift/oracle-config]] | A6-PI |
| #c7 | TooUncertain rule: confidence interval is too large — confidence is a very large percentage of the price (>10%). | [[parameters/drift/oracle-config]] | A6-PI |
| #c8 | When the oracle for a Perpetuals Market is deemed invalid, the market can block order fills, withdraws, liquidations, and funding-rate updates that would increase protocol risk. | [[parameters/drift/oracle-config]] | A6-PI |
| #c9 | During the invalid oracle period, on-chain oracle TWAP calculation aims to shrink toward mark TWAP to avoid erroneous funding payment magnitudes. | [[parameters/drift/oracle-config]] | A6-PI |
