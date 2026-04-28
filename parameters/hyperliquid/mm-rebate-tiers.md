---
type: parameter
entity: [[hyperliquid]]
parameter: mm-rebate-tiers
unit: percent
last_change: 2026-04-27
last_reviewed: 2026-04-28
disputed: false
---

# Hyperliquid MM rebate tiers

## Current (as of 2026-04-27)

Three rebate tiers based on share of platform 14-day weighted maker volume[^hl-docs-2026-04-27-trading-fees]:

| Tier | 14d weighted maker volume share | Maker fee |
|---|---|---|
| 1 | >0.5% | -0.001% |
| 2 | >1.5% | -0.002% |
| 3 | >3.0% | -0.003% |

[^hl-docs-2026-04-27-trading-fees]

## Tiering rules / formulae

Tier is determined by the maker's share of platform-wide 14d weighted maker volume — not by absolute volume. As platform volume grows, the absolute volume needed to maintain a tier scales with it.

The negative fee (rebate) is paid out continuously per trade directly to the trading wallet[^hl-docs-2026-04-27-trading-fees].

## Time series

| effective  | tier 1 (>0.5%) | tier 2 (>1.5%) | tier 3 (>3.0%) | source |
|------------|-----------------|------------------|------------------|--------|
| 2026-04-27 | -0.001% | -0.002% | -0.003% | [^hl-docs-2026-04-27-trading-fees] |

## Disputed values
None.

## Sources
[^hl-docs-2026-04-27-trading-fees]: [[sources/hl-docs-2026-04-27-trading-fees]]
