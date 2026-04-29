---
type: parameter
entity: [[dydx-v4]]
parameter: order-router-rev-share
unit: ppm
last_change: 2026-04-28
last_reviewed: 2026-04-29
disputed: false
---

# dYdX v4 order-router-rev-share

## Current (as of 2026-04-28)
- Third-party order routers earn a portion of trading fees (maker AND taker) by including `order_router_address` in order message[^dydx-community-2026-04-28-modules-governance-order-router-rev-share][^dydx-docs-2026-04-28-interaction-integration-revshare]
- Share (in ppm) set per-router by governance proposal (`MsgSetOrderRouterRevShare` with `address` + `share_ppm`; example: 500,000 = 50%)[^dydx-community-2026-04-28-modules-governance-order-router-rev-share]
- Revenue distributes based on filled orders routed through that router[^dydx-docs-2026-04-28-interaction-integration-revshare]
- Affiliate priority rule: if active affiliate split has not reached $10k/30d-rolling-window cap, no revenue shared with order router[^dydx-docs-2026-04-28-interaction-integration-revshare]
- Router activity observable via indexer `/orders` and `/fills` endpoints[^dydx-docs-2026-04-28-interaction-integration-revshare]
- Reference governance proposal: dYdX proposal 311[^dydx-docs-2026-04-28-interaction-integration-revshare]

## Time series

| effective | governance_msg | example_share | source |
|---|---|---|---|
| 2026-04-28 (snapshot) | MsgSetOrderRouterRevShare | 500,000 ppm (50%) | [^dydx-community-2026-04-28-modules-governance-order-router-rev-share] |

## Tiering rules / formulae
- Per-router governance whitelist; individual `share_ppm` per address[^dydx-community-2026-04-28-modules-governance-order-router-rev-share]
- Affiliate priority: affiliate split suppresses router share until $10k/30d cap reached[^dydx-docs-2026-04-28-interaction-integration-revshare]

## Disputed values
None.

## Sources
[^dydx-community-2026-04-28-modules-governance-order-router-rev-share]: [[sources/dydx-community-2026-04-28-modules-governance-order-router-rev-share]]
[^dydx-docs-2026-04-28-interaction-integration-revshare]: [[sources/dydx-docs-2026-04-28-interaction-integration-revshare]]
