---
type: concept
domain: risk
name: Insurance fund sizing
last_reviewed: 2026-04-29
disputed: false
---

# Insurance fund sizing

## Definition
Insurance fund sizing is the risk-management policy governing how large the insurance fund should be relative to the venue's open interest, stress slippage, and gap-move probability. A common metric is IF coverage ratio = IF / (max-OI x slippage x gap%).

## Variants in the wild

| venue | sizing policy | coverage ratio published? |
|---|---|---|
| [[entities/perpdex/hyperliquid]] | not surfaced in primary docs (gap A6/PIII) | no |
| [[entities/perpdex/dydx]] | not surfaced in primary docs; IF receives 100% of 1.5% liquidation penalty; IF aggression limited to 1.5 x MMF spread from oracle[^dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism] | no (gap A6/PIII) |

## Disputed claims
None.

## Related
[[concepts/operations/insurance-fund]] . [[concepts/risk/liquidation]] . [[concepts/risk/adl-waterfall]]

## Sources
[^dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism]: [[sources/dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism]]
