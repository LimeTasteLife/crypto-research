---
type: source
id: dydx-community-2026-04-28-modules-distribution
title: Distribution
publisher: dYdX Community Docs
author: dYdX community
date: null
original_url: https://docs.dydx.community/dydx/modules/distribution
mirror_snapshot: dydx-community-2026-04-28
mirror_page: pages/modules-distribution.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Distribution

## TL;DR
The distribution module collects all transaction fees (USDC trading fees + USDC and DYDX gas fees) per block and distributes to validators and DYDX stakers proportionally to their staked weight, after subtracting validator commission and community tax. Stakers must claim manually; unclaimed rewards accrue in the Distribution `ModuleAccount`. Staking rewards are not auto-restaked.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | The distribution module collects and distributes rewards between validators and delegators. | [[parameters/dydx-v4/staking-rewards]] | A2-PI |
| #c2 | All transaction fees (USDC trading fees, DYDX-denominated gas fees, USDC-denominated gas fees) collected by the protocol are distributed to validators and DYDX stakers. | [[parameters/dydx-v4/staking-rewards]] | A2-PI |
| #c3 | DYDX stakers are entitled to a portion of: USDC taker trading fees, USDC maker trading fees, USDC-denominated gas fees, and DYDX-denominated gas fees. | [[parameters/dydx-v4/staking-rewards]] | A2-PI |
| #c4 | Fees accrue in the Distribution ModuleAccount each block; stakers may claim each block; unclaimed rewards remain in the module account. | [[parameters/dydx-v4/staking-rewards]] | A2-PI |
| #c5 | Staking Rewards are not automatically staked to a validator; the staker must claim and re-stake to contribute again to network security. | [[parameters/dydx-v4/staking-rewards]] | A2-PI |
| #c6 | Staking rewards calculation depends on validator commission rate (set per validator), community tax (% of fee pool to community pool), staker's bonded DYDX, and total bonded DYDX. | [[parameters/dydx-v4/staking-rewards]] | A2-PI |
| #c7 | Total bonded power = sum of all DYDX self-bonded by validators plus DYDX delegated to validators by holders. | [[parameters/dydx-v4/staking-rewards]] | A2-PI |
