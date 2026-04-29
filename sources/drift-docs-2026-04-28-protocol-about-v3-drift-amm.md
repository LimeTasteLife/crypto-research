---
type: source
id: drift-docs-2026-04-28-protocol-about-v3-drift-amm
title: Drift AMM
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/protocol/about-v3/drift-amm
mirror_snapshot: drift-docs-2026-04-28
mirror_page: pages/protocol-about-v3-drift-amm.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Drift AMM

## TL;DR
Drift's v3 AMM is a constant-product vAMM augmented with three runtime knobs: external Backstop AMM Liquidity (BAL), a concentration factor, and dynamic spread/peg programmatically updated prior to filling. The bid/ask are asymmetric offsets from a reservation price, calculated as `bid/ask = reservation_price ± base_spread + f(inventory, balance, ...)`, capped by a max spread (a percentage of the current valid oracle price). Live oracle pricing updates the AMM's peg toward oracle each interaction; a minimum 10-slot duration is required before AMM fills. Effective leverage of the AMM (function of inventory PnL and fee-pool collateral) widens spread when AMM is heavily levered or in debt.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | The Drift AMM provides guaranteed constant liquidity to the exchange, available to be taken against asynchronously. | [[concepts/market-structure/vamm]] | A1-PI |
| #c2 | Drift v1's Dynamic AMM iterated on Perpetual Protocol's vAMM with configurable parameters: peg (price multiplier), K (liquidity depth), Fee Pool, and Fee Tranches. | [[concepts/market-structure/vamm]] | - |
| #c3 | Drift v3 AMM uses a constant product curve and adds external Backstop AMM Liquidity (BAL), a concentration factor, and dynamic spread/peg that programmatically update prior to filling trades. | [[concepts/market-structure/vamm]], [[parameters/drift/lp-shares]] | A1-PI, A5-PI |
| #c4 | Drift v3's AMM quotes different prices for buys and sells (asymmetric); the offset from mid-price is dynamic based on current inventory. | [[concepts/market-structure/vamm]] | A4-PIII |
| #c5 | The bid/ask spread formula is: `bid/ask price = reservation price ± base_spread + f(inventory, balance, ...)`. | [[concepts/market-structure/vamm]] | A4-PI |
| #c6 | The ask − bid never exceeds the max spread, calculated as a percentage using the current valid oracle price. | [[concepts/market-structure/vamm]] | A6-PI |
| #c7 | Bid quote reserve is calculated as: `bid_quote_reserve = quote_reserve − (quote_reserve / (100% / short_spread))`. | [[concepts/market-structure/vamm]] | - |
| #c8 | Ask quote reserve is calculated as: `ask_quote_reserve = quote_reserve + (quote_reserve / (100% / long_spread))`. | [[concepts/market-structure/vamm]] | - |
| #c9 | The AMM's reservation price updates regularly through Drift's live oracle-based pricing. | [[concepts/market-structure/vamm]] | A6-PI |
| #c10 | Mark price is updated each time the oracle updates and when the contract is interacted with. | [[concepts/market-microstructure/mark-price-formula]] | A6-PI |
| #c11 | Every time a trader fills against the AMM, the AMM is updated in the same slot with a valid oracle price. | [[concepts/market-microstructure/mark-price-formula]] | A6-PI |
| #c12 | The AMM moves its peg toward the oracle price each fill cycle. | [[concepts/market-structure/vamm]] | A6-PI |
| #c13 | Orders fill against the AMM only after the order has lived longer than the minimum AMM-fill duration of 10 slots. | [[concepts/market-microstructure/jit-auction]] | A4-PI |
| #c14 | Overall spread widens when the AMM is heavily levered or in debt; oracle and reservation prices are always within the spread. | [[concepts/market-structure/vamm]] | A4-PIII, A6-PI |
| #c15 | Reservation (AMM) price is computed as `quote_reserves / base_reserves * peg`. | [[concepts/market-microstructure/mark-price-formula]] | - |
