---
type: parameter
entity: [[dydx]]
parameter: listed-markets-roster
unit: count
last_change: 2026-04-28
last_reviewed: 2026-04-29
disputed: false
---

# dYdX v4 listed-markets-roster

## Current (as of 2026-04-28)
- Markets include both cross-margin and isolated-margin perpetuals[^dydx-docs-2026-04-28-concepts-trading-isolated-markets]
- `PerpetualParams.market_type` switch: `PERPETUAL_MARKET_TYPE_CROSS` (default, all pre-v5.0.0 markets) or `PERPETUAL_MARKET_TYPE_ISOLATED`[^dydx-docs-2026-04-28-concepts-trading-isolated-markets]
- Historical change series for per-market parameters (IMF, MMF, max-leverage, OI cap) lives on-chain -- currently a gap (G(dydx)-1)[^dydx-docs-2026-04-28-concepts-trading-margin]
- CLOB module schema represents each market as a Clob Pair (Perpetual / Spot / other)[^dydx-community-2026-04-28-modules-governance-clob]

## Time series

| effective | description | source |
|---|---|---|
| 2023-10 | Genesis markets (cross-margin only) | [^dydx-community-2026-04-28-introduction] |
| v5.0.0 | Isolated Markets introduced; `market_type` switch added | [^dydx-docs-2026-04-28-concepts-trading-isolated-markets] |

## Tiering rules / formulae
- Each market assigned to one of 8 Liquidity Tiers governing IMF/MMF/capacity[^dydx-community-2026-04-28-modules-governance-markets]

## Disputed values
None.

## Sources
[^dydx-docs-2026-04-28-concepts-trading-isolated-markets]: [[sources/dydx-docs-2026-04-28-concepts-trading-isolated-markets]]
[^dydx-community-2026-04-28-modules-governance-clob]: [[sources/dydx-community-2026-04-28-modules-governance-clob]]
[^dydx-docs-2026-04-28-concepts-trading-margin]: [[sources/dydx-docs-2026-04-28-concepts-trading-margin]]
[^dydx-community-2026-04-28-modules-governance-markets]: [[sources/dydx-community-2026-04-28-modules-governance-markets]]
[^dydx-community-2026-04-28-introduction]: [[sources/dydx-community-2026-04-28-introduction]]
