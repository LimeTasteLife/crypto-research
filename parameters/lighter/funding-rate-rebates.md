---
type: parameter
entity: [[entities/perpdex/lighter]]
parameter: funding-rate-rebates
unit: percent
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: false
---

# Lighter funding-rate-rebates

## Current (as of 2026-04-28)

- **Headline cap:** up to 15% of funding paid is rebated to the funding-paying side[^lighter-docs-2026-04-28-trading-funding-funding-rate-rebates].
- **Automatic Premium discount:** 6% per hourly funding payment for any Premium account[^lighter-docs-2026-04-28-trading-funding-funding-rate-rebates].
- **LIT-staking-scaled bonus:** up to an additional 9%, scaling linearly with LIT staked, capped at 9% when 50,000 LIT is staked[^lighter-docs-2026-04-28-trading-funding-funding-rate-rebates].
- **Rebate base (cap on "interest-only" portion):** EligibleFunding = `min(FundingRate, InterestRateComponent) × PositionValue`[^lighter-docs-2026-04-28-trading-funding-funding-rate-rebates].
- **Rebate amount formula:** `RebateAmount = EligibleFunding × DiscountPercentage`[^lighter-docs-2026-04-28-trading-funding-funding-rate-rebates].
- **Annualized cap (across consolidated accounts):** 10%[^lighter-docs-2026-04-28-trading-funding-funding-rate-rebates].
- **Settlement cadence:** daily L2 transfers at 00:00 UTC[^lighter-docs-2026-04-28-trading-funding-funding-rate-rebates].
- **Treasury / payer address:** `0xc4535ceeA637b3B1bcdf5932603A4DbC00Ad2772` (Lighter Rebates Fund)[^lighter-docs-2026-04-28-trading-funding-funding-rate-rebates].
- **Minimum payment threshold:** $1 — sub-threshold payments are not processed[^lighter-docs-2026-04-28-trading-funding-funding-rate-rebates].
- **Sub-account stake aggregation:** effective staked LIT is consolidated across the main account and all sub-accounts[^lighter-docs-2026-04-28-trading-funding-funding-rate-rebates].
- **Scope:** applies to all markets listed on Lighter; only the funding-paying side benefits; the receiving side is unaffected[^lighter-docs-2026-04-28-trading-funding-funding-rate-rebates].

## Time series

| effective | premium auto | lit-stake bonus | total cap | annual cap | settlement | min payout | source |
|---|---|---|---|---|---|---|---|
| 2026-04-28 | 6% | up to 9% (linear, capped at 50k LIT staked) | 15% | 10% | daily 00:00 UTC L2 | $1 | [^lighter-docs-2026-04-28-trading-funding-funding-rate-rebates] |

## Tiering rules / formulae

**Discount stack.** Total discount = `6% (Premium) + min(9%, 9% × min(stakedLIT / 50,000, 1))`. Linear scaling of the staking bonus is governed by an exponent currently set to 1; the team retains discretion to adjust the curve[^lighter-docs-2026-04-28-trading-funding-funding-rate-rebates].

**Rebate calculation.**
1. Compute `InterestRateComponent` (fixed-rate portion of the funding rate, see [[parameters/lighter/funding-config]]).
2. `EligibleFunding = min(FundingRate, InterestRateComponent) × PositionValue` — caps the rebate at the "interest-rate-only" portion of funding (i.e. the rebate cannot pay more than what the trader would have paid under a pure interest-rate funding regime)[^lighter-docs-2026-04-28-trading-funding-funding-rate-rebates].
3. `RebateAmount = EligibleFunding × (6% + scaled-LIT-bonus)` capped at 15%[^lighter-docs-2026-04-28-trading-funding-funding-rate-rebates].
4. Cumulative annualized rebates across consolidated accounts capped at 10%[^lighter-docs-2026-04-28-trading-funding-funding-rate-rebates].
5. Daily aggregation at 00:00 UTC; if total < $1, payment is deferred (effectively dropped per docs)[^lighter-docs-2026-04-28-trading-funding-funding-rate-rebates].

## Disputed values

None at first ingest.

## Sources
[^lighter-docs-2026-04-28-trading-funding-funding-rate-rebates]: [[sources/lighter-docs-2026-04-28-trading-funding-funding-rate-rebates]]
