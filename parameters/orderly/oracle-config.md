---
type: parameter
entity: [[entities/perpdex/orderly]]
parameter: oracle-config
unit: mixed
last_change: 2026-04-29
last_reviewed: 2026-04-28
disputed: false
---

# Orderly oracle-config

## Current (as of 2026-04-29)
- Index prices aggregated from CEX feeds and on-chain oracles[^orderly-docs-2026-04-29-permissionless-listing]
- Supported on-chain oracles: Pyth and Stork[^orderly-docs-2026-04-29-permissionless-listing]
- Supported CEX feed sources (for standard listing): Binance, OKX, Bybit, Bitget, BingX, Gate.io, Kucoin, HTX, MEXC, WOO X[^orderly-listing-2026-04-29-listing]
- If all price sources unavailable for a market: market placed into reduce-only mode[^orderly-docs-2026-04-29-permissionless-listing]
- Standard listing requires 3+ price oracles from supported sources[^orderly-listing-2026-04-29-listing]

## Time series

| effective | parameter | value | source |
|-----------|-----------|-------|--------|
| 2026-04-29 | On-chain oracle providers | Pyth, Stork | [^orderly-docs-2026-04-29-permissionless-listing] |
| 2026-04-29 | CEX feed providers | Binance, OKX, Bybit, Bitget, BingX, Gate.io, Kucoin, HTX, MEXC, WOO X | [^orderly-listing-2026-04-29-listing] |
| 2026-04-29 | Min oracle sources (standard listing) | 3+ | [^orderly-listing-2026-04-29-listing] |
| 2026-04-29 | All-source-unavailable fallback | reduce-only mode | [^orderly-docs-2026-04-29-permissionless-listing] |

## Disputed values
None.

## Sources
[^orderly-docs-2026-04-29-permissionless-listing]: [[sources/orderly-docs-2026-04-29-permissionless-listing]]
[^orderly-listing-2026-04-29-listing]: [[sources/orderly-listing-2026-04-29-listing]]
