---
type: entity
subtype: programme
name: Lighter Liquidity Partner Program
operator: [[entities/perpdex/lighter]]
status: live
launched: unknown
sources_count: 1
last_reviewed: 2026-04-28
disputed: false
---

# Lighter Liquidity Partner Program

> Weekly maker-rebate pool for Premium-account market makers, scored via randomized order-book snapshots against per-tier cumulative spread/size grids; tiers, weights, and pool size published every Monday by 17:00 UTC.

## Snapshot
- Operator: [[entities/perpdex/lighter]] (discretionary weekly publication of tiers, weights, and reward pool)[^lighter-docs-2026-04-28-liquidity-partner-program]
- Eligibility: Premium-account only; only resting orders count[^lighter-docs-2026-04-28-liquidity-partner-program]
- Publication cadence: Mondays by 17:00 UTC, public Google spreadsheet[^lighter-docs-2026-04-28-liquidity-partner-program]
- Reward currency: program reward pool (denomination not surfaced in the snapshot — likely LIT-program points; see Open questions)
- Snapshot interval: randomized, approximately every minute[^lighter-docs-2026-04-28-liquidity-partner-program]

## Mechanism

**Snapshot-based scoring.** Rewards are allocated through randomized snapshots of the order book, taken at randomized intervals approximately every minute[^lighter-docs-2026-04-28-liquidity-partner-program]. Only resting orders present on the order book at the time of each snapshot are eligible — taker fills and IOC orders do not score[^lighter-docs-2026-04-28-liquidity-partner-program].

**Per-symbol tiered liquidity grid.** A single global reward pool is shared across all eligible assets, with each asset assigned a weight that determines its share[^lighter-docs-2026-04-28-liquidity-partner-program]. Assets are categorized into tiers based on liquidity profile: highly liquid / strategic assets get tightest spread requirements but largest eligible book sizes; less liquid assets get wider allowed spreads but smaller eligible sizes[^lighter-docs-2026-04-28-liquidity-partner-program]. Spread requirements widen during low-activity periods to reflect liquidity conditions[^lighter-docs-2026-04-28-liquidity-partner-program].

Each asset tier and time period defines three cumulative spread levels representing maximum eligible liquidity within that spread distance from BBO[^lighter-docs-2026-04-28-liquidity-partner-program]. Spread levels are cumulative — e.g. $300,000 eligible at ≤15 bps includes the first $150,000 within 15 bps of BBO on each side[^lighter-docs-2026-04-28-liquidity-partner-program].

**Walk-the-book accounting.** At each snapshot the order book is walked from the inside out, starting at best bid/ask, accumulating eligible liquidity per side up to the size cap for the tightest qualifying spread level[^lighter-docs-2026-04-28-liquidity-partner-program]. Tie-breaking at the same price level uses earliest-timestamp priority (oldest order wins)[^lighter-docs-2026-04-28-liquidity-partner-program].

**50/50 bid/ask split.** Half of the rewards are allocated to resting bids and half to resting asks (50/50 symmetry)[^lighter-docs-2026-04-28-liquidity-partner-program].

**No rollover.** If an asset's order book has less eligible liquidity than its allocation, the unallocated portion is not redistributed[^lighter-docs-2026-04-28-liquidity-partner-program].

**Weekly publication of weights and pool.** Each Monday by 17:00 UTC, Lighter publishes updated asset tiers, reward weights, and total incentives pool in a public Google spreadsheet[^lighter-docs-2026-04-28-liquidity-partner-program]. Weekly updates are set by the Lighter team (discretionary)[^lighter-docs-2026-04-28-liquidity-partner-program].

## Relations
- [[entities/perpdex/lighter]] **subsidizes** [[entities/programme/lighter-liquidity-partner-program]] (operates the program, sets discretionary weekly tiers/weights/pool)[^lighter-docs-2026-04-28-liquidity-partner-program]
- [[entities/programme/lighter-liquidity-partner-program]] **applies_to** [[concepts/incentives/points-program]] (per-symbol/bps/size cumulative-grid liquidity scoring; closest existing concept until a `mm-agreement/quote-obligation` concept stub exists)[^lighter-docs-2026-04-28-liquidity-partner-program]

## Open questions
- What is the reward currency / unit (LIT, points convertible to LIT, USDC)? The snapshot does not name the denomination of the weekly pool.
- Are weekly published tiers and pool sizes archived on-chain or only in the Google spreadsheet?
- Is there a sunset / decay schedule for the program (cliff date, taper)?
- What is the historical distribution of the 250k weekly points pool's 20% MM share between this LP program and other MM-points channels (e.g. raw volume, the Points Program MM track)?

## Disputed claims
None at first ingest.

## Related
[[entities/perpdex/lighter]] · [[entities/programme/lighter-points-program]] · [[parameters/lighter/lp-program-tiers]] · [[concepts/incentives/points-program]]

## Sources
[^lighter-docs-2026-04-28-liquidity-partner-program]: [[sources/lighter-docs-2026-04-28-liquidity-partner-program]]
