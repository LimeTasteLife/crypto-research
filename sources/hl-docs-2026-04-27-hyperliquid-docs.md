---
type: source
id: hl-docs-2026-04-27-hyperliquid-docs
title: About Hyperliquid
publisher: Hyperliquid Docs
author: Hyperliquid team
date: null
original_url: https://hyperliquid.gitbook.io/hyperliquid-docs
mirror_snapshot: hl-docs-2026-04-27
mirror_page: pages/hyperliquid-docs.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-27
---

# About Hyperliquid

## TL;DR
Hyperliquid is positioned as a layer-one blockchain purpose-built for an onchain financial system, with a custom HotStuff-derived consensus called HyperBFT. Execution is split into HyperCore (fully onchain perpetual and spot order books with one-block finality) and HyperEVM (general-purpose smart contract layer). HyperCore reportedly supports approximately 200k orders per second on mainnet. HyperEVM exposes HyperCore liquidity as a primitive for arbitrary applications. The page is the docs landing/about page; identical content also appears under `about-hyperliquid`.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Hyperliquid is a layer-one blockchain optimized from first principles. | [[entities/perpdex/hyperliquid]], [[entities/network/hyperliquid-l1]] |  |
| #c2 | Hyperliquid uses a custom consensus algorithm called HyperBFT, inspired by HotStuff and its successors. | [[entities/network/hyperliquid-l1]], [[concepts/operations/sequencer]] |  |
| #c3 | Hyperliquid execution is split into two components: HyperCore (perp/spot order books) and HyperEVM (general smart contracts). | [[entities/perpdex/hyperliquid]] |  |
| #c4 | HyperCore order/cancel/trade/liquidation events have one-block finality inherited from HyperBFT. | [[concepts/operations/settlement]], [[entities/perpdex/hyperliquid]] | A8-PI |
| #c5 | HyperCore currently supports ~200k orders per second on mainnet. | [[entities/perpdex/hyperliquid]], [[concepts/metrics/volume]] | A4-PI |
| #c6 | HyperEVM exposes HyperCore liquidity as a permissionless building block for applications. | [[entities/perpdex/hyperliquid]] |  |
