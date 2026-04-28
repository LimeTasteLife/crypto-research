---
type: source
id: dydx-docs-2026-04-28-interaction-integration-revshare
title: Revenue Share (Order Router Rev Share)
publisher: dYdX Docs
author: dYdX team
date: null
original_url: https://docs.dydx.xyz/interaction/integration/integration-revshare
mirror_snapshot: dydx-docs-2026-04-28
mirror_page: pages/interaction-integration-revshare.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Revenue Share (Order Router Rev Share)

## TL;DR
A3 mechanism #1 — Order Router Rev Share. Third-party order routers receive a portion of trading fees (maker + taker) by including their `order_router_address` in the order message. The share (in ppm) is set by governance proposal (e.g. proposal 311 referenced as a template). Affiliate revenue takes priority — if an active affiliate split has not reached its $10k/30d cap, no revenue is shared with the order router. The integration field is monitored via the indexer's `/orders` and `/fills` endpoints.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Order Router Rev Share enables third-party order routers to direct orders to dYdX and earn a portion of the trading fees (maker and taker). | [[parameters/dydx-v4/order-router-rev-share]], [[entities/programme/dydx-order-router-rev-share]] | A3-PI |
| #c2 | The revenue share is specified in parts per million (ppm) and must be voted in via Governance and set in the `order_router_address` field of the order message. | [[parameters/dydx-v4/order-router-rev-share]] | A3-PI, A7-PI |
| #c3 | Order Router Rev Share revenue is distributed based on filled orders that were routed through the participating order router. | [[parameters/dydx-v4/order-router-rev-share]] | A3-PI |
| #c4 | Order router details and revenue share percentages can be monitored through the indexer's `/orders` (router address info) and `/fills` (router address + per-fill revenue distributed) endpoints. | [[parameters/dydx-v4/order-router-rev-share]] | A3-PI |
| #c5 | If there is an active affiliate split that has not reached its $10k/30d-rolling-window maximum, no revenue will be shared with the order router. | [[parameters/dydx-v4/order-router-rev-share]] | A3-PIV |
| #c6 | Affiliate revenue takes priority over Order Router Rev Share in the distribution hierarchy. | [[parameters/dydx-v4/order-router-rev-share]], [[entities/programme/dydx-affiliate-program]] | A3-PIV |
| #c7 | The Order Router Rev Share governance proposal must include a `share_ppm` (revenue share in ppm) and an `address` (the order router that will receive the share, also used as the order ID). | [[parameters/dydx-v4/order-router-rev-share]] | A3-PV, A7-PV |
| #c8 | Order Router Rev Share governance proposal flow uses the same standard process as other governance proposals; reference example is proposal 311 on Mintscan. | [[parameters/dydx-v4/order-router-rev-share]] | A3-PV, A7-PI |
| #c9 | The `order_router_address` field is set on each order; it is verified at order placement that the address has been voted in via governance. | [[parameters/dydx-v4/order-router-rev-share]] | A3-PI |
