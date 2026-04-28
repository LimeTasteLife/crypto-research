---
type: parameter
entity: [[hyperliquid]]
parameter: oracle-config
unit: weight
last_change: 2026-04-27
last_reviewed: 2026-04-28
disputed: false
---

# Hyperliquid oracle config

## Current (as of 2026-04-27)

**Source weights** (CEX spot mids feeding the per-perp oracle):

| source | weight |
|---|---|
| Binance | 3 |
| OKX | 2 |
| Bybit | 2 |
| Kraken | 1 |
| Kucoin | 1 |
| Gate | 1 |
| MEXC | 1 |
| Hyperliquid spot | 1 |

[^hl-docs-2026-04-27-hypercore-oracle]

**Aggregation.** Stake-weighted median across validator submissions yields the final oracle price[^hl-docs-2026-04-27-hypercore-oracle].

**Update cadence.** Validators publish per-perp spot prices every 3 seconds[^hl-docs-2026-04-27-hypercore-oracle].

## Tiering rules / formulae

**Adaptive source exclusion** (per-asset overrides):
- Assets with primary spot liquidity on Hyperliquid (e.g. HYPE) **exclude external CEX sources** until external liquidity reaches threshold[^hl-docs-2026-04-27-hypercore-oracle].
- Assets with primary spot liquidity off-Hyperliquid (e.g. BTC) **exclude Hyperliquid spot**[^hl-docs-2026-04-27-hypercore-oracle].

## Time series

| effective  | weight scheme | aggregation | cadence | source |
|------------|----------------|---------------|---------|--------|
| 2026-04-27 | Binance 3 / OKX 2 / Bybit 2 / Kraken 1 / Kucoin 1 / Gate 1 / MEXC 1 / HL spot 1 | stake-weighted median across validators | 3s | [^hl-docs-2026-04-27-hypercore-oracle] |

## Disputed values
None.

## Sources
[^hl-docs-2026-04-27-hypercore-oracle]: [[sources/hl-docs-2026-04-27-hypercore-oracle]]
