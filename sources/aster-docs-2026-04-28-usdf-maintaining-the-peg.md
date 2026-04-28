---
type: source
id: aster-docs-2026-04-28-usdf-maintaining-the-peg
title: Maintaining the Peg
publisher: Aster Docs
author: Aster team
date: null
original_url: https://docs.asterdex.com/usdf-stablecoin/overview/maintaining-the-peg
mirror_snapshot: aster-docs-2026-04-28
mirror_page: pages/usdf-maintaining-the-peg.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Maintaining the Peg

## TL;DR
USDF maintains its 1:1 USD peg through three named mechanisms: (1) rigid 1:1 redemption against USDT, (2) market arbitrage on liquidity-pool deviations, and (3) delta-neutral hedging of underlying assets. The redemption mechanism is the structural anchor — USDF can be redeemed for USDT at a fixed 1:1 rate at any time, backed by an equal underlying balance. The arbitrage mechanism relies on third-party traders to close discrepancies (e.g., 100 USDF redeemed for 100 USDT, swapped for 102 USDT of USDF on a DEX trading at 1.02). The delta-neutral leg balances long and short positions in underlying assets to suppress price-volatility transmission and to generate fee yield. Notably the page does not specify a redemption fee, redemption SLA, redemption queue mechanics, the venue of the delta-neutral hedge, or counterparty for the short leg — all peg-defense surface areas relevant to A6-PI / A8-PI risk.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | USDF maintains a 1:1 peg with the US Dollar via three mechanisms: rigid redemption, arbitrage, and delta-neutral positioning. | [[parameters/aster/usdf-peg]], [[entities/token/usdf]] | A6-PI |
| #c2 | USDF has a strict 1:1 redemption mechanism against USDT. | [[parameters/aster/usdf-peg]] | A6-PI |
| #c3 | Holders can redeem USDF for USDT at any time at the fixed 1:1 rate. | [[parameters/aster/usdf-peg]] | A6-PI |
| #c4 | The redemption guarantee depends on Aster maintaining an equal amount of underlying assets (such as USDT) available for redemption. | [[parameters/aster/usdf-peg]] | A6-PI, A8-PI |
| #c5 | Price deviations of USDF in third-party liquidity pools are stabilized by external arbitrageurs, not by an internal market-making program. | [[parameters/aster/usdf-peg]] | A6-PI |
| #c6 | Documented arbitrage example for overvalued USDF (1.02): redeem 100 USDF → 100 USDT → swap to 102 USDT-equivalent USDF → 2% gain. | [[parameters/aster/usdf-peg]] | - |
| #c7 | Documented arbitrage path for undervalued USDF (0.98): purchase USDF at discount, redeem at 1:1 for USDT, capture spread on revert. | [[parameters/aster/usdf-peg]] | - |
| #c8 | Aster operates delta-neutral positions in underlying assets as a secondary peg-defense mechanism. | [[parameters/aster/usdf-peg]], [[concepts/risk/peg-defense]] | A6-PI |
| #c9 | Delta-neutral positions are stated to generate fee yield via liquidity mechanisms while minimizing volatile-asset exposure. | [[parameters/aster/usdf-peg]] | A6-PI |
| #c10 | The peg mechanism page does not disclose a redemption fee. | [[parameters/aster/usdf-peg]] | A6-PI, A8-PI |
| #c11 | The peg mechanism page does not disclose a redemption SLA, redemption queue policy, or maximum daily redemption capacity. | [[parameters/aster/usdf-peg]] | A6-PI, A8-PI |
| #c12 | The peg mechanism page does not disclose the venue or counterparty of the delta-neutral hedge. | [[parameters/aster/usdf-peg]] | A6-PI, A8-PI |
| #c13 | USDF peg defense is described as serving both stability and capital preservation for holders. | [[parameters/aster/usdf-peg]] | A6-PI |
| #c14 | Arbitrage-based peg defense relies on external participants having capital and motivation to close deviations — i.e., peg stability is contingent on third-party arbitrage activity. | [[parameters/aster/usdf-peg]], [[concepts/risk/peg-defense]] | A6-PI |
| #c15 | The page positions delta-neutral hedging as protection against volatility "even during uncertain markets" without specifying liquidation handling on the short leg. | [[parameters/aster/usdf-peg]] | A6-PI, A8-PI |
