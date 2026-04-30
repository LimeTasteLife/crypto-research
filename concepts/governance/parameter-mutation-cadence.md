---
type: concept
domain: governance
name: Parameter Mutation Cadence
last_reviewed: 2026-04-29
disputed: false
---

# Parameter Mutation Cadence

## Definition
The frequency, lead-time, and process by which risk parameters (margin tiers, fee schedule, oracle config, listed-markets roster) can be changed. Captures the layering between routine "live tuning" (multisig / ops rotation) and structural change (token-holder vote), as well as published change-announcement windows. Maps to frame axis A7 (see [[schema/frame]]); related to [[concepts/governance/governance-vs-ops-separation]].

## Variants in the wild

| venue | who can change | typical lead-time | announce window |
|---|---|---|---|
| [[entities/perpdex/hyperliquid]] | validator-set parameters via staking module; validator commission ≤1% increase per change[^hl-docs-2026-04-27-hypercore-staking] | validator epoch ~90 min (100k consensus rounds)[^hl-docs-2026-04-27-hypercore-staking] | not surfaced |
| [[entities/perpdex/aster]] | Aster team / Aster Foundation; Treasury (7%) gated on governance approval; staking lifecycle gated on Epoch snapshot[^aster-docs-2026-04-28-usdaster-tokenomics][^aster-docs-2026-04-28-aster-chain-staking-how-staking-works] | next Epoch (Mon 00:00 UTC snapshot, weekly cadence)[^aster-docs-2026-04-28-aster-chain-staking-how-staking-works] | not surfaced |
| [[entities/perpdex/lighter]] | Lighter Governance adds markets; LP-program tiers/weights/pool at Lighter team discretion; points-program parameters at team discretion[^lighter-docs-2026-04-28-trading-contract-specifications][^lighter-docs-2026-04-28-liquidity-partner-program][^lighter-docs-2026-04-28-points-program] | not surfaced | LP-program parameters published Mondays 17:00 UTC[^lighter-docs-2026-04-28-liquidity-partner-program] |
| [[entities/perpdex/dydx]] | on-chain governance (DYDX stakers + validators) controls module parameters across 8 categories: Trading Stats, Fee Tiers, Trading Core, Markets, Perpetual, CLOB, Updating Live Markets, Safety[^dydx-community-2026-04-28-modules-governance-adjustable-parameters][^dydx-community-2026-04-28-modules-governance] | parameter changes take effect in the block after voting ends; voting period ~4 days[^dydx-community-2026-04-28-modules-governance-proposal-lifecycle] | effectively zero announce-window post-vote; expedited-path voting period 1 day[^dydx-community-2026-04-28-modules-governance-proposal-lifecycle] |
| [[entities/perpdex/orderly]] | multi-sig governance with signers having "deepest interest in success of Orderly"; $ORDER staking grants future voting rights; Foundation goal to transfer to DAO[^orderly-docs-2026-04-29-security][^orderly-docs-2026-04-29-distribution-and-emission-schedule] | not surfaced | not surfaced |
| [[entities/perpdex/drift]] | Drift Safety Module incentive parameters and further DRIFT utility added via DAO governance proposals; State-account admin controls protocol-wide config[^drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module][^drift-developers-docs-2026-04-28-developers-concepts-account-model] | not surfaced | not surfaced |

## Edge cases
_(populated as claims are backfilled in Phase 2.)_

## Disputed claims
None.

## Related
[[concepts/governance/veto-holders]] . [[concepts/governance/emergency-pause-authority]] . [[concepts/governance/governance-vs-ops-separation]]

## Sources
[^hl-docs-2026-04-27-hypercore-staking]: [[sources/hl-docs-2026-04-27-hypercore-staking]]
[^aster-docs-2026-04-28-usdaster-tokenomics]: [[sources/aster-docs-2026-04-28-usdaster-tokenomics]]
[^aster-docs-2026-04-28-aster-chain-staking-how-staking-works]: [[sources/aster-docs-2026-04-28-aster-chain-staking-how-staking-works]]
[^lighter-docs-2026-04-28-trading-contract-specifications]: [[sources/lighter-docs-2026-04-28-trading-contract-specifications]]
[^lighter-docs-2026-04-28-liquidity-partner-program]: [[sources/lighter-docs-2026-04-28-liquidity-partner-program]]
[^lighter-docs-2026-04-28-points-program]: [[sources/lighter-docs-2026-04-28-points-program]]
[^dydx-community-2026-04-28-modules-governance]: [[sources/dydx-community-2026-04-28-modules-governance]]
[^dydx-community-2026-04-28-modules-governance-adjustable-parameters]: [[sources/dydx-community-2026-04-28-modules-governance-adjustable-parameters]]
[^dydx-community-2026-04-28-modules-governance-proposal-lifecycle]: [[sources/dydx-community-2026-04-28-modules-governance-proposal-lifecycle]]
[^orderly-docs-2026-04-29-security]: [[sources/orderly-docs-2026-04-29-security]]
[^orderly-docs-2026-04-29-distribution-and-emission-schedule]: [[sources/orderly-docs-2026-04-29-distribution-and-emission-schedule]]
[^drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module]: [[sources/drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module]]
[^drift-developers-docs-2026-04-28-developers-concepts-account-model]: [[sources/drift-developers-docs-2026-04-28-developers-concepts-account-model]]
