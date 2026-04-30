---
type: concept
domain: governance
name: Governance vs Ops Separation
last_reviewed: 2026-04-29
disputed: false
---

# Governance vs Ops Separation

## Definition
The boundary between governance-controlled parameters (require token-holder action or formal proposal) and operations-controlled parameters (multisig / team / engineering rotation can change without vote). Captures the published list of which parameters live on which side, escalation paths when scope is contested, and audit trail expectations. Maps to frame axis A7 (see [[schema/frame]]).

## Variants in the wild

| venue | governance scope | ops scope | escalation path |
|---|---|---|---|
| [[entities/perpdex/dydx]] | on-chain governance (DYDX stakers + validators) controls module parameters: fee tiers, liquidation params, funding clamps, oracle list per market, full Liquidity Tier table, IF send-out, MegaVault operator election, Order Router Rev Share whitelist[^dydx-community-2026-04-28-modules-governance-adjustable-parameters][^dydx-docs-2026-04-28-concepts-trading-governance] | dYdX Trading Inc. open-sourced software but does NOT run protocol/Indexer/front-end; Operations subDAO handles validator coordination; Treasury subDAO + MegaVault Operator (Greave) hold operational authority; CryptoLearningClub manages VIP affiliate whitelisting via on-chain proposals[^dydx-docs-2026-04-28-concepts-architecture-overview][^dydx-community-2026-04-28-dydx-features-megavault][^dydx-community-2026-04-28-dydx-features-affiliate-program] | proposal lifecycle has 8 stages including off-chain DRC discussion on https://dydx.forum/; investor transfer restrictions enforced via contractual agreements with dYdX Foundation and dYdX Trading Inc. (not on-chain)[^dydx-community-2026-04-28-modules-governance-proposal-lifecycle][^dydx-community-2026-04-28-start-here-dydx-token-allocation] |

## Edge cases
_(populated as claims are backfilled in Phase 2.)_

## Disputed claims
None.

## Related
[[concepts/governance/parameter-mutation-cadence]] . [[concepts/governance/veto-holders]] . [[concepts/governance/emergency-pause-authority]]

## Sources
[^dydx-community-2026-04-28-modules-governance-adjustable-parameters]: [[sources/dydx-community-2026-04-28-modules-governance-adjustable-parameters]]
[^dydx-docs-2026-04-28-concepts-trading-governance]: [[sources/dydx-docs-2026-04-28-concepts-trading-governance]]
[^dydx-docs-2026-04-28-concepts-architecture-overview]: [[sources/dydx-docs-2026-04-28-concepts-architecture-overview]]
[^dydx-community-2026-04-28-dydx-features-megavault]: [[sources/dydx-community-2026-04-28-dydx-features-megavault]]
[^dydx-community-2026-04-28-dydx-features-affiliate-program]: [[sources/dydx-community-2026-04-28-dydx-features-affiliate-program]]
[^dydx-community-2026-04-28-modules-governance-proposal-lifecycle]: [[sources/dydx-community-2026-04-28-modules-governance-proposal-lifecycle]]
[^dydx-community-2026-04-28-start-here-dydx-token-allocation]: [[sources/dydx-community-2026-04-28-start-here-dydx-token-allocation]]
