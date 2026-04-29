---
type: source
id: orderly-docs-2026-04-29-permissionless-listing
title: Permissionless Listing
publisher: Orderly Network Docs
author: Orderly team
date: 2026-04-29
original_url: https://orderly.network/docs/introduction/trade-on-orderly/permissionless-listing
mirror_snapshot: orderly-docs-2026-04-29
mirror_page: pages/permissionless-listing.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Permissionless Listing

## TL;DR
Permissionless Listing allows Diamond Tier Builders ($10B monthly volume or 7M $ORDER staked) to self-list new perpetual markets without Orderly approval. Each builder has a per-Builder Insurance Fund ($50k minimum per active symbol, up to 5 markets). All community-listed markets are Isolated Margin only. Controlled launch: POST_ONLY → ACTIVE once ±2% depth reaches $100k for 10 minutes. Circuit breakers force REDUCE_ONLY or delisting. Index prices from CEX feeds + Pyth + Stork oracles. Multiple builders can list same asset independently with separate books, IFs, and risk parameters.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Diamond Tier Builders ($10B monthly volume or 7M $ORDER staked) can permissionlessly list new perpetual markets | [[parameters/orderly/listing-policy]] | A1-PI |
| #c2 | Up to 5 active markets per builder (adjustable by Orderly) | [[parameters/orderly/listing-policy]] | A1-PI |
| #c3 | Per-Builder Insurance Fund: minimum $50,000 per active symbol (e.g., 3 markets = $150,000 minimum); separate from platform IF and other builders' IFs | [[parameters/orderly/insurance-fund]] | A1-PI, A6-PI |
| #c4 | If Builder IF drops too low, system restricts trading or triggers delisting | [[parameters/orderly/listing-policy]] | A1-PII |
| #c5 | All permissionlessly listed markets are Isolated Margin only — prevents cascade from long-tail token crash into BTC/ETH positions | [[parameters/orderly/listing-policy]] | A6-PI |
| #c6 | Controlled launch sequence: POST_ONLY → ACTIVE once ±2% order book depth reaches $100,000 on both sides and holds for 10 minutes | [[parameters/orderly/listing-policy]] | A1-PI |
| #c7 | Circuit breakers: insufficient depth, low IF, or funding rate anomalies → REDUCE_ONLY mode or delisting; per-market, not platform-wide | [[parameters/orderly/listing-policy]] | A1-PII |
| #c8 | Index prices aggregated from CEX feeds and on-chain oracles; supported: Pyth and Stork | [[parameters/orderly/oracle-config]] | A1-PI |
| #c9 | If all price sources unavailable, market placed into reduce-only mode | [[parameters/orderly/oracle-config]] | A6-PII |
| #c10 | Multiple builders can list same underlying asset independently — separate order books, liquidity, IFs, risk parameters | [[parameters/orderly/listing-policy]] | A1-PIV |
| #c11 | Per-Builder Market Maker (MM) accounts — optional sub-accounts for market-making on community-listed markets | [[parameters/orderly/listing-policy]] | A4-PI |
| #c12 | Standard Listing: evaluated and approved by Orderly, shared platform IF, standardized risk parameters | [[parameters/orderly/listing-policy]] | A1-PI |
| #c13 | Permissionless Listing: instant and self-managed, per-Builder IF, customizable risk parameters | [[parameters/orderly/listing-policy]] | A1-PI |
| #c14 | Builder earns 50% of trading fees and 100% of liquidation fees from permissionlessly listed markets | [[parameters/orderly/listing-policy]] | A2-PIV |

## Conflicts raised
None.
