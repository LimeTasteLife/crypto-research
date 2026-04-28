---
type: parameter
entity: [[entities/perpdex/lighter]]
parameter: oracle-config
unit: n/a
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: false
---

# Lighter oracle config

## Current (as of 2026-04-28)

**Mark price formula.** Lighter's mark price is the median of three components[^lighter-docs-2026-04-28-trading-fair-price-marking]:

1. **Impact Price** = `(Impact Bid Price + Impact Ask Price) / 2`[^lighter-docs-2026-04-28-trading-fair-price-marking]
   - Impact Notional Amount = `500 USDC / Initial Margin Fraction`[^lighter-docs-2026-04-28-trading-fair-price-marking]
   - Impact Bid Price: average execution price for a market sell of the impact notional[^lighter-docs-2026-04-28-trading-fair-price-marking]
   - Impact Ask Price: average execution price for a market buy of the impact notional[^lighter-docs-2026-04-28-trading-fair-price-marking]

2. **price1** = `index + EMA_8min(clamp(ImpactPrice − index, −index/200, +index/200))`[^lighter-docs-2026-04-28-trading-fair-price-marking]
   - Clamp limits the (ImpactPrice − index) input to ±0.5% of the index price[^lighter-docs-2026-04-28-trading-fair-price-marking]
   - EMA_8min: Exponential Moving Average over 8 minutes[^lighter-docs-2026-04-28-trading-fair-price-marking]
   - Equivalent to: Index Price + Lighter Perpetual Premium, where the premium is capped at ±0.5% of index[^lighter-docs-2026-04-28-trading-fair-price-marking]

3. **price2** = `median(cexPrices)`, where cexPrices are mark prices from different centralized exchanges[^lighter-docs-2026-04-28-trading-fair-price-marking]

`Mark Price = Median(ImpactPrice, price1, price2)`[^lighter-docs-2026-04-28-trading-fair-price-marking]

**Index oracle sources.** Lighter uses a combination of Chainlink, Stork, and Pyth oracles to determine the index price[^lighter-docs-2026-04-28-trading-fair-price-marking].

**Design rationale.**
- Incorporating impact price directly ensures liquidations execute close to mark[^lighter-docs-2026-04-28-trading-fair-price-marking].
- The 8-minute EMA forces sustained manipulation (an attacker must maintain book-level distortion over a prolonged period) to move mark[^lighter-docs-2026-04-28-trading-fair-price-marking].
- The 0.5% cap ensures mark cannot exceed external references by more than 0.5%[^lighter-docs-2026-04-28-trading-fair-price-marking].
- Taking the median of three components provides manipulation resistance against any single component[^lighter-docs-2026-04-28-trading-fair-price-marking].

**Usage.** The mark price is used for liquidation decisions and unrealized PnL calculations[^lighter-docs-2026-04-28-trading-fair-price-marking].

## Time series

| effective | index sources | impact notional | EMA window | premium clamp | mark formula | source |
|---|---|---|---|---|---|---|
| 2026-04-28 | Chainlink + Stork + Pyth | 500 USDC / IMF | 8 minutes | ±0.5% | Median(ImpactPrice, price1, price2) | [^lighter-docs-2026-04-28-trading-fair-price-marking] |

## Tiering rules / formulae

**Mark Price:**
`Mark Price = Median(ImpactPrice, price1, price2)`[^lighter-docs-2026-04-28-trading-fair-price-marking]

**price1:**
`price1 = index + EMA_8min(clamp(ImpactPrice − index, −index/200, +index/200))`[^lighter-docs-2026-04-28-trading-fair-price-marking]

**Impact Notional:**
`ImpactNotional = 500 USDC / InitialMarginFraction`[^lighter-docs-2026-04-28-trading-fair-price-marking]

## Disputed values
None.

## Sources
[^lighter-docs-2026-04-28-trading-fair-price-marking]: [[sources/lighter-docs-2026-04-28-trading-fair-price-marking]]
