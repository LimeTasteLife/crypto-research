---
type: source
id: hl-docs-2026-04-27-hypercore-overview
title: HyperCore Overview
publisher: Hyperliquid Docs
author: Hyperliquid team
date: null
original_url: https://hyperliquid.gitbook.io/hyperliquid-docs/hypercore/overview
mirror_snapshot: hl-docs-2026-04-27
mirror_page: pages/hypercore-overview.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-27
---

# HyperCore Overview

## TL;DR
HyperCore is the part of the Hyperliquid state machine that holds margin and matching-engine state. Consensus is HyperBFT (HotStuff variant); blocks are produced by validators in proportion to staked native token. HyperCore explicitly does not use off-chain order books — full decentralization with single transaction order via HyperBFT is asserted as a core design principle. End-to-end latency from a co-located client is reported at 0.2s median / 0.9s p99. Mainnet throughput ~200k orders/sec; reported bottleneck is execution, not consensus or networking.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | HyperBFT is a HotStuff-variant proof-of-stake consensus where validator block production is weighted by native-token stake. | [[entities/network/hyperliquid-l1]], [[concepts/operations/sequencer]] |  |
| #c2 | HyperCore holds margin and matching-engine state on-chain (no off-chain order book). | [[entities/perpdex/hyperliquid]], [[concepts/market-structure/clob]] | A4-PI |
| #c3 | Single consistent transaction order is produced by HyperBFT consensus (no parallel/off-chain matching). | [[entities/perpdex/hyperliquid]], [[concepts/operations/matching-engine]] | A8-PI |
| #c4 | End-to-end latency from a co-located client: median 0.2s, p99 0.9s. | [[entities/perpdex/hyperliquid]], [[concepts/metrics/mm-uptime]] | A4-PI |
| #c5 | Mainnet throughput approximately 200k orders/sec; current bottleneck is execution. | [[entities/perpdex/hyperliquid]], [[concepts/metrics/volume]] | A4-PI |
| #c6 | Consensus + networking stack is designed to scale to millions of orders per second once execution catches up. | [[entities/perpdex/hyperliquid]] |  |
