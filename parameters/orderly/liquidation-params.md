---
type: parameter
entity: [[entities/perpdex/orderly]]
parameter: liquidation-params
unit: percent
last_change: 2026-04-29
last_reviewed: 2026-04-28
disputed: false
---

# Orderly liquidation-params

## Current (as of 2026-04-29)
- Decentralized liquidation: positions transferred to liquidators at a discount, not dumped on orderbook[^orderly-docs-2026-04-29-liquidations]
- Triggers when Account Margin Ratio < Maintenance Margin Ratio (evaluated against Mark Price)[^orderly-docs-2026-04-29-liquidations]
- System calculates minimum liquidation amount to restore AMR to IMR[^orderly-docs-2026-04-29-liquidations]
- Anyone with sufficient margin can act as liquidator[^orderly-docs-2026-04-29-liquidations]

## Time series

| effective | tier | markets | liquidation_fee | liquidator_fee | min_notional_full_takeover | source |
|-----------|------|---------|-----------------|----------------|---------------------------|--------|
| 2026-04-29 | Low | BTC, ETH | 0.60% | 0.30% | 10,000 USDC | [^orderly-docs-2026-04-29-liquidations] |
| 2026-04-29 | Low | SOL | 0.60% | 0.30% | — | [^orderly-docs-2026-04-29-liquidations] |
| 2026-04-29 | High | Others | 1.20% | 0.60% | 5,000 USDC | [^orderly-docs-2026-04-29-liquidations] |

## Fee split rules
- Plenty of margin: 50/50 between Insurance Fund and liquidator (each 0.5 × User Liquidation Fee)[^orderly-docs-2026-04-29-liquidations]
- Low margin: liquidator gets 0.5 × User Liquidation Fee, remainder to IF[^orderly-docs-2026-04-29-liquidations]
- Near zero margin: entire balance and positions transferred to Insurance Fund[^orderly-docs-2026-04-29-liquidations]

## Takeover rules
- Low-tier below 10,000 USDC notional: must take all positions[^orderly-docs-2026-04-29-liquidations]
- High-tier below 5,000 USDC notional: must take entire position[^orderly-docs-2026-04-29-liquidations]
- Above thresholds: liquidator can take a percentage[^orderly-docs-2026-04-29-liquidations]

## Disputed values
None.

## Sources
[^orderly-docs-2026-04-29-liquidations]: [[sources/orderly-docs-2026-04-29-liquidations]]
