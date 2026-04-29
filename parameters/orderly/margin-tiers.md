---
type: parameter
entity: [[entities/perpdex/orderly]]
parameter: margin-tiers
unit: percent
last_change: 2026-04-29
last_reviewed: 2026-04-28
disputed: false
---

# Orderly margin-tiers

## Current (as of 2026-04-29)
- IMR formula: IMR_i = Max(1/MaxAccountLeverage, BaseIMR_i, IMRFactor_i × |PositionNotional_i|^(4/5))[^orderly-docs-2026-04-29-margin-leverage-pnl]
- MMR formula: MMR_i = Max(BaseMMR_i, BaseMMR_i/BaseIMR_i × IMRFactor_i × |PositionNotional_i|^(4/5))[^orderly-docs-2026-04-29-margin-leverage-pnl]
- Max leverage = 1 / Base IMR[^orderly-docs-2026-04-29-margin-leverage-pnl]
- Two margin modes simultaneously: Cross (default, shared balance) and Isolated (per-position); mode specified per order[^orderly-docs-2026-04-29-isolated-margin]
- Independent leverage per symbol per mode; can hold both on same symbol[^orderly-docs-2026-04-29-isolated-margin]
- Max notional: BTC/ETH $5M, Alts $2M[^orderly-docs-2026-04-29-margin-leverage-pnl]

## Time series

| effective | market | base_imr | max_leverage | base_mmr | imr_factor | source |
|-----------|--------|----------|--------------|----------|------------|--------|
| 2026-04-29 | BTC-PERP | 1% | 100x | 0.6% | 0.0000000910 | [^orderly-docs-2026-04-29-margin-leverage-pnl] |
| 2026-04-29 | ETH-PERP | 1% | 100x | 0.6% | 0.0000001724 | [^orderly-docs-2026-04-29-margin-leverage-pnl] |
| 2026-04-29 | SOL-PERP | 1% | 100x | 0.6% | 0.0000010667 | [^orderly-docs-2026-04-29-margin-leverage-pnl] |
| 2026-04-29 | SUI-PERP | 5% | 20x | 2.5% | 0.0000028100 | [^orderly-docs-2026-04-29-margin-leverage-pnl] |
| 2026-04-29 | HYPE-PERP | 5% | 20x | 2.5% | 0.0000028100 | [^orderly-docs-2026-04-29-margin-leverage-pnl] |
| 2026-04-29 | ARB-PERP | 10% | 10x | 5% | 0.0000021481 | [^orderly-docs-2026-04-29-margin-leverage-pnl] |
| 2026-04-29 | ORDER-PERP | 10% | 10x | 5% | 0.0000092820 | [^orderly-docs-2026-04-29-margin-leverage-pnl] |
| 2026-04-29 | SPX500-PERP | 5% | 20x | 2.5% | ~0 | [^orderly-docs-2026-04-29-margin-leverage-pnl] |
| 2026-04-29 | NAS100-PERP | 5% | 20x | 2.5% | ~0 | [^orderly-docs-2026-04-29-margin-leverage-pnl] |
| 2026-04-29 | XAU-PERP | 5% | 20x | 2.5% | ~0 | [^orderly-docs-2026-04-29-margin-leverage-pnl] |
| 2026-04-29 | GOOGL-PERP | 5% | 20x | 2.5% | ~0 | [^orderly-docs-2026-04-29-margin-leverage-pnl] |
| 2026-04-29 | TSLA-PERP | 5% | 20x | 2.5% | ~0 | [^orderly-docs-2026-04-29-margin-leverage-pnl] |
| 2026-04-29 | NVDA-PERP | 5% | 20x | 2.5% | ~0 | [^orderly-docs-2026-04-29-margin-leverage-pnl] |
| 2026-04-29 | IP-PERP | 20% | 5x | 10% | 0.0000073100 | [^orderly-docs-2026-04-29-margin-leverage-pnl] |

## Disputed values
None.

## Sources
[^orderly-docs-2026-04-29-margin-leverage-pnl]: [[sources/orderly-docs-2026-04-29-margin-leverage-pnl]]
[^orderly-docs-2026-04-29-isolated-margin]: [[sources/orderly-docs-2026-04-29-isolated-margin]]
