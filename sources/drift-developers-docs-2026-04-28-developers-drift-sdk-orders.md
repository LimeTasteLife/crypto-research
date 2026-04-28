---
type: source
id: drift-developers-docs-2026-04-28-developers-drift-sdk-orders
title: SDK Orders
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/developers/drift-sdk/orders
mirror_snapshot: drift-developers-docs-2026-04-28
mirror_page: pages/developers-drift-sdk-orders.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Orders

## TL;DR
Order types: MARKET (executes immediately, JIT auction first), LIMIT (rests on DLOB until filled/cancelled; postOnly guarantees maker), ORACLE (auction prices and resting limit price as offsets from oracle), TRIGGER_MARKET (stop/take-profit market when oracle crosses triggerPrice), TRIGGER_LIMIT (stop/take-profit limit). PostOnlyParams: NONE (default, can be maker or taker), MUST_POST_ONLY (tx fails if would cross), TRY_POST_ONLY (silently skipped if would cross), SLIDE (price adjusted one tick inside spread). For OrderType.ORACLE, `auctionStartPrice`, `auctionEndPrice`, and `oraclePriceOffset` are all RELATIVE offsets from oracle in PRICE_PRECISION (1e6), not absolute prices. SDK methods: `placePerpOrder`, `placeSpotOrder`, `placeOrders` (multi), `cancelOrder` (by ID), `cancelOrdersByIds` (multi by IDs), `cancelOrders` (all). Helper: `getMarketOrderParams`, `getOrderParams` (generic). Convert helpers: `convertToPerpPrecision(1)` → BN(1e9); `convertToPricePrecision(21.23)` → BN(21_230_000).

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Order types supported: MARKET, LIMIT, ORACLE, TRIGGER_MARKET, TRIGGER_LIMIT. | [[concepts/operations/matching-engine]] | A4-PI |
| #c2 | MARKET orders execute immediately, going through a JIT auction first (controlled by auctionStartPrice/EndPrice/Duration), then DLOB or AMM. | [[concepts/operations/matching-engine]] | A4-PI |
| #c3 | LIMIT orders rest on the DLOB at a fixed price; setting `postOnly: PostOnlyParams.MUST_POST_ONLY` guarantees maker status and avoids crossing. | [[concepts/operations/matching-engine]] | A4-PI |
| #c4 | ORACLE order auction prices and resting limit price are expressed as offsets from the oracle price (not absolute prices). | [[concepts/operations/matching-engine]] | A4-PI |
| #c5 | TRIGGER_MARKET orders execute as a market order when oracle price crosses `triggerPrice` in the specified `triggerCondition` direction. | [[concepts/operations/matching-engine]] | A4-PI |
| #c6 | TRIGGER_LIMIT orders execute as a limit order at `price` once triggered (same trigger mechanism as TRIGGER_MARKET). | [[concepts/operations/matching-engine]] | A4-PI |
| #c7 | PostOnlyParams modes: NONE (maker or taker, default), MUST_POST_ONLY (tx fails if would cross), TRY_POST_ONLY (silently skipped if would cross), SLIDE (price adjusted one tick inside spread). | [[concepts/operations/matching-engine]] | A4-PI |
| #c8 | For OrderType.ORACLE, `auctionStartPrice`, `auctionEndPrice`, and `oraclePriceOffset` are offsets from oracle in PRICE_PRECISION (1e6), not absolute prices. | [[concepts/operations/matching-engine]] | A4-PI |
| #c9 | SDK precision conversion: `convertToPerpPrecision(1)` returns BN(1e9); `convertToPricePrecision(21.23)` returns BN(21_230_000). | [[entities/perpdex/drift]] | - |
| #c10 | SDK order-placement methods include `placePerpOrder`, `placeSpotOrder`, `placeOrders` (multi-order), `cancelOrder` (by id), `cancelOrdersByIds` (multi by ids), `cancelOrders` (cancel all). | [[entities/perpdex/drift]] | - |
