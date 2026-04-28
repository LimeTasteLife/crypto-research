---
type: source
id: lighter-docs-2026-04-28-points-program-market-makers
title: Market Makers (Points Program)
publisher: Lighter Docs
author: Lighter team
date: null
original_url: https://docs.lighter.xyz/points-program/market-makers
mirror_snapshot: lighter-docs-2026-04-28
mirror_page: pages/points-program-market-makers.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Market Makers (Points Program)

## TL;DR
Market-making activity receives 20% of total allocated points (50,000 of 250,000). Only Premium accounts can earn MM points. LLP is treated as an MM under the same rules but its share is redistributed proportionally so the total stays at 250,000. Volume points use score = volume + max(0, (volume − 2.5B) × 0.25), giving a 25% bonus to weekly maker volume above $2.5B; markets weighted equally for volume scoring. Liquidity points use random order-book snapshots scored across ~6–10 size and bps thresholds per market (e.g. $10k/$30k/$100k/… at 1/2/5/10 bps), separated for bid and ask. Market weights blend Lighter's own data with adjusted external venues' volume and OI; weights recompute hourly. A volatility multiplier scales each snapshot, but daily floor of 8.33% prevents one day dominating a week.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Market-making activity receives 20% of total allocated points, equal to 50,000 points. | [[entities/programme/lighter-points-program]], [[parameters/lighter/points-rules]] | A3-PI, A4-PI |
| #c2 | Implied total points pool referenced for the program = 250,000 (20% = 50,000). | [[parameters/lighter/points-rules]] | A3-PI |
| #c3 | Only Premium accounts are eligible to earn market-making points. | [[entities/programme/lighter-points-program]], [[parameters/lighter/points-rules]] | A3-PIII, A4-PI |
| #c4 | LLP is treated as a market maker under the same rules. | [[entities/programme/lighter-points-program]] | A4-PI |
| #c5 | Points earned by LLP are not allocated to LLP; remaining points are scaled so the total stays at 250,000. | [[parameters/lighter/points-rules]] | A4-PIV |
| #c6 | LLP scaling effectively redistributes LLP-earned points to other platform participants. | [[parameters/lighter/points-rules]] | A4-PIV |
| #c7 | Volume score formula: score = volume + max(0, (volume − 2.5B) × 0.25). | [[parameters/lighter/points-rules]] | A3-PI |
| #c8 | A 25% bonus applies to weekly maker volume above $2.5B. | [[parameters/lighter/points-rules]] | A3-PI |
| #c9 | Volume points are computed once for the entire week, not daily. | [[parameters/lighter/points-rules]] | A3-PI |
| #c10 | $1 of volume on the first day of the week has the same weight as $1 on the last day. | [[parameters/lighter/points-rules]] | A3-PI |
| #c11 | All markets are weighted equally for the volume-based score. | [[parameters/lighter/points-rules]] | A3-PI |
| #c12 | Liquidity-provision points use random order-book snapshots, with users scored proportionally to their share of liquidity. | [[parameters/lighter/points-rules]] | A4-PI |
| #c13 | At each snapshot, several metrics evaluate the top $10k/$30k/$100k/$300k/… of liquidity and the top 1/2/5/10 bps from mid-price. | [[parameters/lighter/points-rules]] | A4-PI |
| #c14 | Per-market roughly 6–10 metrics are used for liquidity scoring, each carrying the same weight. | [[parameters/lighter/points-rules]] | A4-PI |
| #c15 | Liquidity metrics are computed separately for bid and ask sides. | [[parameters/lighter/points-rules]] | A4-PI |
| #c16 | A market weight for liquidity points is derived by combining Lighter's own data with adjusted external-exchange volume and open-interest multipliers. | [[parameters/lighter/points-rules]] | A4-PI |
| #c17 | Market weights are recomputed hourly. | [[parameters/lighter/points-rules]] | A4-PI |
| #c18 | The weighting approach shifts toward heavily-traded tokens (e.g. BTC, ETH, SOL) and toward tokens popular elsewhere but not yet active on Lighter. | [[parameters/lighter/points-rules]] | A4-PIV |
| #c19 | A per-snapshot volatility multiplier increases the weight of high-volatility snapshots to incentivise quoting through volatility. | [[parameters/lighter/points-rules]] | A4-PI |
| #c20 | Liquidity-provision total scores are calculated daily (because the volatility multiplier varies snapshot by snapshot). | [[parameters/lighter/points-rules]] | A4-PI |
| #c21 | A daily floor of 8.33% of total liquidity-provision points is enforced so no single day dominates the week. | [[parameters/lighter/points-rules]] | A4-PIV |
| #c22 | If extreme volatility persists for ~20 hours of one day, that day's liquidity-provision points are capped at 50% of the weekly pool. | [[parameters/lighter/points-rules]] | A4-PIV |
| #c23 | Constants and parameters in the program may change at the team's discretion based on market conditions and data availability. | [[parameters/lighter/points-rules]] | A7-PI |

## Conflicts raised
- #c2 vs lighter-docs-2026-04-28-points-program-retail#c1 → 250,000 (MM page total) ≠ 200,000 (Retail page weekly) — these may be reconciled as MM points = 50k/week + Retail points = 200k/week summing to 250k/week, but the MM page states "total allocated points (50,000)" alongside "scaled so total remains 250,000" without explicit weekly cadence. See [[entities/programme/lighter-points-program]]#disputed.
