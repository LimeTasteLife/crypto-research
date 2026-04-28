---
type: concept
domain: metrics
name: Volume
last_reviewed: 2026-04-28
disputed: false
---

# Volume

## Definition
Volume is the notional value of trades executed on the venue over a time window. As a metric it is most useful in **rolling-window form** for fee-tier eligibility and as a proxy for liquidity demand. Counter-quality KPIs (organic-volume share, depth-time persistence, markout-adjusted PnL) should accompany any volume figure.

## Mechanism on Hyperliquid

**Throughput claim.** HyperCore mainnet supports approximately 200k orders per second; the bottleneck is execution, not consensus or networking[^hl-docs-2026-04-27-hyperliquid-docs][^hl-docs-2026-04-27-hypercore-overview].

**Volume → fee tier.** User fee tiers are computed from a 14-day rolling weighted volume: `14d_weighted = 14d_perps + 2 * 14d_spot`[^hl-docs-2026-04-27-trading-fees]. See [[parameters/hyperliquid/fee-schedule]] for tier thresholds.

## Variants in the wild

| venue | reported throughput | tier window | spot weighting |
|---|---|---|---|
| [[entities/perpdex/hyperliquid]] | ~200k orders/sec mainnet[^hl-docs-2026-04-27-hypercore-overview] | 14-day rolling[^hl-docs-2026-04-27-trading-fees] | spot counts 2× toward perps tier[^hl-docs-2026-04-27-trading-fees] |
| [[entities/perpdex/aster]] | Aster Chain L1 target ≥100,000 TPS / 50ms block latency (matching-engine throughput in trades/sec not surfaced)[^aster-docs-2026-04-28-overview-what-is-aster] | 14-day rolling for MM tier qualification (MM1 ≥$150M, MM2 ≥$300M, MM3 ≥$600M, or 0.25%/0.5%/1% maker share)[^aster-docs-2026-04-28-trading-perpetuals-market-maker-program] | not surfaced (primary docs) — Aster runs an order-book Spot product but no documented spot-volume → perp-tier weighting[^aster-docs-2026-04-28-overview-what-is-aster] |

(Other perpdex venues to be added in subsequent ingest passes.)

## Disputed claims
None.

## Related
[[parameters/hyperliquid/fee-schedule]] · [[concepts/metrics/mm-uptime]]

## Sources
[^hl-docs-2026-04-27-hypercore-overview]: [[sources/hl-docs-2026-04-27-hypercore-overview]]
[^hl-docs-2026-04-27-hyperliquid-docs]: [[sources/hl-docs-2026-04-27-hyperliquid-docs]]
[^hl-docs-2026-04-27-trading-fees]: [[sources/hl-docs-2026-04-27-trading-fees]]
[^aster-docs-2026-04-28-overview-what-is-aster]: [[sources/aster-docs-2026-04-28-overview-what-is-aster]]
[^aster-docs-2026-04-28-trading-perpetuals-market-maker-program]: [[sources/aster-docs-2026-04-28-trading-perpetuals-market-maker-program]]
