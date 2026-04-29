---
type: parameter
entity: [[entities/perpdex/orderly]]
parameter: fee-schedule
unit: basis-points
last_change: 2026-04-29
last_reviewed: 2026-04-28
disputed: false
---

# Orderly fee-schedule

## Current (as of 2026-04-29)
- Two-layer structure: Orderly base fee (charged to Builder) + Builder custom fee (charged to Trader)[^orderly-docs-2026-04-29-trading-fees]
- Base maker fee: 0.00 bps across all tiers[^orderly-docs-2026-04-29-trading-fees]
- Base taker fees range by Builder Staking Programme tier (volume or $ORDER staked)[^orderly-docs-2026-04-29-trading-fees]
- Builder must charge user fee ≥ Orderly base fee; builder keeps 100% of the margin[^orderly-docs-2026-04-29-trading-fees]
- Fees charged in USDC after every trade, factored into position's average entry price[^orderly-docs-2026-04-29-trading-fees]
- Builders receive daily rebates in fee wallet after deducting referral rebates[^orderly-docs-2026-04-29-custom-fees]
- Permissionless listing builders earn 50% of trading fees + 100% of liquidation fees from their markets[^orderly-docs-2026-04-29-trading-fees]

## Time series

| effective | tier | crypto_taker_bps | rwa_taker_bps | maker_bps | volume_req | staking_req | source |
|-----------|------|------------------|---------------|-----------|------------|-------------|--------|
| 2026-04-29 | Public | 3.00 | 5.00 | 0.00 | none | none | [^orderly-docs-2026-04-29-trading-fees] |
| 2026-04-29 | Silver | 2.75 | 4.75 | 0.00 | ≥$30M/mo | 100K $ORDER | [^orderly-docs-2026-04-29-trading-fees] |
| 2026-04-29 | Gold | 2.50 | 4.50 | 0.00 | ≥$90M/mo | 250K $ORDER | [^orderly-docs-2026-04-29-trading-fees] |
| 2026-04-29 | Platinum | 2.00 | 4.00 | 0.00 | ≥$1B/mo | 2M $ORDER | [^orderly-docs-2026-04-29-trading-fees] |
| 2026-04-29 | Diamond | 1.00 | 3.00 | 0.00 | ≥$10B/mo | 7M $ORDER | [^orderly-docs-2026-04-29-trading-fees] |

## Tiering rules
- Monthly (30-day) aggregate volume includes all activity from Builder and their direct Builder referrals[^orderly-docs-2026-04-29-trading-fees]
- Daily snapshots determine tier eligibility[^orderly-docs-2026-04-29-trading-fees]
- Volume OR staking requirement (either qualifies)[^orderly-docs-2026-04-29-trading-fees]
- Base fee subject to change per Builder Staking Programme[^orderly-docs-2026-04-29-custom-fees]

## Disputed values
None.

## Sources
[^orderly-docs-2026-04-29-trading-fees]: [[sources/orderly-docs-2026-04-29-trading-fees]]
[^orderly-docs-2026-04-29-custom-fees]: [[sources/orderly-docs-2026-04-29-custom-fees]]
