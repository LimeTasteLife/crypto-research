---
type: source
id: dydx-docs-2026-04-28-concepts-trading-limits-withdrawal-limits
title: Withdrawal Limits
publisher: dYdX Docs
author: dYdX team
date: null
original_url: https://docs.dydx.xyz/concepts/trading/limits/withdrawal-limits
mirror_snapshot: dydx-docs-2026-04-28
mirror_page: pages/concepts-trading-limits-withdrawal-limits.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Withdrawal Limits

## TL;DR
Two protective mechanisms. Rate limits on Noble USDC withdrawals: `max(1% of TVL, $1mm)/hour` and `max(10% of TVL, $10mm)/day`, governance-adjustable. Withdrawal gating: 50-block block on transfers/withdrawals if (a) a negative-collateralized subaccount exists and cannot be liquidated/deleveraged, OR (b) a 5+ minute chain outage occurred.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Withdrawals of Noble USDC are rate-limited to max(1% of TVL, $1mm) per hour by default. | [[parameters/dydx-v4/rate-limits]] | A8-PI, A6-PI |
| #c2 | Withdrawals of Noble USDC are rate-limited to max(10% of TVL, $10mm) per day by default. | [[parameters/dydx-v4/rate-limits]] | A8-PI, A6-PI |
| #c3 | Withdrawal rate-limit parameters are governance-adjustable. | [[parameters/dydx-v4/rate-limits]] | A7-PI |
| #c4 | All subaccount transfers and withdrawals are gated for 50 blocks if a negative-collateralized subaccount is seen in state and/or cannot be liquidated or deleveraged. | [[parameters/dydx-v4/rate-limits]] | A8-PI, A6-PI |
| #c5 | All subaccount transfers and withdrawals are gated for 50 blocks if a chain outage of 5+ minutes occurs. | [[parameters/dydx-v4/rate-limits]] | A8-PI |
