---
type: parameter
entity: [[drift]]
parameter: oracle-config
unit: mixed
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: false
---

# Drift oracle config

## Current (as of 2026-04-28)

**Default oracle.** Pyth; Switchboard supported per market; custom internal Prelaunch oracle (mark-TWAP) for markets without an external spot reference[^drift-docs-2026-04-28-protocol-trading-oracles][^drift-docs-2026-04-28-protocol-trading-market-specs].

**On-chain TWAP tracking.** Each market tracks last-seen oracle values and updates an EMA TWAP over 1hr (funding period) and 5min intervals[^drift-docs-2026-04-28-protocol-trading-oracles].

**Validity guards (five rules):**

| guard | threshold | effect |
|---|---|---|
| Stale-for-AMM | > 10 slots behind current slot | blocks AMM fills[^drift-docs-2026-04-28-protocol-trading-oracles] |
| Stale-for-Margin | > 120 slots behind current slot | blocks margin operations[^drift-docs-2026-04-28-protocol-trading-oracles] |
| InvalidPrice | any negative price field | blocks operations[^drift-docs-2026-04-28-protocol-trading-oracles] |
| TooVolatile | TWAP/price ratio out of [0.2, 5] | blocks operations[^drift-docs-2026-04-28-protocol-trading-oracles] |
| TooUncertain | confidence > 10% of price | blocks operations[^drift-docs-2026-04-28-protocol-trading-oracles] |

**Invalid-period behavior.** On-chain oracle TWAP shrinks toward mark TWAP to prevent erroneous funding magnitudes[^drift-docs-2026-04-28-protocol-trading-oracles]. May block fills, withdraws, liquidations, and funding-rate updates that would increase protocol risk[^drift-docs-2026-04-28-protocol-trading-oracles].

**MM accessor.** `getMMOracleDataForPerpMarket` returns MM-specific data including a validity flag (`isValid`) and confidence interval; bots instructed to skip fills when `oracle.isValid` is false[^drift-developers-docs-2026-04-28-developers-market-makers-jit-only].

## Time series

| effective | default oracle | guards | source |
|---|---|---|---|
| 2026-04-28 | Pyth + Switchboard + Prelaunch | Stale-AMM 10s / Stale-Margin 120s / InvalidPrice / TooVolatile [0.2,5] / TooUncertain >10% | [^drift-docs-2026-04-28-protocol-trading-oracles] |

## Disputed values
None.

## Sources
[^drift-docs-2026-04-28-protocol-trading-oracles]: [[sources/drift-docs-2026-04-28-protocol-trading-oracles]]
[^drift-docs-2026-04-28-protocol-trading-market-specs]: [[sources/drift-docs-2026-04-28-protocol-trading-market-specs]]
[^drift-developers-docs-2026-04-28-developers-market-makers-jit-only]: [[sources/drift-developers-docs-2026-04-28-developers-market-makers-jit-only]]
