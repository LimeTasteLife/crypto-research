---
type: entity
subtype: network
name: Lighter Core
status: live
launched: unknown
sources_count: 4
last_reviewed: 2026-04-28
disputed: false
---

# Lighter Core

> A custom ZK-rollup whose state machine is an exchange (orderbook, positions, public pools), with Ethereum as data-availability and settlement layer and an on-chain Escape Hatch for permissionless self-withdrawal.

## Snapshot
- Architecture: ZK rollup with custom proving engine purpose-built for orderbook / position / public-pool workloads[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]
- DA + settlement: Ethereum L1 (data blobs + state-root contracts)[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]
- Sequencer: single, FIFO ordering, soft finality[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]
- Liveness fallback: on-chain priority queue + Escape Hatch contract freeze + state-blob withdrawal proofs[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]
- Hosted exchange: [[entities/perpdex/lighter]]

## Mechanism

**Design principles.** Lighter Core is built on four explicit principles: users always maintain custody of their assets; operations must be verifiable and adhere to a publicly predefined ruleset; the system must scale seamlessly in latency and throughput; users must always be able to exit securely and independently[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]. Lighter positions itself as the first exchange to offer verifiable order matching and verifiable liquidations while delivering performance comparable to traditional exchanges[^lighter-docs-2026-04-28-lighter-docs-index].

**ZK rollup with custom proving engine.** Lighter Core combines succinct execution proofs with Ethereum as the anchoring layer for both proofs and system state[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]. The proving engine uses new algorithms and optimized data structures purpose-built for exchange-specific workloads — orderbook, positions, and public pools — rather than a general-purpose ZK VM[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]. All exchange operations are executed deterministically via user-signed transactions; a batch produces a new post-execution state along with a succinct cryptographic proof[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core].

**Data availability.** Smart contracts on Ethereum hold deposited assets and the canonical Lighter state root, which encapsulates user assets and positions, public pools, order books, and other critical system components[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]. Lighter Core periodically publishes state-update proposals to Ethereum, each accompanied by data blobs containing per-account state-transition details so users can independently reconstruct and verify their state[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]. The data is highly compressed, enabling state to be published directly to Ethereum at high scale without third parties[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]. State-update proofs also attest to the validity and sufficiency of the posted blobs, so the on-chain data alone suffices to reconstruct all user states from censorship-resistant immutable storage[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core].

**Sequencer + Witness Generators + Prover.** A Sequencer coordinates first-in-first-out transaction ordering and provides soft finality on Lighter Core[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]. Sequencer-produced data is fed to API servers, which provide ultra-low-latency data to end users[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]. The same data feeds horizontally and vertically scalable Witness Generator services that transform it into circuit-friendly inputs for the Prover[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]. The Lighter Prover generates proofs in parallel across Lighter transactions; hundreds of thousands of execution proofs are fed into a multi-layer aggregation engine and combined into a single batch proof for verification on Ethereum[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]. Once a state-update proposal's proof is verified on Ethereum, the contracts update the exchange state[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core].

**Verifiable matching.** The Lighter Matching Engine ensures price-time priority is always respected by utilizing SNARKs to generate cryptographic proofs for fair order-book matching execution; the engine is described as a trustless service, bound to function in a predefined way and mathematically impossible to act maliciously[^lighter-docs-2026-04-28-trading-order-types-and-matching]. This is the verifiability guarantee that distinguishes Lighter Core from optimistic-execution alternatives.

**Escape Hatch (liveness fallback).** Lighter Core introduces a priority request queue on Ethereum to guarantee liveness and censorship resistance[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]. Users can submit critical exit operations — withdrawals, public-pool exits, and reduce-only IOC orders — to the priority queue, which the Sequencer must process within a predefined timeframe[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]. If the Sequencer fails to process priority requests in time, the system automatically triggers Escape Hatch mode, in which the Lighter Core smart contract freezes entirely[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]. In Escape Hatch mode, users use Ethereum-posted data blobs to reconstruct their account state and generate succinct proofs of ownership over balances, positions, and pool shares; these proofs allow withdrawal of the full value of assets directly on Ethereum with no reliance on off-chain coordination[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core].

**Audited surface.** Nethermind audited LighterCore and the LighterEvmDepositBridge (both 2025-09-22)[^lighter-docs-2026-04-28-security-security-audits]. The LighterCore audit scope is the core matching/state-transition contract; the deposit-bridge audit scope is the Ethereum-side deposit path[^lighter-docs-2026-04-28-security-security-audits]. Block audits (2025-04-08; 2025-08-09 Block & delta) plus internal Wrapper (2025-10-10), Desert exit (2025-05-11), and Spot (2025-11-24) audits round out the verified surface[^lighter-docs-2026-04-28-security-security-audits].

**Whitepaper.** The Lighter whitepaper is published at https://assets.lighter.xyz/whitepaper.pdf[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core].

## Relations
- [[entities/network/lighter-core]] **runs** [[entities/perpdex/lighter]] (the only application is the Lighter exchange)[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]
- [[entities/network/lighter-core]] **depends_on** Ethereum L1 for data availability and settlement[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]
- [[entities/network/lighter-core]] **uses** [[concepts/operations/sequencer]] (FIFO ordering, soft finality)[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]
- [[entities/network/lighter-core]] **implements** the Escape Hatch (Ethereum priority queue + state-proof self-withdrawal)[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]

## Open questions
- What is the priority-queue processing deadline before Escape Hatch fires (the "predefined timeframe")?
- Does Lighter Core publish a Sequencer failover plan or run multiple sequencers?
- How is the Lighter Prover currently operated — single-prover, multi-prover, or permissionless?
- Are there published latency / throughput / batch-size targets for the Prover stack?
- What are the on-chain contract addresses for the LighterCore state-root, Deposit Bridge, and Escape Hatch components on Ethereum mainnet?
- Has Escape Hatch ever been triggered in production, and if so what was the resolution?

## Disputed claims
None at first ingest.

## Related
[[entities/perpdex/lighter]] · [[entities/token/lit]] · [[concepts/operations/sequencer]] · [[parameters/lighter/audit-history]]

## Sources
[^lighter-docs-2026-04-28-lighter-docs-index]: [[sources/lighter-docs-2026-04-28-lighter-docs-index]]
[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]: [[sources/lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]]
[^lighter-docs-2026-04-28-trading-order-types-and-matching]: [[sources/lighter-docs-2026-04-28-trading-order-types-and-matching]]
[^lighter-docs-2026-04-28-security-security-audits]: [[sources/lighter-docs-2026-04-28-security-security-audits]]
