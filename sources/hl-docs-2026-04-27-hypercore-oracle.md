---
type: source
id: hl-docs-2026-04-27-hypercore-oracle
title: HyperCore Oracle
publisher: Hyperliquid Docs
author: Hyperliquid team
date: null
original_url: https://hyperliquid.gitbook.io/hyperliquid-docs/hypercore/oracle
mirror_snapshot: hl-docs-2026-04-27
mirror_page: pages/hypercore-oracle.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-27
---

# HyperCore Oracle

## TL;DR
Validators publish per-perp spot oracle prices every 3 seconds. These prices feed both funding-rate computation and the mark price (which is used for margining, liquidations, and TP/SL triggering). Oracle prices are computed as the weighted median of CEX spot mids — Binance (3), OKX (2), Bybit (2), Kraken (1), Kucoin (1), Gate (1), MEXC (1), and Hyperliquid spot (1). Special-case rules: assets whose primary spot liquidity is on Hyperliquid (e.g. HYPE) exclude external sources until liquidity reaches a threshold; assets with primary liquidity off-Hyperliquid (e.g. BTC) exclude Hyperliquid spot. The clearinghouse uses the stake-weighted median across validator submissions as the final price.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Validators publish spot oracle prices for each perp asset every 3 seconds. | [[concepts/market-microstructure/oracle-spec]], [[entities/perpdex/hyperliquid]] | A1-PI |
| #c2 | Oracle prices feed funding-rate computation and mark-price construction. | [[concepts/market-microstructure/oracle-spec]], [[concepts/market-microstructure/mark-price-formula]] | A6-PI |
| #c3 | Spot oracle weights: Binance 3, OKX 2, Bybit 2, Kraken 1, Kucoin 1, Gate 1, MEXC 1, Hyperliquid spot 1. | [[parameters/hyperliquid/oracle-config]] | A1-PI |
| #c4 | Perps on assets with primary spot liquidity on Hyperliquid (e.g. HYPE) exclude external CEX sources until sufficient liquidity is met. | [[concepts/market-microstructure/oracle-spec]] | A1-PI |
| #c5 | Perps on assets with primary spot liquidity outside Hyperliquid (e.g. BTC) exclude Hyperliquid spot from the oracle. | [[concepts/market-microstructure/oracle-spec]] | A1-PI |
| #c6 | The clearinghouse uses the stake-weighted median of validator-submitted oracle prices as the final price. | [[parameters/hyperliquid/oracle-config]] | A1-PI |
