---
type: concept
domain: incentives
name: Referral design
last_reviewed: 2026-04-28
disputed: false
---

# Referral design

## Definition
A referral design is the venue's policy for paying out rewards to referrers and discounts to referred users. Key design dimensions: per-user reward cap, per-user discount cap, attribution window (last-vs-first touch), termination conditions, multi-level depth, sybil/wash detection, and clawback policy.

## Mechanism on Hyperliquid

**Per-user caps.**
- Referral **rewards** apply for a referrer's first **$1B** in referred-user volume[^hl-docs-2026-04-27-trading-fees].
- Referral **discounts** apply for a referred user's first **$25M** in volume[^hl-docs-2026-04-27-trading-fees].

**Claim mechanism.** Referral rewards are claimable from the Referrals page on the user dashboard[^hl-docs-2026-04-27-trading-fees].

(Multi-level depth, attribution window, and sybil/clawback policy are not surfaced in primary docs at this snapshot — these are gaps in the A3/PIII and A3/PIV cells of the Frame coverage.)

## Variants in the wild

| venue | reward cap | discount cap | depth | clawback policy |
|---|---|---|---|---|
| [[entities/perpdex/hyperliquid]] | $1B referred volume[^hl-docs-2026-04-27-trading-fees] | $25M referred volume[^hl-docs-2026-04-27-trading-fees] | not surfaced | not surfaced |
| [[entities/perpdex/aster]] | 10% default; 20% (VIP1) / 10% (VIP2+) via application[^aster-docs-2026-04-28-program-referral] | configurable split with referee[^aster-docs-2026-04-28-program-referral] | 1L (no permissionless multi-level)[^aster-docs-2026-04-28-program-referral] | liquidation-fee / self-trade / zero-fee excluded; self-referral revoked[^aster-docs-2026-04-28-program-referral] |
| [[entities/perpdex/dydx]] | VIP ≤50% taker ($10k/referral/30d cap); Standard ≤15% taker ($3k/referral/30d cap)[^dydx-community-2026-04-28-dydx-features-affiliate-program] | not surfaced (taker-fee share only)[^dydx-community-2026-04-28-dydx-features-affiliate-program] | 1L; VIP managed by CryptoLearningClub via dYdX Grants[^dydx-community-2026-04-28-dydx-features-affiliate-program] | $10k vol gate; MMs/trading firms excluded from VIP; ≥30k social followers required[^dydx-community-2026-04-28-dydx-features-affiliate-program] |
| [[entities/perpdex/orderly]] | listing referral only: $2,000 fixed + 30% of project marketing budget (capped $10,000)[^orderly-listing-2026-04-29-listing]; no documented trader referral program | not applicable (listing referral, not trader referral) | 1L; planned Multi-Level Referral (roadmap 2026 H1)[^orderly-docs-2026-04-29-roadmap] | not surfaced |

(Other perpdex venues to be added in subsequent ingest passes.)

## Disputed claims
None.

## Related
[[parameters/hyperliquid/fee-schedule]] · `concepts/incentives/anti-abuse` (TBD — page not yet created)

## Sources
[^hl-docs-2026-04-27-trading-fees]: [[sources/hl-docs-2026-04-27-trading-fees]]
[^aster-docs-2026-04-28-program-referral]: [[sources/aster-docs-2026-04-28-program-referral]]
[^dydx-community-2026-04-28-dydx-features-affiliate-program]: [[sources/dydx-community-2026-04-28-dydx-features-affiliate-program]]
[^orderly-listing-2026-04-29-listing]: [[sources/orderly-listing-2026-04-29-listing]]
[^orderly-docs-2026-04-29-roadmap]: [[sources/orderly-docs-2026-04-29-roadmap]]
