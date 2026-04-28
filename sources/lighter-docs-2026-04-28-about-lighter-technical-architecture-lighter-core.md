---
type: source
id: lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core
title: "Technical Architecture: Lighter Core"
publisher: Lighter Docs
author: Lighter team
date: null
original_url: https://docs.lighter.xyz/about-lighter/technical-architecture-lighter-core
mirror_snapshot: lighter-docs-2026-04-28
mirror_page: pages/about-lighter-technical-architecture-lighter-core.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Technical Architecture: Lighter Core

## TL;DR
Lighter Core is a ZK-rollup-style exchange that anchors state and proofs to Ethereum, with a custom proving engine purpose-built for exchange workloads (orderbook, positions, public pools). User-signed transactions are batched into a state transition and proven succinctly; data blobs posted to Ethereum let any user reconstruct their state from on-chain data alone. A Sequencer provides FIFO ordering and soft finality; Witness Generators feed a Prover that aggregates hundreds of thousands of execution proofs into a single batch proof. An Escape Hatch — a priority on-chain queue for withdrawals, pool exits, and reduce-only IOC orders — freezes the contract if the Sequencer fails to process priority requests within a deadline, letting users self-withdraw via Merkle/state proofs. Distinctive vs. a generic perp DEX: this is verifiable execution rather than redundant-consensus, with explicit on-chain liveness fallback.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Lighter Core is built on the principle that users always maintain custody of their assets. | [[entities/perpdex/lighter]], [[entities/network/lighter-core]] | A1-PI |
| #c2 | Lighter Core is built on the principle that operations must be verifiable and strictly adhere to a publicly predefined set of rules. | [[entities/perpdex/lighter]], [[entities/network/lighter-core]] | A1-PI, A8-PV |
| #c3 | Lighter Core is built on the principle that the system must scale seamlessly in both latency and throughput. | [[entities/perpdex/lighter]], [[entities/network/lighter-core]] | A1-PI |
| #c4 | Lighter Core is built on the principle that users must always be able to exit securely and independently. | [[entities/perpdex/lighter]], [[entities/network/lighter-core]] | A8-PII |
| #c5 | Lighter Core combines succinct execution proofs with Ethereum as the anchoring layer for both proofs and system state. | [[entities/network/lighter-core]] | A1-PI |
| #c6 | Users can securely enter or exit directly through Ethereum, with all proofs verified publicly before any state updates occur. | [[entities/network/lighter-core]] | A8-PII |
| #c7 | Lighter Core uses a novel proving engine purpose-built for exchange-specific workloads, with new algorithms and optimized data structures for efficient exchange-operation proof generation. | [[entities/network/lighter-core]] | A1-PI |
| #c8 | All Lighter exchange operations are executed deterministically via user-signed transactions. | [[entities/network/lighter-core]] | A1-PI |
| #c9 | A batch of user-signed transactions on Lighter produces a new post-execution state along with a succinct cryptographic proof. | [[entities/network/lighter-core]] | A1-PI |
| #c10 | Smart contracts on Ethereum hold deposited assets and the canonical Lighter state root, which encapsulates user assets and positions, public pools, order books, and other critical system components. | [[entities/network/lighter-core]] | A8-PII |
| #c11 | Lighter Core periodically publishes state update proposals to Ethereum, each accompanied by data blobs containing per-account state-transition details so users can independently reconstruct and verify their state. | [[entities/network/lighter-core]] | A8-PII |
| #c12 | The data Lighter Core posts to Ethereum is highly compressed, enabling state data to be published directly to Ethereum at high scale without third parties. | [[entities/network/lighter-core]] | A1-PI |
| #c13 | A Sequencer coordinates first-in-first-out transaction ordering and provides soft finality on Lighter Core. | [[entities/network/lighter-core]], [[concepts/operations/sequencer]] | A1-PI |
| #c14 | Sequencer-produced data is fed to API servers, which provide ultra-low-latency data to end users. | [[entities/network/lighter-core]] | A1-PI |
| #c15 | Sequencer-produced data is fed to horizontally and vertically scalable Witness Generator services, which transform it into circuit-friendly inputs for the Lighter Prover. | [[entities/network/lighter-core]] | A1-PI |
| #c16 | The Lighter Prover generates proofs in parallel across Lighter transactions. | [[entities/network/lighter-core]] | A1-PI |
| #c17 | Hundreds of thousands of execution proofs are fed into a multi-layer aggregation engine and combined into a single batch proof for verification on Ethereum. | [[entities/network/lighter-core]] | A1-PI |
| #c18 | Once a state-update proposal's proof is verified on Ethereum, the contracts update the exchange state. | [[entities/network/lighter-core]] | A8-PII |
| #c19 | State-update proofs also attest to the validity and sufficiency of the data posted in Ethereum's data blobs, so the posted data alone suffices to reconstruct all user states from censorship-resistant immutable on-chain data. | [[entities/network/lighter-core]] | A8-PII |
| #c20 | Lighter Core introduces a priority request queue on Ethereum to guarantee liveness and censorship resistance. | [[entities/network/lighter-core]] | A8-PII |
| #c21 | Users can submit critical exit operations — withdrawals, public pool exits, and reduce-only IOC orders — to the Ethereum priority request queue, which the Sequencer must process within a predefined timeframe. | [[entities/network/lighter-core]] | A8-PII |
| #c22 | If the Sequencer fails to process priority requests in time, the system automatically triggers Escape Hatch mode, in which the Lighter Core smart contract freezes entirely. | [[entities/network/lighter-core]] | A8-PII |
| #c23 | In Escape Hatch mode, users can use Ethereum-posted data blobs to reconstruct their account state and generate succinct proofs of ownership over balances, positions, and pool shares. | [[entities/network/lighter-core]] | A8-PII |
| #c24 | Escape Hatch proofs allow users to withdraw the full value of their assets directly on Ethereum with no reliance on off-chain coordination. | [[entities/network/lighter-core]] | A8-PII |
| #c25 | The Lighter whitepaper is published at https://assets.lighter.xyz/whitepaper.pdf. | [[entities/perpdex/lighter]] | A1-PI |

## Conflicts raised
- (none)
