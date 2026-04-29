---
type: parameter
entity: [[entities/perpdex/orderly]]
parameter: listing-policy
unit: mixed
last_change: 2026-04-29
last_reviewed: 2026-04-28
disputed: false
---

# Orderly listing-policy

## Current (as of 2026-04-29)

### Standard Listing
- Evaluated and approved by Orderly[^orderly-docs-2026-04-29-permissionless-listing]
- Requires 3+ price oracles from supported CEX sources: Binance, OKX, Bybit, Bitget, BingX, Gate.io, Kucoin, HTX, MEXC, WOO X[^orderly-listing-2026-04-29-listing]
- Market cap: $20M+[^orderly-listing-2026-04-29-listing]
- Liquidity requirements: ±2% depth ≥$20K, ≥15 levels, spread ≤50 bps, uptime ≥90%[^orderly-listing-2026-04-29-listing]
- Shared platform Insurance Fund; standardized risk parameters[^orderly-docs-2026-04-29-permissionless-listing]

### Permissionless Listing
- Available to Diamond Tier Builders ($10B monthly volume or 7M $ORDER staked)[^orderly-docs-2026-04-29-permissionless-listing]
- Up to 5 active markets per Builder (adjustable by Orderly)[^orderly-docs-2026-04-29-permissionless-listing]
- Instant and self-managed; no Orderly approval required[^orderly-docs-2026-04-29-permissionless-listing]
- Customizable risk parameters; Builder takes direct responsibility[^orderly-docs-2026-04-29-permissionless-listing]
- Dedicated per-Builder Insurance Fund ($50k/symbol minimum)[^orderly-docs-2026-04-29-permissionless-listing]
- All community-listed markets are Isolated Margin only[^orderly-docs-2026-04-29-permissionless-listing]
- Multiple Builders can list same underlying asset independently (separate books, IFs, risk params)[^orderly-docs-2026-04-29-permissionless-listing]

### Controlled launch sequence (permissionless)
1. POST_ONLY — only limit orders; MMs build liquidity[^orderly-docs-2026-04-29-permissionless-listing]
2. ACTIVE — once ±2% depth reaches $100,000 both sides and holds 10 minutes[^orderly-docs-2026-04-29-permissionless-listing]

### Circuit breakers
- Insufficient depth, low IF, or funding rate anomalies → REDUCE_ONLY mode or delisting[^orderly-docs-2026-04-29-permissionless-listing]
- Per-market, not platform-wide[^orderly-docs-2026-04-29-permissionless-listing]

### Fee revenue for listing builders
- 50% of trading fees + 100% of liquidation fees from their listed markets[^orderly-docs-2026-04-29-trading-fees]

## Time series

| effective | parameter | value | source |
|-----------|-----------|-------|--------|
| 2026-04-29 | Diamond Tier volume req | ≥$10B/30d | [^orderly-docs-2026-04-29-permissionless-listing] |
| 2026-04-29 | Diamond Tier staking req | 7M $ORDER | [^orderly-docs-2026-04-29-permissionless-listing] |
| 2026-04-29 | Max markets per Builder | 5 | [^orderly-docs-2026-04-29-permissionless-listing] |
| 2026-04-29 | IF minimum per symbol | $50,000 | [^orderly-docs-2026-04-29-permissionless-listing] |
| 2026-04-29 | POST_ONLY→ACTIVE depth gate | $100K ±2% both sides × 10 min | [^orderly-docs-2026-04-29-permissionless-listing] |
| 2026-04-29 | Standard listing mcap req | $20M+ | [^orderly-listing-2026-04-29-listing] |
| 2026-04-29 | Standard listing oracle req | 3+ CEX sources | [^orderly-listing-2026-04-29-listing] |

## Disputed values
None.

## Sources
[^orderly-docs-2026-04-29-permissionless-listing]: [[sources/orderly-docs-2026-04-29-permissionless-listing]]
[^orderly-docs-2026-04-29-trading-fees]: [[sources/orderly-docs-2026-04-29-trading-fees]]
[^orderly-listing-2026-04-29-listing]: [[sources/orderly-listing-2026-04-29-listing]]
