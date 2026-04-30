---
type: source
id: dydx-chain-tech-2026-04-28-front-end-and-wallets-architecture-overview
title: Architecture Overview (Front-end & Wallets)
publisher: dYdX Community Docs (chain technical)
author: dYdX community
date: null
original_url: https://docs.dydx.community/dydx-chain-technical-docs/front-end-and-wallets/architecture-overview
mirror_snapshot: dydx-chain-tech-2026-04-28
mirror_page: pages/front-end-and-wallets-architecture-overview.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Architecture Overview (Front-end & Wallets)

## TL;DR
High-level v4 architecture from the front-end perspective. Web app: JS/React, talks to Indexer API for off-chain orderbook + sends trades directly to chain. iOS/Android: native Swift/Kotlin. Five-step order lifecycle: trade placed on FE → routed to validator → gossip → consensus proposer matches and adds to next block → 2/3 vote commits → on-chain + off-chain data streamed to Indexers → API/WS back to front-end.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | The dYdX web application uses JavaScript and React, interacts with the Indexer via API for off-chain orderbook data, and submits trade transactions directly to the blockchain. | [[entities/perpdex/dydx]] | A1-PI |
| #c2 | The dYdX front-end codebase and deployment scripts are open-source, allowing anyone to deploy via IPFS/Cloudflare gateway. | [[entities/perpdex/dydx]] | A9-PV |
| #c3 | The dYdX mobile applications are built natively in Swift (iOS) and Kotlin (Android), and will also be open-sourced. | [[entities/perpdex/dydx]] | A9-PV |
| #c4 | The order lifecycle is: user submits via FE/API → routed to validator → validator gossips to others → proposer matches and adds to next proposed block → 2/3 of validators vote to commit → block committed and on-chain/off-chain data streamed from full nodes to Indexers → Indexer serves data via API and WebSockets back to front-end. | [[entities/perpdex/dydx]] | A1-PI |
