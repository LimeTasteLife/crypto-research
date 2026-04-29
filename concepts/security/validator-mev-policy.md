---
type: concept
domain: security
name: Validator MEV Policy
last_reviewed: 2026-04-29
disputed: false
---

# Validator MEV Policy

## Definition
Rules governing validator (or sequencer) behavior regarding MEV extraction: oracle vote-time arbitrage, transaction ordering inside a block, sandwich and front-run mitigation, and the slashing or stake-loss conditions that follow misbehavior. Captures whether the protocol publishes a formal MEV stance or leaves it implicit. Maps to frame axis A8 (see [[schema/frame]]); related to [[concepts/operations/sequencer]].

## Variants in the wild

| venue | MEV stance | monitoring | slashing |
|---|---|---|---|
| [[entities/perpdex/hyperliquid]] | | | |
| [[entities/perpdex/aster]] | | | |
| [[entities/perpdex/lighter]] | | | |
| [[entities/perpdex/dydx]] | | | |
| [[entities/perpdex/orderly]] | | | |
| [[entities/perpdex/drift]] | | | |

## Edge cases
_(populated as claims are backfilled in Phase 2.)_

## Disputed claims
None.

## Related
[[concepts/operations/sequencer]] . [[concepts/operations/matching-engine]] . [[concepts/security/incident-response-sla]]

## Sources
_(populated as claims are backfilled in Phase 2.)_
