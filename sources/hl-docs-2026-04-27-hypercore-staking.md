---
type: source
id: hl-docs-2026-04-27-hypercore-staking
title: HyperCore Staking
publisher: Hyperliquid Docs
author: Hyperliquid team
date: null
original_url: https://hyperliquid.gitbook.io/hyperliquid-docs/hypercore/staking
mirror_snapshot: hl-docs-2026-04-27
mirror_page: pages/hypercore-staking.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-27
---

# HyperCore Staking

## TL;DR
Defines HYPE staking via delegated proof of stake on HyperCore. Validator self-delegation requirement is 10k HYPE locked for 1 year; falling below moves the validator into undelegate-only mode. Validator commission cannot be increased except to ≤1%. Delegations have a 1-day lockup; spot→staking transfer is instant; staking→spot transfer goes through a 7-day unstaking queue (max 5 pending withdrawals per address). Reward rate is inversely proportional to the square root of total HYPE staked (Ethereum-inspired); at 400M staked, the rate is approximately 2.37%/yr; rewards come from the future emissions reserve. Validators may vote to jail unresponsive peers; jailing is distinct from slashing (which is reserved for provable malice such as double-signing). No automatic slashing currently implemented. Epochs are 100k consensus rounds (~90 minutes mainnet).

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | HYPE staking happens within HyperCore; HYPE moves between spot and staking accounts. | [[entities/token/hype]], [[entities/network/hyperliquid-l1]] |  |
| #c2 | Hyperliquid uses delegated proof-of-stake (delegate and stake are interchangeable terms). | [[entities/network/hyperliquid-l1]] |  |
| #c3 | Validator self-delegation requirement is 10k HYPE, locked for one year. | [[parameters/hyperliquid/validator-requirements]] | A7-PV |
| #c4 | If validator self-delegation drops below 10k HYPE, the validator enters undelegate-only mode (no new delegations). | [[parameters/hyperliquid/validator-requirements]] | A7-PII |
| #c5 | Validator commission cannot be increased unless the new commission is ≤1%. | [[parameters/hyperliquid/validator-requirements]] | A7-PV |
| #c6 | Delegation lockup duration is 1 day. | [[parameters/hyperliquid/validator-requirements]] |  |
| #c7 | Spot→staking transfers are instant. | [[entities/token/hype]] |  |
| #c8 | Staking→spot transfers have a 7-day unstaking queue. | [[entities/token/hype]], [[parameters/hyperliquid/validator-requirements]] | A7-PII |
| #c9 | Maximum of 5 pending unstaking withdrawals per address. | [[parameters/hyperliquid/validator-requirements]] |  |
| #c10 | Staking reward rate is inversely proportional to sqrt(total HYPE staked) — Ethereum-inspired formula. | [[concepts/tokenomics/emission-schedule]], [[entities/token/hype]] |  |
| #c11 | At 400M total HYPE staked, the yearly reward rate is approximately 2.37%. | [[parameters/hyperliquid/staking-rewards]], [[entities/token/hype]] |  |
| #c12 | Staking rewards come from the future emissions reserve. | [[concepts/tokenomics/emission-schedule]], [[entities/token/hype]] |  |
| #c13 | Rewards accrue every minute and are distributed daily. | [[parameters/hyperliquid/staking-rewards]] |  |
| #c14 | Rewards are auto-redelegated (compounded) to the staked validator. | [[parameters/hyperliquid/staking-rewards]] |  |
| #c15 | Reward calculation uses the minimum delegated balance during each staking epoch (100k rounds). | [[parameters/hyperliquid/staking-rewards]] |  |
| #c16 | A quorum is any validator set holding more than 2/3 of total stake. | [[entities/network/hyperliquid-l1]] |  |
| #c17 | The validator set is static within a staking epoch; epochs are 100k consensus rounds (~90 minutes on mainnet). | [[entities/network/hyperliquid-l1]] | A7-PI |
| #c18 | Validators can vote to jail peers with inadequate latency or response frequency; quorum vote leads to jailing. | [[entities/network/hyperliquid-l1]] | A8-PII |
| #c19 | Jailed validators cease consensus participation and produce no rewards for delegators; unjailing is rate-limited on-chain. | [[entities/network/hyperliquid-l1]] | A8-PII |
| #c20 | Slashing is reserved for provably malicious behavior (e.g. double-signing) and is distinct from jailing; no automatic slashing currently implemented. | [[entities/network/hyperliquid-l1]] | A8-PI |
