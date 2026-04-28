---
type: source
id: lighter-docs-2026-04-28-trading-multi-asset-margin-collateral-supply-limits
title: Collateral Supply Limits
publisher: Lighter Docs
author: Lighter team
date: null
original_url: https://docs.lighter.xyz/trading/multi-asset-margin/collateral-supply-limits
mirror_snapshot: lighter-docs-2026-04-28
mirror_page: pages/trading-multi-asset-margin-collateral-supply-limits.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Collateral Supply Limits

## TL;DR
Thin page (576 bytes; webfetch fallback). Lighter is rolling out non-USDC collateral with conservative caps, ETH first. Users choose how much of their available collateral to allocate as margin on a per-asset basis. The Global Supply Cap table shows ETH as "coming soon" — no concrete cap value is published in the mirror snapshot. Numeric global caps remain a Phase 2 gap to be reconfirmed once the live page populates the table.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Lighter is implementing a measured approach to collateral supply with conservative limits as ETH becomes the first non-USDC collateral asset. | [[parameters/lighter/multi-asset-collateral]] | A6-PII |
| #c2 | Users can choose how much of their available collateral to allocate as margin on a per-asset basis. | [[parameters/lighter/multi-asset-collateral]] | A6-PI |
| #c3 | As of the 2026-04-28 mirror snapshot, the Global Cap value for ETH (the only currently-listed non-USDC margin asset) is shown as "ETH as collateral is coming soon" — no concrete numeric cap published. | [[parameters/lighter/multi-asset-collateral]] | A6-PI |

## Conflicts raised
- (none within group; #c3 surfaces a forward-looking inconsistency with `lighter-docs-2026-04-28-trading-multi-asset-margin`#c2 which describes ETH as the first asset added — implying live, vs the supply-limits page calling it "coming soon". Likely staleness on one of the two pages; flag for Phase 2 reconciliation rather than silent overwrite.)
