---
type: source
id: drift-sdk-docs-2026-04-28-installation
title: Installation
publisher: Drift Protocol v2 SDK Docs (Mintlify)
author: Drift Labs
date: null
original_url: https://mintlify.com/drift-labs/protocol-v2/installation
mirror_snapshot: drift-sdk-docs-2026-04-28
mirror_page: pages/installation.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Installation

## TL;DR
SDK installation requires Node.js ≥24.0.0. Current SDK version: 2.158.0-beta.0. Core dependencies: `@coral-xyz/anchor` (0.29.0 & 0.30.1), `@solana/web3.js` (1.98.0), `@solana/spl-token` (0.4.13), `bn.js`. Wallet generation via `solana-keygen new` writes to `~/.config/solana/id.json`. Devnet: `solana airdrop 2 <addr> --url devnet` plus Drift's devnet USDC faucet. Mainnet requires SOL (for fees) and USDC (for collateral). Premium RPCs recommended for production: Helius, QuickNode, Triton. tsconfig requirements: target ES2020, module commonjs, esModuleInterop, strict. Building from source requires the protocol-v2 repo; M1 Macs need `rustup default stable-x86_64-apple-darwin`.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | The Drift SDK requires Node.js version 24.0.0 or higher. | [[entities/perpdex/drift]] | - |
| #c2 | The current Drift SDK version on this snapshot is 2.158.0-beta.0. | [[entities/perpdex/drift]] | - |
| #c3 | SDK core dependencies: `@coral-xyz/anchor` (0.29.0 & 0.30.1), `@solana/web3.js` (1.98.0), `@solana/spl-token` (0.4.13), `bn.js`. | [[entities/perpdex/drift]] | - |
| #c4 | Devnet provides a Drift USDC faucet for testing after wallet connection. | [[entities/perpdex/drift]] | - |
| #c5 | Mainnet trading requires both SOL (for transaction fees) and USDC (for trading collateral). | [[entities/perpdex/drift]] | - |
| #c6 | Recommended premium RPC providers: Helius, QuickNode, Triton (for higher rate limits and reliability). | [[entities/perpdex/drift]] | - |
| #c7 | The Drift SDK is open source on GitHub at `github.com/drift-labs/protocol-v2`. | [[entities/perpdex/drift]] | A1-PI |
