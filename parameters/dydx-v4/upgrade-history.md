---
type: parameter
entity: [[dydx]]
parameter: upgrade-history
unit: text
last_change: 2026-04-28
last_reviewed: 2026-04-29
disputed: false
---

# dYdX v4 upgrade-history

## Current (as of 2026-04-28)
- v5.0.0: Isolated Markets introduced; per-address subaccount cap raised from 127 to 128,000[^dydx-docs-2026-04-28-concepts-trading-isolated-markets]
- v9: Designated Proposers + OEGS (Order Entry Gateway Service); TWAP order type (OrderFlags=128)[^dydx-docs-2026-04-28-concepts-architecture-oegs][^dydx-docs-2026-04-28-concepts-trading-orders]

## Time series

| effective | version | key_changes | source |
|---|---|---|---|
| v5.0.0 | v5.0.0 | Isolated Markets, subaccount cap 127->128,000 | [^dydx-docs-2026-04-28-concepts-trading-isolated-markets] |
| v9 | v9 | Designated Proposers, OEGS gateway, TWAP order type | [^dydx-docs-2026-04-28-concepts-architecture-oegs][^dydx-docs-2026-04-28-concepts-trading-orders] |

## Tiering rules / formulae
N/A.

## Disputed values
None.

## Sources
[^dydx-docs-2026-04-28-concepts-trading-isolated-markets]: [[sources/dydx-docs-2026-04-28-concepts-trading-isolated-markets]]
[^dydx-docs-2026-04-28-concepts-architecture-oegs]: [[sources/dydx-docs-2026-04-28-concepts-architecture-oegs]]
[^dydx-docs-2026-04-28-concepts-trading-orders]: [[sources/dydx-docs-2026-04-28-concepts-trading-orders]]
