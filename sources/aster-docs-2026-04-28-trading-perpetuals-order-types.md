---
type: source
id: aster-docs-2026-04-28-trading-perpetuals-order-types
title: Order Types
publisher: Aster Docs
author: Aster team
date: null
original_url: https://docs.asterdex.com/trading/perpetuals/order-types
mirror_snapshot: aster-docs-2026-04-28
mirror_page: pages/trading-perpetuals-order-types.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Order Types

## TL;DR
Aster Perps supports six order primitives — Market, Limit, Stop Limit, Stop Market, Trailing Stop, and Post Only — plus modifiers (TP/SL with mark-or-last reference, Reduce Only, BBO with Counterparty/Queue variants) and three Time-in-Force options (GTC, IOC, FOK). TP/SL can be referenced against either Mark Price (more stable through wicks) or Last Price (faster but more wick-prone). Post Only orders are rejected outright if they would immediately match — useful for guaranteed maker placement. BBO supports best-price and fifth-best-price variants, surfacing more granular maker-placement preferences than typical CEX UIs.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Aster Perps supports a Market Order type that buys/sells immediately at the best available price. | [[entities/perpdex/aster]] | - |
| #c2 | Aster Perps supports a Limit Order type that executes only if the market reaches the chosen price. | [[entities/perpdex/aster]] | - |
| #c3 | Aster Perps supports a Stop Limit Order combining a stop price (trigger) and a limit price (placement). | [[entities/perpdex/aster]] | - |
| #c4 | Aster Perps supports a Stop Market Order that converts into a market order once stop price is reached. | [[entities/perpdex/aster]] | - |
| #c5 | Aster Perps supports a Trailing Stop Order whose stop price follows market movement in trader's favor. | [[entities/perpdex/aster]] | - |
| #c6 | Aster Perps supports a Post Only Order that ensures the limit order is added to the book as a maker order. | [[entities/perpdex/aster]] | A2-PIII |
| #c7 | A Post Only order is rejected if it would immediately match an existing order. | [[entities/perpdex/aster]] | A2-PIII |
| #c8 | Aster Perps supports TP (Take Profit) and SL (Stop Loss) modifiers as automatic exit levels. | [[entities/perpdex/aster]] | - |
| #c9 | TP/SL can use Mark Price as the reference (more stable during volatility). | [[entities/perpdex/aster]] | A6-PIV |
| #c10 | TP/SL can use Last Price as the reference (reacts more quickly but can be triggered by wicks/spikes). | [[entities/perpdex/aster]] | A6-PIV |
| #c11 | Reduce Only orders guarantee the order will never open or increase a position; they only reduce or fully close. | [[entities/perpdex/aster]] | - |
| #c12 | BBO (Best Bid/Offer) orders place a limit order at the best bid or ask price. | [[entities/perpdex/aster]] | - |
| #c13 | For a buy BBO order, the price is set at the lowest current ask. | [[entities/perpdex/aster]] | - |
| #c14 | For a sell BBO order, the price is set at the highest current bid. | [[entities/perpdex/aster]] | - |
| #c15 | BBO supports variants such as [Counterparty 1] and [Queue 1] that adjust price based on side and position (best vs fifth-best). | [[entities/perpdex/aster]] | A6-PIV |
| #c16 | BBO with Post Only mode places the order only if it adds liquidity. | [[entities/perpdex/aster]] | A2-PIII |
| #c17 | TIF GTC (Good Till Cancelled) keeps an order open until filled or manually canceled; default for most limit orders. | [[entities/perpdex/aster]] | - |
| #c18 | TIF IOC (Immediate or Cancel) fills available quantity immediately and cancels any unfilled portion. | [[entities/perpdex/aster]] | - |
| #c19 | TIF FOK (Fill or Kill) cancels the entire order unless it can be fully filled immediately. | [[entities/perpdex/aster]] | - |
