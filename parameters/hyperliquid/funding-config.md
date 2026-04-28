---
type: parameter
entity: [[hyperliquid]]
parameter: funding-config
unit: percent / time
last_change: 2026-04-27
last_reviewed: 2026-04-28
disputed: false
---

# Hyperliquid funding config

## Current (as of 2026-04-27)

| field | value |
|---|---|
| interest rate (default perps) | 0.01% per 8 hours (≈11.6% APR paid to short)[^hl-docs-2026-04-27-trading-funding] |
| premium sampling | every 5 seconds, averaged over the hour[^hl-docs-2026-04-27-trading-funding] |
| pay cadence | every hour, at 1/8 of 8h-equivalent rate[^hl-docs-2026-04-27-trading-funding] |
| funding cap | 4%/hour (asset-independent)[^hl-docs-2026-04-27-trading-funding] |
| notional reference | spot oracle price (not mark price)[^hl-docs-2026-04-27-trading-funding] |
| funding impact notional (BTC, ETH) | 20,000 USDC[^hl-docs-2026-04-27-trading-contract-specifications] |
| funding impact notional (other) | 6,000 USDC[^hl-docs-2026-04-27-trading-contract-specifications] |

## Tiering rules / formulae

**Default perps.**

```
F = average_premium + clamp(interest_rate − premium, −0.0005, 0.0005)
premium = impact_price_difference / oracle_price
impact_price_difference = avg_execution_price(impact_notional_usd) − oracle_price
```

[^hl-docs-2026-04-27-trading-funding]

**HIP-3 perps** (more responsive, deployer-configurable interest rate and multiplier):

```
premium = 0.5 * (impact_bid_px + impact_ask_px) / oracle_px − 1
```

[^hl-docs-2026-04-27-trading-funding]

**Funding payment.**

```
payment = position_size * oracle_price * funding_rate
```

[^hl-docs-2026-04-27-trading-funding]

Funding payments are peer-to-peer; the venue does not collect fees on them[^hl-docs-2026-04-27-trading-funding]. Hyperliquid notes the 4%/hour cap is "explicitly less aggressive than CEX counterparts"[^hl-docs-2026-04-27-trading-funding].

## Time series

| effective  | interest (8h) | cap (per hour) | sampling | pay period | impact notional (BTC/ETH / other) | source |
|------------|----------------|----------------|----------|------------|-----------------------------------|--------|
| 2026-04-27 | 0.01% | 4% | 5s avg over 1h | 1h | 20k / 6k USDC | [^hl-docs-2026-04-27-trading-funding][^hl-docs-2026-04-27-trading-contract-specifications] |

## Disputed values
None.

## Sources
[^hl-docs-2026-04-27-trading-funding]: [[sources/hl-docs-2026-04-27-trading-funding]]
[^hl-docs-2026-04-27-trading-contract-specifications]: [[sources/hl-docs-2026-04-27-trading-contract-specifications]]
