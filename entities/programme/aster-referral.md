---
type: entity
subtype: programme
name: Aster Referral
status: active
launched: unknown
sources_count: 1
last_reviewed: 2026-04-28
disputed: false
---

# Aster Referral

> Permissionless referral programme operated by Aster: 10% default commission on referee trading fees, splittable between referrer and referee, with an upgraded affiliate tier (20% VIP1 / 10% VIP2+) available by application[^aster-docs-2026-04-28-program-referral].

## Snapshot
- Default rate: **10%** of referee trading fees, splittable referrer/referee[^aster-docs-2026-04-28-program-referral]
- Affiliate tier (apply): **20%** from VIP1 referrals, **10%** from VIP2+ referrals[^aster-docs-2026-04-28-program-referral]
- Validity: **365 days** per referee, extendable at Aster's discretion[^aster-docs-2026-04-28-program-referral]
- Settlement: real-time accrual, daily payout in the same asset the referee paid fees in; rate calc 00:00 UTC, update 09:00 UTC[^aster-docs-2026-04-28-program-referral]
- KPIs and time series: [[parameters/programmes/aster-referral]]

## Mechanism
The referral relationship is established when a new user signs up via a referrer's link or custom code. From that point, a configurable share (default 10%) of the referee's eligible trading fees accrues to the referrer in real time and credits to the referrer's Aster account by the next day. Liquidation fees, self-trade volume, and zero-fee trade volume are excluded from the commission base. Self-referral via multiple accounts triggers revocation of all rewards. Aster reserves unilateral right to modify rates, rules, or cancel the programme[^aster-docs-2026-04-28-program-referral].

## Relations
- [[entities/perpdex/aster]] **operates** [[entities/programme/aster-referral]][^aster-docs-2026-04-28-program-referral]
- [[entities/programme/aster-referral]] **applies_to** [[concepts/incentives/referral-design]][^aster-docs-2026-04-28-program-referral]

## Parameters
- [[parameters/programmes/aster-referral]] — outcomes (rates, validity, exclusions, time series)

## Open questions
- What fraction of total trading volume is currently subject to referral commission?
- How many approved affiliates exist and what is their cumulative payout?
- Is there a public dashboard for referrer leaderboard / cumulative rebate?

## Disputed claims
None at first ingest.

## Related
[[entities/perpdex/aster]], [[parameters/programmes/aster-referral]], [[concepts/incentives/referral-design]]

## Sources
[^aster-docs-2026-04-28-program-referral]: [[sources/aster-docs-2026-04-28-program-referral]]
