---
type: entity
subtype: network
name: BNB Chain
status: live
launched: 2020-Q3
sources_count: 1
last_reviewed: 2026-04-28
disputed: false
---

# BNB Chain

> EVM-compatible L1 (formerly Binance Smart Chain). Referenced here as the primary execution venue for Aster's Earn products, USDF token + minting contracts, and one of two ALP mint chains. Full BNB Chain coverage is out of current scope.

## Snapshot
- Hosts [[entities/perpdex/aster]] Treasury contract on BNB Chain[^aster-docs-2026-04-28-overview-smart-contracts]
- Hosts [[entities/token/usdf]] token + minting contract pair (Earn products listed only on BNB Chain)[^aster-docs-2026-04-28-overview-smart-contracts]
- One of two ALP mint chains alongside Arbitrum[^aster-docs-2026-04-28-earn-aster-alp]

## Mechanism
Stub. BNB Chain is an EVM-compatible L1 used by Aster as the primary execution venue for Earn products (asBTC, asUSDF, asBNB, asCAKE, USDF) and the canonical chain for ALP mint and burn flows. Aster's Treasury also has a BNB Chain deployment alongside Ethereum, Solana, and Arbitrum[^aster-docs-2026-04-28-overview-smart-contracts].

## Relations
- [[entities/token/usdf]] **runs_on** [[entities/network/bnb-chain]] (token + minting contract pair)[^aster-docs-2026-04-28-overview-smart-contracts]
- [[entities/perpdex/aster]] **runs_on** [[entities/network/bnb-chain]] (Treasury + Earn product surface)[^aster-docs-2026-04-28-overview-smart-contracts]

## Parameters
_(none yet — BNB Chain–side parameters out of current ingest scope)_

## Open questions
- Are Aster's perp matching engine and Aster Chain L1 deployed on BNB Chain, or is BNB Chain only the Earn-product / Treasury surface?
