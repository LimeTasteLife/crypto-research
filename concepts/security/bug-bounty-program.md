---
type: concept
domain: security
name: Bug Bounty Program
last_reviewed: 2026-04-30
disputed: false
---

# Bug Bounty Program

## Definition
Public vulnerability-disclosure program scope, max payout per severity tier, eligibility rules (residency, KYC, prior-employment exclusions), platform host (Immunefi, in-house, etc.), and the disclosed track record of past findings paid out. Captures whether bounty terms cover oracle / off-chain components or smart contracts only. Maps to frame axis A8 (see [[schema/frame]]).

## Variants in the wild

| venue | platform | max payout | scope |
|---|---|---|---|
| [[entities/perpdex/lighter]] | unpublished — page is "Coming soon" stub as of 2026-04-28[^lighter-docs-2026-04-28-security-bug-bounty-program] | unknown[^lighter-docs-2026-04-28-security-bug-bounty-program] | unknown — no scope, payout tiers, severity classifications, or disclosure terms published[^lighter-docs-2026-04-28-security-bug-bounty-program] |
| [[entities/perpdex/dydx]] | informal — community invited to identify vulnerabilities given public repos; no formal published bug-bounty SLA[^dydx-docs-2026-04-28-policies-security][^dydx-community-2026-04-28-introduction] | not surfaced[^dydx-docs-2026-04-28-policies-security] | implicit — all core repos public; no payout amount, scope, or coordinated-disclosure template surfaced[^dydx-docs-2026-04-28-policies-security] |
| [[entities/perpdex/drift]] | in-house, Immunefi-classified severity rules; submission to hello@drift.trade; paid in USDC; 1 business day response[^drift-sdk-docs-2026-04-28-program-security] | **Critical** up to $500,000 (funds drainage / theft without signatures); **High** $10,000–$50,000 (funds freezing / incorrect value assignment); **Medium/Low** $1,000–$5,000[^drift-sdk-docs-2026-04-28-program-security] | in-scope: protocol smart-contract vulnerabilities. Out-of-scope: already-exploited attacks, leaked credentials, privileged-address access, oracle data issues (except manipulation), liquidity issues, third-party bot errors, social engineering, DoS, Immunefi rules violations; public disclosure before reporting forbidden[^drift-sdk-docs-2026-04-28-program-security] |

## Edge cases
- **Hyperliquid:** row dropped — no bug-bounty programme surfaced in primary docs mirror.
- **Aster:** row dropped — `parameters/aster/audits.md` covers audit registry only; no bug-bounty scheme surfaced in mirrored Aster docs.
- **Orderly:** row dropped — no bug bounty program found in primary docs; may exist in GitHub SECURITY.md (out of mirror scope)[^orderly-docs-2026-04-29-security].
- **Lighter:** publicly signaled but unpublished — page declares "Coming soon" with no actionable terms; the 131-byte thin content is genuine, not a crawl error[^lighter-docs-2026-04-28-security-bug-bounty-program].
- **dYdX:** no formal payout SLA exists; the "bounty" is implicit — public-repo invitation to identify vulnerabilities[^dydx-docs-2026-04-28-policies-security].
- **Drift:** Immunefi-classified severity tiers are used in-house, NOT hosted on Immunefi's platform; submissions go to hello@drift.trade directly[^drift-sdk-docs-2026-04-28-program-security].

## Disputed claims
None.

## Related
[[concepts/security/audit-cadence-and-scope]] . [[concepts/security/oracle-attack-history]] . [[concepts/security/incident-response-sla]]

## Sources
[^lighter-docs-2026-04-28-security-bug-bounty-program]: [[sources/lighter-docs-2026-04-28-security-bug-bounty-program]]
[^dydx-docs-2026-04-28-policies-security]: [[sources/dydx-docs-2026-04-28-policies-security]]
[^dydx-community-2026-04-28-introduction]: [[sources/dydx-community-2026-04-28-introduction]]
[^orderly-docs-2026-04-29-security]: [[sources/orderly-docs-2026-04-29-security]]
[^drift-sdk-docs-2026-04-28-program-security]: [[sources/drift-sdk-docs-2026-04-28-program-security]]
