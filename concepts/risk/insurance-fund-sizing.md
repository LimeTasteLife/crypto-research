---
type: concept
domain: risk
name: Insurance fund sizing
last_reviewed: 2026-04-28
disputed: false
---

# Insurance fund sizing

## Definition
Insurance fund sizing determines the capital base, coverage scope, and replenishment mechanism of a venue's solvency backstop that absorbs losses from bankrupt positions before socialized loss applies to surviving counterparties[^drift-docs-2026-04-28-protocol-insurance-fund].

## Variants in the wild

| venue | model | current value | notes |
|---|---|---|---|
| [[entities/perpdex/drift]] | multi-asset (USDC / BTC / ETH / SOL) + per-market isolated IF + DRIFT Safety Module | per-asset IF covers same-denomination liabilities; isolated IF for speculative markets; DSM is DRIFT-staked backstop with asset-isolated slashing[^drift-docs-2026-04-28-protocol-insurance-fund][^drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module] | perp bankruptcy waterfall: external IF -> vAMM lifetime profit -> socialized loss pro rata; spot covered in full; perp up to per-market limit; 13-day unstake cooldown; 80% utilization gate[^drift-docs-2026-04-28-protocol-insurance-fund-staking][^drift-docs-2026-04-28-protocol-trading-liquidations-liquidation-engine] |

## Edge cases
- Speculative and Highly Speculative tier markets on Drift explicitly cannot draw from the standard Insurance Fund -- they rely solely on the per-market fee pool, structurally elevating ADL probability.
- Multi-asset IF isolation means a shortfall in SOL cannot be covered by the USDC pool.

## Disputed claims
None.

## Related
[[concepts/risk/liquidation]] . [[concepts/risk/adl-waterfall]] . [[parameters/drift/insurance-fund]]

## Sources
[^drift-docs-2026-04-28-protocol-insurance-fund]: [[sources/drift-docs-2026-04-28-protocol-insurance-fund]]
[^drift-docs-2026-04-28-protocol-insurance-fund-staking]: [[sources/drift-docs-2026-04-28-protocol-insurance-fund-staking]]
[^drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module]: [[sources/drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module]]
[^drift-docs-2026-04-28-protocol-trading-liquidations-liquidation-engine]: [[sources/drift-docs-2026-04-28-protocol-trading-liquidations-liquidation-engine]]
