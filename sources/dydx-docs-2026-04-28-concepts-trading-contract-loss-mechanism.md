---
type: source
id: dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism
title: Contract Loss Mechanisms
publisher: dYdX Docs
author: dYdX team
date: null
original_url: https://docs.dydx.xyz/concepts/trading/contract-loss-mechanism
mirror_snapshot: dydx-docs-2026-04-28
mirror_page: pages/concepts-trading-contract-loss-mechanism.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Contract Loss Mechanisms

## TL;DR
Two distinct loss-handling mechanisms layered. Insurance Fund: covers insufficient collateral by aggressing liquidation order limit prices up to a max spread (default 1.5x MMF = 4.5% from oracle). Worked example: $15 of insurance-fund-aggression on a $100 position with 3% MMF allows fill at $0.77 vs the bankruptcy-implied $0.80. Deleveraging: triggers immediately whenever account value goes negative, matching against randomly chosen offsetting positions. The IF is bypassed once balance is negative — deleveraging acts directly. Isolated markets each have their own segregated insurance fund.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | When an account is undercollateralized, the protocol automatically liquidates its positions until the account is sufficiently collateralized or positions are closed. | [[concepts/risk/liquidation]] | A6-PI |
| #c2 | If an account's value turns negative, deleveraging occurs immediately against randomly chosen offsetting positions. | [[concepts/risk/adl-waterfall]] | A6-PI |
| #c3 | The deleveraging mechanism may reduce the expected profits of offsetting accounts. | [[concepts/risk/adl-waterfall]] | A6-PI |
| #c4 | The Insurance Fund covers insufficient collateral by adjusting liquidation order limit prices (up to a max spread from oracle) to improve fill probability. | [[parameters/dydx-v4/insurance-fund]], [[concepts/operations/insurance-fund]] | A6-PI |
| #c5 | By default, the maximum spread at which a liquidation order may be placed from the oracle price is 1.5 × MMF (e.g. 4.5% for a 3% MMF). | [[parameters/dydx-v4/liquidation-params]] | A6-PI |
| #c6 | Once an account balance turns negative, deleveraging occurs immediately without using the insurance fund. | [[concepts/risk/adl-waterfall]] | A6-PI |
| #c7 | If a large price shift occurs in one oracle update, an account may go directly from collateralized to negative and be immediately deleveraged. | [[concepts/risk/adl-waterfall]] | A6-PI |
| #c8 | Isolated markets are markets with segregated pools of collateral and their own individual insurance fund. | [[concepts/risk/insurance-fund-sizing]], [[parameters/dydx-v4/insurance-fund]] | A6-PI |
