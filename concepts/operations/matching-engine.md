---
type: concept
domain: operations
name: Matching engine
last_reviewed: 2026-04-28
disputed: false
---

# Matching engine

## Definition
The matching engine is the venue's deterministic process that pairs buy and sell orders into trades according to a published priority rule (typically price-time)[^hl-docs-2026-04-27-hypercore-order-book]. Its design choices determine fill order under contention, MEV/toxic-flow resistance, and the venue's relationship between consensus ordering and trade ordering.

## Mechanism on Hyperliquid

**On-chain matching, no off-chain book.** HyperCore matches orders inside the L1 state machine, ordered by HyperBFT consensus[^hl-docs-2026-04-27-hypercore-overview][^hl-docs-2026-04-27-hypercore-order-book]. There is no separate matching server or off-chain book.

**Margin checks at two points.** A perp order is margin-checked both at submission and at the moment a resting order is matched, so margining stays consistent under oracle drift[^hl-docs-2026-04-27-hypercore-order-book].

**Consensus-aware in-block ordering** (toxic-flow defense). Within a single block, actions are ordered in three categories:

1. Non-GTC / non-IOC actions (e.g. spot transfers, modifies of resting orders without an immediate-trade intent).
2. Cancels.
3. Actions that send at least one GTC/IOC order.

Within each category, actions are sorted in proposer order[^hl-docs-2026-04-27-hypercore-order-book]. Modifies are categorized by the new order they place (placement category drives ordering)[^hl-docs-2026-04-27-hypercore-order-book]. This explicit ordering rule is a deliberate latency-arb mitigation: cancels resolve before aggressive submissions, so a resting market maker can pull stale quotes ahead of a same-block aggressive taker.

## Variants in the wild

| venue | match location | priority | toxic-flow ordering rule |
|---|---|---|---|
| [[entities/perpdex/hyperliquid]] | on-chain (HyperCore)[^hl-docs-2026-04-27-hypercore-order-book] | price-time[^hl-docs-2026-04-27-hypercore-order-book] | per-block: non-GTC > cancels > GTC/IOC; proposer order within[^hl-docs-2026-04-27-hypercore-order-book] |
| [[entities/perpdex/aster]] | on-chain (Aster Chain L1) via encrypted-order pipeline; cryptographic primitive unspecified (MPC/threshold/FHE/TEE candidates); audit gap — engine NOT in published audit set[^aster-docs-2026-04-28-overview-what-is-aster][^aster-docs-2026-04-28-overview-audit-reports] | not surfaced | not surfaced |

(Other perpdex venues to be added in subsequent ingest passes.)

## Edge cases
- The same-block "cancel before GTC" rule materially changes maker economics: makers can cancel stale quotes when an aggressive order arrives in the same block, preventing them from being run over by latency-advantaged takers.

## Disputed claims
None at first ingest.

## Related
[[concepts/market-structure/clob]] · [[concepts/operations/sequencer]] · [[concepts/risk/margin-tier]]

## Sources
[^hl-docs-2026-04-27-hypercore-order-book]: [[sources/hl-docs-2026-04-27-hypercore-order-book]]
[^hl-docs-2026-04-27-hypercore-overview]: [[sources/hl-docs-2026-04-27-hypercore-overview]]
[^aster-docs-2026-04-28-overview-what-is-aster]: [[sources/aster-docs-2026-04-28-overview-what-is-aster]]
[^aster-docs-2026-04-28-overview-audit-reports]: [[sources/aster-docs-2026-04-28-overview-audit-reports]]
