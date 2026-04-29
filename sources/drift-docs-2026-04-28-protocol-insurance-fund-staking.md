---
type: source
id: drift-docs-2026-04-28-protocol-insurance-fund-staking
title: Insurance Fund Staking
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/protocol/insurance-fund/insurance-fund-staking
mirror_snapshot: drift-docs-2026-04-28
mirror_page: pages/protocol-insurance-fund-staking.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Insurance Fund Staking

## TL;DR
IF stakers earn a proportionate share of the Revenue Pool every hour. Revenue Pool is funded by borrow fees, spot exchange fees, perp exchange fees, and liquidation fees. Each hourly settlement is split between IF Stakers and a protocol-owned IF portion. Stakers' share = `Total Staked Amount / Total Insurance Fund`. Cooldown period for unstaking is 13 days (during which the staked amount earns no rewards). Cannot unstake while spot market utilization (or 1hr utilization TWAP) exceeds 80%. Only one pending unstake request per vault at a time; cancelling and resubmitting restarts the 13-day clock. Worked example in docs: $10k stake into $5k pool = 66.6% of staker payout, getting $10 of a $15 split out of $30 hourly settlement.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Insurance Fund Stakers are rewarded with their proportionate share of the Revenue Pool every hour. | [[parameters/drift/insurance-fund]] | A5-PI |
| #c2 | The Revenue Pool is funded by: borrow fees, spot market exchange fees, perpetual market exchange fees, and liquidation fees. | [[parameters/drift/insurance-fund]] | A2-PI, A5-PI |
| #c3 | Insurance Fund Staker proportionate share = `Total Staked Amount / Total Insurance Fund`. | [[parameters/drift/insurance-fund]] | A5-PI |
| #c4 | Each revenue settlement is split between Insurance Fund Stakers and a protocol-owned portion of the insurance fund. | [[parameters/drift/insurance-fund]] | A5-PI, A2-PI |
| #c5 | The cooldown period for unstaking collateral from the Insurance Fund is 13 days. | [[parameters/drift/insurance-fund]] | A5-PII |
| #c6 | During the unstaking cooldown period, the staked amount does not receive rewards. | [[parameters/drift/insurance-fund]] | A5-PII |
| #c7 | A user cannot unstake while the spot market utilization (or 1hr utilization TWAP) is above 80%. | [[parameters/drift/insurance-fund]] | A5-PII, A6-PI |
| #c8 | A user can have only one pending unstake request per vault at a time. | [[parameters/drift/insurance-fund]] | A5-PII |
| #c9 | Cancelling an unstake request and submitting a new one restarts the 13-day cooldown clock. | [[parameters/drift/insurance-fund]] | A5-PII |
| #c10 | All earned rewards accumulate and compound the staker's insurance amount staked. | [[parameters/drift/insurance-fund]] | A5-PI |
