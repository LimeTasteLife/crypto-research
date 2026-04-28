---
type: source
id: dydx-community-2026-04-28-modules-governance-order-router-rev-share
title: Order Router Rev Share (Governance)
publisher: dYdX Community Docs
author: dYdX community
date: null
original_url: https://docs.dydx.community/dydx/modules/governance/governance-adjustable-parameters/order-router-rev-share
mirror_snapshot: dydx-community-2026-04-28
mirror_page: pages/modules-governance-order-router-rev-share.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Order Router Rev Share (Governance)

## TL;DR
Governance side of A3 mechanism #1 — Order Router Rev Share. The page provides the example JSON for `MsgSetOrderRouterRevShare` (with address + share_ppm e.g. 500,000 = 50%). Steps follow the standard Proposal Lifecycle. Detailed integration steps live at docs.dydx.xyz/interaction/integration/integration-revshare. Min-deposit baseline observed: 2,000 DYDX (2,000,000,000,000,000,000,000 adydx).

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Order Router Rev Share enables third-party order routers to direct orders to dYdX and earn a portion of the trading fees (maker and taker). | [[parameters/dydx-v4/order-router-rev-share]], [[entities/programme/dydx-order-router-rev-share]] | A3-PI |
| #c2 | To enable an Order Router Rev Share, the interested party must submit a governance proposal and obtain approval from the dYdX community. | [[parameters/dydx-v4/order-router-rev-share]] | A3-PV, A7-PI |
| #c3 | The Order Router Rev Share governance message type is `/dydxprotocol.revshare.MsgSetOrderRouterRevShare`. | [[parameters/dydx-v4/order-router-rev-share]] | A3-PV |
| #c4 | The Order Router Rev Share governance message contains an `order_router_rev_share` block with `address` and `share_ppm` fields. | [[parameters/dydx-v4/order-router-rev-share]] | A3-PV |
| #c5 | The example deposit for an Order Router Rev Share governance proposal is 2,000 DYDX (2,000,000,000,000,000,000,000 adydx). | [[parameters/dydx-v4/governance-params]] | A7-PI |
