---
type: source
id: aster-docs-2026-04-28-trading-perpetuals-market-maker-program
title: Market Maker program
publisher: Aster Docs
author: Aster team
date: null
original_url: https://docs.asterdex.com/trading/perpetuals/market-maker-program
mirror_snapshot: aster-docs-2026-04-28
mirror_page: pages/trading-perpetuals-market-maker-program.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Market Maker program

## TL;DR
Aster's MM program offers three preferential tiers — MM1 ($150M / 0.25% maker share, 2.3 bps taker / -0.25 bps maker), MM2 ($300M / 0.5%, 2.0 / -0.35), and MM3 ($600M / 1%, 1.6 / -0.5) — gated on rolling 14-day volume. Maker rebates accrue but display as 0 in the UI; they're hourly-disbursed via the published schedule and visible in transaction history. To count, a pair must meet a strict quoting standard for ≥70% of the UTC day: bid/offer sizes ≥ minimum, spread ≤ pair-specific cap (0.10% for BTC/ETH/SOL; 0.25% for most other crypto perps; 1.00% for equity perps like AAPL/TSLA/NVDA), and orders must remain live ≥0.5 seconds. Falling below 70% qualifying excludes that pair's volume from MM credit and disqualifies it the next day. Application requires ≥$100M monthly futures volume (any platform) and IP whitelisting at MM1 entry. Aster reserves unilateral right to modify, suspend, or terminate the program.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | The Aster Market Maker program updates the maker fee structure to ensure liquidity for perpetual pairs. | [[parameters/aster/mm-rebate-tiers]] | A4-PIII |
| #c2 | MM1 tier criteria (rolling 14 days): ≥ $150M volume OR Maker Volume ≥ 0.25%. | [[parameters/aster/mm-rebate-tiers]] | A4-PIII |
| #c3 | MM1 tier fees: Taker 2.3 bps, Maker -0.25 bps. | [[parameters/aster/mm-rebate-tiers]] | A2-PIII, A4-PIII |
| #c4 | MM2 tier criteria (rolling 14 days): ≥ $300M volume OR Maker Volume ≥ 0.5%. | [[parameters/aster/mm-rebate-tiers]] | A4-PIII |
| #c5 | MM2 tier fees: Taker 2.0 bps, Maker -0.35 bps. | [[parameters/aster/mm-rebate-tiers]] | A2-PIII, A4-PIII |
| #c6 | MM3 tier criteria (rolling 14 days): ≥ $600M volume OR Maker Volume ≥ 1%. | [[parameters/aster/mm-rebate-tiers]] | A4-PIII |
| #c7 | MM3 tier fees: Taker 1.6 bps, Maker -0.5 bps. | [[parameters/aster/mm-rebate-tiers]] | A2-PIII, A4-PIII |
| #c8 | Maker rebates display as Maker fee 0 in the trading UI but are calculated and disbursed hourly per the published schedule. | [[parameters/aster/mm-rebate-tiers]] | A4-PV |
| #c9 | Maker rebate disbursements can be tracked in transaction history under Aster Perpetual. | [[parameters/aster/mm-rebate-tiers]] | A4-PV |
| #c10 | A maker's volume on a pair is counted as effective only if Bid and Offer sizes meet or exceed the minimum size requirement. | [[parameters/aster/mm-rebate-tiers]] | A4-PIII |
| #c11 | A maker's volume requires Bid-Offer spread within the allowed limit (≤0.1% for BTC/ETH/SOL, ≤0.25% for other pairs). | [[parameters/aster/mm-rebate-tiers]] | A4-PIII |
| #c12 | A maker's orders must remain live in the orderbook for at least 0.5 seconds at a time to qualify. | [[parameters/aster/mm-rebate-tiers]] | A4-PIII |
| #c13 | A pair only counts if the MM maintains quoting standards for ≥70% of the UTC trading day (00:00–23:59 UTC). | [[parameters/aster/mm-rebate-tiers]] | A4-PIII |
| #c14 | If qualifying percentage on a pair is < 70%, that pair's volume is excluded from MM's effective maker volume. | [[parameters/aster/mm-rebate-tiers]] | A4-PIII |
| #c15 | If qualifying percentage on a pair is < 70%, that pair does not qualify for preferential fees on the next day. | [[parameters/aster/mm-rebate-tiers]] | A4-PIII |
| #c16 | Bid/Offer spread is computed as ([Offer price at Min Size] − [Bid price at Min Size]) / (avg of the two prices) and must be < required spread. | [[parameters/aster/mm-rebate-tiers]] | A4-PIII |
| #c17 | BTCUSDT MM qualifying spread is 0.10% with minimum size 2 contracts. | [[parameters/aster/mm-rebate-tiers]], [[parameters/aster/markets/BTCUSDT]] | A4-PIII |
| #c18 | ETHUSDT MM qualifying spread is 0.10% with minimum size 60 contracts. | [[parameters/aster/mm-rebate-tiers]], [[parameters/aster/markets/ETHUSDT]] | A4-PIII |
| #c19 | SOLUSDT MM qualifying spread is 0.10% with minimum size 1,000 contracts. | [[parameters/aster/mm-rebate-tiers]], [[parameters/aster/markets/SOLUSDT]] | A4-PIII |
| #c20 | Most non-BTC/ETH/SOL crypto perps use a 0.25% qualifying spread. | [[parameters/aster/mm-rebate-tiers]] | A4-PIII |
| #c21 | Equity-style perps (AAPLUSDT, TSLAUSDT, NVDAUSDT, AMZNUSDT, METAUSDT, GOOGUSDT, MSFTUSDT) use a 1.00% qualifying spread. | [[parameters/aster/mm-rebate-tiers]], [[parameters/aster/listed-markets-roster]] | A1-PI, A4-PIII |
| #c22 | ASTERUSDT MM qualifying spread is 0.25% with minimum size 30,000. | [[parameters/aster/mm-rebate-tiers]], [[parameters/aster/markets/ASTERUSDT]] | A4-PIII |
| #c23 | HYPEUSDT MM qualifying spread is 0.25% with minimum size 800. | [[parameters/aster/mm-rebate-tiers]], [[parameters/aster/markets/HYPEUSDT]] | A4-PIII |
| #c24 | Pair "Type" column includes values H (likely indicating a high-correlation/host listing) and N (likely standard) — examples: BNBUSDT=H, ETHUSDT=Not Applicable, ADAUSDT=N. | [[parameters/aster/mm-rebate-tiers]] | A4-PIII |
| #c25 | The full MM qualification table covers 250+ pairs spanning crypto perps, equity perps, and commodity perps. | [[parameters/aster/listed-markets-roster]] | A1-PI |
| #c26 | MM applicants must have minimum $100M USD monthly futures cumulative trading volume (on Aster or other trading platforms). | [[parameters/aster/mm-rebate-tiers]] | A4-PIII |
| #c27 | If eligible, Aster whitelists the MM's IPs and configures fees starting from Tier 1. | [[parameters/aster/mm-rebate-tiers]] | A4-PV |
| #c28 | The Aster team contacts MM applicants within three working days. | [[parameters/aster/mm-rebate-tiers]] | A4-PV |
| #c29 | Aster reserves the right to modify, suspend, or terminate the Market Maker Reward Program at any time. | [[parameters/aster/mm-rebate-tiers]] | A7-PV |
| #c30 | Modifications may include changes in eligibility criteria, reward allocation methodology, token distribution schedules, and qualifying requirements. | [[parameters/aster/mm-rebate-tiers]] | A7-PV |
| #c31 | Participation in the MM program does not constitute a binding agreement. | [[parameters/aster/mm-rebate-tiers]] | A7-PV, A9-PV |
| #c32 | Aster retains full discretion in interpretation and enforcement of program rules. | [[parameters/aster/mm-rebate-tiers]] | A7-PV |
