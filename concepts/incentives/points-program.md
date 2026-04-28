---
type: concept
domain: incentives
name: Points program
last_reviewed: 2026-04-28
disputed: false
---

# Points program

## Definition
A **points program** is a venue-issued, off-chain (or pre-token) credit ledger that scores user activity according to a published or partially-published rubric, with the explicit or implicit promise that points convert into a future token/airdrop allocation, fee discount, or other claim[^lighter-docs-2026-04-28-points-program][^lighter-docs-2026-04-28-points-program-retail][^lighter-docs-2026-04-28-points-program-market-makers]. Points are typically distributed on a recurring cadence (weekly is the modal choice) from a fixed-size pool, with multipliers favoring "quality" behavior (volume, OI persistence, PnL) and explicit penalties for "non-organic" behavior (sybil, self-trading, intentional liquidations)[^lighter-docs-2026-04-28-points-program-retail][^lighter-docs-2026-04-28-points-program-market-makers]. Programs differ on three structural dimensions: **(a)** fixed vs uncapped pool, **(b)** retail-only vs retail+MM split tracks, **(c)** rule transparency (full-published vs intentionally-undisclosed-anti-gaming).

## Variants in the wild

| venue | program | tracks | weekly pool (or cadence) | rule transparency | quality multipliers | anti-abuse | gating |
|---|---|---|---|---|---|---|---|
| [[entities/perpdex/lighter]] | [[entities/programme/lighter-points-program]] | retail + MM (two-track)[^lighter-docs-2026-04-28-points-program-retail][^lighter-docs-2026-04-28-points-program-market-makers] | 200,000 retail/wk + 50,000 MM/wk = implied 250,000/wk total[^lighter-docs-2026-04-28-points-program-retail][^lighter-docs-2026-04-28-points-program-market-makers] (see Disputed claims) | partially-undisclosed (sybil metrics intentionally hidden); rubric headlines published[^lighter-docs-2026-04-28-points-program-retail] | non-linear scaling (2× volume ≠ 2× points; can be ~3× or ~1.5×); per-snapshot volatility multiplier for MM (with daily 8.33% floor + 50% daily cap); Premium-account weighting bonus on PnL[^lighter-docs-2026-04-28-points-program-retail][^lighter-docs-2026-04-28-points-program-market-makers] | sybil-detection both fully-automated and semi-automated; ≤10 accounts per user tolerated; intentional losses excluded; self-trading enforced via Discord announcement[^lighter-docs-2026-04-28-points-program-retail] | MM track Premium-only; LLP-as-MM share redistributed to other participants[^lighter-docs-2026-04-28-points-program-market-makers] |
| [[entities/perpdex/hyperliquid]] | HL Points (S1, S2) | retail (MM treated separately via HLP economics) | TBD on next ingest | TBD on next ingest | TBD on next ingest | TBD on next ingest | TBD on next ingest |
| dYdX (v3 retro / v4 launch) | dYdX retro airdrop + ongoing rewards | retail | TBD on next ingest | TBD on next ingest | TBD on next ingest | TBD on next ingest | TBD on next ingest |
| Aevo | Aevo Surge | retail | TBD on next ingest | TBD on next ingest | TBD on next ingest | TBD on next ingest | TBD on next ingest |

(HL/dYdX/Aevo rows: TBD on next ingest — these venues have not yet been crawled at points-program-page granularity. Will be enriched once their respective Phase-1 source set lands.)

## Edge cases

- **Sybil filters — disclosed-presence + undisclosed-content.** Lighter discloses *that* it runs sybil detection (mixed automated and semi-automated) and tolerates up to 10 accounts per user before any penalty[^lighter-docs-2026-04-28-points-program-retail], but it deliberately does **not** publish the specific anti-farming metrics, "to prevent gaming"[^lighter-docs-2026-04-28-points-program-retail]. This creates a gameable gradient: the existence of the rule is public knowledge, the parameter values are private — equivalent to a redacted-rubric Goodhart defense.
- **Intentional-loss exclusion.** Intentionally losing money or being liquidated is explicitly **not** rewarded under Lighter's retail rubric — this is needed because the rubric scores Liquidations & Deleverages as a category[^lighter-docs-2026-04-28-points-program-retail], so without an intentional-loss filter a sufficiently bored user could earn points by holding bad positions through liquidation.
- **Self-trade blocking.** Lighter issued an explicit Discord announcement on self-trading to enforce a level playing field[^lighter-docs-2026-04-28-points-program-retail]; combined with the [[concepts/market-microstructure/mark-price-formula|venue's]] cancel-resting STP variant in the matching engine, this closes the same-account spoofing loophole at both the rubric layer and the matching layer.
- **Attribution rules.** Lighter uses a Wed–Tue activity window with weekly distribution every Friday[^lighter-docs-2026-04-28-points-program-retail]; volume score is computed once per week (so $1 of volume on the first day of the window is worth the same as $1 on the last day), but liquidity-provision (MM) scores are computed daily because the per-snapshot volatility multiplier varies snapshot-by-snapshot[^lighter-docs-2026-04-28-points-program-market-makers]. Mixing weekly and daily attribution windows in the same program is non-trivial: it means a user's Volume contribution is order-independent inside the week, but their MM contribution is time-weighted.
- **Retail-vs-MM split.** Lighter splits the weekly pool 80/20 (retail/MM): 200,000 retail and 50,000 MM, with the MM share gated to Premium accounts[^lighter-docs-2026-04-28-points-program-retail][^lighter-docs-2026-04-28-points-program-market-makers]. The retail rubric scores Volume, OI, Fundings, Liquidations/Deleverages, and PnL[^lighter-docs-2026-04-28-points-program-retail]; the MM rubric scores volume (with 25% bonus above $2.5B/wk via `score = volume + max(0, (volume − 2.5B) × 0.25)`) and liquidity (random snapshots scored across $10k/$30k/$100k/$300k/… size buckets at 1/2/5/10 bps, separate bid/ask)[^lighter-docs-2026-04-28-points-program-market-makers]. The two rubrics share **no metrics** — they are functionally separate programs that share a brand and a publication cadence.
- **Weekly cadence.** Lighter Season 2 distributes every Friday[^lighter-docs-2026-04-28-points-program][^lighter-docs-2026-04-28-points-program-retail]. Season 1 ended with the final Private Beta distribution on 2025-09-30[^lighter-docs-2026-04-28-points-program] — a documented onboarding/offboarding boundary.
- **Discretionary parameter changes.** Lighter explicitly reserves the right to adjust constants and parameters in the program at the team's discretion based on market conditions and data availability[^lighter-docs-2026-04-28-points-program][^lighter-docs-2026-04-28-points-program-market-makers]. Combined with the public weekly-cadence promise, this produces a program that is procedurally legible (you know when distributions happen, you know the published rubric) but parametrically illegible (you do not know the exact weights or sybil thresholds, and they may move week-to-week).
- **MM-share redistribution from protocol vault.** Lighter explicitly excludes its own LLP from MM-points payout: LLP qualifies under the same rules but its share is rescaled to other participants so the total weekly MM pool stays at 50,000[^lighter-docs-2026-04-28-points-program-market-makers]. This is a structural defense against a protocol-owned MM cannibalizing third-party MM rewards; without it, the program would silently subsidize LLP at LLP's external-MM competitors' expense.

## Disputed claims
The 250,000 weekly-cap arithmetic for the Lighter Points Program — whether "20% MM = 50k" implies a strictly weekly 250k total — is recorded canonically on [[entities/perpdex/lighter]]#disputed and [[entities/programme/lighter-points-program]]#disputed; see those pages.

## Related
[[concepts/incentives/sybil-resistance]] · [[concepts/incentives/referral-design]] · [[concepts/incentives/anti-abuse]] · [[entities/programme/lighter-points-program]] · [[entities/programme/lighter-liquidity-partner-program]] · [[entities/perpdex/lighter]] · [[parameters/lighter/points-rules]] · [[parameters/lighter/lp-program-tiers]]

## Sources
[^lighter-docs-2026-04-28-points-program]: [[sources/lighter-docs-2026-04-28-points-program]]
[^lighter-docs-2026-04-28-points-program-retail]: [[sources/lighter-docs-2026-04-28-points-program-retail]]
[^lighter-docs-2026-04-28-points-program-market-makers]: [[sources/lighter-docs-2026-04-28-points-program-market-makers]]
