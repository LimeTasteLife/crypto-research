---
type: concept
domain: security
name: Audit Cadence and Scope
last_reviewed: 2026-04-30
disputed: false
---

# Audit Cadence and Scope

## Definition
External smart-contract / system audit frequency, scope coverage (which contracts, modules, off-chain components, oracle pipelines), publication policy for findings, and remediation tracking. Captures whether audits are point-in-time, retainer-based, or continuous, and whether unfixed findings remain disclosed. Maps to frame axis A8 (see [[schema/frame]]).

## Variants in the wild

| venue | auditor(s) | cadence | scope |
|---|---|---|---|
| [[entities/perpdex/aster]] | Salus Security, PeckShield, HALBORN[^aster-docs-2026-04-28-overview-audit-reports] | seven reports clustered 2024-09-12 → 2024-12-17; no new audits surfaced through 2026-04-28[^aster-docs-2026-04-28-overview-audit-reports] | AsterVault, AsterEarn, asBNB (twin-audited), USDF, USDF+asUSDF, asCAKE; **gap: no audit of Aster Chain L1 or perp matching engine published**[^aster-docs-2026-04-28-overview-audit-reports] |
| [[entities/perpdex/lighter]] | Nethermind, Block, plus internal scope audits[^lighter-docs-2026-04-28-security-security-audits] | 7 reports across 2025-04-08 → 2025-11-24[^lighter-docs-2026-04-28-security-security-audits] | LighterCore, LighterEvmDepositBridge, Block, Block+delta, Wrapper, Desert exit, Spot; remediation status not on public index page[^lighter-docs-2026-04-28-security-security-audits] |
| [[entities/perpdex/dydx]] | Informal Systems[^dydx-docs-2026-04-28-policies-security][^dydx-community-2026-04-28-introduction] | pre-mainnet; additional audits planned as more code ships[^dydx-docs-2026-04-28-policies-security] | v4 Chain protocol; finalized reports in v4_chain audits folder; all core repos public[^dydx-docs-2026-04-28-policies-security] |
| [[entities/perpdex/orderly]] | Halborn, Zellic, Guardian Audits, several independent consultants; OmniVault: 2 independent audits[^orderly-docs-2026-04-29-security][^orderly-docs-2026-04-29-omnivault-overview] | not surfaced | platform contracts; OmniVault strategy vault contracts (separate scope); reports publicly available on GitHub[^orderly-docs-2026-04-29-security][^orderly-docs-2026-04-29-omnivault-overview] |
| [[entities/perpdex/drift]] | Trail of Bits (Tier-1), Neodyme, OtterSec[^drift-docs-2026-04-28-protocol-risk-and-safety-audits] | Trail of Bits 2022-11-07 → 2022-12-02 + 2023-01 fixup; Neodyme 2024-05-10 (last updated 2024-06-27); OtterSec point-in-time on Snap[^drift-docs-2026-04-28-protocol-risk-and-safety-audits] | Trail of Bits: protocol (no high-severity); Neodyme: protocol-v2; OtterSec: Metamask Snap "Connect"; **note: ClawSecure 2026 citation EXPLICITLY UNVERIFIED on first-party audits page**[^drift-docs-2026-04-28-protocol-risk-and-safety-audits] |

## Edge cases
- **Hyperliquid:** row dropped — no audit registry surfaced in primary docs mirror or `parameters/hyperliquid/`.
- **Aster L1 / matching-engine gap:** the published audit page covers Vault, Earn, asBNB, USDF, asUSDF, asCAKE — but not the Aster Chain L1 itself or the perpetuals matching engine[^aster-docs-2026-04-28-overview-audit-reports].
- **Aster date-gap:** all listed Aster reports predate the 2025 product timeline (TGE, asUSDF emission changes), so the audit page may lag the live deployed surface[^aster-docs-2026-04-28-overview-audit-reports].
- **Lighter remediation gap:** no findings or remediation status appear on the public index page[^lighter-docs-2026-04-28-security-security-audits].
- **Drift ClawSecure dispute:** secondary post-mortem material cites a ClawSecure February 2026 audit; the first-party page lists only Trail of Bits, Neodyme, and OtterSec. Per AGENTS.md hallucination guard, ClawSecure is NOT filed as a confirmed audit[^drift-docs-2026-04-28-protocol-risk-and-safety-audits].

## Disputed claims
- Drift ClawSecure 2026 audit citation — not on canonical first-party audits page; held as open question (see [[entities/perpdex/drift]] §"Disputed claims — ClawSecure February 2026 audit citation").

## Related
[[concepts/security/bug-bounty-program]] . [[concepts/security/oracle-attack-history]] . [[concepts/security/incident-response-sla]]

## Sources
[^aster-docs-2026-04-28-overview-audit-reports]: [[sources/aster-docs-2026-04-28-overview-audit-reports]]
[^lighter-docs-2026-04-28-security-security-audits]: [[sources/lighter-docs-2026-04-28-security-security-audits]]
[^dydx-docs-2026-04-28-policies-security]: [[sources/dydx-docs-2026-04-28-policies-security]]
[^dydx-community-2026-04-28-introduction]: [[sources/dydx-community-2026-04-28-introduction]]
[^orderly-docs-2026-04-29-security]: [[sources/orderly-docs-2026-04-29-security]]
[^orderly-docs-2026-04-29-omnivault-overview]: [[sources/orderly-docs-2026-04-29-omnivault-overview]]
[^drift-docs-2026-04-28-protocol-risk-and-safety-audits]: [[sources/drift-docs-2026-04-28-protocol-risk-and-safety-audits]]
