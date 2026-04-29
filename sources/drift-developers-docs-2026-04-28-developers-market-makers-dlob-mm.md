---
type: source
id: drift-developers-docs-2026-04-28-developers-market-makers-dlob-mm
title: DLOB Market Maker
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/developers/market-makers/dlob-mm
mirror_snapshot: drift-developers-docs-2026-04-28
mirror_page: pages/developers-market-makers-dlob-mm.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# DLOB MM

## TL;DR
DLOB market making = resting two-sided post-only quotes on the decentralized orderbook, earning maker rebates when takers cross. Three post-only modes: MUST_POST_ONLY (recommended; rejects if would cross), TRY_POST_ONLY (amends to non-crossing best price), SLIDE (slides to best bid/ask). Oracle offset orders are the most efficient quoting mechanism — instead of fixed prices, set `orderType: ORACLE` with `oraclePriceOffset` (signed offset in PRICE_PRECISION 1e6 units). Order automatically tracks oracle at fill time; a typical MM sends ~30 transactions per day instead of thousands with cancel-replace. Atomic `cancelAndPlaceOrders` avoids the no-orders gap. Inventory-aware quoting widens bid when long, tightens ask. Reference: `FloatingPerpMaker` in keeper-bots-v2 — uses 30-slot `MARKET_UPDATE_COOLDOWN_SLOTS`, async-mutex periodic tasks, position-aware sizing via `MAX_POSITION_EXPOSURE`, watchdog timer. 32-order limit per subaccount = use multiple subaccounts for multi-market quoting.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | DLOB market making means placing resting two-sided quotes on the decentralized orderbook and earning maker rebates when takers trade against them. | [[concepts/mm-agreement/quote-obligation]] | A4-PI |
| #c2 | Drift offers three post-only modes: MUST_POST_ONLY (rejects if would cross), TRY_POST_ONLY (amends price), SLIDE (slides to best bid/ask). | [[concepts/operations/matching-engine]] | A4-PI |
| #c3 | Drift recommends MUST_POST_ONLY for all MM quotes to guarantee maker-only execution. | [[parameters/drift/mm-rebate-tiers]] | A4-PI |
| #c4 | Oracle offset orders use `orderType: OrderType.ORACLE` with `oraclePriceOffset` instead of a fixed `price`; positive offset = above oracle, negative = below. | [[concepts/operations/matching-engine]] | A4-PI |
| #c5 | Oracle offset orders automatically track the oracle price at fill time — the onchain program evaluates `oracle_price + offset` per fill. | [[concepts/operations/matching-engine]] | A4-PI |
| #c6 | A typical MM using oracle offset orders sends ~30 transactions per day to adjust spread or size, vs. thousands with cancel-replace on fixed-price limits. | [[concepts/mm-agreement/quote-obligation]] | A4-PI |
| #c7 | `cancelAndPlaceOrders` atomically cancels existing orders and places new ones in a single transaction, avoiding the no-orders gap during a separate cancel-then-place. | [[concepts/operations/matching-engine]] | A4-PI |
| #c8 | The 32-order-per-subaccount limit constrains multi-market quoting — Drift recommends using multiple subaccounts for multi-market strategies. | [[entities/perpdex/drift]] | A4-PIV |
| #c9 | If MUST_POST_ONLY oracle offset order would cross the spread (oracle moved sharply), the order is rejected, not silently filled as taker. | [[concepts/operations/matching-engine]] | A4-PI |
| #c10 | The reference FloatingPerpMaker bot uses `MARKET_UPDATE_COOLDOWN_SLOTS` of 30 slots before re-quoting a market to avoid excessive transactions. | [[parameters/drift/mm-rebate-tiers]] | A4-PI |
| #c11 | The reference FloatingPerpMaker bot uses `async mutex` to prevent overlapping quote updates. | [[parameters/drift/mm-rebate-tiers]] | A4-PI |
| #c12 | The reference FloatingPerpMaker bot uses `MAX_POSITION_EXPOSURE` (percentage of account collateral) for position-aware sizing. | [[parameters/drift/mm-rebate-tiers]] | A4-PI |
| #c13 | Oracle offset precision: `oraclePriceOffset` is in raw PRICE_PRECISION units (1e6); offset of 500000 = $0.50, not $500,000. | [[entities/perpdex/drift]] | - |
| #c14 | Oracle offset orders work for spot markets too (use `MarketType.SPOT` with `placeSpotOrder` / `placeAndMakeSpotOrder`). | [[concepts/operations/matching-engine]] | A4-PI |
