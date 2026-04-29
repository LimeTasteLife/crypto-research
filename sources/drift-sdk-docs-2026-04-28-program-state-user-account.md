---
type: source
id: drift-sdk-docs-2026-04-28-program-state-user-account
title: User Account
publisher: Drift Protocol v2 SDK Docs (Mintlify)
author: Drift Labs
date: null
original_url: https://mintlify.com/drift-labs/protocol-v2/program/state/user-account
mirror_snapshot: drift-sdk-docs-2026-04-28
mirror_page: pages/program-state-user-account.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# User Account

## TL;DR
UserAccount stores all trading data for a single user (subaccount). Defined in `programs/drift/src/state/user.rs`. Key fields: authority (controlling wallet), subAccountId (0–9999), perpPositions array (up to 8), spotPositions array (up to 8), orders array (up to 32), settledPerpPnl, cumulativePerpFunding, nextOrderId, maxMarginRatio, isMarginTradingEnabled flag.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | The Drift UserAccount is defined in `programs/drift/src/state/user.rs`. | [[entities/perpdex/drift]] | - |
| #c2 | Each Drift wallet authority can have subAccountId values from 0 to 9999. | [[entities/perpdex/drift]] | - |
| #c3 | UserAccount holds up to 8 perpetual positions. | [[entities/perpdex/drift]] | - |
| #c4 | UserAccount holds up to 8 spot positions (collateral). | [[entities/perpdex/drift]] | - |
| #c5 | UserAccount holds up to 32 active orders. | [[entities/perpdex/drift]] | - |
| #c6 | UserAccount tracks settled perpetual PnL, cumulative funding payments, and nextOrderId for order ID assignment. | [[entities/perpdex/drift]] | - |
| #c7 | UserAccount has a custom `maxMarginRatio` field allowing per-account leverage caps below market maximums. | [[entities/perpdex/drift]] | A6-PI |
| #c8 | UserAccount has an `isMarginTradingEnabled` boolean flag controlling whether margin trading is allowed. | [[entities/perpdex/drift]] | - |
