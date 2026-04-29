---
type: source
id: orderly-docs-2026-04-29-custom-fees
title: Custom Fee Structure
publisher: Orderly Network Docs
author: Orderly team
date: 2026-04-29
original_url: https://orderly.network/docs/build-on-omnichain/user-flows/custom-fees
mirror_snapshot: orderly-docs-2026-04-29
mirror_page: pages/custom-fees.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Custom Fee Structure

## TL;DR
The Custom Trading Fee System lets builders set per-user fee structures beyond Orderly's base fees. Base fee goes 100% to Orderly; custom fee goes 100% to the builder. Default base taker fee is 3 bps, base maker fee is 0 bps (subject to Builder Staking Programme). Total user-facing fee rate cannot be less than Orderly's base fee. Builders receive daily rebates in their fee wallet after deducting referral rebates.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Base fee goes 100% to Orderly; custom fee goes 100% to builder | [[parameters/orderly/fee-schedule]] | A2-PI |
| #c2 | Default base taker fee: 3 bps; base maker fee: 0 bps (subject to Builder Staking Programme tiers) | [[parameters/orderly/fee-schedule]] | A2-PI |
| #c3 | Total user-facing fee rate cannot be less than Orderly base fee | [[parameters/orderly/fee-schedule]] | A2-PI |
| #c4 | Builders can set custom fee rates per user (override default rate) | [[parameters/orderly/fee-schedule]] | A2-PIV |
| #c5 | Builders receive daily rebates in fee wallet, calculated after deducting referral rebates | [[parameters/orderly/fee-schedule]] | A2-PI |

## Conflicts raised
None.
