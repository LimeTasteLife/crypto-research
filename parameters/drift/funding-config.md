---
type: parameter
entity: [[drift]]
parameter: funding-config
unit: percent
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: false
---

# Drift funding config

## Current (as of 2026-04-28)

**Formula.** `funding_per_hour = 1/24 * (mark_twap - oracle_twap) / oracle_twap`[^drift-docs-2026-04-28-protocol-trading-perpetuals-funding-rates].

**Mark TWAP.** `(bid_twap + ask_twap) / 2`; TWAPs are EMAs with span = 1 hour[^drift-docs-2026-04-28-protocol-trading-perpetuals-funding-rates].

**Settlement frequency.** End of hour[^drift-docs-2026-04-28-protocol-trading-perpetuals-funding-rates].

**Per-tier clamps (hourly magnitude):**

| contract tier | hourly clamp |
|---|---|
| B+ (A and B) | 0.125% |
| C | 0.208% |
| Below C (Speculative, Highly Speculative) | 0.4167% |

[^drift-docs-2026-04-28-protocol-trading-perpetuals-funding-rates]

**20-minute update window.** If no market trades or funding update calls occur within the first ~20 minutes of the hour, the next funding update is delayed by an additional hour[^drift-docs-2026-04-28-protocol-trading-perpetuals-funding-rates].

**Lazy updates.** Funding rates are updated on user actions (open/close/deposit); cumulative funding accrues to position between actions and shows as Unrealized PnL[^drift-docs-2026-04-28-protocol-trading-perpetuals-funding-rates].

**Capped Symmetric Funding.** When long-short imbalance exists, a per-market Rebate Pool covers the cost delta, capped at 2/3 of the Rebate Pool's available balance per interval[^drift-docs-2026-04-28-protocol-trading-perpetuals-funding-rates].

**Infrequent-market caveat.** Funding payments may not pay out for markets that trade infrequently[^drift-docs-2026-04-28-protocol-trading-perpetuals-funding-rates].

## Time series

| effective | formula | settlement | clamp (B+) | clamp (C) | clamp (below C) | source |
|---|---|---|---|---|---|---|
| 2026-04-28 | 1/24 * (mark_twap - oracle_twap) / oracle_twap | hourly | 0.125% | 0.208% | 0.4167% | [^drift-docs-2026-04-28-protocol-trading-perpetuals-funding-rates] |

## Tiering rules / formulae

Capped Symmetric Funding rebate pool draw = min(imbalance_cost, 2/3 * rebate_pool_balance)[^drift-docs-2026-04-28-protocol-trading-perpetuals-funding-rates].

## Disputed values
None.

## Sources
[^drift-docs-2026-04-28-protocol-trading-perpetuals-funding-rates]: [[sources/drift-docs-2026-04-28-protocol-trading-perpetuals-funding-rates]]
