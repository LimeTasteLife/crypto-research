---
type: source
id: aster-docs-2026-04-28-earn-aster-alp
title: Aster ALP
publisher: Aster Docs
author: Aster team
date: null
original_url: https://docs.asterdex.com/earn/overview/aster-alp
mirror_snapshot: aster-docs-2026-04-28
mirror_page: pages/earn-aster-alp.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Aster ALP

## TL;DR
ALP is Aster's venue-owned LP token: holders mint ALP to act as the market-maker counterparty for perp trades across all pairs on Aster, in the same architectural pattern as Hyperliquid's HLP and GMX's GLP. ALP NAV moves with the pool's overall P&L, so token price can rise or fall with trading activity and market conditions. Yield sources accrue directly to NAV and span five categories: trading P&L (from Simple Mode), trading fees, funding fees, liquidations captured by the pool, and platform-level fee collection. ALP can be minted on BNB Chain and Arbitrum, with chain-specific deposit assets — establishing a multi-chain LP footprint that cross-chains the spot-LP risk surface.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | ALP is the liquidity pool token for Aster. | [[parameters/aster/alp]] | A5-PI |
| #c2 | ALP holders act as the market-maker counterparty for perp trades on Aster. | [[parameters/aster/alp]], [[concepts/lp/venue-owned-lp]] | A5-PI, A4-PI |
| #c3 | The ALP pool provides liquidity across all trading pairs on Aster perps. | [[parameters/aster/alp]] | A5-PI |
| #c4 | ALP's net asset value (NAV) moves with the pool's overall P&L. | [[parameters/aster/alp]] | A5-PI |
| #c5 | ALP price can rise or fall depending on trading activity and market conditions (i.e., LPs bear directional/adverse-selection risk). | [[parameters/aster/alp]], [[concepts/lp/venue-owned-lp]] | A5-PIII |
| #c6 | All ALP yield is automatically reflected in NAV; no separate claim step is required. | [[parameters/aster/alp]] | A5-PIV |
| #c7 | ALP yield source #1: ALP's share of market-making P&L from Simple Mode trading activity. | [[parameters/aster/alp]] | A5-PIV |
| #c8 | ALP yield source #2: protocol fees collected on trades. | [[parameters/aster/alp]], [[parameters/aster/fee-schedule]] | A5-PIV, A2-PI |
| #c9 | ALP yield source #3: fees from perpetual contract funding rate mechanisms. | [[parameters/aster/alp]] | A5-PIV |
| #c10 | ALP yield source #4: profit captured from liquidation events within the pool. | [[parameters/aster/alp]] | A5-PIV, A6-PI |
| #c11 | ALP yield source #5: NAV boost from platform-level fee collection. | [[parameters/aster/alp]] | A5-PIV |
| #c12 | ALP can be minted on BNB Chain. | [[parameters/aster/alp]], [[entities/network/bnb-chain]] | A5-PI |
| #c13 | ALP can be minted on Arbitrum. | [[parameters/aster/alp]] | A5-PI |
| #c14 | Supported deposit assets for ALP minting differ between BNB Chain and Arbitrum. | [[parameters/aster/alp]] | A5-PIV |
