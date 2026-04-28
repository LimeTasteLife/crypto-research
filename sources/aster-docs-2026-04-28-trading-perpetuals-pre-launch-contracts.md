---
type: source
id: aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts
title: Pre-Launch Contracts
publisher: Aster Docs
author: Aster team
date: null
original_url: https://docs.asterdex.com/trading/perpetuals/pre-launch-contracts
mirror_snapshot: aster-docs-2026-04-28
mirror_page: pages/trading-perpetuals-pre-launch-contracts.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Pre-Launch Contracts

## TL;DR
Aster pre-launch contracts let users trade tokens before they list on major exchanges, structured as expiry futures (sometimes perpetuals) that auto-convert to a regular perp once the underlying token launches. Aster claims unilateral authority to initiate the conversion/delivery process when the token launches externally or when tokenomics are released, and reserves the right to delist contracts and to set the final delivery price. The mark price formula in pre-market mode differs from regular perps — Price 1 and Price 2 are both anchored to the local pre-market order book's (Bid1+Ask1)/2 rather than to an external Price Index, since no external spot reference exists yet. After conversion to perpetual, the standard perp index/mark methodology applies.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Pre-launch contracts allow users to trade token pairs before they are officially listed on major exchanges. | [[parameters/aster/listing-policy]] | A1-PI |
| #c2 | Pre-launch contracts are structured as expiry futures contracts but may also take the form of perpetual futures. | [[parameters/aster/listing-policy]] | A1-PI |
| #c3 | Once the token launches and begins trading, the pre-market symbol on Aster Perps converts to a regular perp futures contract. | [[parameters/aster/listing-policy]] | A1-PI |
| #c4 | Aster has the right to initiate the delivery process automatically when a token launches on an external exchange. | [[parameters/aster/listing-policy]] | A7-PV |
| #c5 | Aster has the right to initiate the delivery process automatically when the token's tokenomics are released. | [[parameters/aster/listing-policy]] | A7-PV |
| #c6 | Pre-market mode switches to a perpetual contract automatically upon delivery trigger. | [[parameters/aster/listing-policy]] | A1-PI |
| #c7 | Aster retains final authority over the delivery price. | [[parameters/aster/listing-policy]] | A7-PV |
| #c8 | Aster retains the right to delist a pre-launch contract. | [[parameters/aster/listing-policy]] | A7-PV |
| #c9 | Pre-launch USDT-margined futures use Mark Price to avoid unnecessary liquidations and prevent market manipulation. | [[parameters/aster/listing-policy]], [[concepts/market-microstructure/mark-price-formula]] | - |
| #c10 | Pre-launch Mark Price = Median(Price 1, Price 2, Contract Price). | [[parameters/aster/listing-policy]] | A6-PIV |
| #c11 | Pre-launch Price 1 = (Bid1 + Ask1)/2 × (1 + Funding Rate × (Time to Next Funding Rate (h)/8)). | [[parameters/aster/listing-policy]] | A6-PIV |
| #c12 | Pre-launch Price 2 = (Bid1 + Ask1)/2. | [[parameters/aster/listing-policy]] | A6-PIV |
| #c13 | Bid1 and Ask1 in pre-launch markets are sourced from the pre-market order book itself (no external Price Index). | [[parameters/aster/listing-policy]], [[parameters/aster/oracle-config]] | A6-PIV |
| #c14 | Pre-launch Price 2 logic may be updated based on market conditions. | [[parameters/aster/listing-policy]] | A7-PV |
| #c15 | Once the pre-market symbol transitions to a regular perpetual futures contract, the index price calculation switches to the standard perpetual futures methodology. | [[parameters/aster/listing-policy]] | A1-PI |
