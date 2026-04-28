---
type: source
id: drift-developers-docs-2026-04-28-developers-drift-sdk-setup
title: SDK Setup
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/developers/drift-sdk/setup
mirror_snapshot: drift-developers-docs-2026-04-28
mirror_page: pages/developers-drift-sdk-setup.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# SDK Setup

## TL;DR
Drift program addresses are identical on mainnet & devnet: Drift program = `dRiftyHA39MWEi3m9aunc5MzRF1JYuBsbn6VPcn33UH`; Drift Vaults program = `vAuLTsyrvSfZRuRB3XgvkPwNGgYSs9YRYymVebLKoxR`. Importable via SDK as `DRIFT_PROGRAM_ID`. Setup flow: generate Solana keypair via `solana-keygen new`, set `ANCHOR_WALLET` env var, install `@drift-labs/sdk`, then create a DriftClient with connection + wallet + env. DriftClient parameters: `connection`, `wallet`, `env` (devnet | mainnet-beta), `perpMarketIndexes`, `spotMarketIndexes`, `oracleInfos`, `accountSubscription` (WebSocket default; polling via `BulkAccountLoader`), `activeSubAccountId`, `subAccountIds`, `authority` (only set for delegated accounts). Critical for delegated accounts: must explicitly set `subAccountIds`, `activeSubAccountId`, `authority` — omission causes wrong-account subscription. WebSocket is the default subscription mode for bots; polling with BulkAccountLoader is for read-only or RPC-rate-controlled workflows.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | The Drift Protocol program ID is `dRiftyHA39MWEi3m9aunc5MzRF1JYuBsbn6VPcn33UH` on both mainnet and devnet. | [[parameters/drift/contract-addresses]] | - |
| #c2 | The Drift Vaults program ID is `vAuLTsyrvSfZRuRB3XgvkPwNGgYSs9YRYymVebLKoxR`. | [[parameters/drift/contract-addresses]] | - |
| #c3 | The Drift program ID is importable from `@drift-labs/sdk` as `DRIFT_PROGRAM_ID`. | [[entities/perpdex/drift]] | - |
| #c4 | DriftClient parameters: `connection`, `wallet`, `env` (devnet | mainnet-beta), `perpMarketIndexes`, `spotMarketIndexes`, `oracleInfos`, `accountSubscription`, `activeSubAccountId`, `subAccountIds`, `authority`. | [[entities/perpdex/drift]] | - |
| #c5 | For delegated accounts, the SDK requires explicit `subAccountIds`, `activeSubAccountId`, and `authority` — omitting any causes the client to subscribe to wrong accounts. | [[entities/perpdex/drift]] | - |
| #c6 | The default DriftClient account-subscription mode is WebSocket; an alternative polling mode is available via `BulkAccountLoader` for read-only workflows or RPC-load control. | [[entities/perpdex/drift]] | - |
