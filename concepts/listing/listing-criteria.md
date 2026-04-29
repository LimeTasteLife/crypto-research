---
type: concept
domain: listing
name: Listing criteria
last_reviewed: 2026-04-29
disputed: false
---

# Listing criteria

## Definition
Listing criteria are the venue's published prerequisites for adding a new perpetual market, covering oracle-source availability, liquidity depth, data history, and governance approval requirements.

## Variants in the wild

| venue | listing mode | key criteria | governance required? |
|---|---|---|---|
| [[entities/perpdex/hyperliquid]] | HIP-2 auction / HIP-3 deployer-permissionless / governance[^hl-docs-2026-04-27-hypercore-overview] | not surfaced in primary docs (gap A1/PV) | varies by path |
| [[entities/perpdex/dydx]] | permissionless IML (10k USDC deposit) + governance 4-msg path[^dydx-community-2026-04-28-dydx-features-instant-market-listings] | isolated-to-cross upgrade: >=2 sources >$1M vol, >=2 sources >$150K depth @ 2%, >=4 sources, >=30d data[^dydx-community-2026-04-28-modules-governance-markets] | IML: no; cross: governance vote[^dydx-docs-2026-04-28-concepts-trading-governance] |

## Disputed claims
None.

## Related
[[concepts/listing/listing-playbook]] . [[parameters/dydx-v4/listing-policy]]

## Sources
[^hl-docs-2026-04-27-hypercore-overview]: [[sources/hl-docs-2026-04-27-hypercore-overview]]
[^dydx-community-2026-04-28-dydx-features-instant-market-listings]: [[sources/dydx-community-2026-04-28-dydx-features-instant-market-listings]]
[^dydx-community-2026-04-28-modules-governance-markets]: [[sources/dydx-community-2026-04-28-modules-governance-markets]]
[^dydx-docs-2026-04-28-concepts-trading-governance]: [[sources/dydx-docs-2026-04-28-concepts-trading-governance]]
