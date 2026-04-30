---
type: source
id: dydx-docs-2026-04-28-concepts-architecture-indexer
title: Indexer Deep Dive
publisher: dYdX Docs
author: dYdX team
date: null
original_url: https://docs.dydx.xyz/concepts/architecture/indexer
mirror_snapshot: dydx-docs-2026-04-28
mirror_page: pages/concepts-architecture-indexer.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Indexer Deep Dive

## TL;DR
The Indexer is a read-only service serving offchain data to clients via REST and WebSockets — analogous to Infura/Alchemy for Ethereum but open-source and runnable by anyone. It splits ingestion into onchain (10-50 events/s, Postgres-backed Ender service) vs offchain (500-1000 events/s, Redis-backed Vulcan service). Comlink exposes REST APIs; Socks handles WebSockets; Roundtable computes periodic aggregations (24h volume, OI, PnL, candles). Indexers are deployed on AWS (Secret Manager, EC2, ELB, ElastiCache Redis, Lambda, RDS Postgres, ECS Fargate); a DevOps engineer is required for operation.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | The Indexer is a read-only service that serves off-chain data to clients via REST APIs and WebSockets. | [[entities/perpdex/dydx]] | A1-PI |
| #c2 | The Indexer is open source and can be run by anyone. | [[entities/perpdex/dydx]] | A9-PV |
| #c3 | Onchain data throughput is expected to be 10–50 events/second; offchain data throughput is expected to be 500–1,000 events/second (10–100x difference). | [[entities/perpdex/dydx]] | A1-PI |
| #c4 | Onchain data includes order fills (partial and complete), deleveraging, liquidations, and trades. | [[entities/perpdex/dydx]] | - |
| #c5 | Offchain data includes indexed order updates before they hit the chain, the order book of each perpetual exchange pair, short-term order placement and cancellations, and conditional order placement and cancellations. | [[entities/perpdex/dydx]] | - |
| #c6 | Ender is the Indexer's onchain ingestion service; it reads from the to-ender Kafka topic, applies block state changes to Postgres, and emits WebSocket events. | [[entities/perpdex/dydx]] | A1-PI |
| #c7 | Vulcan is the Indexer's offchain ingestion service; it reads from the to-vulcan Kafka topic and stores active order book updates in Redis. | [[entities/perpdex/dydx]] | A1-PI |
| #c8 | Comlink is the Indexer's REST API server, exposing both onchain and offchain data. | [[entities/perpdex/dydx]] | A1-PI |
| #c9 | Roundtable is the Indexer's periodic job service computing 24h volume per market, open interest, PnL by account, and candles. | [[entities/perpdex/dydx]] | A1-PI |
| #c10 | Socks is the Indexer's WebSocket service for real-time client communication. | [[entities/perpdex/dydx]] | A1-PI |
| #c11 | The Indexer is deployed on AWS (Secret Manager, CloudWatch, EC2 ELB, ElastiCache Redis, Lambda, EC2, RDS Postgres, ECS Fargate). | [[entities/perpdex/dydx]] | A9-PV |
| #c12 | dYdX recommends that a DevOps engineer is required at minimum to deploy and maintain the Indexer. | [[entities/perpdex/dydx]] | A9-PV |
