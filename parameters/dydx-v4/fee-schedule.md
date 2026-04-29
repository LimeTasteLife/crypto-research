---
type: parameter
entity: [[dydx-v4]]
parameter: fee-schedule
unit: percent
last_change: 2026-04-28
last_reviewed: 2026-04-29
disputed: false
---

# dYdX v4 fee-schedule

## Current (as of 2026-04-28)
- 7 volume tiers by 30-day trailing volume (sub-accounts + all markets combined)[^dydx-docs-2026-04-28-concepts-trading-rewards][^dydx-community-2026-04-28-modules-governance-fee-tiers]
- Tier 1 (<$1M): 5.0 bps taker / 1.0 bps maker[^dydx-docs-2026-04-28-concepts-trading-rewards]
- Tier 7 (>=$200M): 2.5 bps taker / -1.1 bps maker rebate[^dydx-docs-2026-04-28-concepts-trading-rewards]
- Fees are uniform across all markets[^dydx-community-2026-04-28-modules-governance-fee-tiers]
- 5-tier-group staking-DYDX discount overlay (25%-50% off net positive trading fees; no rebate on rebates; only bonded DYDX counts)[^dydx-docs-2026-04-28-concepts-trading-rewards]
- Staking discount tiers: tier 1 = 25% at 3,000 DYDX or 50% at 20,000 DYDX; tier 5-7 = 5% at 800,000 or 10% at 5,000,000 DYDX[^dydx-docs-2026-04-28-concepts-trading-rewards]
- Fee tier updates via governance `MsgUpdatePerpetualFeeParams`[^dydx-community-2026-04-28-modules-governance-fee-tiers]
- Stats Module tracks user maker/taker volumes over 30-day look-back window (governance-adjustable in seconds)[^dydx-community-2026-04-28-modules-governance-fee-tiers][^dydx-docs-2026-04-28-concepts-trading-governance]

## Time series

| effective | tier | taker | maker | source |
|---|---|---|---|---|
| 2026-04-28 (snapshot) | 1 (<$1M) | 0.050% | 0.010% | [^dydx-docs-2026-04-28-concepts-trading-rewards] |
| 2026-04-28 (snapshot) | 2 (>=$1M) | 0.045% | 0.010% | [^dydx-docs-2026-04-28-concepts-trading-rewards] |
| 2026-04-28 (snapshot) | 3 (>=$5M) | 0.040% | 0.005% | [^dydx-docs-2026-04-28-concepts-trading-rewards] |
| 2026-04-28 (snapshot) | 4 (>=$25M) | 0.035% | 0.000% | [^dydx-docs-2026-04-28-concepts-trading-rewards] |
| 2026-04-28 (snapshot) | 5 (>=$50M) | 0.030% | -0.005% | [^dydx-docs-2026-04-28-concepts-trading-rewards] |
| 2026-04-28 (snapshot) | 6 (>=$125M) | 0.028% | -0.008% | [^dydx-docs-2026-04-28-concepts-trading-rewards] |
| 2026-04-28 (snapshot) | 7 (>=$200M) | 0.025% | -0.011% | [^dydx-docs-2026-04-28-concepts-trading-rewards] |

## Tiering rules / formulae
- Volume window: 30-day trailing, tracked by Stats Module (look-back governance-adjustable in seconds)[^dydx-community-2026-04-28-modules-governance-fee-tiers]
- Staking discount: applies only to net positive trading fees (no discount on rebates); only bonded DYDX counts (unbonding does not qualify)[^dydx-docs-2026-04-28-concepts-trading-rewards]

## Disputed values
None.

## Sources
[^dydx-docs-2026-04-28-concepts-trading-rewards]: [[sources/dydx-docs-2026-04-28-concepts-trading-rewards]]
[^dydx-community-2026-04-28-modules-governance-fee-tiers]: [[sources/dydx-community-2026-04-28-modules-governance-fee-tiers]]
[^dydx-docs-2026-04-28-concepts-trading-governance]: [[sources/dydx-docs-2026-04-28-concepts-trading-governance]]
