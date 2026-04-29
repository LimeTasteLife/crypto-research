---
type: source
id: orderly-docs-2026-04-29-trading-fees
title: Trading Fees
publisher: Orderly Network Docs
author: Orderly team
date: 2026-04-29
original_url: https://orderly.network/docs/introduction/trade-on-orderly/trading-basics/trading-fees
mirror_snapshot: orderly-docs-2026-04-29
mirror_page: pages/trading-fees.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Trading Fees

## TL;DR
Orderly uses a two-layer fee structure: base fees (Builder pays to Orderly) and user fees (Trader pays to Builder). The base maker fee is 0.00 bps across all tiers. Base taker fees range from 3.00 bps (Public) to 1.00 bps (Diamond) for crypto, and 5.00 bps to 3.00 bps for RWA. Builder Staking Programme tiers (Public/Silver/Gold/Platinum/Diamond) are determined by monthly volume or $ORDER staking. Builders who permissionlessly list markets earn 50% of trading fees and 100% of liquidation fees from their markets.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Two-layer fee structure: base fees (Builder → Orderly) and user fees (Trader → Builder) | [[parameters/orderly/fee-schedule]] | A2-PI |
| #c2 | Base maker fee: 0.00 bps across all tiers | [[parameters/orderly/fee-schedule]] | A2-PI |
| #c3 | Public tier: crypto base taker 3.00 bps, RWA base taker 5.00 bps; no volume/staking requirement | [[parameters/orderly/fee-schedule]] | A2-PI |
| #c4 | Silver tier: crypto base taker 2.75 bps, RWA base taker 4.75 bps; requires ≥$30M monthly volume or 100K $ORDER staked | [[parameters/orderly/fee-schedule]] | A2-PI |
| #c5 | Gold tier: crypto base taker 2.50 bps, RWA base taker 4.50 bps; requires ≥$90M monthly volume or 250K $ORDER staked | [[parameters/orderly/fee-schedule]] | A2-PI |
| #c6 | Platinum tier: crypto base taker 2.00 bps, RWA base taker 4.00 bps; requires ≥$1B monthly volume or 2M $ORDER staked | [[parameters/orderly/fee-schedule]] | A2-PI |
| #c7 | Diamond tier: crypto base taker 1.00 bps, RWA base taker 3.00 bps; requires ≥$10B monthly volume or 7M $ORDER staked | [[parameters/orderly/fee-schedule]] | A2-PI |
| #c8 | Monthly (30-day) aggregate trading volume includes all activity from the Builder and their direct Builder referrals; daily snapshots determine tier | [[parameters/orderly/fee-schedule]] | A2-PIV |
| #c9 | Builder user fee must be at least as high as Orderly base fee; builder keeps 100% of the margin | [[parameters/orderly/fee-schedule]] | A2-PI |
| #c10 | Fees measured in bps (1 bps = 0.01%) of trade's total value, charged in USDC after every trade, factored into position's average entry price | [[parameters/orderly/fee-schedule]] | A2-PI |
| #c11 | Permissionless listing builders earn 50% of trading fees and 100% of liquidation fees from their markets | [[parameters/orderly/listing-policy]] | A1-PI, A2-PIV |

## Conflicts raised
None.
