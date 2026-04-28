---
type: source
id: drift-sdk-docs-2026-04-28-concepts-orders
title: Orders
publisher: Drift Protocol v2 SDK Docs (Mintlify)
author: Drift Labs
date: null
original_url: https://mintlify.com/drift-labs/protocol-v2/concepts/orders
mirror_snapshot: drift-sdk-docs-2026-04-28
mirror_page: pages/concepts-orders.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Orders

## TL;DR
OrderType enum: LIMIT, TRIGGER_MARKET, TRIGGER_LIMIT, MARKET, ORACLE. OrderTriggerCondition: ABOVE, BELOW, TRIGGERED_ABOVE, TRIGGERED_BELOW. PostOnlyParams: NONE, MUST_POST_ONLY, TRY_POST_ONLY, SLIDE. Reduce-only orders only decrease position; cannot open, increase, or flip — used for SL/TP. IOC via `immediateOrCancel: true` or OrderParamsBitFlag.ImmediateOrCancel = 1. Time-in-force via `maxTs`. OrderStatus: INIT, OPEN, FILLED, CANCELED. Dutch auction: starts at premium/discount, moves toward oracle over `auctionDuration`, then matches at limit. Liquidity sources documented: DLOB matching (resting), AMM fill, JIT auction (keeper-provided), External DEX (Serum, Phoenix, OpenBook v2). OrderActionExplanation enum: ORDER_FILLED_WITH_MATCH, ORDER_FILLED_WITH_AMM, ORDER_FILLED_WITH_AMM_JIT, ORDER_FILLED_WITH_OPENBOOK_V2. Scale orders supported (2–32 sub-orders, FLAT/ASCENDING/DESCENDING distribution). Protected Maker Mode: certain users get price adjustments to ensure maker status and better fill prices.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | OrderType enum values: LIMIT, TRIGGER_MARKET, TRIGGER_LIMIT, MARKET, ORACLE. | [[concepts/operations/matching-engine]] | A4-PI |
| #c2 | OrderTriggerCondition values: ABOVE, BELOW, TRIGGERED_ABOVE, TRIGGERED_BELOW. | [[concepts/operations/matching-engine]] | - |
| #c3 | PostOnlyParams enum: NONE, MUST_POST_ONLY (tx fails if order would cross), TRY_POST_ONLY (skip if would cross), SLIDE (adjust price to be maker). | [[concepts/operations/matching-engine]] | A4-PI |
| #c4 | Reduce-only orders can only decrease position size — cannot open new, increase existing, or flip direction. | [[concepts/operations/matching-engine]] | A4-PI |
| #c5 | OrderParamsBitFlag values: ImmediateOrCancel = 1; UpdateHighLeverageMode = 2. | [[entities/perpdex/drift]] | - |
| #c6 | Order time-in-force is set via `maxTs`; expired orders are auto-cancelled. | [[concepts/operations/matching-engine]] | - |
| #c7 | OrderStatus enum: INIT, OPEN, FILLED, CANCELED. | [[entities/perpdex/drift]] | - |
| #c8 | Dutch auction mechanism: order starts at premium (buy) or discount (sell), price moves toward oracle over auctionDuration slots, fills at oracle at end if not filled earlier. | [[concepts/market-microstructure/jit-auction]] | A4-PI |
| #c9 | Drift's order matching uses four liquidity sources: DLOB matching, AMM fill, JIT auction, External DEX (Serum, Phoenix, OpenBook v2). | [[concepts/operations/matching-engine]] | A4-PI |
| #c10 | OrderActionExplanation enum values: ORDER_FILLED_WITH_MATCH, ORDER_FILLED_WITH_AMM, ORDER_FILLED_WITH_AMM_JIT, ORDER_FILLED_WITH_OPENBOOK_V2. | [[concepts/operations/matching-engine]] | A4-PI |
| #c11 | Scale orders place multiple orders across a price range (orderCount 2–32) with sizeDistribution = FLAT, ASCENDING, or DESCENDING. | [[concepts/operations/matching-engine]] | A4-PI |
| #c12 | Order cancellation triggers: user-initiated, expired (maxTs), user being liquidated (risk-increasing orders), reduce-only conditions violated. | [[concepts/operations/matching-engine]] | A6-PI |
| #c13 | Markets can enable Protected Maker Mode for certain users; protected makers get price adjustments to ensure maker status and better fill prices. | [[concepts/mm-agreement/quote-obligation]] | A4-PI |
| #c14 | OrderAction enum: PLACE, CANCEL, EXPIRE, FILL, TRIGGER. | [[entities/perpdex/drift]] | - |
