---
type: source
id: lighter-docs-2026-04-28-trading-fair-price-marking
title: Fair Price Marking
publisher: Lighter Docs
author: Lighter team
date: null
original_url: https://docs.lighter.xyz/trading/fair-price-marking
mirror_snapshot: lighter-docs-2026-04-28
mirror_page: pages/trading-fair-price-marking.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Fair Price Marking

## TL;DR
Lighter's mark price is the median of three components: (1) Impact Price = average of impact bid and impact ask, where impact-notional is sized at 500 USDC / Initial Margin Fraction; (2) price1 = index + EMA_8min(clamp(ImpactPrice − index, ±index/200)) — i.e. an 8-minute EMA premium, hard-clamped at ±0.5% of index; (3) price2 = median of mark prices reported by external CEXs. The index price comes from Chainlink, Stork, and Pyth oracles in combination. The design rationale is explicit: incorporate impact price directly so liquidations execute close to mark; use EMA over 8 minutes to make order-book manipulation expensive (must be sustained); cap the premium at 0.5% so Lighter's mark cannot deviate from external references by more than 0.5%. This is a multi-source mark formula combining microstructure (impact), time-smoothed Lighter-internal premium, and external CEX consensus, with the median-of-three providing manipulation resistance against any single component.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Mark price on Lighter is the fair price of a perpetual contract. | [[entities/perpdex/lighter]], [[concepts/market-microstructure/mark-price-formula]] | A6-PI |
| #c2 | Lighter mark price is calculated using the liquidity in the perpetual market order book and the index price (spot price of the underlying market). | [[parameters/lighter/oracle-config]] | A6-PI |
| #c3 | Impact Notional Amount on Lighter equals 500 USDC / Initial Margin Fraction. | [[parameters/lighter/oracle-config]] | A6-PI |
| #c4 | Impact Bid Price is the average execution price for a market sell of the impact notional value on Lighter. | [[parameters/lighter/oracle-config]] | A6-PI |
| #c5 | Impact Ask Price is the average execution price for a market buy of the impact notional value on Lighter. | [[parameters/lighter/oracle-config]] | A6-PI |
| #c6 | Impact Price equals (Impact Bid Price + Impact Ask Price) / 2. | [[parameters/lighter/oracle-config]] | A6-PI |
| #c7 | price1 = index + EMA_8min(clamp(ImpactPrice − index, −index/200, +index/200)). | [[parameters/lighter/oracle-config]] | A6-PI |
| #c8 | The clamp bounds in price1 limit the (ImpactPrice − index) input to ±index/200, i.e. ±0.5% of the index price. | [[parameters/lighter/oracle-config]] | A6-PI |
| #c9 | EMA_8min refers to the Exponential Moving Average of the value over 8 minutes. | [[parameters/lighter/oracle-config]] | A6-PI |
| #c10 | price2 = median(cexPrices), where cexPrices are mark prices from different centralized exchanges. | [[parameters/lighter/oracle-config]] | A6-PI |
| #c11 | Mark Price = Median(ImpactPrice, price1, price2). | [[parameters/lighter/oracle-config]] | A6-PI |
| #c12 | Lighter uses a combination of Chainlink, Stork, and Pyth oracles to determine the index price. | [[parameters/lighter/oracle-config]] | A6-PI |
| #c13 | The mark price is used when deciding if liquidations should occur on Lighter, and is therefore designed to reflect impact price as much as possible so that liquidations execute close to mark. | [[parameters/lighter/oracle-config]], [[concepts/risk/liquidation]] | A6-PI |
| #c14 | price1 can be summarized as Index Price + Lighter Perpetual Premium, where the premium is capped at 0.5% of the Index Price. | [[parameters/lighter/oracle-config]] | A6-PI |
| #c15 | The use of an 8-minute EMA in price1 means an attacker would need to manipulate the order book over a prolonged period for the manipulation to affect mark price. | [[parameters/lighter/oracle-config]] | A6-PI |
| #c16 | The 0.5% cap ensures that the mark price on Lighter will not exceed the external components by more than 0.5%. | [[parameters/lighter/oracle-config]] | A6-PI |

## Conflicts raised
- (none)
