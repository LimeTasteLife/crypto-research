---
type: source
id: drift-docs-2026-04-28-protocol-trading-perpetuals-funding-rates
title: Funding Rates
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/protocol/trading/perpetuals-trading/funding-rates
mirror_snapshot: drift-docs-2026-04-28
mirror_page: pages/protocol-trading-perpetuals-funding-rates.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Funding Rates

## TL;DR
Drift funding rate per hour = `1/24 * (market_twap − oracle_twap) / oracle_twap`. TWAPs are EMAs with span = 1 hour; mark TWAP = (bid_twap + ask_twap) / 2. Settlement is on the hour (10:00 AM, etc.). Hourly magnitude is clamped by Contract Tier — B+: 0.125%; C: 0.208%; below C: 0.4167%. If no trades occur in the first ~20 minutes of the hour, the next funding update is delayed by an additional hour. Funding rates are updated lazily on user actions (open/close/deposit). Drift uses Capped Symmetric Funding: when long-short imbalance exists, the per-market Rebate Pool covers the cost delta — but only up to 2/3 of the Rebate Pool's available balance per interval — to prevent the Insurance Fund being drained by funding. Cumulative funding rate accrues to position even between user actions and shows as Unrealized P&L.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Funding rate payments are the incentive mechanism that brings perpetual mark price in line with oracle price. | [[concepts/fee-model/funding-rate]] | - |
| #c2 | Drift Funding Rate (per hour) = `1/24 * (market_twap − oracle_twap) / oracle_twap`. | [[parameters/drift/funding-config]], [[concepts/fee-model/funding-rate]] | A6-PI |
| #c3 | Mark TWAP = (bid_twap + ask_twap) / 2. | [[parameters/drift/funding-config]] | A6-PI |
| #c4 | TWAP parameters are EMA with span = 1 hour. | [[parameters/drift/funding-config]] | A6-PI |
| #c5 | Funding settlement frequency is at end of hour (e.g. 9:00 AM, 10:00 AM). | [[parameters/drift/funding-config]] | A6-PI |
| #c6 | Funding rate hourly magnitudes are clamped by Contract Tier: B or greater = 0.125%; C = 0.208%; lower than C = 0.4167%. | [[parameters/drift/funding-config]] | A6-PI |
| #c7 | If no market trades or funding update calls occur within the first ~20 minutes of the hour, the next funding update is delayed by an additional hour. | [[parameters/drift/funding-config]] | A6-PI |
| #c8 | Funding rates are updated lazily — every time a user opens or closes a position the exchange tries to update the funding rate. | [[parameters/drift/funding-config]] | A6-PI |
| #c9 | Cumulative funding rate is checked against user positions in case the off-chain funding bot fails — it appears as Unrealised P&L until next user action. | [[concepts/fee-model/funding-rate]] | A6-PI |
| #c10 | Funding payments may not pay out for markets that trade infrequently. | [[concepts/fee-model/funding-rate]] | A6-PI |
| #c11 | Drift uses Capped Symmetric Funding: a per-market Rebate Pool covers the cost delta when long-short imbalance exists. | [[parameters/drift/funding-config]] | A6-PI |
| #c12 | Funding payment from the Rebate Pool is capped at 2/3 of the Rebate Pool balance available at each funding interval. | [[parameters/drift/funding-config]] | A6-PI |
| #c13 | The Rebate Pool funding cap protects the Insurance Fund from being drained by funding rates. | [[parameters/drift/funding-config]], [[parameters/drift/insurance-fund]] | A6-PI |
| #c14 | Drift's on-chain calculation of a market's oracle TWAP is updated only on trades and incorporates the oracle's confidence interval and interpolations. | [[parameters/drift/oracle-config]] | A6-PI |
| #c15 | Funding APR is calculated as `rate × 24 × 365.25`. | [[concepts/fee-model/funding-rate]] | - |
| #c16 | Funding APY is calculated as `(1 + rate) ^ (24 × 365.25) − 1`. | [[concepts/fee-model/funding-rate]] | - |
