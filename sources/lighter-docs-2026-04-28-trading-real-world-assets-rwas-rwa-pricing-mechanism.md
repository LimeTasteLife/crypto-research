---
type: source
id: lighter-docs-2026-04-28-trading-real-world-assets-rwas-rwa-pricing-mechanism
title: RWA Pricing Mechanism
publisher: Lighter Docs
author: Lighter team
date: null
original_url: https://docs.lighter.xyz/trading/real-world-assets-rwas/rwa-pricing-mechanism
mirror_snapshot: lighter-docs-2026-04-28
mirror_page: pages/trading-real-world-assets-rwas-rwa-pricing-mechanism.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# RWA Pricing Mechanism

## TL;DR
RWA pricing on Lighter blends external oracle feeds (Chainlink, Pyth, Stork, other exchanges) with an internal price derived from order-book impact prices smoothed via a time-weighted EMA. External oracle is primary; on stale-oracle ticks, oracle weight decays exponentially with a per-source time constant and the residual weight shifts to the internal source. Convergence back from internal to external is instant. Index price uses τ = 1 hour and is capped at ±(1/L·0.75 − 0.5%) around the last oracle. Mark price uses τ = 8 minutes and is capped at ±(1/L·0.75) around the last oracle. Korean equities are USDC-settled but priced in KRW.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | RWA pricing is derived from two primary sources: external oracle feeds (Chainlink, Pyth, Stork, other exchanges) and internal pricing. | [[concepts/market-microstructure/oracle-spec]], [[parameters/lighter/markets/XAU]] | A6-PI |
| #c2 | The RWA index price calculation reuses the existing Lighter index methodology with the `cexPrices` component replaced by RWA-specific pricing. | [[concepts/market-microstructure/oracle-spec]] | A6-PI |
| #c3 | External oracle feeds are the primary price source; on staleness, pricing gradually shifts toward internal pricing via exponential decay of the oracle weight. | [[concepts/market-microstructure/oracle-spec]] | A6-PI |
| #c4 | When an external price becomes available again, the internal price instantly converges to it (asymmetric transition: decay outbound, instant return). | [[concepts/market-microstructure/oracle-spec]] | A6-PI, A6-PII |
| #c5 | Reweighing formula for stale oracle: w_oracle(t) = w_oracle(t−1) · exp(−Δt/τ_oracle); w_internal(t) = 1 − w_oracle(t). | [[concepts/market-microstructure/oracle-spec]] | A6-PI |
| #c6 | Time constants τ vary by price type (index vs mark). | [[concepts/market-microstructure/oracle-spec]] | A6-PI |
| #c7 | Internal pricing is derived from order-book impact prices smoothed by a time-weighted EMA: EMA_t = α·P_t + (1−α)·EMA_{t−1}, with α = 1 − exp(−Δt/τ). | [[concepts/market-microstructure/mark-price-formula]] | A6-PI |
| #c8 | For RWA index price, smoothing time constant τ = 1 hour. | [[concepts/market-microstructure/mark-price-formula]] | A6-PI |
| #c9 | The internal RWA index price is capped at [P_oracle · (1 − 1/L·0.75 + 0.5%), P_oracle · (1 + 1/L·0.75 − 0.5%)], where L is market leverage. | [[concepts/market-microstructure/mark-price-formula]] | A6-PI |
| #c10 | For RWA mark price, smoothing time constant τ = 8 minutes. | [[concepts/market-microstructure/mark-price-formula]] | A6-PI |
| #c11 | The internal RWA mark price is capped at [P_oracle · (1 − 1/L·0.75), P_oracle · (1 + 1/L·0.75)], where L is market leverage. | [[concepts/market-microstructure/mark-price-formula]] | A6-PI |
| #c12 | Korean equity perpetual contracts are settled in USDC while the underlying reference price is quoted in KRW; the contract tracks KRW performance and each full contract is priced and settled in USDC. | [[parameters/lighter/listed-markets-roster]] | A1-PI, A6-PI |

## Conflicts raised
- (none within group)
