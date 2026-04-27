---
type: source
id: hl-docs-2026-04-27-trading-robust-price-indices
title: Robust Price Indices
publisher: Hyperliquid Docs
author: Hyperliquid team
date: null
original_url: https://hyperliquid.gitbook.io/hyperliquid-docs/trading/robust-price-indices
mirror_snapshot: hl-docs-2026-04-27
mirror_page: pages/trading-robust-price-indices.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-27
---

# Robust Price Indices

## TL;DR
Defines two robust price indices: oracle price (weighted CEX-only median, used for funding) and mark price (median of three components used for margining, liquidations, TP/SL triggers, and unrealized PnL). The mark price components are: (1) oracle plus a 150-second EMA of the (Hyperliquid mid − oracle) difference, (2) median of HL best bid/ask/last, and (3) weighted median of Binance/OKX/Bybit/Gate/MEXC perp mids (weights 3/2/2/1/1). If only two of the three exist, a 30-second EMA of HL bid/ask/last median is added. Both prices update approximately every 3 seconds. Includes the precise EMA update formula with τ = 2.5 minutes.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Oracle price is used to compute funding rates and is independent of Hyperliquid market data. | [[concepts/market-microstructure/oracle-spec]] | A6-PI |
| #c2 | Oracle prices are updated by validators approximately every 3 seconds. | [[concepts/market-microstructure/oracle-spec]] | A6-PI |
| #c3 | Mark price is the median of: (a) oracle + 150s EMA of (HL mid − oracle), (b) median of HL best bid/best ask/last trade, (c) weighted median of Binance/OKX/Bybit/Gate IO/MEXC perp mids with weights 3/2/2/1/1. | [[concepts/market-microstructure/mark-price-formula]] | A6-PI |
| #c4 | If exactly two of the three mark-price inputs exist, a 30-second EMA of (median of HL best bid/ask/last) is appended to the median inputs. | [[concepts/market-microstructure/mark-price-formula]] | A6-PI |
| #c5 | Mark price is used for margining, liquidations, triggering TP/SL, and computing unrealized PnL. | [[concepts/market-microstructure/mark-price-formula]] | A6-PI |
| #c6 | Mark price updates whenever validators publish new oracle prices (approximately every 3 seconds). | [[concepts/market-microstructure/mark-price-formula]] | A6-PI |
| #c7 | EMA update formula: numerator → numerator * exp(-t/2.5min) + sample*t; denominator → denominator * exp(-t/2.5min) + t; ema = numerator/denominator. | [[concepts/market-microstructure/mark-price-formula]] | A6-PI |
