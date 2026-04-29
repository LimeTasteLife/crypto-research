---
type: source
id: dydx-community-2026-04-28-modules-governance-perpetual
title: Perpetual (Governance Adjustable Parameters)
publisher: dYdX Community Docs
author: dYdX community
date: null
original_url: https://docs.dydx.community/dydx/modules/governance/governance-adjustable-parameters/perpetual
mirror_snapshot: dydx-community-2026-04-28
mirror_page: pages/modules-governance-perpetual.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Perpetual (Governance Adjustable Parameters)

## TL;DR
Funding Rate parameters: funding_rate_clamp_factor_ppm = 6,000,000 (6%) — clamps 8h funding rates by `factor × (IM − MM)`; premium_vote_clamp_factor_ppm = 60,000,000 (60%) — clamps 8h premium votes; min_num_votes_per_sample = 15. Epoch info — funding-sample epoch: next_tick 30, duration 60s; funding-tick epoch: duration 3,600s; stats-epoch: duration 3,600s. Funding payments are exchanged directly between traders, not the exchange.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Funding rate is determined algorithmically based on Index Price and Mid-Market Prices, with longs paying shorts when perp trades at a premium and vice versa. | [[concepts/fee-model/funding-rate]], [[parameters/dydx-v4/funding-config]] | A2-PI |
| #c2 | Funding payments are exchanged directly between traders and do not involve the exchange. | [[concepts/fee-model/funding-rate]] | A2-PI |
| #c3 | funding_rate_clamp_factor_ppm = 6,000,000 (6%); used to clamp 8-hour funding rates as `factor × (initial margin − maintenance margin)`. | [[parameters/dydx-v4/funding-config]] | A6-PI |
| #c4 | premium_vote_clamp_factor_ppm = 60,000,000 (60%); used to clamp 8-hour premium votes as `factor × (initial margin − maintenance margin)`. | [[parameters/dydx-v4/funding-config]] | A6-PI |
| #c5 | min_num_votes_per_sample = 15 (minimum number of premium votes per premium sample). | [[parameters/dydx-v4/funding-config]] | A6-PI |
| #c6 | The funding-sample epoch has next_tick = 30, duration = 60 seconds. | [[parameters/dydx-v4/funding-config]] | A6-PI |
| #c7 | The funding-tick epoch has duration = 3,600 seconds. | [[parameters/dydx-v4/funding-config]] | A6-PI |
| #c8 | The stats-epoch has duration = 3,600 seconds. | [[parameters/dydx-v4/fee-schedule]] | A2-PI |
