---
type: source
id: lighter-docs-2026-04-28-trading-funding-funding-rate-rebates
title: Funding Rate Rebates
publisher: Lighter Docs
author: Lighter team
date: null
original_url: https://docs.lighter.xyz/trading/funding/funding-rate-rebates
mirror_snapshot: lighter-docs-2026-04-28
mirror_page: pages/trading-funding-funding-rate-rebates.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Funding Rate Rebates

## TL;DR
Lighter rebates up to 15% of funding paid by the funding-paying side. 6% is automatic for Premium accounts; an additional 9% scales linearly with LIT staked, capped at 9% when 50,000 LIT is staked. The rebate-eligible funding is min(FundingRate, InterestRateComponent) × PositionValue, so rebates effectively cap the "interest-rate-only" portion. Sub-account stakes aggregate with the main account, and a 10% annualized cap applies. Rebates pay out daily at 00:00 UTC as L2 transfers from address 0xc4535ceeA637b3B1bcdf5932603A4DbC00Ad2772 with a $1 minimum payment threshold.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | The Funding Rate Rebates program rebates up to 15% of funding paid on positions paying funding. | [[parameters/lighter/funding-rate-rebates]] | A2-PIV, A6-PI |
| #c2 | The rebate program applies to all markets listed on Lighter. | [[parameters/lighter/funding-rate-rebates]] | A2-PIV |
| #c3 | The position receiving funding is unaffected by the rebate program (only the paying side benefits). | [[parameters/lighter/funding-rate-rebates]] | A2-PIV |
| #c4 | Premium-account traders automatically receive a 6% discount per hourly funding payment. | [[parameters/lighter/funding-rate-rebates]] | A2-PIV |
| #c5 | Traders earn an additional 9% discount through staking LIT, for a 15% combined cap. | [[parameters/lighter/funding-rate-rebates]], [[entities/token/lit]] | A2-PIV |
| #c6 | The staking bonus scales with LIT staked and is capped at 9% when staking 50,000 LIT. | [[parameters/lighter/funding-rate-rebates]], [[entities/token/lit]] | A2-PIV |
| #c7 | Rebate benefit cannot exceed the rebate that would apply if funding rate equaled the interest-rate component. | [[parameters/lighter/funding-rate-rebates]] | A2-PIV |
| #c8 | Eligible funding for rebate = min(FundingRate, InterestRateComponent) × PositionValue. | [[parameters/lighter/funding-rate-rebates]] | A2-PIV |
| #c9 | Rebate amount = EligibleFunding × DiscountPercentage. | [[parameters/lighter/funding-rate-rebates]] | A2-PIV |
| #c10 | Staking-reward scaling exponent is currently set to 1, giving linear scaling up to the 50,000 LIT cap. | [[parameters/lighter/funding-rate-rebates]] | A2-PIV |
| #c11 | The scaling exponent parameter may be adjusted in the future to refine the reward curve. | [[parameters/lighter/funding-rate-rebates]] | A7-PI |
| #c12 | Effective staked LIT is calculated on a consolidated basis across the main account and all sub-accounts. | [[parameters/lighter/funding-rate-rebates]] | A2-PIV |
| #c13 | A 10% annualized cap applies to funding-rate rebates across consolidated accounts. | [[parameters/lighter/funding-rate-rebates]] | A2-PIV |
| #c14 | Rebates are distributed daily at 00:00 UTC as an L2 transfer to the trader's account. | [[parameters/lighter/funding-rate-rebates]] | A2-PIV |
| #c15 | Lighter Rebates Fund address: 0xc4535ceeA637b3B1bcdf5932603A4DbC00Ad2772. | [[parameters/lighter/funding-rate-rebates]] | A2-PIV |
| #c16 | A rebate payment is processed only if the amount exceeds $1. | [[parameters/lighter/funding-rate-rebates]] | A2-PIV |

## Conflicts raised
