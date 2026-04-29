---
type: source
id: drift-docs-2026-04-28-protocol-about-v3-decentralized-orderbook
title: Decentralized Orderbook
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/protocol/about-v3/decentralized-orderbook
mirror_snapshot: drift-docs-2026-04-28
mirror_page: pages/protocol-about-v3-decentralized-orderbook.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Decentralized Orderbook

## TL;DR
Drift's DLOB is powered by a permissionless network of Keeper Bots that match open orders with on-chain liquidity sources when triggers are met. Two post-only maker orders cannot cross. Maker orders that fill against the AMM are NOT eligible for rebate reward (a notable carve-out). Limit orders CAN be filled by market orders going through the JIT auction. Keepers are rewarded for providing best execution relative to oracle and for following First-Come-First-Serve ordering. The system is a hybrid: order-filling logic is computed off-chain (where it's cheap) and settled on-chain. Existing trading bots (JIT makers, taker bots) implicitly fulfill the keeper role.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | The decentralized orderbook is powered by a network of Keeper Bots. | [[concepts/operations/matching-engine]] | A1-PI |
| #c2 | Keeper Bots match open orders against on-chain liquidity mechanisms once they cross or their trigger condition is met. | [[concepts/operations/matching-engine]] | A4-PI |
| #c3 | Two post-only maker orders cannot be crossed against each other. | [[concepts/operations/matching-engine]] | A4-PI |
| #c4 | Maker orders that fill against the AMM are not eligible for rebate reward. | [[parameters/drift/mm-rebate-tiers]] | A2-PI, A4-PIV |
| #c5 | Limit orders can be filled by market orders that go through the JIT auction. | [[concepts/operations/matching-engine]] | A4-PI |
| #c6 | Keepers earn rewards that incentivize providing best execution relative to oracle price. | [[parameters/drift/fee-schedule]] | A4-PV |
| #c7 | Keepers earn rewards for following First-Come-First-Serve execution ordering. | [[concepts/operations/matching-engine]] | A4-PV |
| #c8 | The DLOB is a hybrid system: off-chain Keepers run order-filling logic, and on-chain settlement executes the fill. | [[entities/perpdex/drift]] | A1-PI |
| #c9 | Existing JIT maker bots and resting-order-taker bots implicitly fulfill the keeper role. | [[concepts/operations/matching-engine]] | A4-PI |
| #c10 | The protocol's core functionality does not depend on the keeper network — keepers improve throughput/usability but are not load-bearing. | [[entities/perpdex/drift]] | A1-PI, A6-PI |
