---
type: source
id: dydx-community-2026-04-28-modules-governance-fee-tiers
title: Fee Tiers
publisher: dYdX Community Docs
author: dYdX community
date: null
original_url: https://docs.dydx.community/dydx/modules/governance/governance-adjustable-parameters/fee-tiers
mirror_snapshot: dydx-community-2026-04-28
mirror_page: pages/modules-governance-fee-tiers.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Fee Tiers

## TL;DR
Stub on the FeeTiers Module schema. Fee tiers are updated by submitting a parameter-change proposal with `MsgUpdatePerpetualFeeParams`. Three structural characteristics: differs by side (maker/taker), discounts by 30-day trading volume, uniform across all markets. Numeric tier values live on docs.dydx.xyz/concepts/trading/rewards.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | The dYdX fee tier structure was developed to stimulate liquidity, incentivize high-volume traders, and contribute to platform growth and competitiveness. | [[parameters/dydx-v4/fee-schedule]] | A2-PI |
| #c2 | Fee tier updates are submitted via a parameter-change proposal using `MsgUpdatePerpetualFeeParams`. | [[parameters/dydx-v4/fee-schedule]] | A7-PI |
| #c3 | Fee tier structure has three characteristics: (1) different fees for maker vs taker, (2) volume-tier discounts based on each user's 30-day trading volume across sub-accounts and markets, (3) uniform fee structure across all markets. | [[parameters/dydx-v4/fee-schedule]] | A2-PI |
