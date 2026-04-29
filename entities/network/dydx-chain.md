---
type: entity
subtype: network
name: dYdX Chain
status: live
launched: 2023-10-26
sources_count: 3
last_reviewed: 2026-04-29
disputed: false
---

# dYdX Chain

> Sovereign Cosmos-SDK + CometBFT PoS L1 purpose-built to run a perpetual DEX.

## Snapshot
- Consensus: CometBFT (Tendermint-derived BFT); block commits when >=2/3 of validators (by stake weight) approve[^dydx-docs-2026-04-28-concepts-architecture-overview]
- Active validator set: 60[^dydx-docs-2026-04-28-concepts-trading-rewards]
- Genesis: October 26, 2023, 17:00 UTC (block 1)[^dydx-community-2026-04-28-introduction]
- Node software: single Go binary, open-sourced by dYdX Trading Inc.[^dydx-docs-2026-04-28-concepts-architecture-overview]
- Indexer: read-optimized Postgres + Redis + Kafka stack consuming from full nodes[^dydx-docs-2026-04-28-concepts-architecture-overview]

## Related
[[entities/perpdex/dydx]] . [[entities/token/dydx]] . [[parameters/dydx-v4/validator-requirements]]

## Sources
[^dydx-docs-2026-04-28-concepts-architecture-overview]: [[sources/dydx-docs-2026-04-28-concepts-architecture-overview]]
[^dydx-community-2026-04-28-introduction]: [[sources/dydx-community-2026-04-28-introduction]]
[^dydx-docs-2026-04-28-concepts-trading-rewards]: [[sources/dydx-docs-2026-04-28-concepts-trading-rewards]]
