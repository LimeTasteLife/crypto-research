---
type: source
id: hl-docs-2026-04-27-trading-fees
title: Trading Fees
publisher: Hyperliquid Docs
author: Hyperliquid team
date: null
original_url: https://hyperliquid.gitbook.io/hyperliquid-docs/trading/fees
mirror_snapshot: hl-docs-2026-04-27
mirror_page: pages/trading-fees.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-27
---

# Trading Fees

## TL;DR
Hyperliquid's fee schedule is volume-tiered (rolling 14-day) with separate perps and spot ladders, plus six staking-tier discounts and three maker-rebate tiers based on share of platform maker volume. Spot volume counts double when computing the perps tier. Sub-account volume aggregates to the master; vault volume is separate. Fees are fully directed to the community: HLP, the Assistance Fund, and HIP-3/spot deployers (deployers may keep up to 50%). The Assistance Fund (system address `0xfefe…fefe`) automatically converts trading fees into HYPE on-chain and burns it, permanently removing supply. Aligned-quote-asset pairs receive 20% lower taker fees, 50% better maker rebates, and 20% extra volume contribution. HIP-3 perps in growth mode have all fees/rebates/volume contributions reduced by 90%, with deployers configurable up to 100% (300% normal mode).

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Fee tiers are based on rolling 14-day volume, assessed daily at UTC end-of-day. | [[parameters/hyperliquid/fee-schedule]] | A2-PI |
| #c2 | Sub-account volume counts toward the master account; all sub-accounts share one fee tier. | [[parameters/hyperliquid/fee-schedule]] | A2-PIV |
| #c3 | Vault volume is treated separately from the master account for fee tier purposes. | [[parameters/hyperliquid/fee-schedule]] | A2-PIV |
| #c4 | Referral rewards apply for a user's first $1B in volume. | [[parameters/hyperliquid/fee-schedule]], [[concepts/incentives/referral-design]] | A3-PII |
| #c5 | Referral discounts apply for a user's first $25M in volume. | [[parameters/hyperliquid/fee-schedule]], [[concepts/incentives/referral-design]] | A3-PII |
| #c6 | Maker rebates are paid out continuously per trade directly to the trading wallet. | [[parameters/hyperliquid/fee-schedule]] | A2-PIII |
| #c7 | Perps and spot volume count together toward fee tier; spot volume counts double: 14d_weighted = 14d_perps + 2*14d_spot. | [[parameters/hyperliquid/fee-schedule]] | A2-PI |
| #c8 | One fee tier applies per user across all assets including perps, HIP-3 perps, and spot. | [[parameters/hyperliquid/fee-schedule]] | A2-PI |
| #c9 | Perps Tier 0 base taker fee is 0.045% and base maker fee is 0.015%. | [[parameters/hyperliquid/fee-schedule]] | A2-PI |
| #c10 | Perps Tier 6 (>$7B 14d weighted volume) base taker is 0.024% and base maker is 0.000%. | [[parameters/hyperliquid/fee-schedule]] | A2-PI |
| #c11 | Spot Tier 0 base taker fee is 0.070% and base maker fee is 0.040%. | [[parameters/hyperliquid/fee-schedule]] | A2-PI |
| #c12 | Spot Tier 6 (>$7B) base taker is 0.025% and base maker is 0.000%. | [[parameters/hyperliquid/fee-schedule]] | A2-PI |
| #c13 | Staking tier Wood (>10 HYPE staked) gives 5% trading fee discount. | [[parameters/hyperliquid/fee-schedule]] | A2-PIV |
| #c14 | Staking tier Bronze (>100 HYPE) gives 10% discount. | [[parameters/hyperliquid/fee-schedule]] | A2-PIV |
| #c15 | Staking tier Silver (>1,000 HYPE) gives 15% discount. | [[parameters/hyperliquid/fee-schedule]] | A2-PIV |
| #c16 | Staking tier Gold (>10,000 HYPE) gives 20% discount. | [[parameters/hyperliquid/fee-schedule]] | A2-PIV |
| #c17 | Staking tier Platinum (>100,000 HYPE) gives 30% discount. | [[parameters/hyperliquid/fee-schedule]] | A2-PIV |
| #c18 | Staking tier Diamond (>500,000 HYPE) gives 40% discount. | [[parameters/hyperliquid/fee-schedule]] | A2-PIV |
| #c19 | Maker rebate Tier 1 (>0.5% of 14d weighted maker volume) yields -0.001% maker fee. | [[parameters/hyperliquid/mm-rebate-tiers]] | A2-PIII, A4-PIII |
| #c20 | Maker rebate Tier 2 (>1.5% of 14d weighted maker volume) yields -0.002%. | [[parameters/hyperliquid/mm-rebate-tiers]] | A2-PIII, A4-PIII |
| #c21 | Maker rebate Tier 3 (>3.0% of 14d weighted maker volume) yields -0.003%. | [[parameters/hyperliquid/mm-rebate-tiers]] | A2-PIII, A4-PIII |
| #c22 | Spot pairs between two spot quote assets ("stable pair") have 80% lower taker fees, maker rebates, and user volume contribution. | [[parameters/hyperliquid/fee-schedule]] | A2-PIV |
| #c23 | Aligned quote assets benefit from 20% lower taker fees, 50% better maker rebates, and 20% more fee-tier volume contribution. | [[parameters/hyperliquid/fee-schedule]] | A2-PIV |
| #c24 | HIP-3 growth mode reduces protocol fees, rebates, volume contributions, and L1 user rate-limit contributions by 90%. | [[parameters/hyperliquid/fee-schedule]] | A2-PIV, A1-PI |
| #c25 | HIP-3 deployers can configure additional fee share between 0–300% (0–100% in growth mode); above 100% the protocol fee scales up to match. | [[parameters/hyperliquid/fee-schedule]] | A2-PI |
| #c26 | All trading fees are directed to the community: HLP, the Assistance Fund, and deployers — the team takes nothing. | [[parameters/hyperliquid/revenue-distribution]], [[concepts/tokenomics/fee-distribution]] | A2-PI |
| #c27 | Spot and HIP-3 perp deployers may keep up to 50% of trading fees on their deployed assets. | [[parameters/hyperliquid/revenue-distribution]] | A2-PI |
| #c28 | The Assistance Fund uses on-chain system address 0xfefefefefefefefefefefefefefefefefefefefe. | [[entities/perpdex/hyperliquid]] |  |
| #c29 | The Assistance Fund automatically converts trading fees into HYPE as part of L1 execution. | [[entities/token/hype]], [[concepts/tokenomics/buyback]] | A2-PI |
| #c30 | HYPE accumulated in the Assistance Fund is burned, permanently removing tokens from circulating and total supply. | [[entities/token/hype]], [[concepts/tokenomics/buyback]] | A2-PI |
| #c31 | A staking user can be permanently linked to a trading user so the staked HYPE attributes to the trading user's fee discount. | [[parameters/hyperliquid/fee-schedule]] |  |
| #c32 | Staking-trading link is permanent and cannot be undone; the staking user gains unilateral control of the trading account funds. | [[parameters/hyperliquid/fee-schedule]] | A8-PII |
| #c33 | Linking requires the trading user to send the action first, finalized by the staking user. | [[parameters/hyperliquid/fee-schedule]] |  |
| #c34 | Outcome tokens (testnet only) charge fees only on close/settle, not on opening positions. | [[entities/perpdex/hyperliquid]] |  |
| #c35 | Stable-pair scaling factor is 0.2 (i.e. 80% reduction) applied to maker rate, taker rate, and volume contribution. | [[parameters/hyperliquid/fee-schedule]] | A2-PI |
| #c36 | Aligned-quote-token taker scale = (1 - deployerShare) * 0.8 + deployerShare; rebate scale = (1 - deployerShare) * 1.5 + deployerShare. | [[parameters/hyperliquid/fee-schedule]] | A2-PI |
