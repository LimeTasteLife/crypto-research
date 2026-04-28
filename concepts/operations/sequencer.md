---
type: concept
domain: operations
name: Sequencer
last_reviewed: 2026-04-28
disputed: false
---

# Sequencer

## Definition
A sequencer is the component responsible for choosing the order of transactions within a block (or, in non-blockchain venues, within a matching round). On a permissioned L2 the sequencer is typically a single trusted operator; on a BFT L1 the sequencer role is dispersed across the validator set and bound by the consensus algorithm.

## Mechanism on Hyperliquid

Hyperliquid uses HyperBFT — a HotStuff-derived BFT consensus — as its sequencing layer[^hl-docs-2026-04-27-hyperliquid-docs][^hl-docs-2026-04-27-hypercore-overview]. Validator block production is weighted by staked HYPE; a single consistent transaction order is produced by HyperBFT[^hl-docs-2026-04-27-hypercore-overview]. There is no separate "sequencer" role — sequencing is a property of the consensus, not a privileged endpoint.

The L1 mempool/consensus is **semantically aware** of HyperCore order-book actions[^hl-docs-2026-04-27-hypercore-order-book] — i.e. consensus does not treat all transactions as opaque blobs; it knows which are matching-engine relevant and applies the [[concepts/operations/matching-engine|matching engine's]] in-block ordering rule.

## Variants in the wild

| venue | sequencing model | failure mode | MEV / front-run posture |
|---|---|---|---|
| [[entities/perpdex/hyperliquid]] | BFT consensus across validators (no single sequencer)[^hl-docs-2026-04-27-hypercore-overview] | validator jailing on inadequate latency[^hl-docs-2026-04-27-hypercore-staking] | consensus-aware in-block ordering (cancels before GTC)[^hl-docs-2026-04-27-hypercore-order-book] |

(Other perpdex venues to be added in subsequent ingest passes.)

## Disputed claims
None at first ingest.

## Related
[[entities/network/hyperliquid-l1]] · [[concepts/operations/matching-engine]] · [[parameters/hyperliquid/validator-requirements]]

## Sources
[^hl-docs-2026-04-27-hypercore-overview]: [[sources/hl-docs-2026-04-27-hypercore-overview]]
[^hl-docs-2026-04-27-hyperliquid-docs]: [[sources/hl-docs-2026-04-27-hyperliquid-docs]]
[^hl-docs-2026-04-27-hypercore-order-book]: [[sources/hl-docs-2026-04-27-hypercore-order-book]]
[^hl-docs-2026-04-27-hypercore-staking]: [[sources/hl-docs-2026-04-27-hypercore-staking]]
