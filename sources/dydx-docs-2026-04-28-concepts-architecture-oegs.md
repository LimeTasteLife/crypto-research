---
type: source
id: dydx-docs-2026-04-28-concepts-architecture-oegs
title: OEGS (Order Entry Gateway Service)
publisher: dYdX Docs
author: dYdX team
date: null
original_url: https://docs.dydx.xyz/concepts/architecture/oegs
mirror_snapshot: dydx-docs-2026-04-28
mirror_page: pages/concepts-architecture-oegs.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# OEGS (Order Entry Gateway Service)

## TL;DR
OEGS is dYdX's two-stage performance evolution layered on top of CometBFT. Stage 1: Designated Proposers — a governance-selected subset of validators responsible for proposing blocks (v9 software upgrade). Stage 2: OEGS — specialized gateway nodes peering directly with all designated proposers, accepting orders via public gRPC, bypassing standard gossip in a single hop. The motivating problem: previously, professional traders had to run private full nodes to inject orders directly into the gossip layer; OEGS lowers that barrier. dYdX claims a 98% improvement to API performance/reliability since April 2025. OEGS is fully opt-in — traders can still send orders directly to a full node. Governance may consider operator incentives.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | OEGS is the next stage in dYdX's performance evolution and consists of two components: Designated Proposers and Order Entry Gateway Service. | [[entities/perpdex/dydx-v4]] | A1-PI |
| #c2 | Designated Proposers are a governance-selected subset of validators responsible for proposing blocks; available in the v9 software upgrade. | [[entities/perpdex/dydx-v4]], [[parameters/dydx-v4/upgrade-history]] | A1-PI, A7-PII |
| #c3 | OEGS gateway nodes are available after the v9 upgrade. | [[entities/perpdex/dydx-v4]] | A1-PI |
| #c4 | Previously, orders were submitted to full nodes which gossipped them across the network until they reached the current proposer; this introduced multi-hop latency. | [[entities/perpdex/dydx-v4]] | A1-PI |
| #c5 | Professional trading firms have typically run private full nodes with streaming enabled to inject orders directly into the gossip layer to achieve competitive speeds. | [[entities/perpdex/dydx-v4]] | A4-PI |
| #c6 | Since April 2025, dYdX has made huge improvements (98%) to API performance and reliability. | [[entities/perpdex/dydx-v4]] | A1-PI |
| #c7 | OEGS gateway nodes peer directly with all designated proposers, accept orders via public high-performance gRPC endpoints, and bypass standard gossip in a single hop. | [[entities/perpdex/dydx-v4]] | A1-PI, A4-PI |
| #c8 | OEGS is designed to simplify access (public gRPC instead of private full nodes), ensure routing fairness via direct peering with validators, and scale via governance updates to the gateway set. | [[entities/perpdex/dydx-v4]] | A1-PI, A4-PI |
| #c9 | Order flow through OEGS: trader → OEGS validation → direct gossip to proposer set → block inclusion → on-chain commit → state propagation to full nodes and Indexers. | [[entities/perpdex/dydx-v4]] | A1-PI |
| #c10 | dYdX Labs plans to fully open-source the OEGS code and infrastructure requirements. | [[entities/perpdex/dydx-v4]], [[entities/actor/dydx-labs]] | A9-PV |
| #c11 | OEGS use is fully opt-in; traders may still send orders directly to a full node, preserving decentralization and censorship-resistance. | [[entities/perpdex/dydx-v4]] | A1-PI, A9-PV |
| #c12 | Governance may consider additional incentives for OEGS operators given their elevated role and service expectations. | [[entities/perpdex/dydx-v4]] | A1-PI, A7-PV |
