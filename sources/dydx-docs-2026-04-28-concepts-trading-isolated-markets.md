---
type: source
id: dydx-docs-2026-04-28-concepts-trading-isolated-markets
title: Isolated Markets
publisher: dYdX Docs
author: dYdX team
date: null
original_url: https://docs.dydx.xyz/concepts/trading/isolated-markets
mirror_snapshot: dydx-docs-2026-04-28
mirror_page: pages/concepts-trading-isolated-markets.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Isolated Markets

## TL;DR
Isolated Markets shipped in v5.0.0. Each isolated market gets its own segregated collateral pool and insurance fund. A subaccount that holds an isolated-market position cannot open positions in any other market until the isolated position is closed (orders for other markets fail with error 2005 at match time). To accommodate one subaccount per isolated market, the per-address subaccount limit was raised from 127 to 128,000 in v5.0.0. Markets are tagged via `market_type` in `PerpetualParams`: PERPETUAL_MARKET_TYPE_CROSS (default, all pre-v5.0.0 markets) or PERPETUAL_MARKET_TYPE_ISOLATED.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | The Isolated Markets feature was added to the v4 chain software in v5.0.0. | [[entities/perpdex/dydx-v4]], [[parameters/dydx-v4/upgrade-history]] | A1-PI |
| #c2 | A subaccount with an open isolated-market position cannot open positions in any other market until the isolated position is closed. | [[concepts/risk/margin-tier]] | A6-PI |
| #c3 | Orders placed for other markets while a subaccount holds an open isolated position will fail and be cancelled at match time with error code 2005. | [[entities/perpdex/dydx-v4]] | A6-PI |
| #c4 | The maximum number of subaccounts per address was increased from 127 to 128,000 in v5.0.0 to support one subaccount per isolated market. | [[parameters/dydx-v4/account-limits]] | A1-PI |
| #c5 | The PerpetualParams proto contains a `market_type` field with two values: PERPETUAL_MARKET_TYPE_CROSS and PERPETUAL_MARKET_TYPE_ISOLATED. | [[entities/perpdex/dydx-v4]] | A1-PI |
| #c6 | All markets created before the v5.0.0 upgrade are PERPETUAL_MARKET_TYPE_CROSS. | [[parameters/dydx-v4/listed-markets-roster]] | A1-PI |
| #c7 | Cross markets allow positions to be cross-margined with other PERPETUAL_MARKET_TYPE_CROSS markets. | [[concepts/risk/margin-tier]] | A6-PI |
| #c8 | Isolated markets can only be margined in isolation; no cross-margining with any other market is possible. | [[concepts/risk/margin-tier]] | A6-PI |
