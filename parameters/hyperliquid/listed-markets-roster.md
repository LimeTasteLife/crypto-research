---
type: parameter
entity: [[hyperliquid]]
parameter: listed-markets-roster
unit: spec-mixed
last_change: 2026-04-27
last_reviewed: 2026-04-28
disputed: false
---

# Hyperliquid listed-markets roster

## Current (as of 2026-04-27)

**Aggregate spec** (applies across listed perps unless per-symbol override):

| field | value |
|---|---|
| product type | linear perp, no expiry, funding-converged[^hl-docs-2026-04-27-trading-contract-specifications] |
| default margining | USDC-collateralized, USDT-denominated linear (technically quanto since no USDC/USDT conversion)[^hl-docs-2026-04-27-trading-contract-specifications] |
| USDC-denominated exceptions | PURR-USD, HYPE-USD (primary spot liquidity on HL)[^hl-docs-2026-04-27-trading-contract-specifications] |
| contract size | 1 unit underlying[^hl-docs-2026-04-27-trading-contract-specifications] |
| funding period | 1 hour[^hl-docs-2026-04-27-trading-contract-specifications] |
| funding impact notional | 20,000 USDC for BTC/ETH; 6,000 USDC for others[^hl-docs-2026-04-27-trading-contract-specifications] |
| max leverage | 3x – 40x per asset[^hl-docs-2026-04-27-trading-liquidations] |
| global per-user position limit | none[^hl-docs-2026-04-27-trading-contract-specifications] |

**Maximum order values by max-leverage tier:**

| max leverage | max market order | max limit order |
|---|---|---|
| ≥25x | $30M | $300M (10×)[^hl-docs-2026-04-27-trading-contract-specifications] |
| [20, 25) | $5M | $50M[^hl-docs-2026-04-27-trading-contract-specifications] |
| [10, 20) | $2M | $20M[^hl-docs-2026-04-27-trading-contract-specifications] |
| <10x | $500k | $5M[^hl-docs-2026-04-27-trading-contract-specifications] |

## Tiering rules / formulae

Per-symbol contract spec time-series (tick size, lot size, max leverage, OI cap, mark price formula override, IM/MM, oracle config) is intended to live in `parameters/hyperliquid/markets/<symbol>.md` per AGENTS.md schema. Not yet populated — current crawl page provides aggregate spec only, not per-symbol detail.

## Time series

| effective  | product type | max leverage range | global pos limit | source |
|------------|---------------|----------------------|------------------|--------|
| 2026-04-27 | linear perp, no expiry | 3x – 40x | none | [^hl-docs-2026-04-27-trading-contract-specifications][^hl-docs-2026-04-27-trading-liquidations] |

## Disputed values
None.

## Sources
[^hl-docs-2026-04-27-trading-contract-specifications]: [[sources/hl-docs-2026-04-27-trading-contract-specifications]]
[^hl-docs-2026-04-27-trading-liquidations]: [[sources/hl-docs-2026-04-27-trading-liquidations]]
