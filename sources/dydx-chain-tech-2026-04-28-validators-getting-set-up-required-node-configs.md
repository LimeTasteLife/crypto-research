---
type: source
id: dydx-chain-tech-2026-04-28-validators-getting-set-up-required-node-configs
title: Required Node Configs
publisher: dYdX Community Docs (chain technical)
author: dYdX community
date: null
original_url: https://docs.dydx.community/dydx-chain-technical-docs/validators/getting-set-up/required-node-configs
mirror_snapshot: dydx-chain-tech-2026-04-28
mirror_page: pages/validators-getting-set-up-required-node-configs.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Required Node Configs

## TL;DR
Operator-facing config requirements. Bridge-daemon needs an Ethereum RPC supporting `"finalized"` toBlock, `eth_getLogs`, and `eth_chainId` (Erigon NOT supported because it lacks finalized). Two required config files: `app.toml` (CosmosSDK) and `config.toml` (CometBFT). Consensus: timeout_commit = 500ms. Pruning: custom, keep-recent ≥ 2 for validators (larger for historical-query full nodes), pruning-interval prime [13, 97]. gRPC must run on port 9090. Min gas prices use IBC USDC + native token at specific weights.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | dYdX validators must specify a private Ethereum RPC endpoint via `--bridge-daemon-eth-rpc-endpoint` for the bridge daemon to ingest bridge transactions. | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c2 | The required Ethereum RPC endpoint must support `"finalized"` as input to the `toBlock` parameter (Erigon does not support this). | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c3 | The required Ethereum RPC endpoint must support the `eth_getLogs` method. | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c4 | The required Ethereum RPC endpoint must support the `eth_chainId` method. | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c5 | dYdX node consensus config requires `timeout_commit = 500ms` in config.toml. | [[parameters/dydx-v4/validator-requirements]] | A1-PI, A8-PI |
| #c6 | dYdX validator pruning config: pruning-keep-recent should be a small number ≥ 2 for validator nodes (larger for full nodes used for historical queries). | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c7 | dYdX validator pruning config: pruning-interval is any prime number between 13 and 97 (inclusive). | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c8 | dYdX validator gRPC must run on port 9090; non-standard gRPC ports are not supported. | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c9 | dYdX node minimum gas prices specify IBC USDC denom (`ibc/8E27BA2D5493AF5636760E354E46004562C46AB7EC0CC4C1CA14E9E20E2545B5`) at 0.025 and native token denom at 12,500,000,000. | [[parameters/dydx-v4/validator-requirements]] | A2-PI |
