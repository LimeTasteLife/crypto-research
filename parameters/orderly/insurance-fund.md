---
type: parameter
entity: [[entities/perpdex/orderly]]
parameter: insurance-fund
unit: USDC
last_change: 2026-04-29
last_reviewed: 2026-04-28
disputed: false
---

# Orderly insurance-fund

## Current (as of 2026-04-29)
- Insurance Fund absorbs bad debt when trader losses exceed collateral[^orderly-docs-2026-04-29-insurance-fund-and-adl]
- Funded by collecting a portion of liquidation fees[^orderly-docs-2026-04-29-insurance-fund-and-adl]
- Key parameters: min_insurance_fund_margin_ratio (maintenance margin for IF) and min_margin_ratio_solvency (absolute floor)[^orderly-docs-2026-04-29-insurance-fund-and-adl]
- If remaining margin too low for minimum liquidator fee: all positions + USDC transferred to IF; liquidators can claim from IF at discount[^orderly-docs-2026-04-29-insurance-fund-and-adl]

## Topology
- **Platform IF (standard markets):** Shared across all standard-listed markets[^orderly-docs-2026-04-29-permissionless-listing]
- **Per-Builder IF (permissionless markets):** Dedicated per Builder, minimum $50,000 per active symbol (e.g., 3 markets = $150,000 minimum)[^orderly-docs-2026-04-29-permissionless-listing]
- Per-Builder IFs are completely separate from platform IF and from other Builders' IFs[^orderly-docs-2026-04-29-permissionless-listing]
- If Builder IF depleted: ADL scoped to that specific market only; no cross-market impact[^orderly-docs-2026-04-29-insurance-fund-and-adl]
- If Builder IF drops too low: system restricts trading or triggers delisting[^orderly-docs-2026-04-29-permissionless-listing]

## Time series

| effective | parameter | value | source |
|-----------|-----------|-------|--------|
| 2026-04-29 | per-Builder IF minimum per symbol | $50,000 | [^orderly-docs-2026-04-29-permissionless-listing] |

## Disputed values
None.

## Sources
[^orderly-docs-2026-04-29-insurance-fund-and-adl]: [[sources/orderly-docs-2026-04-29-insurance-fund-and-adl]]
[^orderly-docs-2026-04-29-permissionless-listing]: [[sources/orderly-docs-2026-04-29-permissionless-listing]]
