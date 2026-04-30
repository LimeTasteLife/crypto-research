---
type: source
id: dydx-docs-2026-04-28-concepts-architecture-overview
title: Intro to dYdX Chain Architecture
publisher: dYdX Docs
author: dYdX team
date: null
original_url: https://docs.dydx.xyz/concepts/architecture/overview
mirror_snapshot: dydx-docs-2026-04-28
mirror_page: pages/concepts-architecture-overview.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Intro to dYdX Chain Architecture

## TL;DR
dYdX Chain (v4) is a CosmosSDK + CometBFT proof-of-stake L1, end-to-end decentralized — none of the protocol, Indexer, or front-end components are run by dYdX Trading Inc. Validators store orders in an in-memory off-chain orderbook, gossip transactions, and propose blocks via weighted-round-robin (weighted by stake). 2/3 stake-weighted approval commits a block. Indexer is a read-only Postgres+Redis+Kafka services stack consuming full-node data. Three open-source front-ends (web, iOS, Android). OEGS (Order Entry Gateway Service) is the next performance-evolution layer, providing a one-hop direct path from traders to the proposer set, available now on testnet.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | dYdX Chain (also referred to as v4) has been designed to be completely decentralized end-to-end, with the protocol, Indexer, and front-end all available as open-source software. | [[entities/perpdex/dydx]] | A1-PI |
| #c2 | None of the dYdX Chain components (protocol, Indexer, front-end) are run by dYdX Trading Inc. | [[entities/perpdex/dydx]], [[entities/actor/dydx-trading-inc]] | A1-PI, A9-PV |
| #c3 | The dYdX Chain protocol is an L1 blockchain built on CometBFT and using CosmosSDK; the node software is written in Go and compiles to a single binary. | [[entities/perpdex/dydx]], [[entities/network/dydx-chain]] | A1-PI |
| #c4 | dYdX Chain uses a proof-of-stake consensus mechanism. | [[entities/network/dydx-chain]] | A1-PI |
| #c5 | Validators store orders in an in-memory orderbook off-chain (not committed to consensus), gossip transactions, and produce new blocks. | [[entities/perpdex/dydx]] | A1-PI, A4-PI |
| #c6 | The block proposer is selected in a weighted-round-robin fashion, weighted by the number of tokens staked to the validator. | [[entities/network/dydx-chain]] | A1-PI |
| #c7 | A block is committed when 2/3 or more of validators (by stake weight) approve of it. | [[entities/network/dydx-chain]] | A1-PI |
| #c8 | Full Nodes do not participate in consensus (zero stake weight, no voting/proposing) and are intended to support the Indexer. | [[entities/perpdex/dydx]] | A1-PI |
| #c9 | The Indexer is a read-only collection of services that consumes real-time data from a dYdX Chain full node, stores it (Postgres for onchain, Redis for offchain, Kafka for streaming), and serves it via WebSocket and REST. | [[entities/perpdex/dydx]] | A1-PI |
| #c10 | Excessive query load on a validator can impair its ability to participate in consensus, which is why the Indexer exists as a separate read-optimized layer. | [[entities/perpdex/dydx]] | A1-PI |
| #c11 | dYdX has built three open-source front-ends: a web app (JavaScript/React), an iOS app (Swift), and an Android app (Kotlin). | [[entities/perpdex/dydx]] | A1-PI, A9-PV |
| #c12 | The web front-end can be deployed by anyone to their own domain/hosting (including IPFS/Cloudflare gateway); deployment scripts are open-sourced. | [[entities/perpdex/dydx]] | A9-PV |
| #c13 | OEGS (Order Entry Gateway Service) is open-sourced infrastructure providing a direct, optimized path from traders to the proposer set. | [[entities/perpdex/dydx]] | A1-PI, A4-PI |
| #c14 | Designated proposers (a governance-selected subset of validators) become available in the v9 software upgrade. | [[entities/perpdex/dydx]], [[parameters/dydx-v4/upgrade-history]] | A1-PI, A7-PII |
| #c15 | OEGS is now live on testnet. | [[entities/perpdex/dydx]] | A1-PI |
