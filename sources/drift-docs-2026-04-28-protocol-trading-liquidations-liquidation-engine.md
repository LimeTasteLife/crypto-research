---
type: source
id: drift-docs-2026-04-28-protocol-trading-liquidations-liquidation-engine
title: Liquidation Engine
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/protocol/trading/liquidations/liquidation-engine
mirror_snapshot: drift-docs-2026-04-28
mirror_page: pages/protocol-trading-liquidations-liquidation-engine.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Liquidation Engine

## TL;DR
Drift uses partial liquidation with a slot-based pacing window (default 25 slots): if price keeps going against the user, liquidation accelerates; if price improves, it decelerates. The buffer leaves liquidated accounts slightly behind a safe margin buffer instead of right at maintenance margin, to reduce immediate re-liquidation risk while staying close enough for leverage users. Liquidation references the oracle price, NOT mark price. The engine compares current oracle to the 5-min oracle TWAP — if deviation is ≥50%, liquidations are temporarily blocked to wait for confirmation. The Insurance Fund (USDC + per-asset SOL/BTC/ETH funds) is the first solvency backstop. Per-market perp coverage is bounded; spot is covered in full. The bankruptcy waterfall is: external IF → internal vAMM lifetime profit → socialized loss across remaining open positions in that market.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Drift uses partial liquidation: instead of closing the entire position at once, the system liquidates portions over time, throttled across multiple slots. | [[concepts/risk/liquidation]] | A6-PI |
| #c2 | The buffer system places liquidated accounts slightly behind a safe margin buffer rather than right at maintenance margin, to reduce immediate re-liquidation risk. | [[concepts/risk/liquidation]] | A6-PI |
| #c3 | Drift's liquidation engine accelerates liquidation if the price keeps moving against the user and slows it down if the price moves in favor. | [[concepts/risk/liquidation]] | A6-PI |
| #c4 | Liquidation pacing happens over a slot-based window set to 25 slots by default. | [[parameters/drift/liquidation-params]] | A6-PI |
| #c5 | Liquidations on Drift are not triggered directly by the mark price; the engine references the oracle price for liquidation thresholds. | [[concepts/risk/liquidation]] | A6-PI |
| #c6 | The engine compares current oracle price with the 5-minute oracle TWAP to detect outliers. | [[concepts/risk/liquidation]] | A6-PI |
| #c7 | If oracle price deviates ≥50% from the 5-minute oracle TWAP, liquidations are temporarily blocked to await additional oracle confirmation. | [[parameters/drift/liquidation-params]] | A6-PI |
| #c8 | The Insurance Fund covers trader losses that exceed account balances; users can stake USDC, SOL, BTC, or ETH and earn a share of trading and liquidation fees. | [[parameters/drift/insurance-fund]] | A5-PI, A6-PI |
| #c9 | Insurance Fund coverage scope: spot markets are covered in full; perpetual markets are covered up to a per-market limit. | [[parameters/drift/insurance-fund]] | A6-PI |
| #c10 | Each asset has its own Insurance Fund; the USDC fund backs both perps and borrow/lend; SOL, BTC, and ETH funds cover borrow/lend losses specific to those assets. | [[parameters/drift/insurance-fund]] | A6-PI |
| #c11 | The Insurance Fund accumulates capital through user staking (deposits) and a portion of trading, borrowing, and liquidation fees. | [[parameters/drift/insurance-fund]] | A5-PI, A2-PI |
| #c12 | Perp bankruptcy resolution hierarchy: external Insurance Fund (USDC) covers debt up to per-market limit, then vAMM lifetime profit (internal insurance) covers remainder, then socialized loss applies pro rata across all open positions in that market. | [[parameters/drift/insurance-fund]], [[concepts/risk/insurance-fund-sizing]] | A6-PI |
| #c13 | The system aims to keep socialized losses as close to zero as possible. | [[parameters/drift/insurance-fund]] | A6-PI |
