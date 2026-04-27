---
type: source
id: hl-docs-2026-04-27-trading-contract-specifications
title: Contract Specifications
publisher: Hyperliquid Docs
author: Hyperliquid team
date: null
original_url: https://hyperliquid.gitbook.io/hyperliquid-docs/trading/contract-specifications
mirror_snapshot: hl-docs-2026-04-27
mirror_page: pages/trading-contract-specifications.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-27
---

# Contract Specifications

## TL;DR
Hyperliquid perps are linear, no-expiry contracts using funding to keep mark-to-spot convergence. The default is USDC-margined / USDT-denominated linear contracts (technically quanto contracts since no USDC/USDT conversion is applied). PURR-USD and HYPE-USD are the only USDC-denominated contracts (because their primary spot liquidity is on Hyperliquid). One contract = 1 unit of underlying. Initial margin = 1/leverage; maintenance margin = half of initial at max leverage. Funding occurs every hour. Funding impact notional is $20,000 USDC for BTC and ETH and $6,000 USDC for all other assets. Maximum order values are tied to max leverage tier. The page lists specs in aggregate (no per-symbol time-series); per the audit guidance, claims here file to the venue-wide listed-markets-roster slot.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Hyperliquid perps are linear contracts with no expiration date; convergence to spot is enforced by funding payments. | [[concepts/market-microstructure/contract-size]] |  |
| #c2 | Default margining is USDC-collateralized, USDT-denominated linear (technically quanto contracts since no USDC/USDT conversion is applied). | [[parameters/hyperliquid/listed-markets-roster]] | A1-PI |
| #c3 | PURR-USD and HYPE-USD are the only USDC-denominated perp contracts because their primary spot liquidity is on Hyperliquid. | [[parameters/hyperliquid/listed-markets-roster]] | A1-PI |
| #c4 | Each contract represents 1 unit of the underlying spot asset. | [[concepts/market-microstructure/contract-size]] |  |
| #c5 | Initial margin fraction = 1 / (user-set leverage). | [[concepts/risk/margin-tier]] |  |
| #c6 | Maintenance margin fraction = half of the maximum initial margin fraction. | [[concepts/risk/margin-tier]] |  |
| #c7 | Funding payments occur every hour. | [[parameters/hyperliquid/listed-markets-roster]], [[concepts/fee-model/funding-rate]] | A6-PI |
| #c8 | No global position limit per user. | [[parameters/hyperliquid/listed-markets-roster]] | A6-PI |
| #c9 | Account types: per-wallet cross or isolated margin. | [[concepts/risk/margin-tier]] |  |
| #c10 | Funding impact notional is 20,000 USDC for BTC and ETH; 6,000 USDC for all other assets. | [[parameters/hyperliquid/listed-markets-roster]] | A6-PI |
| #c11 | Maximum market order value is $30M for max-leverage ≥25x assets. | [[parameters/hyperliquid/listed-markets-roster]] | A6-PI |
| #c12 | Maximum market order value is $5M for max-leverage in [20, 25) assets. | [[parameters/hyperliquid/listed-markets-roster]] | A6-PI |
| #c13 | Maximum market order value is $2M for max-leverage in [10, 20) assets. | [[parameters/hyperliquid/listed-markets-roster]] | A6-PI |
| #c14 | Maximum market order value is $500k for max-leverage <10x assets. | [[parameters/hyperliquid/listed-markets-roster]] | A6-PI |
| #c15 | Maximum limit order value is 10× the maximum market order value. | [[parameters/hyperliquid/listed-markets-roster]] | A6-PI |
