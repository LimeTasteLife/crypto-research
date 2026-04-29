---
type: concept
domain: mm-agreement
name: Quote obligation
last_reviewed: 2026-04-28
disputed: false
---

# Quote obligation

## Definition
A quote obligation is the set of requirements (spread, depth, uptime, size) that a market maker must meet to qualify for venue rebates, rewards, or formal partnership status.

## Variants in the wild

| venue | model | current value | notes |
|---|---|---|---|
| [[entities/perpdex/drift]] | three entry points with implicit obligation via rebate eligibility | post-only flag required for maker rebate; AMM-fill makers NOT eligible; DLOB MM uses oracle offset orders (~30 tx/day); JIT-only deploys capital on fill; SWIFT 100-500ms head-start[^drift-docs-2026-04-28-protocol-market-makers-maker-fee-rebate][^drift-developers-docs-2026-04-28-developers-market-makers] | no formal uptime/depth SLA surfaced in primary docs; opt-in MM Rewards Alpha Program advertised; Keepers earn rewards for best-execution-vs-oracle and FCFS ordering[^drift-docs-2026-04-28-protocol-about-v3-decentralized-orderbook][^drift-docs-2026-04-28-index] |

## Edge cases
- Drift's protocol-as-MM (running its own floating maker bot for-profit) creates a potential conflict of interest with external MMs who share the same rebate pool and order flow.

## Disputed claims
None.

## Related
[[concepts/mm-agreement/mm-tier]] . [[parameters/drift/mm-rebate-tiers]] . [[concepts/operations/matching-engine]]

## Sources
[^drift-docs-2026-04-28-protocol-market-makers-maker-fee-rebate]: [[sources/drift-docs-2026-04-28-protocol-market-makers-maker-fee-rebate]]
[^drift-developers-docs-2026-04-28-developers-market-makers]: [[sources/drift-developers-docs-2026-04-28-developers-market-makers]]
[^drift-docs-2026-04-28-protocol-about-v3-decentralized-orderbook]: [[sources/drift-docs-2026-04-28-protocol-about-v3-decentralized-orderbook]]
[^drift-docs-2026-04-28-index]: [[sources/drift-docs-2026-04-28-index]]
