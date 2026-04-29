---
type: source
id: drift-developers-docs-2026-04-28-developers-drift-sdk-builder-codes
title: SDK Builder Codes
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/developers/drift-sdk/builder-codes
mirror_snapshot: drift-developers-docs-2026-04-28
mirror_page: pages/developers-drift-sdk-builder-codes.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Builder Codes

## TL;DR
Drift Builder Codes (DBC) are an integrator revenue-share mechanism layered on top of Swift orders ONLY. Workflow: (1) Builder calls `initializeRevenueShare` (one-time setup, on-chain revenue-share config account); (2) User calls `initializeRevenueShareEscrow(authority, numOrders)` (recommend ≥8 to accommodate multiple subaccounts); (3) User calls `changeApprovedBuilder(builderAuthority, maxFeeTenthBps, true)` to approve a builder with a max-fee cap (in tenths of a basis point: 100 = 10 bps, 200 = 20 bps). Per Swift order, builder's app injects `builderIdx` (index in user's approved_builders list) and `builderFeeTenthBps` into the signed message. Keeper bundles the fill tx and fees auto-settle to the builder's revenue-share account on fill. NOTE: Builder Codes are CURRENTLY LIMITED TO SWIFT ORDERS ONLY — not standard onchain orders.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Builder Codes (DBC) let integrators earn fees by routing flow through their application. | [[parameters/drift/referral-program]] | A3-PI |
| #c2 | Builder Codes are currently limited to Swift orders only — not standard onchain orders. | [[parameters/drift/referral-program]] | A3-PI |
| #c3 | Builder fee setup workflow: (1) builder initializes revenue-share account; (2) user creates an escrow account for tracking approved builders; (3) user approves the builder with a maximum fee cap. | [[parameters/drift/referral-program]] | A3-PV |
| #c4 | The user's RevenueShareEscrow `numOrders` parameter should be ≥8 to accommodate multiple subaccounts with open orders. | [[parameters/drift/referral-program]] | - |
| #c5 | Builder fee cap is expressed in tenths of a basis point: 100 = 10 bps, 200 = 20 bps. | [[parameters/drift/referral-program]] | A3-PI |
| #c6 | Per-Swift-order fee fields: `builderIdx` (index in user's approved_builders list) and `builderFeeTenthBps` (fee for this order in tenths of a basis point). | [[parameters/drift/referral-program]] | A3-PI |
| #c7 | When a Swift order with builder fields is filled, fees are automatically settled to the builder's revenue-share account. | [[parameters/drift/referral-program]] | A3-PI |
