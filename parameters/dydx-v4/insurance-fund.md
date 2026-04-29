---
type: parameter
entity: [[dydx-v4]]
parameter: insurance-fund
unit: USDC
last_change: 2026-04-28
last_reviewed: 2026-04-29
disputed: false
---

# dYdX v4 insurance-fund

## Current (as of 2026-04-28)
- Single cross-margin IF + per-isolated-market segregated IF[^dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism][^dydx-community-2026-04-28-modules-governance-markets]
- Receives 100% of liquidation penalty (default 1.5%)[^dydx-docs-2026-04-28-concepts-trading-liquidations]
- Governance can send funds out of IF; anyone can send funds in[^dydx-docs-2026-04-28-concepts-trading-governance]
- IF widens the liquidation order limit price up to max spread from oracle (1.5 x MMF)[^dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism]
- Once an account's value turns negative, deleveraging fires immediately -- IF is bypassed at that stage[^dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism]
- Isolated-market positions handled by that market's segregated IF; cross-market positions share a single IF[^dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism]

## Time series

| effective | topology | funding_source | source |
|---|---|---|---|
| 2026-04-28 (snapshot) | single cross + per-isolated segregated | 100% liquidation penalty | [^dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism][^dydx-docs-2026-04-28-concepts-trading-liquidations] |

## Tiering rules / formulae
- IF aggression limit: max spread from oracle = 1.5 x MMF per market[^dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism]

## Disputed values
None.

## Sources
[^dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism]: [[sources/dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism]]
[^dydx-docs-2026-04-28-concepts-trading-liquidations]: [[sources/dydx-docs-2026-04-28-concepts-trading-liquidations]]
[^dydx-docs-2026-04-28-concepts-trading-governance]: [[sources/dydx-docs-2026-04-28-concepts-trading-governance]]
[^dydx-community-2026-04-28-modules-governance-markets]: [[sources/dydx-community-2026-04-28-modules-governance-markets]]
