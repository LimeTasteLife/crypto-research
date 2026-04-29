---
type: parameter
entity: [[dydx]]
parameter: oracle-config
unit: mixed
last_change: 2026-04-28
last_reviewed: 2026-04-29
disputed: false
---

# dYdX v4 oracle-config

## Current (as of 2026-04-28)
- Oracle system: Slinky validator-sidecar vote extensions[^dydx-docs-2026-04-28-concepts-trading-oracle]
- Each validator runs a sidecar pulling from external exchanges; submits price view via vote extensions; proposer aggregates; block commits — all in-consensus[^dydx-docs-2026-04-28-concepts-trading-oracle]
- Named source exchanges: Binance, Bitfinex, Bitstamp, Bybit, Coinbase, crypto.com, GateIO[^dydx-docs-2026-04-28-concepts-trading-oracle]
- Per-market governance-adjustable parameters: `min_exchanges`, `min_price_change_ppm`, `exchange_config_json`[^dydx-community-2026-04-28-modules-governance-markets][^dydx-docs-2026-04-28-concepts-trading-governance]
- Adding/removing supported source exchanges requires a binary upgrade[^dydx-docs-2026-04-28-concepts-trading-governance]
- Rate limits: max-markets-per-block ceiling + min-price-change threshold[^dydx-docs-2026-04-28-concepts-trading-oracle]
- Oracle Price (not last-traded) drives liquidation eligibility and stop/take-profit triggers[^dydx-docs-2026-04-28-concepts-trading-liquidations]

## Time series

| effective | oracle_system | source_exchanges | source |
|---|---|---|---|
| 2026-04-28 (snapshot) | Slinky vote-extension consensus | Binance, Bitfinex, Bitstamp, Bybit, Coinbase, crypto.com, GateIO | [^dydx-docs-2026-04-28-concepts-trading-oracle] |

## Tiering rules / formulae
- Per-market parameters (`min_exchanges`, `min_price_change_ppm`) set individually via governance[^dydx-community-2026-04-28-modules-governance-markets]

## Disputed values
None.

## Sources
[^dydx-docs-2026-04-28-concepts-trading-oracle]: [[sources/dydx-docs-2026-04-28-concepts-trading-oracle]]
[^dydx-community-2026-04-28-modules-governance-markets]: [[sources/dydx-community-2026-04-28-modules-governance-markets]]
[^dydx-docs-2026-04-28-concepts-trading-governance]: [[sources/dydx-docs-2026-04-28-concepts-trading-governance]]
[^dydx-docs-2026-04-28-concepts-trading-liquidations]: [[sources/dydx-docs-2026-04-28-concepts-trading-liquidations]]
