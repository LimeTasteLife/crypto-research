---
type: source
id: dydx-community-2026-04-28-modules-trading-rewards
title: Trading Rewards
publisher: dYdX Community Docs
author: dYdX community
date: null
original_url: https://docs.dydx.community/dydx/modules/trading-rewards
mirror_snapshot: dydx-community-2026-04-28
mirror_page: pages/modules-trading-rewards.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Trading Rewards

## TL;DR
Critical one-liner update: protocol-level trading rewards have been removed; all rewards consolidated under the Surge Program. This contradicts (or supersedes) the docs.dydx.xyz Trading Rewards page which still documents the C-formula in detail (though that page also notes "C factor has been set to 0").

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | The dYdX community has aligned on simplifying rewards by removing protocol-level trading rewards. | [[parameters/dydx-v4/trading-rewards-config]] | A3-PII, A7-PII |
| #c2 | All rewards on dYdX are now consolidated under the Surge Program, eliminating redundant rewards mechanisms. | [[parameters/dydx-v4/trading-rewards-config]], [[entities/programme/dydx-surge]] | A3-PII |

## Conflicts raised
- #c1 ("protocol-level trading rewards removed, consolidated under Surge Program") vs `dydx-docs-2026-04-28-concepts-trading-rewards-trading-rewards`#c1 (which describes Trading Rewards as live with C-formula). The docs.dydx.xyz page does note inline that C has been set to 0 — so the formula may still be on-chain but effectively dormant. Phase 2 must reconcile and decide canonical phrasing (e.g. "C-formula remains in code but is set to 0; new rewards flow via Surge Program").
