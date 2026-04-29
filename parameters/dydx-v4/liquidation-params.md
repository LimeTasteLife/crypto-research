---
type: parameter
entity: [[dydx]]
parameter: liquidation-params
unit: mixed
last_change: 2026-04-28
last_reviewed: 2026-04-29
disputed: false
---

# dYdX v4 liquidation-params

## Current (as of 2026-04-28)
- Maximum Liquidation Penalty: 1.5% (default, governance-adjustable); 100% of the fee goes to the Insurance Fund[^dydx-docs-2026-04-28-concepts-trading-liquidations][^dydx-docs-2026-04-28-concepts-trading-governance]
- Fillable-price config: liquidation order placed at calculated Fillable Price as limit, matched against book liquidity[^dydx-docs-2026-04-28-concepts-trading-liquidations]
- Max spread from oracle for IF aggression: 1.5 x MMF (e.g. 4.5% for 3% MMF market)[^dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism]
- Max IF quantums for deleveraging: governance-adjustable[^dydx-docs-2026-04-28-concepts-trading-governance]
- Per-block liquidation caps: per-position and per-subaccount limits[^dydx-docs-2026-04-28-concepts-trading-governance]
- Negative-balance accounts trigger immediate deleveraging (IF bypassed)[^dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism]
- Liquidation price formulae: isolated `p' = (e - s*p) / (|s|*MMF - s)`; cross subtracts other-position MMR[^dydx-docs-2026-04-28-concepts-trading-liquidations]
- Actual close price = maker-side fill (can be better than fillable-price limit)[^dydx-docs-2026-04-28-concepts-trading-liquidations]

## Time series

| effective | max_liq_penalty | if_share | max_spread_oracle | source |
|---|---|---|---|---|
| 2026-04-28 (snapshot) | 1.5% | 100% | 1.5 x MMF | [^dydx-docs-2026-04-28-concepts-trading-liquidations][^dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism] |

## Tiering rules / formulae
- Isolated liquidation: `p' = (e - s*p) / (|s|*MMF - s)`[^dydx-docs-2026-04-28-concepts-trading-liquidations]
- Cross liquidation: same formula minus other-position MMR[^dydx-docs-2026-04-28-concepts-trading-liquidations]

## Disputed values
None.

## Sources
[^dydx-docs-2026-04-28-concepts-trading-liquidations]: [[sources/dydx-docs-2026-04-28-concepts-trading-liquidations]]
[^dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism]: [[sources/dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism]]
[^dydx-docs-2026-04-28-concepts-trading-governance]: [[sources/dydx-docs-2026-04-28-concepts-trading-governance]]
