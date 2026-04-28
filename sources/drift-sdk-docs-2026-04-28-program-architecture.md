---
type: source
id: drift-sdk-docs-2026-04-28-program-architecture
title: Program Architecture
publisher: Drift Protocol v2 SDK Docs (Mintlify)
author: Drift Labs
date: null
original_url: https://mintlify.com/drift-labs/protocol-v2/program/architecture
mirror_snapshot: drift-sdk-docs-2026-04-28
mirror_page: pages/program-architecture.md
raw_path: null
kind: docs
authority: medium
ingested: 2026-04-28
---

# Program Architecture

## TL;DR
Drift Protocol is a Solana-based derivatives exchange built with the Anchor framework supporting perpetual futures and spot markets through cross-margined risk. Program ID (mainnet & devnet): `dRiftyHA39MWEi3m9aunc5MzRF1JYuBsbn6VPcn33UH`. Core state accounts: State (global protocol settings), PerpMarket (per-perp setup + AMM state), SpotMarket (collateral asset config), User (positions + orders), UserStats (metrics + fee classification). Controllers: Position, Order, AMM, Liquidation, Funding. Single collateral pool supports all positions via cross-margin. Oracle integration via Pyth and Switchboard. Security posture: multiple audit completions, active bug bounty, governance-controlled upgrades, oracle safeguards.

## Source confidence

This page was fetched via WebFetch fallback after `mcp__exa-web-search__web_fetch_exa` returned CRAWL_LIVECRAWL_TIMEOUT. WebFetch returned a summarized rendition (~2.2KB) shorter than what exa would have produced — the full page may contain additional detail (instruction-level breakdowns, account-relationship diagrams). Authority is downgraded to `medium` for this single source pending re-crawl with exa or headless browser. Other architectural claims in this snapshot (concepts-overview, account-model, program-state-*) are unaffected.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Drift Protocol is built with the Anchor framework on Solana. | [[entities/perpdex/drift]] | A1-PI |
| #c2 | Drift's Program ID is `dRiftyHA39MWEi3m9aunc5MzRF1JYuBsbn6VPcn33UH` on both mainnet and devnet. | [[parameters/drift/contract-addresses]] | - |
| #c3 | Drift's core controllers are: Position Controller, Order Controller, AMM Controller, Liquidation Controller, Funding Controller. | [[entities/perpdex/drift]] | - |
| #c4 | Drift uses a "Single collateral pool supports all positions" cross-margin design. | [[entities/perpdex/drift]] | A6-PI |
| #c5 | Drift has multiple audit completions, an active bug bounty initiative, governance-controlled upgrades, and oracle safeguards. | [[parameters/drift/audits]] | A8-PV |
