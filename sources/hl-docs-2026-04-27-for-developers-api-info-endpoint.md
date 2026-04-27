---
type: source
id: hl-docs-2026-04-27-for-developers-api-info-endpoint
title: API Info Endpoint
publisher: Hyperliquid Docs
author: Hyperliquid team
date: null
original_url: https://hyperliquid.gitbook.io/hyperliquid-docs/for-developers/api/info-endpoint
mirror_snapshot: hl-docs-2026-04-27
mirror_page: pages/for-developers-api-info-endpoint.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-27
---

# API Info Endpoint

## TL;DR
Reference page for the read-only `/info` HTTP endpoint of the Hyperliquid API. Documents request/response shapes for ~30 query types: mids, open orders, fills (including TWAP-slice and historical), order status, L2 book snapshot, candles, builder-fee approval, vault details, vault deposits, role/portfolio/referral/fees queries, staking (delegations, summary, history, rewards), HIP-3 DEX abstraction state, aligned-quote-token status, and borrow/lend reserve states. Pagination is capped at 500 elements or distinct blocks per response. Mostly out-of-frame for perpdex investigation: the page is a developer reference for endpoint shapes, not a description of platform behavior. A handful of platform-level facts surface (spot index encoding, master-vs-agent address rule, BTC/UBTC remapping note).

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | The Info endpoint accepts POST requests at https://api.hyperliquid.xyz/info with a JSON body keyed by `type`. | [[entities/perpdex/hyperliquid]] |  |
| #c2 | Time-range responses are capped at 500 elements or distinct data blocks; pagination uses the last returned timestamp as the next startTime. | [[entities/perpdex/hyperliquid]] |  |
| #c3 | For perpetuals, `coin` is the name returned in the `meta` response. | [[entities/perpdex/hyperliquid]] |  |
| #c4 | For PURR spot the canonical coin id is `PURR/USDC`; for all other spot tokens it is `@{index}` referencing the index in the `spotMeta.universe` field. | [[entities/perpdex/hyperliquid]] |  |
| #c5 | Mainnet HYPE spot maps to `@107` because token index 150 pairs with USDC (token index 0). | [[entities/perpdex/hyperliquid]] |  |
| #c6 | Some assets are remapped on user interfaces — e.g. `BTC/USDC` on app.hyperliquid.xyz corresponds to `UBTC/USDC` on mainnet HyperCore. | [[entities/perpdex/hyperliquid]] | A1-PI |
| #c7 | Account-data queries require the master/sub-account address (not the agent-wallet address); using the agent address yields empty results. | [[entities/perpdex/hyperliquid]] |  |
| #c8 | The Info endpoint exposes per-user staking delegations, staking summary, staking history, and staking rewards as separate query types. | [[entities/perpdex/hyperliquid]] |  |
| #c9 | The Info endpoint exposes per-user HIP-3 DEX abstraction state as a query type. | [[entities/perpdex/hyperliquid]] |  |
| #c10 | The Info endpoint exposes aligned-quote-token status as a queryable property. | [[entities/perpdex/hyperliquid]] |  |
| #c11 | The Info endpoint exposes borrow/lend user state, per-reserve state, and full reserve-set state. | [[entities/perpdex/hyperliquid]] |  |
| #c12 | Vault metadata (details, user deposits) is queryable per-vault via the Info endpoint. | [[entities/perpdex/hyperliquid]] |  |
| #c13 | Builder-fee approval status is queryable per user. | [[entities/perpdex/hyperliquid]] | A3-PV |
| #c14 | Approved-builder list is queryable per user. | [[entities/perpdex/hyperliquid]] | A3-PV |
