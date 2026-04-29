---
type: source
id: dydx-docs-2026-04-28-concepts-onboarding-faqs
title: Onboarding FAQs
publisher: dYdX Docs
author: dYdX team
date: null
original_url: https://docs.dydx.xyz/concepts/onboarding-faqs
mirror_snapshot: dydx-docs-2026-04-28
mirror_page: pages/concepts-onboarding-faqs.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Onboarding FAQs

## TL;DR
Q&A grab-bag with several useful operational facts. Block time ~1s. Throughput up to 1500 orders/s (load test). Order-to-trade latency ≥1 block (~0.8s). Short-term orders for MM/HFT, stateful for retail. Indexer reconstructs orderbook by reading from a co-running full node. MEV: dYdX has a Skip-built dashboard; first step is "punish validators with slashing." Cosmos finality is per-block (no reorgs/forks). Pricing: Slinky sidecar pulls from external sources, vote extensions submitted at Precommit, Slinky deterministically aggregates and proposes new prices via consensus, x/prices stores them. Slinky stores only the most recent price.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Validators on dYdX Chain take turns proposing blocks of trades every ~1 second. | [[entities/perpdex/dydx-v4]], [[entities/network/dydx-chain]] | A1-PI |
| #c2 | Full nodes do not participate in consensus; they receive data via gossip and forward to Indexers. | [[entities/perpdex/dydx-v4]] | A1-PI |
| #c3 | Validators participate in consensus by broadcasting votes signed by each validator's private key. | [[entities/network/dydx-chain]] | A1-PI |
| #c4 | Running a full node eliminates latency between order placement and order gossip; it also enables full-node streaming. | [[entities/perpdex/dydx-v4]] | A4-PI |
| #c5 | Both USDC and Cosmos-native dYdX can be used to pay gas fees; USDC must be in the main wallet (not a subaccount) to pay fees. | [[entities/perpdex/dydx-v4]] | A2-PI |
| #c6 | Rate limits are enforced per account, not per subaccount. | [[parameters/dydx-v4/rate-limits]] | A1-PI |
| #c7 | dYdX Chain throughput is up to 1,500 orders/second from load-testing. | [[entities/perpdex/dydx-v4]] | A1-PI |
| #c8 | Order-to-trade latency on dYdX is at least 1 block (~0.8 seconds). | [[entities/perpdex/dydx-v4]] | A1-PI |
| #c9 | A full node is run alongside the Indexer and sends order messages to it; on cold start, the full node has all stateful orders, and the Indexer's view of short-term orders becomes accurate within 20 blocks. | [[entities/perpdex/dydx-v4]] | A1-PI |
| #c10 | dYdX Chain has a framework where MEV is measured via a dashboard (built with Skip Protocol); the first remediation step would be to punish validators with slashing. | [[entities/perpdex/dydx-v4]] | A8-PI |
| #c11 | Every block on dYdX Chain (Cosmos) is final; there are no reorgs or forks. | [[entities/network/dydx-chain]] | A1-PI |
| #c12 | Oracle pricing is computed via 5 components: Slinky (sidecar), Vote Extensions (Precommit phase), Consensus aggregation, x/prices module, and per-network Params. | [[parameters/dydx-v4/oracle-config]] | A6-PI |
| #c13 | Prices will not update on a given block if the market is disabled in `x/marketmap` or if less than 2/3 of validators (by stake) contributed to a price update. | [[parameters/dydx-v4/oracle-config]] | A6-PI |
| #c14 | Slinky stores only the most recently posted price; no historical prices are stored on-chain in `x/oracle`. | [[parameters/dydx-v4/oracle-config]] | A6-PI |
