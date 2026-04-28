---
type: source
id: drift-sdk-docs-2026-04-28-concepts-overview
title: Protocol Overview
publisher: Drift Protocol v2 SDK Docs (Mintlify)
author: Drift Labs
date: null
original_url: https://mintlify.com/drift-labs/protocol-v2/concepts/overview
mirror_snapshot: drift-sdk-docs-2026-04-28
mirror_page: pages/concepts-overview.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Protocol Overview

## TL;DR
Drift v2 is a fully on-chain DEX on Solana offering perpetual futures + spot trading with up to 20x leverage (stated). It combines an AMM with a CLOB to provide deep liquidity. Core modules: State Management, Market Operations, Risk Engine, Oracle Integration. Account types: State, Market (perp + spot), User, UserStats. MarketStatus enum: INITIALIZED, ACTIVE, FUNDING_PAUSED, AMM_PAUSED, FILL_PAUSED, WITHDRAW_PAUSED, REDUCE_ONLY, SETTLEMENT, DELISTED. ContractTier enum: A (highest insurance), B (medium), C (lower), SPECULATIVE (no insurance), HIGHLY_SPECULATIVE (no insurance), ISOLATED (isolated margin only). vAMM uses constant product with repegging. ExchangeStatus bitflags: ACTIVE=0, DEPOSIT_PAUSED=1, WITHDRAW_PAUSED=2, AMM_PAUSED=4, FILL_PAUSED=8, LIQ_PAUSED=16, FUNDING_PAUSED=32, SETTLE_PNL_PAUSED=64, AMM_IMMEDIATE_FILL_PAUSED=128, PAUSED=255. Cross-margin by default; isolated margin available on supported markets. Up to 1000 sub-accounts per user. Permissionless keeper bots trigger liquidations, settle funding, fill orders.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Drift Protocol v2 is a fully on-chain decentralized exchange on Solana offering perpetual futures and spot trading with up to 20x leverage. | [[entities/perpdex/drift]] | A1-PI |
| #c2 | Drift v2 combines an Automated Market Maker (AMM) with a central limit order book (CLOB) to provide deep liquidity and efficient price discovery. | [[concepts/market-structure/hybrid]] | A1-PI |
| #c3 | Drift v2's protocol modules: State Management, Market Operations, Risk Engine, Oracle Integration. | [[entities/perpdex/drift]] | A1-PI |
| #c4 | MarketStatus enum values: INITIALIZED, ACTIVE, FUNDING_PAUSED, AMM_PAUSED, FILL_PAUSED, WITHDRAW_PAUSED, REDUCE_ONLY, SETTLEMENT, DELISTED. | [[entities/perpdex/drift]] | - |
| #c5 | ContractTier enum values: A (highest insurance), B (medium), C (lower), SPECULATIVE (no insurance), HIGHLY_SPECULATIVE (no insurance), ISOLATED (isolated margin only). | [[concepts/risk/margin-tier]] | A6-PI |
| #c6 | Isolated tier markets require isolated margin positions and cannot be used as cross-collateral. | [[concepts/risk/margin-tier]] | A6-PI |
| #c7 | Drift's vAMM uses a constant product formula with repegging capability — adjusts pegMultiplier to track oracle prices and concentrates liquidity around current price. | [[concepts/market-structure/vamm]] | A1-PI, A6-PI |
| #c8 | ExchangeStatus bitflag values: ACTIVE=0, DEPOSIT_PAUSED=1, WITHDRAW_PAUSED=2, AMM_PAUSED=4, FILL_PAUSED=8, LIQ_PAUSED=16, FUNDING_PAUSED=32, SETTLE_PNL_PAUSED=64, AMM_IMMEDIATE_FILL_PAUSED=128, PAUSED=255. | [[entities/perpdex/drift]] | A7-PI |
| #c9 | Drift uses cross-margin by default; users can also opt for isolated margin on supported markets. | [[entities/perpdex/drift]] | A6-PI |
| #c10 | Each Drift user can create up to 1000 sub-accounts to separate trading strategies or risk profiles. | [[entities/perpdex/drift]] | - |
| #c11 | Drift relies on permissionless keeper bots to trigger liquidations, settle funding, and fill orders. | [[entities/perpdex/drift]] | A4-PI |
| #c12 | Drift has a protocol-owned insurance fund that backstops losses from liquidations and bankruptcy events. | [[parameters/drift/insurance-fund]] | A6-PI |
