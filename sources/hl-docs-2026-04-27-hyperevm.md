---
type: source
id: hl-docs-2026-04-27-hyperevm
title: HyperEVM
publisher: Hyperliquid Docs
author: Hyperliquid team
date: null
original_url: https://hyperliquid.gitbook.io/hyperliquid-docs/hyperevm
mirror_snapshot: hl-docs-2026-04-27
mirror_page: pages/hyperevm.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-27
---

# HyperEVM

## TL;DR
HyperEVM is the general-purpose EVM execution layer on Hyperliquid; not a separate chain — secured by the same HyperBFT consensus as HyperCore. This unified-chain design lets HyperEVM contracts read HyperCore order-book prices (read precompile) and submit orders (write system contract) in plain Solidity. Token issuance can pair an HyperEVM ERC-20 with a HyperCore spot asset deployed via the permissionless spot auction, with no bridging risk. The HyperEVM is currently in alpha, justified by the team as "no insiders" / safety / live-iteration tradeoffs; higher throughput and write system contracts are not yet live on mainnet.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | HyperEVM is not a separate chain; it is secured by the same HyperBFT consensus as HyperCore. | [[entities/network/hyperliquid-l1]] | - |
| #c2 | HyperEVM contracts can read HyperCore order-book state via a read precompile. | [[entities/perpdex/hyperliquid]] | A4-PI |
| #c3 | HyperEVM contracts can submit orders to HyperCore order books via a write system contract. | [[entities/perpdex/hyperliquid]] | A4-PI |
| #c4 | An ERC-20 on HyperEVM can be linked to a HyperCore spot asset deployed permissionlessly via spot auction. | [[entities/perpdex/hyperliquid]], [[concepts/listing/listing-playbook]] | A1-PI |
| #c5 | Linked HyperCore↔HyperEVM token has no bridging risk because both layers share unified state. | [[entities/perpdex/hyperliquid]] | A8-PI |
| #c6 | HyperEVM is currently in alpha; higher throughput and write system contracts are not yet live on mainnet. | [[entities/perpdex/hyperliquid]] | A7-PI |
| #c7 | Hyperliquid's stated "no insiders" principle: no party gets advance access or paid integration during alpha. | [[entities/perpdex/hyperliquid]] | A9-PV |
