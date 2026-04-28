---
type: source
id: drift-sdk-docs-2026-04-28-quickstart
title: Quick Start
publisher: Drift Protocol v2 SDK Docs (Mintlify)
author: Drift Labs
date: null
original_url: https://mintlify.com/drift-labs/protocol-v2/quickstart
mirror_snapshot: drift-sdk-docs-2026-04-28
mirror_page: pages/quickstart.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Quick Start

## TL;DR
Tutorial showing how to place a 1 SOL-PERP long order on Drift devnet. Covers SDK initialization with `initialize({ env: 'devnet' })`, wallet load from BOT_PRIVATE_KEY env var, AnchorProvider setup, SOL balance check (≥0.1 SOL needed for fees), DriftClient construction with BulkAccountLoader (polling subscription, 1000ms interval), user account initialization. Full example imports cover DriftClient, User, PositionDirection, convertToNumber, PRICE_PRECISION, QUOTE_PRECISION, BASE_PRECISION, Wallet, PerpMarkets, getMarketOrderParams, BulkAccountLoader, BN, calculateBidAskPrice. The page is the canonical first-touch tutorial for an SDK user.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | The Drift SDK quickstart uses devnet for testing without requiring real funds. | [[entities/perpdex/drift]] | - |
| #c2 | A devnet workflow needs at least 0.1 SOL in the wallet for transaction fees. | [[entities/perpdex/drift]] | - |
| #c3 | The SDK's `initialize({ env })` with env "devnet" or "mainnet-beta" returns a config including DRIFT_PROGRAM_ID and USDC_MINT_ADDRESS. | [[entities/perpdex/drift]] | - |
| #c4 | The SDK supports both polling (via `BulkAccountLoader`) and WebSocket subscription modes for the DriftClient. | [[entities/perpdex/drift]] | - |
| #c5 | Quickstart workflow: initialize SDK → connect wallet → create Drift user account → deposit USDC collateral → place perpetual order → monitor position. | [[entities/perpdex/drift]] | - |
