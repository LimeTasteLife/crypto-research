---
type: parameter
entity: [[entities/perpdex/orderly]]
parameter: funding-config
unit: percent
last_change: 2026-04-29
last_reviewed: 2026-04-28
disputed: false
---

# Orderly funding-config

## Current (as of 2026-04-29)
- Piecewise linear funding function with 3 slope regions before clamping[^orderly-docs-2026-04-29-funding-rate]:
  - Low: abs(premium) < 0.5% → slope 1x
  - Medium: 0.5% ≤ abs(premium) < 1.5% → slope 2x
  - Large: abs(premium) ≥ 1.5% → slope 4x
- Premium sampled every 15 seconds using Impact Bid/Ask (1,000 USDC collateral at max leverage)[^orderly-docs-2026-04-29-funding-rate]
- Interest Rate fixed at 0.01% for most markets (USDC interest 0.06%, asset interest 0.03%)[^orderly-docs-2026-04-29-funding-rate]
- Final: Funding Rate = clamp[FundingFunction(AvgPremium) + clamp(IR - AvgPremium, cap_ir, floor_ir) / (8/N), CapFunding, FloorFunding][^orderly-docs-2026-04-29-funding-rate]
- Per-market intervals: 1h, 4h, or 8h[^orderly-docs-2026-04-29-funding-rate]
- Orderly may adjust Cap/Floor in extreme conditions[^orderly-docs-2026-04-29-funding-rate]

## Time series

| effective | market | interval | cap_funding | floor_funding | interest_rate | source |
|-----------|--------|----------|-------------|---------------|---------------|--------|
| 2026-04-29 | BTC | 8h | 0.30% | -0.30% | 0.01% | [^orderly-docs-2026-04-29-funding-rate] |
| 2026-04-29 | ETH | 8h | 0.30% | -0.30% | 0.01% | [^orderly-docs-2026-04-29-funding-rate] |
| 2026-04-29 | SOL | 8h | 0.375% | -0.375% | 0.01% | [^orderly-docs-2026-04-29-funding-rate] |
| 2026-04-29 | Most alts | 4h or 8h | 2.00% | -2.00% | 0.005-0.01% | [^orderly-docs-2026-04-29-funding-rate] |
| 2026-04-29 | RWA (GOOGL, TSLA, NVDA, XAU, XAG, SPX500, NAS100) | 4-8h | 0.30% | -0.30% | 0.01% | [^orderly-docs-2026-04-29-funding-rate] |

## Disputed values
None.

## Sources
[^orderly-docs-2026-04-29-funding-rate]: [[sources/orderly-docs-2026-04-29-funding-rate]]
