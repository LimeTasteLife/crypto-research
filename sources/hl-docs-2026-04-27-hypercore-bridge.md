---
type: source
id: hl-docs-2026-04-27-hypercore-bridge
title: HyperCore Bridge
publisher: Hyperliquid Docs
author: Hyperliquid team
date: null
original_url: https://hyperliquid.gitbook.io/hyperliquid-docs/hypercore/bridge
mirror_snapshot: hl-docs-2026-04-27
mirror_page: pages/hypercore-bridge.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-27
---

# HyperCore Bridge

## TL;DR
Describes the validator-signed bridge between Hyperliquid and Arbitrum. Deposits credit when ≥2/3 of stake-weighted validators sign. Withdrawals deduct immediately on the L1 then are signed off by validators; once 2/3 sign, an EVM tx finalizes. A dispute period allows malicious withdrawals to be challenged via cold-wallet 2/3 validator signatures locking the bridge. Withdrawal cost: 1 USDC paid on Hyperliquid (no Arbitrum ETH required from the user). Bridge has been audited by Zellic; code is public.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Bridge deposits credit when more than 2/3 of stake-weighted validators sign. | [[entities/perpdex/hyperliquid]], [[concepts/operations/settlement]] | A8-PV |
| #c2 | Withdrawals are deducted immediately from L1 balance; validators sign as separate transactions; ≥2/3 signing power required to send the EVM finalization tx. | [[concepts/operations/settlement]] | A8-PV |
| #c3 | A dispute period exists between withdrawal request and finalization; the bridge can be locked during this window for malicious withdrawals. | [[concepts/operations/settlement]] | A8-PII |
| #c4 | Cold-wallet signatures of 2/3 of stake-weighted validators are required to unlock the bridge. | [[concepts/operations/settlement]] | A8-PV |
| #c5 | Withdrawal gas fee is 1 USDC, paid on Hyperliquid, in lieu of Arbitrum ETH from the user. | [[parameters/hyperliquid/fee-schedule]] | A2-PIV |
| #c6 | The bridge and its L1 staking interaction have been audited by Zellic; reports are public in the Audits section. | [[entities/perpdex/hyperliquid]] | A8-PV |
