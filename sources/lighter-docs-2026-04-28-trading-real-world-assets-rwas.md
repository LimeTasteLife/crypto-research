---
type: source
id: lighter-docs-2026-04-28-trading-real-world-assets-rwas
title: Real World Assets (RWAs)
publisher: Lighter Docs
author: Lighter team
date: null
original_url: https://docs.lighter.xyz/trading/real-world-assets-rwas
mirror_snapshot: lighter-docs-2026-04-28
mirror_page: pages/trading-real-world-assets-rwas.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Real World Assets (RWAs)

## TL;DR
Lighter offers RWA perpetual markets (commodities, equities, fixed income) tradeable 24/7. The Lighter Liquidity Provider (LLP) now manages liquidity and liquidations for RWAs, replacing the prior Experimental Liquidity Provider (XLP). RWA positions are subject to liquidations on equal footing with other markets. Leverage does not change outside underlying market hours, but volatility may spike at open. RWAs support both Isolated and Cross Margin modes; opening RWA positions in Cross Margin is currently restricted due to volatility.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Lighter RWA markets cover commodities, equities, and fixed income; they are tradeable 24/7. | [[entities/perpdex/lighter]], [[parameters/lighter/listed-markets-roster]] | A1-PI |
| #c2 | The Lighter Liquidity Provider (LLP) now manages liquidity and handles liquidations for RWA markets. | [[parameters/lighter/llp]] | A4-PI, A6-PI |
| #c3 | The Experimental Liquidity Provider (XLP) was previously the primary liquidity provider for RWA markets, now superseded by LLP for RWAs. | [[parameters/lighter/llp]] | A4-PII |
| #c4 | RWAs are subject to liquidations in the same manner as all other markets on the exchange. | [[concepts/risk/liquidation]], [[parameters/lighter/liquidation-params]] | A6-PI |
| #c5 | Leverage does not change outside trading hours (e.g. a 10x long XAU position remains 10x; no exposure-reduction requirement). | [[parameters/lighter/markets/XAU]] | A6-PII |
| #c6 | Price volatility on RWA markets may increase at the underlying market's open. | [[entities/perpdex/lighter]] | A6-PI |
| #c7 | All RWA markets support both Isolated and Cross Margin modes. | [[parameters/lighter/listed-markets-roster]] | A6-PI |
| #c8 | Opening RWA positions under Cross Margin is currently restricted due to the experimental and volatile nature of these markets. | [[parameters/lighter/listed-markets-roster]] | A6-PII |

## Conflicts raised
- (none within group)
