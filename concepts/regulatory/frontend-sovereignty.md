---
type: concept
domain: regulatory
name: Frontend Sovereignty
last_reviewed: 2026-04-30
disputed: false
---

# Frontend Sovereignty

## Definition
The degree to which the venue's user-facing frontend is decoupled from a single canonical operator: how many independently-hosted frontends are sanctioned (or sanctioned-by-default), what the fork / self-host path looks like, and how regulatory liability is allocated across the canonical UI vs builder / partner UIs. Distinguishes protocol-level frontend plurality (multiple OSS reference UIs) from builder-attribution models (third-party UIs sharing protocol fee envelope). Maps to frame axis A9 / pillar PIV (see [[schema/frame]]).

## Variants in the wild

| venue | frontend topology | sovereignty mechanism | regulatory-liability allocation |
|---|---|---|---|
| [[entities/perpdex/dydx]] | three OSS reference frontends (web JS/React, iOS Swift, Android Kotlin); web frontend deployable to any domain/hosting including IPFS / Cloudflare gateway[^dydx-docs-2026-04-28-concepts-architecture-overview] | open-sourced deployment scripts; dYdX Trading Inc. does not run the canonical frontend; none of protocol, Indexer, or frontend components run by dYdX Trading Inc.[^dydx-docs-2026-04-28-concepts-architecture-overview] | integrator terms of service push compliance enforcement to deploying party[^dydx-docs-2026-04-28-interaction-integration-compliance] |
| [[entities/perpdex/drift]] | canonical app.drift.trade UI coexists with first-party SDKs (TS / Python / Rust), self-hosted Drift Gateway HTTP API, and builder-attributed third-party frontends[^drift-docs-2026-04-28-index][^drift-developers-docs-2026-04-28-developers] | Drift Builder Codes with user-signed per-builder fee cap envelope (user explicitly authorizes each builder's max fee)[^drift-developers-docs-2026-04-28-developers-drift-sdk-builder-codes] | not surfaced |
| [[entities/perpdex/lighter]] | canonical app.lighter.xyz UI coexists with builder-forkable Partner Attribution frontends[^lighter-docs-2026-04-28-lighter-docs-index] | Partner Attribution program with explicit fee-cap envelope[^lighter-docs-2026-04-28-integrations-partner-attribution] | not surfaced |
| [[entities/perpdex/orderly]] | gap — A9/PII gap: Orderly is permissionless infrastructure with regulatory exposure partly delegated to builder frontends, but no formal framework for builder-vs-protocol regulatory boundary; A9/PIV gap: stack-accounting across multiple builder frontends (which frontend bears regulatory liability?) not documented | gap | gap |
| [[entities/perpdex/hyperliquid]] | gap — A9/PIV gap: frontend sovereignty (canonical vs builder-forkable) policy implicit but not documented | gap | gap |
| [[entities/perpdex/aster]] | gap — A9/PIV gap: frontend sovereignty (canonical UI vs forkable / embeddable UI) and stack-accounting across multiple frontends not documented | gap | gap |

## Edge cases
- Three distinct sovereignty patterns appear in the filled rows: (1) dYdX's _operator-disclaimed plurality_ — multiple OSS reference frontends with the canonical operator explicitly not running any of them; (2) drift / lighter's _canonical-plus-builder envelope_ — a canonical operator-run UI coexisting with sanctioned third-party UIs governed by a fee-cap envelope (user-signed per-builder for drift, program-level for lighter). These differ in who bears default liability before any builder opts in.
- The builder-fee-cap envelope is the load-bearing primitive for drift and lighter: it lets the protocol sanction frontend plurality without ceding fee-policy control. The user-signed per-builder cap on drift is the strictest variant — each builder must be individually authorized at a specified max-fee level.
- Orderly's gap is structurally distinct from hyperliquid's and aster's: orderly explicitly runs a permissionless-infrastructure model where regulatory exposure is _delegated_ to builder frontends, but the framework for that delegation is undocumented (A9/PII gap). Hyperliquid and aster simply have no documented frontend-sovereignty policy at all (A9/PIV gap).

## Disputed claims
None.

## Related
[[concepts/regulatory/blocked-jurisdictions]] . [[concepts/governance/governance-vs-ops-separation]] . [[concepts/incentives/referral-design]]

## Sources
[^dydx-docs-2026-04-28-concepts-architecture-overview]: [[sources/dydx-docs-2026-04-28-concepts-architecture-overview]]
[^dydx-docs-2026-04-28-interaction-integration-compliance]: [[sources/dydx-docs-2026-04-28-interaction-integration-compliance]]
[^drift-docs-2026-04-28-index]: [[sources/drift-docs-2026-04-28-index]]
[^drift-developers-docs-2026-04-28-developers]: [[sources/drift-developers-docs-2026-04-28-developers]]
[^drift-developers-docs-2026-04-28-developers-drift-sdk-builder-codes]: [[sources/drift-developers-docs-2026-04-28-developers-drift-sdk-builder-codes]]
[^lighter-docs-2026-04-28-lighter-docs-index]: [[sources/lighter-docs-2026-04-28-lighter-docs-index]]
[^lighter-docs-2026-04-28-integrations-partner-attribution]: [[sources/lighter-docs-2026-04-28-integrations-partner-attribution]]
