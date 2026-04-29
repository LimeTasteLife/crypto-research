---
type: entity
subtype: programme
name: dYdX Order Router Rev Share
status: live
sources_count: 2
last_reviewed: 2026-04-29
disputed: false
---

# dYdX Order Router Rev Share

> Governance-whitelisted revenue-share program for third-party order routers; per-router share_ppm set via MsgSetOrderRouterRevShare.

## Snapshot
- Third-party routers earn maker + taker fee share by including `order_router_address` in orders[^dydx-community-2026-04-28-modules-governance-order-router-rev-share][^dydx-docs-2026-04-28-interaction-integration-revshare]
- Per-router share set by governance proposal (example: 500,000 ppm = 50%)[^dydx-community-2026-04-28-modules-governance-order-router-rev-share]
- Reference proposal: dYdX proposal 311[^dydx-docs-2026-04-28-interaction-integration-revshare]
- Affiliate priority rule suppresses router share until affiliate $10k/30d cap reached[^dydx-docs-2026-04-28-interaction-integration-revshare]

## Related
[[entities/perpdex/dydx]] · [[parameters/dydx-v4/order-router-rev-share]]

## Sources
[^dydx-community-2026-04-28-modules-governance-order-router-rev-share]: [[sources/dydx-community-2026-04-28-modules-governance-order-router-rev-share]]
[^dydx-docs-2026-04-28-interaction-integration-revshare]: [[sources/dydx-docs-2026-04-28-interaction-integration-revshare]]
