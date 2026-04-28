---
type: source
id: drift-developers-docs-2026-04-28-developers-market-makers-quickstart
title: Market Maker Quickstart
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/developers/market-makers/quickstart
mirror_snapshot: drift-developers-docs-2026-04-28
mirror_page: pages/developers-market-makers-quickstart.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Market Maker Quickstart

## TL;DR
A 10-minute MM tutorial. Prereqs: Node.js + TypeScript, `@drift-labs/sdk`, funded Solana account with USDC, basic async familiarity. Critical disclaimer: the public `https://api.mainnet-beta.solana.com` RPC is rate-limited and unsuitable for production bots — Drift recommends Helius, Triton, or a dedicated RPC provider supporting `accountSubscribe` for WebSocket subscriptions. Step 1: initialize DriftClient with connection + wallet + env. Subsequent steps cover initializing user account, depositing USDC, placing two-sided quotes via `placePerpOrder`, and monitoring fills. The page is a long-form runbook (~74KB) with extensive method-reference appendices for DriftClient.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | A Drift MM bot setup requires Node.js, TypeScript, the `@drift-labs/sdk` package, a funded Solana account with USDC collateral, and basic async/await familiarity. | [[parameters/drift/mm-rebate-tiers]] | - |
| #c2 | The default public Solana RPC (api.mainnet-beta.solana.com) is rate-limited and unsuitable for production MM bots — Drift recommends a dedicated RPC provider (Helius, Triton, etc.). | [[parameters/drift/mm-rebate-tiers]] | A4-PI |
| #c3 | WebSocket subscription support (`accountSubscribe`) on the chosen RPC is required for production MM bots. | [[parameters/drift/mm-rebate-tiers]] | A4-PI |
| #c4 | DriftClient is initialized with `connection`, `wallet`, and `env` ("mainnet-beta" or "devnet"). | [[entities/perpdex/drift]] | - |
| #c5 | The DriftClient's `subscribe()` call activates account subscription updates needed before placing or reading state. | [[entities/perpdex/drift]] | - |
