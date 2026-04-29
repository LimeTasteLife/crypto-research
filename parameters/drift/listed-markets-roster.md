---
type: parameter
entity: [[drift]]
parameter: listed-markets-roster
unit: categorical
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: false
---

# Drift listed markets roster

## Current (as of 2026-04-28)

**Contract Tiers.** Drift defines six Contract Tier labels: A, B, C, Speculative, Highly Speculative, Isolated (the docs call them "five unique tiers" while listing six labels)[^drift-docs-2026-04-28-protocol-trading-market-specs].

**Tier assignments (snapshot):**

| tier | markets |
|---|---|
| A | BTC-PERP |
| B | SOL-PERP, ETH-PERP |
| C | most others |
| Speculative | 1MBONK-PERP, 1MPEPE-PERP, WIF-PERP |
| Highly Speculative | W-PERP |
| Isolated | (none listed explicitly at snapshot) |

[^drift-docs-2026-04-28-protocol-trading-market-specs]

**Tier governance implications.** Tiers govern priority access to collateral in liquidations, max insurance limits, acceptable oracle price divergence, and TWAP / funding-rate sanitization[^drift-docs-2026-04-28-protocol-trading-market-specs].

**Speculative tier insurance carve-out.** Speculative tier markets have NO access to external insurance funds; only the perpetual market's own fee pool[^drift-docs-2026-04-28-protocol-trading-market-specs]. Highly Speculative sits one tranche below[^drift-docs-2026-04-28-protocol-trading-market-specs].

**Isolated tier access gate.** Requires user to disable cross-margin trading on both perpetual and spot; users with margin trading enabled, a non-USDC borrow, or another perp position cannot enter[^drift-docs-2026-04-28-protocol-trading-market-specs].

**Spot Asset Tiers.** Collateral (full privilege), Protected (collateral, no borrow), Cross (not collateral, allow multi-borrow), Isolated (not collateral, single borrow), Unlisted (no privilege)[^drift-docs-2026-04-28-protocol-trading-market-specs].

**Per-market parameters.** Each perp market exposes Max Open Interest, IMF Factor, and Oracle Source (Pyth | Switchboard | Prelaunch)[^drift-docs-2026-04-28-protocol-trading-market-specs].

**Prelaunch markets.** Default to Highly Speculative tier; use custom oracle source set to current mark TWAP (window = funding period) with initial price and max price bounds[^drift-docs-2026-04-28-protocol-trading-prelaunch-markets].

## Time series

| effective | A-tier | B-tier | Speculative | Highly Speculative | source |
|---|---|---|---|---|---|
| 2026-04-28 | BTC-PERP | SOL-PERP, ETH-PERP | 1MBONK, 1MPEPE, WIF | W-PERP | [^drift-docs-2026-04-28-protocol-trading-market-specs] |

## Disputed values
None.

## Sources
[^drift-docs-2026-04-28-protocol-trading-market-specs]: [[sources/drift-docs-2026-04-28-protocol-trading-market-specs]]
[^drift-docs-2026-04-28-protocol-trading-prelaunch-markets]: [[sources/drift-docs-2026-04-28-protocol-trading-prelaunch-markets]]
