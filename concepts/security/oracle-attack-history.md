---
type: concept
domain: security
name: Oracle Attack History
last_reviewed: 2026-04-30
disputed: false
---

# Oracle Attack History

## Definition
Documented incidents where the oracle layer was manipulated, exploited, or experienced significant deviation from honest market price; the remediation taken; and post-mortem publication record. Distinguishes pure oracle attacks (price manipulation) from sequencer / consensus failures that propagate through the oracle. Maps to frame axis A8 (see [[schema/frame]]); related to [[concepts/operations/oracle]].

## Variants in the wild

_(no rows: every surveyed entity records A8/PIII as `gap` in its body — defensive oracle posture is documented per venue but no incident history, post-mortem, or stress-test outcome is surfaced in primary sources. Drift's April 1 2026 incident is flagged in [[entities/perpdex/drift]] as out-of-snapshot pending first-party post-mortem mirror.)_

## Edge cases
- Defensive design vs incident history are distinct concerns. Hyperliquid's stake-weighted Robust Price Indices (median-of-three with EMA bands)[^hl-docs-2026-04-27-trading-robust-price-indices], Lighter's 8-min EMA on price1 (explicitly designed to force prolonged manipulation effort)[^lighter-docs-2026-04-28-trading-fair-price-marking], dYdX's vote-extension `min_exchanges` + `min_price_change_ppm` limits, and Drift's ≥50% deviation block are pre-incident posture, not stress-test results.
- Drift's bug-bounty scope explicitly excludes "oracle data issues (except manipulation attacks)"[^drift-sdk-docs-2026-04-28-program-security] — i.e. oracle-source quality is treated as third-party, oracle-manipulation against the protocol's own logic is in-scope.
- dYdX has a chain-outage propagation guard: 5+ minute chain outage triggers 50-block transfer/withdrawal gate[^dydx-docs-2026-04-28-concepts-trading-limits-withdrawal-limits], coupling consensus-liveness failure to oracle-staleness handling.

## Disputed claims
None.

## Related
[[concepts/operations/oracle]] . [[concepts/security/audit-cadence-and-scope]] . [[concepts/security/incident-response-sla]]

## Sources
[^hl-docs-2026-04-27-trading-robust-price-indices]: [[sources/hl-docs-2026-04-27-trading-robust-price-indices]]
[^lighter-docs-2026-04-28-trading-fair-price-marking]: [[sources/lighter-docs-2026-04-28-trading-fair-price-marking]]
[^drift-sdk-docs-2026-04-28-program-security]: [[sources/drift-sdk-docs-2026-04-28-program-security]]
[^dydx-docs-2026-04-28-concepts-trading-limits-withdrawal-limits]: [[sources/dydx-docs-2026-04-28-concepts-trading-limits-withdrawal-limits]]
