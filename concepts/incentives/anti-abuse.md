---
type: concept
domain: incentives
name: Anti-abuse
last_reviewed: 2026-04-28
disputed: false
---

# Anti-abuse

## Definition

Anti-abuse refers to the suite of rules, detection mechanisms, and enforcement actions a venue applies to prevent manipulation of incentive programs — including wash trading, self-trading, coordinated volume inflation, and fee farming[^lighter-docs-2026-04-28-points-program-retail][^aster-docs-2026-04-28-program-trade-and-earn][^aster-docs-2026-04-28-program-referral]. The design challenge is that incentive programs create structured opportunities for abuse: rewarding volume rewards wash trading, rewarding referrals rewards self-referral, and rewarding holdings rewards single-user multi-account splitting. Anti-abuse mechanisms define the boundary between organic and inorganic activity and enforce it through some combination of rule-based exclusions, statistical detection, and manual review[^lighter-docs-2026-04-28-points-program-retail].

## Mechanism

Anti-abuse systems typically operate across four layers:

1. **Structural exclusions**: define categories of activity that are ineligible by construction (e.g., self-trade volume, liquidation-fee volume, zero-fee volume excluded from referral calculations)[^aster-docs-2026-04-28-program-referral].
2. **Account-level limits**: cap the number of accounts per user or the per-account reward cap (e.g., USDF cap at 100,000 per account)[^aster-docs-2026-04-28-program-trade-and-earn], or tolerate multi-account at a declared threshold without penalty (e.g., up to 10 accounts per user)[^lighter-docs-2026-04-28-points-program-retail].
3. **Behavioral detection**: automated and semi-automated analysis of trading patterns to identify wash trading, coordinated activity, or self-referral[^lighter-docs-2026-04-28-points-program-retail][^aster-docs-2026-04-28-program-trade-and-earn].
4. **Penalty / revocation**: disqualification from the program, clawback of earned rewards, or blacklisting[^aster-docs-2026-04-28-program-trade-and-earn][^aster-docs-2026-04-28-program-referral].

## Variants in the wild

| venue | program | wash-trade detection | sybil / multi-account | self-referral | bulk-account farming | penalty |
|---|---|---|---|---|---|---|
| [[entities/perpdex/lighter]] | [[entities/programme/lighter-points-program]] | mixed automated + semi-automated; specific metrics intentionally undisclosed to prevent gaming[^lighter-docs-2026-04-28-points-program-retail] | ≤10 accounts per user tolerated without penalty; intentional losses excluded[^lighter-docs-2026-04-28-points-program-retail] | Discord enforcement for self-trading; STP cancel-resting at matching layer[^lighter-docs-2026-04-28-points-program-retail] | undisclosed heuristics applied[^lighter-docs-2026-04-28-points-program-retail] | disqualification (not detailed beyond enforcement announcement)[^lighter-docs-2026-04-28-points-program-retail] |
| [[entities/perpdex/aster]] | Trade & Earn | wash trading grounds for disqualification; market manipulation grounds for disqualification[^aster-docs-2026-04-28-program-trade-and-earn] | not stated; USDF per-account cap of 100,000 USDF indirectly limits reward splitting[^aster-docs-2026-04-28-program-trade-and-earn] | not stated | bulk account creation for bonus farming triggers disqualification[^aster-docs-2026-04-28-program-trade-and-earn] | program disqualification[^aster-docs-2026-04-28-program-trade-and-earn] |
| [[entities/perpdex/aster]] | Referral Program | self-trade volume, liquidation-fee volume, zero-fee volume excluded from commission calculations[^aster-docs-2026-04-28-program-referral] | n/a (referral program: 1 referrer → many referees, not a multi-account problem) | self-referrals trigger full reward revocation if detected[^aster-docs-2026-04-28-program-referral] | not applicable to referral structure | full reward revocation for self-referral[^aster-docs-2026-04-28-program-referral]; offensive/misleading codes may be removed[^aster-docs-2026-04-28-program-referral] |

(Hyperliquid row: anti-abuse details for HL Points not yet surfaced in primary docs at this snapshot — see [[concepts/incentives/sybil-resistance]] for HL-relevant points once ingested.)

## Edge cases
- **Intentional-loss loophole.** When liquidations are a scored metric, a user can earn points by holding bad positions through forced closure. Lighter closes this by explicitly excluding intentional losses from points accrual[^lighter-docs-2026-04-28-points-program-retail].
- **Redacted rubric as Goodhart defense.** Lighter discloses that anti-farming metrics exist but not what they are[^lighter-docs-2026-04-28-points-program-retail]. This prevents known-threshold exploitation at the cost of transparency; users cannot verify detection fairness without an independent audit.
- **Volume threshold + per-account cap interaction.** Aster's Trade & Earn requires a 50,000 USD/week volume threshold while also capping USDF holdings at 100,000 per account[^aster-docs-2026-04-28-program-trade-and-earn]. The combination creates a wash-trading incentive at the volume floor: crossing the threshold unlocks rewards, so users near the threshold benefit from self-funding the minimum.

## Disputed claims
None.

## Related
[[concepts/incentives/sybil-resistance]] · [[concepts/incentives/points-program]] · [[concepts/incentives/referral-design]]

## Sources
[^lighter-docs-2026-04-28-points-program-retail]: [[sources/lighter-docs-2026-04-28-points-program-retail]]
[^lighter-docs-2026-04-28-points-program]: [[sources/lighter-docs-2026-04-28-points-program]]
[^aster-docs-2026-04-28-program-trade-and-earn]: [[sources/aster-docs-2026-04-28-program-trade-and-earn]]
[^aster-docs-2026-04-28-program-referral]: [[sources/aster-docs-2026-04-28-program-referral]]
