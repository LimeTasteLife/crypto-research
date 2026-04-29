---
type: source
id: drift-docs-2026-04-28-index
title: Introduction
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/
mirror_snapshot: drift-docs-2026-04-28
mirror_page: pages/index.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Introduction

## TL;DR
Drift Protocol's docs root frames it as an open-source decentralized exchange on Solana with three product surfaces: perpetuals (up to 101x leverage), spot trading (up to 5x), and token swaps (up to 5x). The site advertises a cross-margined risk engine where every deposited token can serve as collateral for perps and earn yield via lend/borrow simultaneously. "Earn" surfaces include lend/borrow yields, Insurance Fund Staking, and an opt-in Market Maker Rewards Alpha Program. The page also calls out SDKs (TypeScript + Python), a Drift Gateway self-hosted API, and a single audit citation: Trail of Bits. Page last-updated stamp: February 27, 2026.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Drift Protocol is a decentralized exchange built on the Solana blockchain. | [[entities/perpdex/drift]], [[entities/network/solana]] | A1-PI |
| #c2 | Drift Protocol is open-sourced. | [[entities/perpdex/drift]] | A1-PI |
| #c3 | Drift offers Perpetual Futures with up to 101x leverage. | [[entities/perpdex/drift]] | A1-PI |
| #c4 | Drift offers Spot Trading with up to 5x leverage. | [[entities/perpdex/drift]] | A1-PI |
| #c5 | Drift offers token Swaps with up to 5x leverage. | [[entities/perpdex/drift]] | A1-PI |
| #c6 | Drift uses a cross-margined risk engine where every deposited token can act as collateral for perpetual swaps. | [[entities/perpdex/drift]] | A6-PI |
| #c7 | Borrowers must hold collateral exceeding the borrowed amount, with multiple safety measures applied. | [[entities/perpdex/drift]] | A6-PI |
| #c8 | Insurance Fund Staking allows users to stake assets into a vault and earn yield from exchange fees. | [[parameters/drift/insurance-fund]] | A5-PI, A6-PI |
| #c9 | Drift offers an opt-in only Market Maker Rewards Alpha Program. | [[parameters/drift/mm-rebate-tiers]] | A4-PV |
| #c10 | Drift provides SDKs in TypeScript and Python. | [[entities/perpdex/drift]] | - |
| #c11 | Drift Gateway is a self-hosted API gateway for interacting with Drift Protocol. | [[entities/perpdex/drift]] | - |
| #c12 | Drift Protocol contracts are audited by Trail of Bits. | [[parameters/drift/audits]] | A8-PV |
