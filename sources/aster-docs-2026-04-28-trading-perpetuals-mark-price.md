---
type: source
id: aster-docs-2026-04-28-trading-perpetuals-mark-price
title: Mark Price
publisher: Aster Docs
author: Aster team
date: null
original_url: https://docs.asterdex.com/trading/perpetuals/fees-and-specs/mark-price
mirror_snapshot: aster-docs-2026-04-28
mirror_page: pages/trading-perpetuals-mark-price.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Mark Price

## TL;DR
Aster's mark price is the median of three components: (1) Price Index × (1 + Funding rate × time-to-next-funding/8); (2) Price Index + a 5-minute moving average of (bid1+ask1)/2 minus Price Index; (3) the contract price. The Price Index itself is a volume-weighted average from major spot exchanges (Binance, HTX, Kraken, Huobi cited as examples). Protective measures kick in when an exchange deviates >5% from the median (its weight is set to zero), when multiple deviations occur (median replaces weighted average), when an exchange feed lags >3 seconds (excluded), and when contract trades stray >5% from mark for >5 seconds (contract price is replaced by mark in calculations). Mark price drives unrealized PnL, liquidation triggers, and funding payments.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Mark Price serves as the reference for calculating unrealized PnL and triggering liquidations. | [[concepts/market-microstructure/mark-price-formula]] | - |
| #c2 | Mark Price is designed to prevent unnecessary forced liquidations during abnormal volatility. | [[concepts/market-microstructure/mark-price-formula]] | - |
| #c3 | Price Index is a weighted average from major spot exchanges including Binance, HTX, Kraken, and other key markets. | [[parameters/aster/oracle-config]] | A6-PIV |
| #c4 | Exchanges with higher trading volume carry greater weight in the Price Index. | [[parameters/aster/oracle-config]] | A6-PIV |
| #c5 | Example: BTC perpetuals' index includes BTC/USDT prices from Binance, Kraken, and Huobi weighted by trading volume. | [[parameters/aster/oracle-config]] | A6-PIV |
| #c6 | Mark Price is the median of three values: Price 1, Price 2, and Contract Price. | [[concepts/market-microstructure/mark-price-formula]] | - |
| #c7 | Price 1 = Price index × (1 + Funding rate × (Time to next funding rate in hours ÷ 8)). | [[parameters/aster/oracle-config]] | A6-PIV |
| #c8 | Price 2 = Price index + 5-minute moving average of ((Bid 1 + Ask 1) ÷ 2 − Price index). | [[parameters/aster/oracle-config]] | A6-PIV |
| #c9 | The 5-minute moving average is sampled every minute over a 5-minute interval. | [[parameters/aster/oracle-config]] | A6-PIV |
| #c10 | If a single exchange's price deviates more than 5% from the median of all sources, that exchange's weight is set to zero. | [[parameters/aster/oracle-config]] | A6-PIV |
| #c11 | If multiple exchanges show deviations above 5%, the median of all sources replaces the weighted average for index calculation. | [[parameters/aster/oracle-config]] | A6-PIV |
| #c12 | If an exchange fails to update its price feed within 3 seconds, it is removed from the price index calculation. | [[parameters/aster/oracle-config]] | A6-PIV |
| #c13 | If the latest contract trade deviates more than 5% from Mark Price and no new trade occurs within 5 seconds, contract price is replaced with mark price in calculations. | [[parameters/aster/oracle-config]] | A6-PIV |
| #c14 | Mark Price determines unrealized PnL for open positions. | [[concepts/market-microstructure/mark-price-formula]] | - |
| #c15 | Mark Price is used as the liquidation reference price. | [[concepts/risk/liquidation]] | - |
| #c16 | Funding payments between longs and shorts are calculated using Mark Price. | [[parameters/aster/funding-config]] | - |
| #c17 | Median selection example: if Price 1 < Price 2 < Contract Price, then Price 2 is selected as Mark Price. | [[parameters/aster/oracle-config]] | - |
