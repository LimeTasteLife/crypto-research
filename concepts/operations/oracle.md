---
type: concept
domain: operations
name: Oracle
last_reviewed: 2026-04-29
disputed: false
---

# Oracle

## Definition
An oracle is the component that brings off-chain reference prices into the on-chain trading engine, feeding mark-price computation, funding-rate calculation, and liquidation triggers. See [[concepts/market-microstructure/oracle-spec]] for the per-venue configuration policy.

## Variants in the wild

| venue | oracle system | in-consensus? | source exchange set |
|---|---|---|---|
| [[entities/perpdex/hyperliquid]] | validator-published feed, stake-weighted median[^hl-docs-2026-04-27-hypercore-oracle] | yes (validator vote)[^hl-docs-2026-04-27-hypercore-oracle] | 7 CEX + HL spot[^hl-docs-2026-04-27-hypercore-oracle] |
| [[entities/perpdex/dydx]] | Slinky validator-sidecar vote extensions; proposer aggregates; block commits[^dydx-docs-2026-04-28-concepts-trading-oracle] | yes (vote-extension consensus)[^dydx-docs-2026-04-28-concepts-trading-oracle] | Binance, Bitfinex, Bitstamp, Bybit, Coinbase, crypto.com, GateIO[^dydx-docs-2026-04-28-concepts-trading-oracle] |

## Edge cases
- Adding/removing source exchanges on dYdX requires a binary upgrade (not a governance parameter change)[^dydx-docs-2026-04-28-concepts-trading-governance]

## Disputed claims
None.

## Related
[[concepts/market-microstructure/oracle-spec]] . [[concepts/market-microstructure/mark-price-formula]] . [[concepts/fee-model/funding-rate]]

## Sources
[^hl-docs-2026-04-27-hypercore-oracle]: [[sources/hl-docs-2026-04-27-hypercore-oracle]]
[^dydx-docs-2026-04-28-concepts-trading-oracle]: [[sources/dydx-docs-2026-04-28-concepts-trading-oracle]]
[^dydx-docs-2026-04-28-concepts-trading-governance]: [[sources/dydx-docs-2026-04-28-concepts-trading-governance]]
