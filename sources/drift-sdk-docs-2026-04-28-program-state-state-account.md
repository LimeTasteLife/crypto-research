---
type: source
id: drift-sdk-docs-2026-04-28-program-state-state-account
title: State Account
publisher: Drift Protocol v2 SDK Docs (Mintlify)
author: Drift Labs
date: null
original_url: https://mintlify.com/drift-labs/protocol-v2/program/state/state-account
mirror_snapshot: drift-sdk-docs-2026-04-28
mirror_page: pages/program-state-state-account.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# State Account

## TL;DR
The State account stores global protocol configuration. Defined in `programs/drift/src/state/state.rs`. Key fields include: protocol admin pubkey, exchangeStatus, oracleGuardRails (slotsBeforeStaleForAmm, confidenceIntervalMaxPercentDivergence, priceDivergence), perp/spot fee structures, maxInitializeUserFee. FeeStructure has 10 FeeTiers, an OrderFillerRewardStructure, referrerRewardEpochUpperBound, and flatFillerFee. Fee tiers are based on 30-day trading volume.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | The Drift State account is defined in `programs/drift/src/state/state.rs`. | [[entities/perpdex/drift]] | - |
| #c2 | The State account stores global protocol configuration including admin pubkey, exchangeStatus, oracleGuardRails, perp/spot fee structures, maxInitializeUserFee. | [[entities/perpdex/drift]] | A7-PI |
| #c3 | OracleGuardRails fields: `slotsBeforeStaleForAmm`, `confidenceIntervalMaxPercentDivergence`, `priceDivergence` (mark/oracle divergence limits). | [[parameters/drift/oracle-config]] | A6-PI |
| #c4 | Drift FeeStructure: array of 10 FeeTiers, an OrderFillerRewardStructure, `referrerRewardEpochUpperBound`, and `flatFillerFee`. | [[parameters/drift/fee-schedule]] | A2-PI, A4-PV |
| #c5 | Drift fee tiers are based on 30-day trading volume. | [[parameters/drift/fee-schedule]] | A2-PI |
