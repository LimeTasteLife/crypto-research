---
type: concept
domain: metrics
name: MM uptime
last_reviewed: 2026-04-28
disputed: false
---

# MM uptime

## Definition
MM uptime is the fraction of a measurement window during which a market maker meets the venue's quote-obligation thresholds (depth at specified bps levels, two-sided presence, max-spread). Combined with end-to-end latency it bounds how reliable a published "MM commitment" is. Quality-side KPI for any [[parameters/hyperliquid/mm-rebate-tiers|rebate program]].

## Mechanism on Hyperliquid

**Latency floor.** End-to-end latency from a co-located client is reported at 0.2s median / 0.9s p99[^hl-docs-2026-04-27-hypercore-overview]. This is the venue-imposed lower bound on MM cancel-to-replace cadence and effectively caps how aggressively an MM can quote against fast-moving external prices.

(Public quote-obligation SLA, depth-by-time KPIs, and MM uptime measurement methodology are not surfaced in the primary docs at this snapshot.)

## Variants in the wild

| venue | latency p50 / p99 | obligation SLA published? |
|---|---|---|
| [[entities/perpdex/hyperliquid]] | 0.2s / 0.9s (co-located)[^hl-docs-2026-04-27-hypercore-overview] | not in primary docs |
| [[entities/perpdex/aster]] | not surfaced | yes — 70% of UTC-day with bid/offer ≥ minimum size, spread ≤ pair cap (0.10% BTC/ETH/SOL, 0.25% other crypto, 1.00% equity), orders live ≥0.5s[^aster-docs-2026-04-28-trading-perpetuals-market-maker-program] |
## Disputed claims
None.

## Related
[[parameters/hyperliquid/mm-rebate-tiers]] · [[concepts/metrics/volume]] · [[concepts/operations/matching-engine]]

## Sources
[^hl-docs-2026-04-27-hypercore-overview]: [[sources/hl-docs-2026-04-27-hypercore-overview]]
[^aster-docs-2026-04-28-trading-perpetuals-market-maker-program]: [[sources/aster-docs-2026-04-28-trading-perpetuals-market-maker-program]]
