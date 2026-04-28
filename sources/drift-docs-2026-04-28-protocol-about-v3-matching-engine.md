---
type: source
id: drift-docs-2026-04-28-protocol-about-v3-matching-engine
title: Matching Engine
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/protocol/about-v3/matching-engine
mirror_snapshot: drift-docs-2026-04-28
mirror_page: pages/protocol-about-v3-matching-engine.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Matching Engine

## TL;DR
Drift is described as a decentralized auction-based matching protocol. Every taker order has five auction parameters (duration in slots, start price, end price, post-auction limit price, max timestamp) defining a linear price function over slots. Market orders REQUIRE auction + max timestamp; limit orders may have them. During a limit order's auction it can only take liquidity; after the auction it transitions to potentially-providing-liquidity (taker → taker-or-maker). Post-only flag forces maker-only. Fills come from three sources: backstop AMM liquidity, resting limit orders, or just-in-time (JIT) maker liquidity. Critically, backstop liquidity is compared against resting/JIT liquidity before each fill — if the backstop offers a superior price, Drift fills against backstop first.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Drift is a decentralized auction-based trading protocol where every taker order carries auction parameters. | [[concepts/operations/matching-engine]] | A1-PI |
| #c2 | Taker order auction parameters are: auction duration (slots), auction start price, auction end price, post-auction limit price, and max timestamp. | [[concepts/market-microstructure/jit-auction]] | A4-PI |
| #c3 | Auction price is defined as a linear function of duration, start price, and end price over a set of slots. | [[concepts/market-microstructure/jit-auction]] | A4-PI |
| #c4 | Auction prices can be defined as fixed prices or as relative oracle offsets to account for oracle price changes during the auction. | [[concepts/market-microstructure/jit-auction]] | A4-PI |
| #c5 | Market orders must have an auction and a max timestamp; auction and max timestamp are optional for limit orders. | [[concepts/operations/matching-engine]] | - |
| #c6 | During a limit order's auction the order can only take liquidity; at end of auction it becomes "resting" and can also provide liquidity. | [[concepts/operations/matching-engine]] | A4-PI |
| #c7 | Setting a limit order to post-only restricts the order to maker-only execution. | [[concepts/operations/matching-engine]] | A4-PI |
| #c8 | A taker order can be filled against three sources: backstop AMM liquidity, resting limit orders, or just-in-time (JIT) maker liquidity. | [[concepts/operations/matching-engine]] | A4-PI |
| #c9 | A user's taker order can be filled in three ways: by a keeper using resting liquidity, by the user's own transaction with resting liquidity, or by a maker creating a transaction with JIT liquidity. | [[concepts/operations/matching-engine]] | A4-PI |
| #c10 | Backstop AMM liquidity is compared against resting and JIT liquidity before each fill; if backstop offers superior price, Drift fills against backstop first. | [[concepts/operations/matching-engine]], [[concepts/market-structure/vamm]] | A4-PI |
