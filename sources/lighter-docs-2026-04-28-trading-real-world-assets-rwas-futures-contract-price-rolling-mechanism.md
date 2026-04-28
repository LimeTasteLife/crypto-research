---
type: source
id: lighter-docs-2026-04-28-trading-real-world-assets-rwas-futures-contract-price-rolling-mechanism
title: Futures Contract Price Rolling Mechanism
publisher: Lighter Docs
author: Lighter team
date: null
original_url: https://docs.lighter.xyz/trading/real-world-assets-rwas/futures-contract-price-rolling-mechanism
mirror_snapshot: lighter-docs-2026-04-28
mirror_page: pages/trading-real-world-assets-rwas-futures-contract-price-rolling-mechanism.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Futures Contract Price Rolling Mechanism

## TL;DR
WTI, NATGAS, and BRENTOIL on Lighter use front-month futures as their underlying. To handle expirations, prices are linearly rolled in 20% increments per business day from the 5th to the 10th business day, ending in a 100% next-month price. The daily roll fires at 5:30 PM ET (WTI, NATGAS) or 7:00 PM ET (BRENTOIL). Underlying markets are closed 5:00–6:00 PM ET (WTI, NATGAS) and 6:00–8:00 PM ET (BRENTOIL).

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | WTI, NATGAS, and BRENTOIL markets use futures contracts as their underlying prices. | [[parameters/lighter/listed-markets-roster]] | A1-PI |
| #c2 | Underlying futures prices are gradually rolled from the current month's contract to the next month's contract between the 5th and 10th business day. | [[concepts/market-microstructure/oracle-spec]] | A6-PI |
| #c3 | Each business day at 5:30 PM ET (WTI and NATGAS), 20% of the price shifts from the front-month to the next-month contract. | [[parameters/lighter/markets/WTI]], [[parameters/lighter/markets/NATGAS]] | A6-PI |
| #c4 | Each business day at 7:00 PM ET (BRENTOIL), 20% of the price shifts from the front-month to the next-month contract. | [[parameters/lighter/markets/BRENTOIL]] | A6-PI |
| #c5 | The roll completes over a five-day window: 100/0 → 80/20 → 60/40 → 40/60 → 20/80 → 0/100 between front- and next-month. | [[concepts/market-microstructure/oracle-spec]] | A6-PI |
| #c6 | Underlying markets for WTI and NATGAS are closed 5:00 PM ET – 6:00 PM ET. | [[parameters/lighter/markets/WTI]], [[parameters/lighter/markets/NATGAS]] | A6-PI |
| #c7 | Underlying market for BRENTOIL is closed 6:00 PM ET – 8:00 PM ET (11 PM London – 1 AM London). | [[parameters/lighter/markets/BRENTOIL]] | A6-PI |

## Conflicts raised
- (none within group)
