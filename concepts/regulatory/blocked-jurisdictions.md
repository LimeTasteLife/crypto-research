---
type: concept
domain: regulatory
name: Blocked Jurisdictions
last_reviewed: 2026-04-30
disputed: false
---

# Blocked Jurisdictions

## Definition
The explicit list of jurisdictions whose users are barred from interacting with the venue, the sanctions / OFAC screening posture, and the technical mechanism (IP geo-block, address screen, terms-of-service obligation on integrators) that enforces the bar. Distinguishes protocol-level enforcement (on-chain or indexer-side) from contractual enforcement delegated to integrator frontends. Maps to frame axis A9 / pillar PI (see [[schema/frame]]).

## Variants in the wild

| venue | blocked-jurisdictions list | enforcement mechanism | sanctions screen |
|---|---|---|---|
| [[entities/perpdex/dydx]] | USA, Canada, Iran, Cuba, North Korea, Syria, Myanmar, Crimea/Donetsk/Luhansk[^dydx-docs-2026-04-28-interaction-integration-compliance] | indexer `/v4/geo` endpoint (IP-derived geo + `blocked` boolean) and `/v4/screen/<address>` endpoint (per-address compliance status) for integrators; client-side geo-blocking obligation under integrator terms of service[^dydx-docs-2026-04-28-interaction-integration-compliance] | OFAC-sanctioned-parties exclusion[^dydx-docs-2026-04-28-interaction-integration-compliance] |
| [[entities/perpdex/drift]] | gap — A9/PI gap: blocked-jurisdictions list / OFAC / sanctions screen coverage not surfaced in primary docs | gap | gap |
| [[entities/perpdex/hyperliquid]] | gap — A9/PI gap: blocked-jurisdictions policy not documented in primary docs | gap | gap |
| [[entities/perpdex/orderly]] | gap — A9/PI gap: no blocked-jurisdictions list, OFAC/sanctions screen, or KYC tier documentation in primary docs | gap | gap |
| [[entities/perpdex/lighter]] | gap — A9/PI gap: blocked-jurisdictions policy / OFAC / sanctions screen coverage not documented in primary docs | gap | gap |
| [[entities/perpdex/aster]] | gap — A9/PII gap: onboarding KYC requirements vs offboarding withdrawal restrictions / blocked-jurisdictions list not documented in primary docs (A9/PI is filled but covers referrer-disclaimer posture, not jurisdictional blocking) | gap | gap |

## Edge cases
- dYdX separates protocol-vs-frontend enforcement: the protocol does not enforce geo-blocking on-chain; the indexer exposes `/v4/geo` and `/v4/screen/<address>` as informational endpoints, and integrator frontends are contractually expected to consume them and gate users client-side[^dydx-docs-2026-04-28-interaction-integration-compliance]. This means a forked frontend that ignores the endpoints can still reach the protocol — the bar is contractual, not cryptographic.
- Aster's A9/PI is filled but with a different posture: referrers are made responsible for understanding legal implications of promoting leveraged trading in their region, with Trade & Earn output framed as not financial advice — i.e. liability disclaimer rather than jurisdictional block. The blocked-jurisdictions question (A9/PII) remains gap.
- Five of six surveyed perpdex entities (drift, hyperliquid, orderly, lighter, aster) record A9/PI as `gap` — the absence of a documented list is itself a structural finding, not a documentation oversight to be filed under "to-do." Open questions on drift and lighter explicitly request the list as a Phase 2 ingest target.

## Disputed claims
None.

## Related
[[concepts/regulatory/frontend-sovereignty]] . [[concepts/listing/listing-criteria]] . [[concepts/governance/governance-vs-ops-separation]]

## Sources
[^dydx-docs-2026-04-28-interaction-integration-compliance]: [[sources/dydx-docs-2026-04-28-interaction-integration-compliance]]
