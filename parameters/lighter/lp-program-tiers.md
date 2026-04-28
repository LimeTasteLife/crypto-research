---
type: parameter
entity: [[entities/perpdex/lighter]]
parameter: lp-program-tiers
unit: percent / USDC
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: false
---

# Lighter lp-program-tiers

## Current (as of 2026-04-28)

**Structure.** The Liquidity Partner Program distributes a weekly reward pool to market makers providing tight, deep resting liquidity, evaluated via randomized order-book snapshots approximately every minute[^lighter-docs-2026-04-28-liquidity-partner-program]. Eligibility requires maintaining an active Premium account; only resting orders present at snapshot time are eligible[^lighter-docs-2026-04-28-liquidity-partner-program].

**Asset tiers.** Assets are categorized into tiers based on liquidity profile[^lighter-docs-2026-04-28-liquidity-partner-program]:
- Highly liquid / strategic assets: tightest spread requirements, largest eligible book sizes.
- Less liquid assets: wider allowed spreads, smaller eligible sizes.

**Cumulative spread levels.** Each asset tier defines three cumulative spread levels representing maximum eligible liquidity within that spread distance from BBO[^lighter-docs-2026-04-28-liquidity-partner-program]. Example: $300,000 eligible at ≤15 bps includes the first $150,000 within 15 bps of BBO on each side[^lighter-docs-2026-04-28-liquidity-partner-program]. Spread requirements widen during low-activity periods[^lighter-docs-2026-04-28-liquidity-partner-program].

**Reward allocation mechanics.**
- A single global reward pool is shared across all eligible assets, with each asset assigned a weight that determines its share[^lighter-docs-2026-04-28-liquidity-partner-program].
- Half of rewards are allocated to resting bids and half to resting asks (50/50 symmetry)[^lighter-docs-2026-04-28-liquidity-partner-program].
- At each snapshot, the order book is walked from inside out, accumulating eligible liquidity per side up to the size cap for the tightest qualifying spread level[^lighter-docs-2026-04-28-liquidity-partner-program].
- Tie-breaking at the same price level uses earliest-timestamp priority (oldest order wins)[^lighter-docs-2026-04-28-liquidity-partner-program].
- If an asset's order book has less eligible liquidity than its allocation, the unallocated portion is not redistributed[^lighter-docs-2026-04-28-liquidity-partner-program].

**Publication cadence.** Each Monday by 17:00 UTC, Lighter publishes updated asset tiers, reward weights, and total incentives pool in a public Google spreadsheet[^lighter-docs-2026-04-28-liquidity-partner-program]. Weekly updates are set by the Lighter team (discretionary)[^lighter-docs-2026-04-28-liquidity-partner-program].

**RWA note.** Premium-account fees on RWA markets were scheduled to resume 2026-04-15 at 14:30 UTC[^lighter-docs-2026-04-28-liquidity-partner-program].

## Time series

| effective | pool structure | bid/ask split | snapshot frequency | publication | eligibility | source |
|---|---|---|---|---|---|---|
| 2026-04-28 | global pool, per-asset weighted tiers | 50/50 | ~every minute (random) | Monday 17:00 UTC Google Sheet | Premium account only | [^lighter-docs-2026-04-28-liquidity-partner-program] |

## Tiering rules / formulae

Exact tier weights and pool size are published weekly in the Google spreadsheet; not static in docs[^lighter-docs-2026-04-28-liquidity-partner-program].

## Disputed values
None.

## Sources
[^lighter-docs-2026-04-28-liquidity-partner-program]: [[sources/lighter-docs-2026-04-28-liquidity-partner-program]]
