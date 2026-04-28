---
type: parameter
entity: [[entities/perpdex/lighter]]
parameter: points-rules
unit: points
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: true
---

# Lighter points-rules

## Current (as of 2026-04-28)

- **Cadence (retail):** Season 2 distributes 200,000 retail points per week, paid every Friday, covering Wednesday (inclusive) through Tuesday (inclusive) activity[^lighter-docs-2026-04-28-points-program-retail].
- **Cadence (MM, implicit):** Market-making activity receives 20% of total allocated points = 50,000 points; the implied total weekly pool is 250,000 (20% = 50,000)[^lighter-docs-2026-04-28-points-program-market-makers]. The MM page does not literally state "weekly" — the 250k weekly figure is the consistent interpretation but is **Disputed** (see Disputed values).
- **Eligibility filters:** organic UI/API trading; sybil, self-trading, and intentional-loss / liquidation-farming do not earn[^lighter-docs-2026-04-28-points-program]; mixed automated + semi-automated sybil detection; up to 10 accounts per user without penalty; anti-farming metrics intentionally undisclosed[^lighter-docs-2026-04-28-points-program-retail]. MM points: only Premium accounts eligible[^lighter-docs-2026-04-28-points-program-market-makers].
- **LLP-as-MM redistribution:** LLP is treated as a market maker under the same rules but its share is not allocated to LLP — remaining points are scaled so the total stays at 250,000[^lighter-docs-2026-04-28-points-program-market-makers].
- **Discretion:** constants and parameters may change at the team's discretion based on market conditions and data availability[^lighter-docs-2026-04-28-points-program-market-makers][^lighter-docs-2026-04-28-points-program].

## Time series

| effective | retail/wk | mm-share-of-total | implied-total/wk | season | source |
|---|---|---|---|---|---|
| 2026-04-28 | 200,000 | 20% (= 50,000) | 250,000 (Disputed) | Season 2 | [^lighter-docs-2026-04-28-points-program-retail][^lighter-docs-2026-04-28-points-program-market-makers] |

Season-1 final Private Beta distribution closed 2025-09-30; per-week numerics for Season 1 are not surfaced in the 2026-04-28 mirror snapshot[^lighter-docs-2026-04-28-points-program]. Future refreshes should append a Season-1 row when historical figures are recovered.

## Tiering rules / formulae

**Retail.** Points span Volume, Open Interest, Fundings, Liquidations & Deleverages, and PnL[^lighter-docs-2026-04-28-points-program-retail]. Scaling factors favor traders with higher trading quality; Premium-account status increases the weight of metrics, especially PnL[^lighter-docs-2026-04-28-points-program-retail]. Some categories evaluate per-market, others globally; some daily, others weekly[^lighter-docs-2026-04-28-points-program-retail]. Points are not linear in the underlying metric — 2× volume may yield ~3× or ~1.5× points (extends beyond volume)[^lighter-docs-2026-04-28-points-program-retail]. Markets are not weighted equally for retail (e.g. $100 BTC volume ≠ $100 HYPE volume)[^lighter-docs-2026-04-28-points-program-retail]. Intentional liquidation / loss does not earn[^lighter-docs-2026-04-28-points-program-retail].

**MM volume score.** `score = volume + max(0, (volume − 2.5B) × 0.25)` — i.e. a 25% bonus to weekly maker volume above $2.5B[^lighter-docs-2026-04-28-points-program-market-makers]. Volume points are computed once for the entire week, not daily; $1 of volume on the first day has the same weight as $1 on the last day; all markets weighted equally for the volume-based score[^lighter-docs-2026-04-28-points-program-market-makers].

**MM liquidity score.** Random order-book snapshots, users scored proportionally to their share of liquidity[^lighter-docs-2026-04-28-points-program-market-makers]. At each snapshot ~6–10 metrics evaluate the top $10k / $30k / $100k / $300k / … liquidity at the top 1 / 2 / 5 / 10 bps from mid-price; metrics computed separately for bid and ask[^lighter-docs-2026-04-28-points-program-market-makers]. Market weight blends Lighter's own data with adjusted external-exchange volume + open-interest multipliers, recomputed hourly; weighting shifts toward heavily-traded tokens (BTC, ETH, SOL) and toward tokens popular elsewhere but not yet active on Lighter[^lighter-docs-2026-04-28-points-program-market-makers].

**Volatility multiplier + daily floor / cap.** A per-snapshot volatility multiplier increases the weight of high-volatility snapshots[^lighter-docs-2026-04-28-points-program-market-makers]. Liquidity-provision total scores are calculated daily because the multiplier varies snapshot by snapshot[^lighter-docs-2026-04-28-points-program-market-makers]. Daily floor of 8.33% of the weekly liquidity-provision pool ensures no single day dominates the week[^lighter-docs-2026-04-28-points-program-market-makers]. If extreme volatility persists for ~20 hours of one day, that day's liquidity-provision points are capped at 50% of the weekly pool[^lighter-docs-2026-04-28-points-program-market-makers].

**Time-priority tiebreak.** Earliest-timestamp priority at the same price level (oldest order wins) is the cross-program tiebreak — see [[entities/programme/lighter-liquidity-partner-program]][^lighter-docs-2026-04-28-liquidity-partner-program].

## Disputed values

- **250k weekly cap (implied vs explicit).** See [[entities/perpdex/lighter#disputed-claims]] (canonical entry) and [[entities/programme/lighter-points-program#disputed-claims]]. Claim A treats 200k retail + 50k MM as the weekly total = 250k. Claim B notes the MM page does not literally state "weekly" cadence; the 250k weekly figure is the consistent interpretation but not literally written.

## Sources
[^lighter-docs-2026-04-28-points-program]: [[sources/lighter-docs-2026-04-28-points-program]]
[^lighter-docs-2026-04-28-points-program-retail]: [[sources/lighter-docs-2026-04-28-points-program-retail]]
[^lighter-docs-2026-04-28-points-program-market-makers]: [[sources/lighter-docs-2026-04-28-points-program-market-makers]]
[^lighter-docs-2026-04-28-liquidity-partner-program]: [[sources/lighter-docs-2026-04-28-liquidity-partner-program]]
