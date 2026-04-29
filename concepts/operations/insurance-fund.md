---
type: concept
domain: operations
name: Insurance fund
last_reviewed: 2026-04-29
disputed: false
---

# Insurance fund

## Definition
An insurance fund is the venue's capital reserve that absorbs losses when a liquidated position cannot be closed at or above the bankruptcy price. It sits between book liquidation and ADL in the contract-loss waterfall.

## Variants in the wild

| venue | topology | funding source | governance control |
|---|---|---|---|
| [[entities/perpdex/hyperliquid]] | single pool (HLP doubles as backstop)[^hl-docs-2026-04-27-trading-liquidations] | maintenance margin from backstop liquidations[^hl-docs-2026-04-27-trading-liquidations] | not surfaced |
| [[entities/perpdex/dydx]] | single cross-margin IF + per-isolated-market segregated IF[^dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism] | 100% of liquidation penalty (default 1.5%)[^dydx-docs-2026-04-28-concepts-trading-liquidations] | governance can send out; anyone can send in[^dydx-docs-2026-04-28-concepts-trading-governance] |

## Edge cases
- dYdX IF is bypassed once account value turns negative -- deleveraging fires immediately[^dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism]

## Disputed claims
None.

## Related
[[concepts/risk/liquidation]] . [[concepts/risk/adl-waterfall]] . [[concepts/risk/insurance-fund-sizing]]

## Sources
[^hl-docs-2026-04-27-trading-liquidations]: [[sources/hl-docs-2026-04-27-trading-liquidations]]
[^dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism]: [[sources/dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism]]
[^dydx-docs-2026-04-28-concepts-trading-liquidations]: [[sources/dydx-docs-2026-04-28-concepts-trading-liquidations]]
[^dydx-docs-2026-04-28-concepts-trading-governance]: [[sources/dydx-docs-2026-04-28-concepts-trading-governance]]
