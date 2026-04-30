---
type: concept
domain: security
name: Incident Response SLA
last_reviewed: 2026-04-30
disputed: false
---

# Incident Response SLA

## Definition
Documented commitments around incident handling: mean-time-to-acknowledge (MTTA), mean-time-to-resolve (MTTR), status-page update cadence, downtime fee-credit or rebate policy, and the liquidation rollback window after an outage. Distinguishes hard SLAs (contractual) from soft expectations (custom-of-the-house). Maps to frame axis A8 (see [[schema/frame]]).

## Variants in the wild

| venue | MTTA | MTTR | downtime credit policy |
|---|---|---|---|
| [[entities/perpdex/dydx]] | not surfaced[^dydx-entity-a8-piv] | not surfaced[^dydx-entity-a8-piv] | not surfaced; chain-outage of 5+ min triggers 50-block transfer/withdrawal gate (loss-mitigation, not credit)[^dydx-docs-2026-04-28-concepts-trading-limits-withdrawal-limits] |

_(Hyperliquid, Aster, Lighter, Orderly, Drift rows dropped: every surveyed entity records A8/PIV as `gap` — no MTTA, MTTR, status-page cadence, downtime fee-credit, or liquidation-rollback policy surfaced in primary docs.[^hl-entity-a8-piv][^aster-entity-a8-piv][^lighter-entity-a8-piv][^orderly-entity-a8-piv][^drift-entity-a8-piv] dYdX row retained because of the documented withdrawal-gating mechanic on chain outages, which is the only first-party outage-handling commitment surfaced across all six venues.)_

## Edge cases
- Aster has a published payout SLA but it covers fee/rebate disbursement, not incident response: Trade & Earn weekly cycle (Thu→Wed) with 7-business-day payout.[^aster-entity-payout-sla] Aster's MM program SLA is explicitly unilateral — Aster reserves modify/suspend/terminate rights with no binding agreement.[^aster-entity-mm-sla]
- Lighter has Escape Hatch as a self-withdrawal failsafe[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core-c21-c24], but the trigger deadline (how long the sequencer can be uncooperative before priority-queue activation) is not documented[^lighter-entity-zk-scaffolding].
- Orderly's security page is sparse — "no audit dates, scope detail, bug bounty, or incident response policy" per source mirror's own assessment.[^orderly-docs-2026-04-29-security]
- Drift's SWIFT API contract specifies that MM bots fall back to `AuctionSubscriber` if SWIFT WebSocket disconnects[^drift-developers-docs-2026-04-28-developers-market-makers-swift-api] — this is a connector-failover contract, not a venue-level incident SLA.

## Disputed claims
None.

## Related
[[concepts/security/audit-cadence-and-scope]] . [[concepts/security/oracle-attack-history]] . [[concepts/governance/emergency-pause-authority]]

## Sources
[^dydx-docs-2026-04-28-concepts-trading-limits-withdrawal-limits]: [[sources/dydx-docs-2026-04-28-concepts-trading-limits-withdrawal-limits]]
[^dydx-entity-a8-piv]: [[entities/perpdex/dydx]] §"A8/PIV: gap — outage-refund / downtime fee-credit / position-stuck remediation policy not documented; status-page MTTA not surfaced"
[^hl-entity-a8-piv]: [[entities/perpdex/hyperliquid]] §"A8/PIV: gap — outage refund / downtime fee credit policy not documented"
[^aster-entity-a8-piv]: [[entities/perpdex/aster]] §"A8/PIV: gap — outage refund / downtime fee credit / position-stuck remediation policy not documented"
[^lighter-entity-a8-piv]: [[entities/perpdex/lighter]] §"A8/PIV: gap — outage refund / downtime fee credit policy not documented"
[^orderly-entity-a8-piv]: [[entities/perpdex/orderly]] §"A8/PIV: gap — no outage refund / downtime fee-credit / position-stuck remediation policy documented"
[^drift-entity-a8-piv]: [[entities/perpdex/drift]] §"A8/PIV: gap — outage-refund / downtime fee-credit / Solana-congestion-induced position-stuck remediation policy not documented in primary docs"
[^aster-entity-payout-sla]: [[entities/perpdex/aster]] §"A3/PIV — Trade & Earn weekly cycle (Thu→Wed) and 7-business-day payout SLA"
[^aster-entity-mm-sla]: [[entities/perpdex/aster]] §"A4/PV — MM program SLA is unilateral on platform side"
[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core-c21-c24]: [[sources/lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]] §"#c21–#c24 (Escape Hatch)"
[^lighter-entity-zk-scaffolding]: [[entities/perpdex/lighter]] §"ZK-rollup operational scaffolding partially documented"
[^orderly-docs-2026-04-29-security]: [[sources/orderly-docs-2026-04-29-security]]
[^drift-developers-docs-2026-04-28-developers-market-makers-swift-api]: [[sources/drift-developers-docs-2026-04-28-developers-market-makers-swift-api]] §"#c13"
