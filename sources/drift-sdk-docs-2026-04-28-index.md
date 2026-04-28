---
type: source
id: drift-sdk-docs-2026-04-28-index
title: Drift Protocol v2 (root)
publisher: Drift Protocol v2 SDK Docs (Mintlify)
author: Drift Labs
date: null
original_url: https://mintlify.com/drift-labs/protocol-v2/
mirror_snapshot: drift-sdk-docs-2026-04-28
mirror_page: pages/index.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Drift Protocol v2 (root)

## TL;DR
The Mintlify-hosted Drift Protocol v2 SDK reference root advertises Drift v2 as a decentralized perpetuals exchange on Solana with up to 20x leverage (note: differs from main docs root which says 101x). vAMM is the core liquidity primitive, alongside cross-collateral margin, the TypeScript SDK (`@drift-labs/sdk`), and Pyth+Switchboard oracle integration. SDK uses bn.js fixed-point integers with four precisions: QUOTE_PRECISION = 1e6 (USDC), PRICE_PRECISION = 1e6 (market prices), BASE_PRECISION = 1e9 (base assets like SOL), AMM_RESERVE_PRECISION = 1e9 (AMM math). Each market identified by unique `marketIndex`. Apache 2.0 licensed. Supports both mainnet-beta and devnet (devnet has USDC faucet for testing).

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Drift Protocol v2 is a decentralized perpetuals exchange built on Solana. | [[entities/perpdex/drift]] | A1-PI |
| #c2 | The Drift Protocol v2 SDK page advertises perp trading "with leverage" up to 20x. | [[entities/perpdex/drift]] | A1-PI |
| #c3 | Drift's vAMM (virtual Automated Market Maker) provides liquidity without requiring traditional order books and adjusts dynamically based on market conditions and oracle data. | [[concepts/market-structure/vamm]] | A1-PI |
| #c4 | Drift integrates with Pyth and Switchboard oracle providers for price feeds. | [[parameters/drift/oracle-config]] | A6-PI |
| #c5 | The TypeScript SDK package is `@drift-labs/sdk`, providing account management, order placement, position monitoring, and automated trading-strategy primitives. | [[entities/perpdex/drift]] | - |
| #c6 | SDK precision constants: QUOTE_PRECISION = 1e6 (USDC), PRICE_PRECISION = 1e6 (market prices), BASE_PRECISION = 1e9 (base assets), AMM_RESERVE_PRECISION = 1e9 (AMM calculations). | [[entities/perpdex/drift]] | - |
| #c7 | Each Drift market has a unique market index, an oracle for price feeds, AMM parameters for liquidity, and funding rate mechanisms. | [[entities/perpdex/drift]] | - |
| #c8 | The SDK supports both Solana networks via `initialize({ env: 'mainnet-beta' \| 'devnet' })`; devnet has a USDC faucet for testing. | [[entities/perpdex/drift]] | - |
| #c9 | Drift Protocol v2 is licensed under Apache 2.0. | [[entities/perpdex/drift]] | A1-PI |
| #c10 | Drift supports cross-collateral margin: USDC and other supported assets can be used as collateral across all positions. | [[entities/perpdex/drift]] | A6-PI |
