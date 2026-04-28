---
type: source
id: drift-developers-docs-2026-04-28-developers-drift-sdk-swift
title: SDK SWIFT
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/developers/drift-sdk/swift
mirror_snapshot: drift-developers-docs-2026-04-28
mirror_page: pages/developers-drift-sdk-swift.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Swift (off-chain signed orders)

## TL;DR
Swift = signed-message orders without paying Solana gas or waiting for confirmation. Taker signs an order message offchain and POSTs to the Swift API at `https://swift.drift.trade/orders`; keepers/MMs bundle the signed message with their own onchain transaction to fill. Order flow: (1) define standard Drift order params (typically market order with auction parameters); (2) sign offchain using DriftClient wallet via `signSignedMsgOrderParamsMessage`; (3) POST `{ market_index, market_type, message, signature, taker_authority }` to Swift API; (4) keepers/MMs pick up and fill on-chain. Each order needs a unique UUID via `generateSignedMsgUuid()` to prevent replay. Delegate accounts can use `initializeSignedMsgUserOrders(authority, numOrders)` for delegate signing. Advanced builders: `getPlaceSignedMsgTakerPerpOrderIxs` (build taker-side fill instructions for keepers); `getPlaceAndMakeSignedMsgPerpOrderIxs` (atomic maker fill of pending Swift taker order).

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Swift is an extension to Drift letting users place orders without submitting a Solana transaction (gas-free for takers). | [[concepts/operations/matching-engine]] | A4-PIII |
| #c2 | The Swift API endpoint is `https://swift.drift.trade/orders`. | [[entities/perpdex/drift]] | - |
| #c3 | Swift order flow: define order params → sign offchain with DriftClient wallet → POST to Swift API → keepers/MMs pick up and fill on-chain. | [[concepts/operations/matching-engine]] | A4-PI |
| #c4 | Each Swift order requires a unique UUID generated via `generateSignedMsgUuid()` to prevent replay attacks. | [[concepts/operations/matching-engine]] | A8-PI |
| #c5 | For delegate flows the signing_authority and taker_authority are distinct; DriftClient must be initialized with `authority` set to the owner's key. | [[concepts/operations/matching-engine]] | - |
| #c6 | `initializeSignedMsgUserOrders(authority, numOrders)` initializes a SignedMsgUserOrders PDA allowing a delegate to place Swift orders on behalf of an owner. | [[entities/perpdex/drift]] | - |
| #c7 | `getPlaceSignedMsgTakerPerpOrderIxs` builds taker-side fill instructions used by keeper bots to submit a taker's signed Swift order on-chain. | [[entities/perpdex/drift]] | A4-PI |
| #c8 | `getPlaceAndMakeSignedMsgPerpOrderIxs` builds instructions for atomic maker fill of a pending Swift taker order. | [[entities/perpdex/drift]] | A4-PI |
