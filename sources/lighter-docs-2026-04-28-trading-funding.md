---
type: source
id: lighter-docs-2026-04-28-trading-funding
title: Funding
publisher: Lighter Docs
author: Lighter team
date: null
original_url: https://docs.lighter.xyz/trading/funding
mirror_snapshot: lighter-docs-2026-04-28
mirror_page: pages/trading-funding.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Funding

## TL;DR
Lighter pays funding hourly, peer-to-peer with zero exchange fee on the payment. Premium per minute is sampled at random within the minute as a normalized impact-bid-vs-index minus index-vs-impact-ask. The 1-hour premium is the time-weighted average over 60 samples. The funding rate combines a fixed interest-rate component (0.01%) with the premium, applies a small clamp (±0.05%) and a big clamp (±4%), then divides by 8 to spread the 1h figure over an 8h equivalent (CEX convention). Funding payment for an account = −position × mark × fundingRate.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Funding payments occur at each hour mark on Lighter. | [[parameters/lighter/funding-config]] | A6-PI |
| #c2 | Funding payments are fully peer-to-peer with no fees taken by the exchange. | [[parameters/lighter/funding-config]], [[concepts/fee-model/funding-rate]] | A2-PI |
| #c3 | When funding rate is positive, longs pay shorts; when negative, shorts pay longs. | [[concepts/fee-model/funding-rate]] | - |
| #c4 | Lighter samples each market's premium once per minute at a random time within that minute. | [[parameters/lighter/funding-config]] | A6-PI |
| #c5 | Per-minute premium formula: premium_t = (max(0, ImpactBid_t − index_t) − max(0, index_t − ImpactAsk_t)) / index_t. | [[parameters/lighter/funding-config]] | A6-PI |
| #c6 | The 1-hour premium is the time-weighted average of the 60 per-minute premiums in the last hour. | [[parameters/lighter/funding-config]] | A6-PI |
| #c7 | Funding rate = clamp(InterestRate + premium + clamp(−premium, −SmallClamp, +SmallClamp), −BigClamp, +BigClamp) / 8. | [[parameters/lighter/funding-config]] | A6-PI |
| #c8 | Default SmallClamp = 0.05% for the majority of markets. | [[parameters/lighter/funding-config]] | A6-PI |
| #c9 | Default BigClamp = 4% for the majority of markets. | [[parameters/lighter/funding-config]] | A6-PI |
| #c10 | Default InterestRate component = 0.01% for the majority of markets. | [[parameters/lighter/funding-config]] | A6-PI |
| #c11 | Dividing the 1h premium by 8 spreads premium-funding payments over 8 hours, aligning Lighter with the CEX 8h convention. | [[parameters/lighter/funding-config]] | A6-PI |
| #c12 | Per-account funding for market j: funding_{i,j} = (−1) × position_{i,j} × mark_j × fundingRate_j. | [[parameters/lighter/funding-config]] | A6-PI |
| #c13 | Lighter implements perpetual-futures funding to anchor perp price to the spot/index price. | [[entities/perpdex/lighter]], [[concepts/fee-model/funding-rate]] | A6-PI |

## Conflicts raised
