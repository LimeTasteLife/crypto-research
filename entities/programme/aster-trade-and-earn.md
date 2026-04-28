---
type: entity
subtype: programme
name: Aster Trade & Earn
status: active
launched: unknown
sources_count: 1
last_reviewed: 2026-04-28
disputed: false
---

# Aster Trade & Earn

> Yield-bearing-collateral incentive programme: traders using USDF or asBNB as Multi-Asset-Mode collateral on Aster perps continue to earn the underlying yield while the assets serve as trading margin, plus separate Deposit and Trading reward streams paid out weekly in USDF[^aster-docs-2026-04-28-program-trade-and-earn].

## Snapshot
- Eligible assets: **USDF** (99.99% collateral ratio), **asBNB** (95% collateral ratio); Multi-Asset Mode must be enabled[^aster-docs-2026-04-28-program-trade-and-earn]
- Eligibility gate: active **≥ 2 days/week** with **weekly volume ≥ 50,000 USD** (raised 2025-11-20)[^aster-docs-2026-04-28-program-trade-and-earn]
- USDF reward streams: **Deposit Rewards** (hourly snapshot, proportional) + **Trading Rewards** (volume-gated, capped **100,000 USDF/account** since 2025-09-04)[^aster-docs-2026-04-28-program-trade-and-earn]
- asBNB yield: BNB Launchpools (auto via exchange rate) + HODLer airdrops + Megadrops (manual claim)[^aster-docs-2026-04-28-program-trade-and-earn]
- Reward cycle: **Thu → Wed**, payout in USDF to Futures account within 7 business days[^aster-docs-2026-04-28-program-trade-and-earn]
- KPIs and time series: [[parameters/programmes/aster-trade-and-earn]]

## Mechanism
Trade & Earn removes the conventional opportunity cost between yield-earning and trading-margin uses of capital: USDF (1:1 USDT-redeemable, fully backed) and asBNB held in the Aster trading account both retain their underlying yield while simultaneously serving as Multi-Asset-Mode collateral on perps. USDF holders > 1 USDF accrue Deposit Rewards from an hourly holdings snapshot, distributed proportionally. Volume-gated traders (≥ 50k USD/week, ≥ 2 days/week) additionally receive Trading Rewards capped at 100,000 USDF per account. Reward weeks run Thursday → following Wednesday with payouts in USDF directly to the Futures account within 7 business days. Wash trading, market manipulation, and bulk-account creation trigger disqualification — the volume-gate + reward-cap structure creates measurable wash-trading exposure that the exclusion clauses acknowledge[^aster-docs-2026-04-28-program-trade-and-earn].

## Relations
- [[entities/perpdex/aster]] **operates** [[entities/programme/aster-trade-and-earn]][^aster-docs-2026-04-28-program-trade-and-earn]
- [[entities/programme/aster-trade-and-earn]] **applies_to** [[entities/token/usdf]] (eligible collateral)[^aster-docs-2026-04-28-program-trade-and-earn]

## Parameters
- [[parameters/programmes/aster-trade-and-earn]] — outcomes (collateral ratios, eligibility, reward streams, time series)

## Open questions
- What is the realized weekly USDF reward distribution (cumulative, by cohort)?
- What is the wash-trading detection methodology and observed clawback rate?
- Is the 100,000 USDF cap per-account or per-wallet (sybil consideration)?

## Disputed claims
None at first ingest.

## Related
[[entities/perpdex/aster]], [[entities/token/usdf]], [[parameters/programmes/aster-trade-and-earn]]

## Sources
[^aster-docs-2026-04-28-program-trade-and-earn]: [[sources/aster-docs-2026-04-28-program-trade-and-earn]]
