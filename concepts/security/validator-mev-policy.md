---
type: concept
domain: security
name: Validator MEV Policy
last_reviewed: 2026-04-30
disputed: false
---

# Validator MEV Policy

## Definition
Rules governing validator (or sequencer) behavior regarding MEV extraction: oracle vote-time arbitrage, transaction ordering inside a block, sandwich and front-run mitigation, and the slashing or stake-loss conditions that follow misbehavior. Captures whether the protocol publishes a formal MEV stance or leaves it implicit. Maps to frame axis A8 (see [[schema/frame]]); related to [[concepts/operations/sequencer]].

## Variants in the wild

| venue | MEV stance | monitoring | slashing |
|---|---|---|---|
| [[entities/perpdex/hyperliquid]] | implicit; HyperBFT one-block finality on staked HYPE-weighted validators[^hl-docs-2026-04-27-hyperliquid-docs] | not surfaced[^hl-entity-a8-piii] | jailing on inadequate latency / response frequency by validator quorum vote;[^hl-docs-2026-04-27-hypercore-staking-c18] double-sign slashing reserved but no automatic slashing currently implemented[^hl-docs-2026-04-27-hypercore-staking-c20] |
| [[entities/perpdex/aster]] | "1001x is one-click, MEV-resistant perp contract trading using on-chain liquidity" — marketing-level claim, no protocol mechanism specified[^aster-docs-2026-04-28-overview-what-is-aster-c11] | not surfaced[^aster-entity-a8-pii] | not surfaced; no documented incident-response history, slashing policy, or validator-misbehavior remediation for Aster Chain[^aster-entity-a8-pii] |
| [[entities/perpdex/dydx]] | explicitly acknowledged harmful but no protocol-level mitigation;[^dydx-community-2026-04-28-modules-slashing-c14] node spec: respect cancels immediately, failure is treated as MEV[^dydx-chain-tech-2026-04-28-validators-faq-and-resources-c12] | Skip-built validator-MEV-discrepancy dashboard at dydx.skip.money;[^dydx-chain-tech-2026-04-28-data-dashboards-and-open-apis-public-dashboards-c3][^dydx-community-2026-04-28-modules-slashing-c13] dashboard has known subtle bug in price-discrepancy calculation; no authentic MEV detected to date[^dydx-chain-tech-2026-04-28-validators-faq-and-resources-c11] | none enforced; community could approve a social slashing framework via governance vote, but has not done so[^dydx-community-2026-04-28-modules-slashing-c15][^dydx-docs-2026-04-28-concepts-onboarding-faqs-c10] |
| [[entities/perpdex/drift]] | not surfaced; Drift runs as a Solana program (Solana validators, not Drift's), so on-chain ordering is the Solana-leader's surface[^drift-entity-network] | not surfaced[^drift-entity-a8-piii] | not applicable at Drift layer — Solana validators are out-of-protocol; Drift Safety Module slashing applies to DSM stakers covering bad debt, not to validator MEV[^drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module] |

_(Lighter and Orderly rows dropped: Lighter is a ZK rollup whose Sequencer provides FIFO ordering and soft finality with Escape Hatch as the trustless-exit failsafe[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core] — there is no public validator set to which a venue-level MEV policy attaches. Orderly is governed by a multi-sig mechanism with signers having "deepest interest in success of Orderly"[^orderly-docs-2026-04-29-security-c3] and runs as a headless builder layer across 16 EVM chains + Solana[^orderly-entity-a1-pi] — no Orderly-operated validator layer exists for an MEV policy to bind.)_

## Edge cases
- dYdX's MEV stance is the most explicit of any surveyed venue: it admits MEV is harmful, publishes a public detection dashboard via Skip Protocol, names the first remediation step (slashing), and has not implemented enforcement. The gap between detection and enforcement is the defining MEV-governance feature.
- Hyperliquid's staking-trading link (validator stake permanence couples consensus security to trading-fee revenue) creates a security surface separate from MEV: validators who jeopardise consensus also lose trading-fee accrual.[^hl-entity-a8-pii]
- Lighter and Orderly are not "no MEV policy" — they are "no validator layer for the policy to bind." The MEV surface relocates: for Lighter, to the Sequencer (single-operator FIFO + Escape Hatch trustless-exit); for Orderly, to per-chain Solana/EVM validators inherited from each underlying network.

## Disputed claims
None.

## Related
[[concepts/operations/sequencer]] . [[concepts/operations/matching-engine]] . [[concepts/security/incident-response-sla]]

## Sources
[^hl-docs-2026-04-27-hyperliquid-docs]: [[sources/hl-docs-2026-04-27-hyperliquid-docs]]
[^hl-docs-2026-04-27-hypercore-staking-c18]: [[sources/hl-docs-2026-04-27-hypercore-staking]] §"#c18"
[^hl-docs-2026-04-27-hypercore-staking-c20]: [[sources/hl-docs-2026-04-27-hypercore-staking]] §"#c20"
[^hl-entity-a8-piii]: [[entities/perpdex/hyperliquid]] §"A8/PIII: gap — adverse selection / oracle attack history not documented"
[^hl-entity-a8-pii]: [[entities/perpdex/hyperliquid]] §"A8/PII — staking-trading link permanence creates security surface"
[^aster-docs-2026-04-28-overview-what-is-aster-c11]: [[sources/aster-docs-2026-04-28-overview-what-is-aster]] §"#c11"
[^aster-entity-a8-pii]: [[entities/perpdex/aster]] §"A8/PII: gap — no documented incident response history, slashing policy, or validator misbehavior remediation for Aster Chain"
[^dydx-community-2026-04-28-modules-slashing-c13]: [[sources/dydx-community-2026-04-28-modules-slashing]] §"#c13"
[^dydx-community-2026-04-28-modules-slashing-c14]: [[sources/dydx-community-2026-04-28-modules-slashing]] §"#c14"
[^dydx-community-2026-04-28-modules-slashing-c15]: [[sources/dydx-community-2026-04-28-modules-slashing]] §"#c15"
[^dydx-chain-tech-2026-04-28-data-dashboards-and-open-apis-public-dashboards-c3]: [[sources/dydx-chain-tech-2026-04-28-data-dashboards-and-open-apis-public-dashboards]] §"#c3"
[^dydx-chain-tech-2026-04-28-validators-faq-and-resources-c11]: [[sources/dydx-chain-tech-2026-04-28-validators-faq-and-resources]] §"#c11"
[^dydx-chain-tech-2026-04-28-validators-faq-and-resources-c12]: [[sources/dydx-chain-tech-2026-04-28-validators-faq-and-resources]] §"#c12"
[^dydx-docs-2026-04-28-concepts-onboarding-faqs-c10]: [[sources/dydx-docs-2026-04-28-concepts-onboarding-faqs]] §"#c10"
[^drift-entity-network]: [[entities/perpdex/drift]] §"Network — Solana"
[^drift-entity-a8-piii]: [[entities/perpdex/drift]] §"A8/PIII: gap — oracle-attack history not disclosed in this snapshot"
[^drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module]: [[sources/drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module]]
[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]: [[sources/lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]]
[^orderly-docs-2026-04-29-security-c3]: [[sources/orderly-docs-2026-04-29-security]] §"#c3"
[^orderly-entity-a1-pi]: [[entities/perpdex/orderly]] §"A1/PI — headless builder model; 16 EVM + Solana"
