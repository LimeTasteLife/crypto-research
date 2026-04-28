---
type: source
id: drift-developers-docs-2026-04-28-developers-market-makers-jit-only
title: JIT-Only Market Maker
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/developers/market-makers/jit-only
mirror_snapshot: drift-developers-docs-2026-04-28
mirror_page: pages/developers-market-makers-jit-only.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# JIT-only MM

## TL;DR
JIT-only MM avoids resting orders entirely, instead competing in JIT auctions by reacting to incoming taker orders in real-time. Benefits: no adverse selection from stale quotes, selective flow inspection, capital efficiency, dynamic pricing per fill. Tradeoff: requires lower-latency infrastructure than DLOB MM, may miss fills in fast markets if too slow. Architecture loop: subscribe (`AuctionSubscriber` with `commitment: "processed"` for lowest latency) → filter (oracle, position limits, toxic flow) → price (`getAuctionPrice` returns interpolated current auction price) → fill (`placeAndMakePerpOrder` atomically places maker order + matches taker in one tx). For oracle access use `getMMOracleDataForPerpMarket` (returns MM-specific data with `isValid` flag and confidence interval). When subscribed to both SWIFT and onchain feeds, use `isSignedMsgOrder()` to skip SWIFT-origin orders that you'll handle via the SWIFT callback. Reference: JitMaker bot uses 1:1 subaccount-to-market mapping, volatility-based fill rejection (`isMarketVolatile`), DLOB-aware pricing (excludes own orders).

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | JIT-only MM does not maintain a standing book; it reacts to incoming taker orders in real-time during JIT auctions. | [[concepts/mm-agreement/quote-obligation]] | A4-PIII |
| #c2 | JIT-only MM reduces adverse selection from stale quotes by committing capital only when filling. | [[concepts/mm-agreement/quote-obligation]] | A4-PIII |
| #c3 | JIT-only MM enables selective flow filtering — each taker order is inspected for profitability before fill. | [[concepts/mm-agreement/quote-obligation]] | A4-PIII |
| #c4 | JIT-only MM requires lower-latency infrastructure than DLOB MM and risks missing fills in fast markets if too slow. | [[concepts/mm-agreement/quote-obligation]] | A4-PI |
| #c5 | The `AuctionSubscriber` with `commitment: "processed"` provides the lowest-latency stream of active JIT auctions. | [[concepts/market-microstructure/jit-auction]] | A4-PI |
| #c6 | `getAuctionPrice(takerOrder, currentSlot, oraclePrice)` computes the current interpolated auction price at any slot. | [[concepts/market-microstructure/jit-auction]] | A4-PI |
| #c7 | `placeAndMakePerpOrder` atomically places a maker order and matches against a taker in one transaction. | [[concepts/operations/matching-engine]] | A4-PI |
| #c8 | `getMMOracleDataForPerpMarket` is the recommended oracle accessor for market makers; it returns MM-specific data including a validity flag and confidence interval. | [[parameters/drift/oracle-config]] | A4-PI, A6-PI |
| #c9 | MM bots should always check `oracle.isValid` before quoting; an invalid oracle indicates stale or unhealthy data and the fill should be skipped. | [[parameters/drift/oracle-config]] | A6-PI |
| #c10 | When subscribed to both SWIFT and onchain feeds, use `isSignedMsgOrder(order)` to skip SWIFT-origin orders in the onchain handler (avoid double-handling). | [[concepts/operations/matching-engine]] | A4-PI |
| #c11 | The reference JitMaker bot enforces a 1:1 subaccount-to-market mapping and throws if misconfigured. | [[parameters/drift/mm-rebate-tiers]] | A4-PI |
| #c12 | Recommended JIT MM target fill rate per market: above ~20%; below this signals pricing or latency issues. | [[parameters/drift/mm-rebate-tiers]] | A4-PI |
| #c13 | The `@drift-labs/jit-proxy` library provides higher-level helpers `JitterSniper` and `JitterShotgun` for JIT participation. | [[parameters/drift/mm-rebate-tiers]] | A4-PI |
