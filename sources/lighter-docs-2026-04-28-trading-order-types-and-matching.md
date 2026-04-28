---
type: source
id: lighter-docs-2026-04-28-trading-order-types-and-matching
title: Order Types & Matching
publisher: Lighter Docs
author: Lighter team
date: null
original_url: https://docs.lighter.xyz/trading/order-types-and-matching
mirror_snapshot: lighter-docs-2026-04-28
mirror_page: pages/trading-order-types-and-matching.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Order Types & Matching

## TL;DR
Lighter supports market, limit, stop-loss/take-profit (with optional limit variants), and TWAP orders, with Reduce-Only, Post-Only, GTT (Good-Til-Time), and IOC (Immediate-or-Cancel) modifiers. TWAPs slice a parent order across the running time, posting a new market child every 30 seconds with size = total/(running_time/30s + 1). The matching engine enforces price-time priority and executes at the maker's price, with post-only auto-cancel if a crossing exists at placement. Distinctively, Lighter's matcher is verifiable: it asserts that price-time priority compliance is enforced via SNARK proofs, making it cryptographically impossible for the matcher to act maliciously. Risk is enforced post-trade — every fill is validated against account health, and an Order Margin reservation is taken on every limit order to prevent placing orders that would auto-cancel at fill time. Finally, fat-finger checks gate limit prices to ±5% of max(MarkPrice,bestBid) / min(MarkPrice,bestAsk) (or just MarkPrice if no opposite-side quotes), and the same bounds apply to SL/TP limit trigger prices.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | A market order on Lighter executes immediately at the current market price for a given position size. | [[entities/perpdex/lighter]] | A1-PI |
| #c2 | Users can set an average execution price on a market order to limit how much the execution price can deviate from the order book mid-price. | [[entities/perpdex/lighter]] | A1-PI |
| #c3 | If liquidity is insufficient or subsequent fills would cause the average execution price to exceed the user-set limit, the market order is partially filled. | [[entities/perpdex/lighter]] | A1-PI |
| #c4 | The Reduce-Only execution option ensures that changes to the position only move it closer to zero, regardless of position direction. | [[entities/perpdex/lighter]] | A1-PI |
| #c5 | A limit order on Lighter is a buy or sell order that executes at the user-set limit price or better. | [[entities/perpdex/lighter]] | A1-PI |
| #c6 | The Post-Only execution option ensures a limit order is placed only as a maker order and is auto-canceled if crossing orders exist on the opposite side at placement. | [[entities/perpdex/lighter]] | A2-PIII |
| #c7 | Post-Only limit orders that pass the placement check are guaranteed to act only as maker orders and pay maker fees for any trades. | [[entities/perpdex/lighter]] | A2-PIII |
| #c8 | Reduce-Only limit orders reduce position size toward zero, executing partially if the order size exceeds the position, with any remaining portion canceled once the position reaches zero. | [[entities/perpdex/lighter]] | A1-PI |
| #c9 | The Good 'Til Time time-in-force option lets users specify a time after which an active order in the order book is automatically canceled. | [[entities/perpdex/lighter]] | A1-PI |
| #c10 | The Immediate or Cancel time-in-force option auto-cancels any unfilled portion at placement and is never placed into the order book as a maker order. | [[entities/perpdex/lighter]] | A1-PI |
| #c11 | A stop-loss order is an instruction to sell or buy an asset when its price hits a trigger price, with the goal of limiting potential losses. | [[entities/perpdex/lighter]] | A1-PI |
| #c12 | A take-profit order specifies a trigger price at which an asset will be sold or bought to lock in gains. | [[entities/perpdex/lighter]] | A1-PI |
| #c13 | Stop-loss and take-profit orders on Lighter are automatically triggered. | [[entities/perpdex/lighter]] | A1-PI |
| #c14 | A stop-loss limit order combines the stop-loss trigger with a limit order, ensuring execution only at the specified price or better once the mark price reaches the trigger. | [[entities/perpdex/lighter]] | A1-PI |
| #c15 | A take-profit limit order sets a price at which the asset will be sold/bought to secure profits, but only if the market price meets or exceeds the trigger price. | [[entities/perpdex/lighter]] | A1-PI |
| #c16 | Stop-loss sell orders and take-profit buy orders trigger when markPrice ≤ triggerPrice. | [[entities/perpdex/lighter]] | A6-PI |
| #c17 | Stop-loss buy orders and take-profit sell orders trigger when markPrice ≥ triggerPrice. | [[entities/perpdex/lighter]] | A6-PI |
| #c18 | The Good 'Til Time option for SL/TP limit orders allows a user-set expiration after which the order is canceled if not triggered. | [[entities/perpdex/lighter]] | A1-PI |
| #c19 | A TWAP order on Lighter executes a large parent order across a specified time period, aiming to match the asset's average price over the execution period. | [[entities/perpdex/lighter]] | A4-PI |
| #c20 | A TWAP order's running time defines the total time over which the order is filled. | [[entities/perpdex/lighter]] | A4-PI |
| #c21 | Every 30 seconds during a TWAP run, a new market order is placed with size = total amount / #orders. | [[entities/perpdex/lighter]] | A4-PI |
| #c22 | TWAP #orders is calculated as #orders = (execution duration / 30s) + 1. | [[entities/perpdex/lighter]] | A4-PI |
| #c23 | Reduce-Only TWAP orders execute only trades that move the position toward zero and continue until expiration even if the position reaches zero. | [[entities/perpdex/lighter]] | A1-PI |
| #c24 | The Lighter Matching Engine performs risk checks after every trade to ensure trading account health. | [[entities/perpdex/lighter]] | A6-PI |
| #c25 | A trade must not cause a currently healthy account on Lighter to become unhealthy. | [[entities/perpdex/lighter]] | A6-PI |
| #c26 | If an account is unhealthy prior to a trade on Lighter, the trade must improve the account's health. | [[entities/perpdex/lighter]] | A6-PI |
| #c27 | If a trade violates the post-trade risk checks, the Lighter Matching Engine auto-cancels the corresponding order(s). | [[entities/perpdex/lighter]] | A6-PI |
| #c28 | The Lighter Risk Engine employs a margining system for limit orders placed onto the book, where each limit order consumes a certain amount of Order Margin. | [[entities/perpdex/lighter]] | A6-PI |
| #c29 | Order Margin does not affect position margin and is used only as a placement-check mechanism. | [[entities/perpdex/lighter]] | A6-PI |
| #c30 | Order Margin usage does not affect liquidations on Lighter. | [[entities/perpdex/lighter]] | A6-PI |
| #c31 | orderValue_{ask/bid} is the sum over active limit orders on a side of (limitPrice_i × orderSize_i). | [[entities/perpdex/lighter]] | A6-PI |
| #c32 | Same-side order margin per side equals orderValue_{ask/bid} / leverage. | [[entities/perpdex/lighter]] | A6-PI |
| #c33 | For Cross Margin accounts, opposite-side order margin equals (orderValue_{ask/bid} − 2 × abs(position) × markPrice) / leverage. | [[entities/perpdex/lighter]] | A6-PI |
| #c34 | For Isolated Margin accounts, opposite-side order margin equals orderValue_{ask/bid} / leverage − TAV_{isolated} − IMR_{isolated}. | [[entities/perpdex/lighter]] | A6-PI |
| #c35 | Available order margin for market i equals TAV_{cross} − IMR_{cross} − M_other − M_current. | [[entities/perpdex/lighter]] | A6-PI |
| #c36 | M_other is the sum over markets other than mi of max(orderMargin_{i,sameSide}, orderMargin_{i,oppositeSide}). | [[entities/perpdex/lighter]] | A6-PI |
| #c37 | M_current equals orderMargin_{mi,sameSide} when the new order's side equals the position's side, else orderMargin_{mi,oppositeSide}. | [[entities/perpdex/lighter]] | A6-PI |
| #c38 | Lighter performs price checks to guarantee that order prices remain within acceptable and realistic ranges. | [[entities/perpdex/lighter]] | A6-PI |
| #c39 | The Fat Finger Prevention check ensures that the price of a limit order is within a reasonable range to prevent errors. | [[entities/perpdex/lighter]] | A6-PI |
| #c40 | For an ask limit order, the price must be at least max(MarkPrice, bestBid) × 0.95. | [[entities/perpdex/lighter]] | A6-PI |
| #c41 | For a bid limit order, the price must be at most min(MarkPrice, bestAsk) × 1.05. | [[entities/perpdex/lighter]] | A6-PI |
| #c42 | If bestBid or bestAsk does not exist, the Fat Finger check uses only markPrice for validation. | [[entities/perpdex/lighter]] | A6-PI |
| #c43 | The Fat Finger check applies to SL/TP limit orders using the order's TriggerPrice instead of the MarkPrice. | [[entities/perpdex/lighter]] | A6-PI |
| #c44 | The Lighter Matching Engine uses a price-time priority system for order matching. | [[entities/perpdex/lighter]], [[concepts/market-structure/clob]] | A1-PI |
| #c45 | When a new order is placed as the taker, the Lighter Matching Engine finds the highest-priority order on the opposite side, defined as the order with the best price; among ties at the best price, the oldest is selected. | [[entities/perpdex/lighter]] | A1-PI |
| #c46 | The Lighter Matching Engine executes the trade at the maker's price. | [[entities/perpdex/lighter]] | A1-PI |
| #c47 | If a taker limit order is not fully filled and needs to be placed in the order book, the Lighter Matching Engine inserts it on the corresponding side. | [[entities/perpdex/lighter]] | A1-PI |
| #c48 | The Lighter Matching Engine ensures price-time priority is always respected by utilizing SNARKs to generate cryptographic proofs for fair order book matching execution. | [[entities/perpdex/lighter]], [[entities/network/lighter-core]] | A1-PI, A8-PV |
| #c49 | The Lighter Matching Engine is described as a trustless service, bound to function in a predefined way and mathematically impossible for it to act maliciously. | [[entities/perpdex/lighter]] | A8-PV |

## Conflicts raised
- (none)
