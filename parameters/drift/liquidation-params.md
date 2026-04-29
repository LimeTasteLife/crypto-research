---
type: parameter
entity: [[drift]]
parameter: liquidation-params
unit: mixed
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: false
---

# Drift liquidation params

## Current (as of 2026-04-28)

**Partial liquidation.** Drift uses partial liquidation with a slot-based pacing window (default 25 slots)[^drift-docs-2026-04-28-protocol-trading-liquidations-liquidation-engine]. If price keeps moving against the user, liquidation accelerates; if price improves, it decelerates[^drift-docs-2026-04-28-protocol-trading-liquidations-liquidation-engine].

**Margin buffer.** Liquidated accounts are left slightly behind a safe margin buffer rather than right at maintenance margin, reducing immediate re-liquidation risk[^drift-docs-2026-04-28-protocol-trading-liquidations-liquidation-engine].

**Oracle-anchored.** Liquidations reference the oracle price, NOT mark price[^drift-docs-2026-04-28-protocol-trading-liquidations-liquidation-engine].

**Oracle TWAP deviation block.** If current oracle deviates >=50% from the 5-minute oracle TWAP, liquidations are temporarily blocked to wait for additional oracle confirmation[^drift-docs-2026-04-28-protocol-trading-liquidations-liquidation-engine].

**Bankruptcy waterfall (perp).** External Insurance Fund (USDC) covers debt up to per-market limit -> vAMM lifetime profit (internal insurance) covers remainder -> socialized loss applies pro rata across all open positions in that market[^drift-docs-2026-04-28-protocol-trading-liquidations-liquidation-engine].

**PositionFlag enum.** IsolatedPosition = 1, BeingLiquidated = 2, Bankruptcy = 4[^drift-sdk-docs-2026-04-28-concepts-positions].

## Time series

| effective | pacing window | oracle ref | deviation block threshold | source |
|---|---|---|---|---|
| 2026-04-28 | 25 slots | oracle price (not mark) | >=50% from 5min TWAP | [^drift-docs-2026-04-28-protocol-trading-liquidations-liquidation-engine] |

## Disputed values
None.

## Sources
[^drift-docs-2026-04-28-protocol-trading-liquidations-liquidation-engine]: [[sources/drift-docs-2026-04-28-protocol-trading-liquidations-liquidation-engine]]
[^drift-sdk-docs-2026-04-28-concepts-positions]: [[sources/drift-sdk-docs-2026-04-28-concepts-positions]]
