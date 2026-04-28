---
type: source
id: aster-docs-2026-04-28-trading-perpetuals-funding-rate
title: Funding Rate
publisher: Aster Docs
author: Aster team
date: null
original_url: https://docs.asterdex.com/trading/perpetuals/fees-and-specs/funding-rate
mirror_snapshot: aster-docs-2026-04-28
mirror_page: pages/trading-perpetuals-funding-rate.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Funding Rate

## TL;DR
Aster's funding rate uses a Binance-style formula: F = [Average Premium Index P + clamp(interest_rate − P, −0.05%, 0.05%)] / (8/N), where interest rate = 0.01% (BNBUSDT is the exception with interest_rate = 0%) and N is the funding interval in hours. The default interval is 8h, though Aster has variable intervals (e.g., ASTERUSDT runs at 4h). The premium index is sampled every 5 seconds using impact-bid/ask prices computed against an Impact Margin Notional (IMN) sized to the contract's max-leverage initial margin. Funding is peer-to-peer between longs and shorts; Aster does not collect or pay funding. There is a 15-second timing deviation between actual time and when funding is charged, and Aster reserves discretion to adjust caps/floors/intervals during extreme volatility.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Funding rate is a periodic payment exchanged between long and short position holders to keep contract price close to spot. | [[concepts/market-microstructure/mark-price-formula]] | - |
| #c2 | Positive funding rate means contract price is above mark price; longs pay shorts. | [[parameters/aster/funding-config]] | - |
| #c3 | Negative funding rate means contract price is below mark price; shorts pay longs. | [[parameters/aster/funding-config]] | - |
| #c4 | There is a 15-second deviation between the actual time and when the funding fee is charged. | [[parameters/aster/funding-config]] | A6-PIV |
| #c5 | A position opened at 16:00:05 UTC may still be charged funding for that interval. | [[parameters/aster/funding-config]] | A6-PIV |
| #c6 | Funding rate formula: F = [Average Premium Index P + clamp(interest_rate − P, −0.05%, 0.05%)] / (8/N). | [[parameters/aster/funding-config]] | A6-PIV |
| #c7 | The default interest rate component is 0.01%. | [[parameters/aster/funding-config]] | A6-PIV |
| #c8 | The BNBUSDT perpetual contract uses an interest rate of 0% (exception to the 0.01% default). | [[parameters/aster/funding-config]], [[parameters/aster/markets/BNBUSDT]] | A6-PIV |
| #c9 | The clamp range on the funding formula is −0.05% to 0.05%. | [[parameters/aster/funding-config]] | A6-PIV |
| #c10 | N denotes the funding interval (hours) in the funding formula divisor 8/N. | [[parameters/aster/funding-config]] | - |
| #c11 | Default funding interval is 8 hours. | [[parameters/aster/funding-config]] | A6-PIV |
| #c12 | ASTERUSDT runs on a 4-hour funding interval. | [[parameters/aster/funding-config]], [[parameters/aster/markets/ASTERUSDT]] | A6-PIV |
| #c13 | Aster reserves the right to adjust funding rate floor, cap, and interval during extreme market volatility. | [[parameters/aster/funding-config]] | A7-PV |
| #c14 | Funding fees are deducted from Perps Account balance; if insufficient, fees may be taken from position margin and impact liquidation price. | [[parameters/aster/funding-config]], [[concepts/risk/liquidation]] | A6-PIV |
| #c15 | Premium index = [max(0, Impact bid price − Index price) − max(0, Index price − Impact ask price)] / Index price. | [[parameters/aster/funding-config]] | - |
| #c16 | Index price is a weighted average price from external spot exchanges. | [[parameters/aster/oracle-config]] | - |
| #c17 | Impact bid price is the average price to sell a fixed notional value using current bid depth. | [[parameters/aster/funding-config]] | - |
| #c18 | Impact ask price is the average price to buy a fixed notional value using current ask depth. | [[parameters/aster/funding-config]] | - |
| #c19 | Aster calculates the premium index every 5 seconds. | [[parameters/aster/funding-config]] | A6-PIV |
| #c20 | For symbols with funding interval > 1 hour, Average Premium Index P is a weighted average: (1·P_1 + 2·P_2 + ... + n·P_n) / (1+2+...+n). | [[parameters/aster/funding-config]] | A6-PIV |
| #c21 | For symbols with funding interval = 1 hour, Average Premium Index P is the simple average of premium index samples. | [[parameters/aster/funding-config]] | A6-PIV |
| #c22 | Impact Margin Notional (IMN) = Impact Margin Amount / Initial Margin Rate at the Maximum Leverage. | [[parameters/aster/funding-config]] | A6-PIV |
| #c23 | The Impact Margin Amount is a configurable parameter that may vary instead of being fixed. | [[parameters/aster/funding-config]] | A7-PV |
| #c24 | Impact bid/ask price uses the order book level x where cumulative quote notional first exceeds IMN. | [[parameters/aster/funding-config]] | - |
| #c25 | Impact Bid Price formula: IMN / [(IMN − Contract Multiplier × Σp_(x-1) × q_(x-1)) / p_x + Contract Multiplier × Σq_(x-1)]. | [[parameters/aster/funding-config]] | - |
| #c26 | Contract multiplier is usually 1. | [[parameters/aster/funding-config]] | - |
| #c27 | Funding amount = Position size × Mark price × Funding rate. | [[parameters/aster/funding-config]] | - |
| #c28 | Aster does not charge or receive funding — funding is a peer-to-peer transfer between longs and shorts. | [[parameters/aster/funding-config]], [[parameters/aster/revenue-distribution]] | A2-PI |
