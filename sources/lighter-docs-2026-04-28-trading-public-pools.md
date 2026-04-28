---
type: source
id: lighter-docs-2026-04-28-trading-public-pools
title: Public Pools
publisher: Lighter Docs
author: Lighter team
date: null
original_url: https://docs.lighter.xyz/trading/public-pools
mirror_snapshot: lighter-docs-2026-04-28
mirror_page: pages/trading-public-pools.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Public Pools

## TL;DR
Public Pools let whitelisted operators run trading strategies on pooled depositor capital via a sub-account in the operator's account. Each pool exposes an Operator Fee (% of profits to operator at participant withdrawal) and a Minimum Operator Share (operator must keep ≥ X% of pool ownership for alignment; e.g. 10% min share with 10,000 USDC operator deposit caps participant deposits at 90,000 USDC). Public Pools do not support isolated positions. Depositors receive pool shares redeemed at withdrawal; unlike many DeFi vaults, there is no lockup — funds withdrawable at any time.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Public Pools allow participants to combine funds under a designated operator who trades on their behalf. | [[concepts/lp/vault]], [[entities/perpdex/lighter]] | A4-PI |
| #c2 | Whitelisted users can create Public Pools to attract participants and manage pooled capital. | [[entities/perpdex/lighter]] | A4-PII |
| #c3 | Profits are distributed to participants after deducting the operator's fee. | [[concepts/lp/vault]] | A4-PI |
| #c4 | Pool operators are currently whitelisted by the protocol to run strategies. | [[entities/perpdex/lighter]] | A4-PV |
| #c5 | Trading by an operator is conducted via a Sub Account inside the operator's account. | [[concepts/lp/vault]] | A4-PI |
| #c6 | Operator Fee is the percentage of profits allocated to the operator upon participant withdrawals as compensation for managing the pool. | [[concepts/lp/vault]] | A4-PI |
| #c7 | Minimum Operator Share is the minimum ownership percentage the operator must maintain to remain aligned with the pool's performance. | [[concepts/lp/vault]] | A4-PI, A4-PIV |
| #c8 | Example: with a 10% minimum operator share and a 10,000 USDC operator deposit, participants may deposit up to 90,000 USDC. | [[concepts/lp/vault]] | A4-PI |
| #c9 | Public Pools do not support isolated positions. | [[concepts/lp/vault]] | A6-PI |
| #c10 | Depositors receive pool shares when depositing, redeemed at withdrawal. | [[concepts/lp/vault]] | A4-PI |
| #c11 | Public Pools do not impose lockup periods; funds can be withdrawn at any time. | [[concepts/lp/vault]] | A4-PII |

## Conflicts raised
- (none within group)
