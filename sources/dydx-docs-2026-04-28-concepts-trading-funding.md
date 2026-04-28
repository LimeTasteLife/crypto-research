---
type: source
id: dydx-docs-2026-04-28-concepts-trading-funding
title: Funding
publisher: dYdX Docs
author: dYdX team
date: null
original_url: https://docs.dydx.xyz/concepts/trading/funding
mirror_snapshot: dydx-docs-2026-04-28
mirror_page: pages/concepts-trading-funding.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Funding

## TL;DR
dYdX funding has two epochs: funding-sample (1 minute, samples premium via median FundingPremiumVote) and funding-tick (1 hour, averages 60 samples). Premium = (Max(0, ImpactBid - Index) - Max(0, Index - ImpactAsk)) / Index. Impact notional = 500 USDC / IMF. Final formula: `Funding Rate = (Premium / 8) + Interest Rate`. Cross-market interest rate component is 0% by default; isolated markets default to 0.125 bps/h (1 bps/8h) per gov vote 220. 8-hour rate cap = 600% × (IMF − MMF) — e.g. 12%/8h for BTC large-cap. Governance can update clamp factors, epoch info, and Liquidity Tier impact notional.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Funding payments anchor the perpetual price to the oracle (underlying) price by paying longs from shorts when the perp trades below underlying and vice versa. | [[concepts/fee-model/funding-rate]] | A2-PI |
| #c2 | Premium = (Max(0, Impact Bid Price − Index Price) − Max(0, Index Price − Impact Ask Price)) / Index Price. | [[parameters/dydx-v4/funding-config]], [[concepts/fee-model/funding-rate]] | A6-PI |
| #c3 | Impact Bid Price = average execution price for a market sell of the impact notional value; Impact Ask Price = average execution price for a market buy of the impact notional value. | [[parameters/dydx-v4/funding-config]] | A6-PI |
| #c4 | Impact Notional Amount = 500 USDC / Initial Margin Fraction. | [[parameters/dydx-v4/funding-config]] | A6-PI |
| #c5 | The proposer determines the premium for each block based on its local view of the order book and proposes a `FundingPremiumVote`. | [[parameters/dydx-v4/funding-config]] | A6-PI |
| #c6 | At the end of each `funding-sample` period (default 1 minute), the median `FundingPremiumVote` is taken as the sample. | [[parameters/dydx-v4/funding-config]] | A6-PI |
| #c7 | At the end of each `funding-tick` period (default 1 hour), the average of past samples is the final funding rate. | [[parameters/dydx-v4/funding-config]] | A6-PI |
| #c8 | Funding Rate = (Premium Component / 8) + Interest Rate Component. | [[parameters/dydx-v4/funding-config]] | A6-PI |
| #c9 | The default interest rate component for cross markets is 0%. | [[parameters/dydx-v4/funding-config]] | A6-PI |
| #c10 | Per governance vote 220, the default interest rate component for isolated markets is 0.125 bps per hour (1 bps per 8 hours). | [[parameters/dydx-v4/funding-config]] | A6-PI, A7-PII |
| #c11 | The 8-hour rate cap is calculated as `600% × (Initial Margin − Maintenance Margin)`. | [[parameters/dydx-v4/funding-config]] | A6-PI |
| #c12 | Large-Cap markets have IMF=5%, MMF=3% and an 8h funding cap of 12%; Mid-Cap IMF=10%, MMF=5%; Long-Tail IMF=20%, MMF=10%. | [[parameters/dydx-v4/funding-config]], [[parameters/dydx-v4/margin-tiers]] | A6-PI, A1-PI |
| #c13 | Governance can adjust funding rate clamp factor, premium vote clamp factor, min number of votes per premium sample, epoch information (funding interval and premium sampling interval), and Liquidity Tier (which defines impact notional value). | [[parameters/dydx-v4/funding-config]] | A7-PI |
