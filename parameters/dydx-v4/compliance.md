---
type: parameter
entity: [[dydx-v4]]
parameter: compliance
unit: text
last_change: 2026-04-28
last_reviewed: 2026-04-29
disputed: false
---

# dYdX v4 compliance

## Current (as of 2026-04-28)
- Blocked jurisdictions: USA, Canada, Iran, Cuba, North Korea, Syria, Myanmar (Burma), Crimea/Donetsk/Luhansk[^dydx-docs-2026-04-28-interaction-integration-compliance]
- OFAC-sanctioned parties prohibited[^dydx-docs-2026-04-28-interaction-integration-compliance]
- Third-party integrators expected to enforce client-side geo-blocking[^dydx-docs-2026-04-28-interaction-integration-compliance]
- Indexer endpoints: `/v4/geo` (IP-derived geo + `blocked` boolean), `/v4/screen/<address>` (per-address compliance status with reason + updatedAt)[^dydx-docs-2026-04-28-interaction-integration-compliance]
- Existing investor transfer restrictions enforced via contractual agreements with dYdX Foundation and dYdX Trading Inc.[^dydx-community-2026-04-28-start-here-dydx-token-allocation]

## Time series

| effective | blocked_jurisdictions | source |
|---|---|---|
| 2026-04-28 (snapshot) | USA, Canada, Iran, Cuba, North Korea, Syria, Myanmar, Crimea/Donetsk/Luhansk | [^dydx-docs-2026-04-28-interaction-integration-compliance] |

## Tiering rules / formulae
N/A.

## Disputed values
None.

## Sources
[^dydx-docs-2026-04-28-interaction-integration-compliance]: [[sources/dydx-docs-2026-04-28-interaction-integration-compliance]]
[^dydx-community-2026-04-28-start-here-dydx-token-allocation]: [[sources/dydx-community-2026-04-28-start-here-dydx-token-allocation]]
