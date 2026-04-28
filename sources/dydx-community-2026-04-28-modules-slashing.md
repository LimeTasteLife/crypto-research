---
type: source
id: dydx-community-2026-04-28-modules-slashing
title: Slashing
publisher: dYdX Community Docs
author: dYdX community
date: null
original_url: https://docs.dydx.community/dydx/modules/slashing
mirror_snapshot: dydx-community-2026-04-28
mirror_page: pages/modules-slashing.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Slashing

## TL;DR
Slashing module penalizes validators for protocol violations. Two infractions: Double Signing (signing two blocks at the same height — leads to slashing + jail + tombstoning) and Downtime (insufficient block-signing within a sliding window — leads to slashing + jail). Current parameters: signed_blocks_window 8192 (~3h11m at 1.4s blocks), min_signed_per_window 0.2 (20%), downtime_jail_duration 7200s (2h), slash_fraction_double_sign = 0.0, slash_fraction_downtime = 0.0. Liveness formula: `maxMissed = signed_blocks_window − min_signed_per_window × signed_blocks_window`. Slashing for liveness failure does NOT cause tombstoning (only double-sign does). MEV is acknowledged as harmful — Skip dashboard exists; Social Slashing has NOT been adopted but governance could approve it.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | The slashing module penalizes validators for protocol violations by burning a portion of their bonded tokens and/or temporarily removing their voting ability. | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c2 | Double Signing occurs when a validator signs two blocks at the same height (causing conflicting blocks/transactions on multiple branches). | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c3 | A Staking Tombstone permanently removes a validator from the Active Set due to double signing. | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c4 | Slashing parameter `signed_blocks_window` = 8192 blocks (~3 hours 11 minutes assuming 1.4s block time). | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c5 | Slashing parameter `min_signed_per_window` = 0.2 (a validator must sign at least 20% of blocks in the window to avoid jail). | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c6 | Slashing parameter `downtime_jail_duration` = 7200 seconds (2 hours). | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c7 | Slashing parameter `slash_fraction_double_sign` = 0.0 (no monetary slash for double-signing in the current default; tombstoning still applies). | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c8 | Slashing parameter `slash_fraction_downtime` = 0.0 (no monetary slash for downtime in the current default; jailing still applies). | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c9 | Liveness formula: `maxMissed = signed_blocks_window − min_signed_per_window × signed_blocks_window`. | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c10 | If MissedBlocksCounter exceeds maxMissed, the validator is slashed by slash_fraction_downtime, jailed for downtime_jail_duration, and has their MissedBlocksBitArray, MissedBlocksCounter, and IndexOffset reset. | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c11 | Slashing due to liveness-tracking failure does not lead to tombstoning. | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c12 | A jailed validator must send a `MsgUnjail` transaction to return after downtime jailing. | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c13 | dYdX Trading and Skip Protocol have collaborated to create a dashboard displaying validator MEV-extraction-related orderbook discrepancies. | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c14 | There is no protocol-level solution to mitigate MEV on dYdX Chain currently, despite MEV extraction being considered harmful validator behavior. | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c15 | The dYdX community could approve a social slashing framework via governance vote to penalize validators engaged in MEV extraction. | [[parameters/dydx-v4/validator-requirements]] | A7-PI, A8-PI |
