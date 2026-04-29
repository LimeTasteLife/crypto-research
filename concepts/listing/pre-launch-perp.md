---
type: concept
domain: listing
name: Pre-launch perp
last_reviewed: 2026-04-28
disputed: false
---

# Pre-launch perp

## Definition
A pre-launch perpetual is a derivatives contract listed before a reliable external oracle exists for the underlying asset, using a venue-internal price reference (e.g. mark TWAP) until an external oracle becomes available[^drift-docs-2026-04-28-protocol-trading-prelaunch-markets].

## Variants in the wild

| venue | model | current value | notes |
|---|---|---|---|
| [[entities/perpdex/drift]] | custom Prelaunch oracle (mark-TWAP, window = funding period) with initial price and max price bounds | default tier: Highly Speculative (no external IF)[^drift-docs-2026-04-28-protocol-trading-prelaunch-markets][^drift-docs-2026-04-28-protocol-trading-market-specs] | configured with conservative OI limits to resist manipulation; oracle source switched once external oracle available; insurance limited to per-market fee pool only[^drift-docs-2026-04-28-protocol-trading-prelaunch-markets] |

## Edge cases
- Without an external oracle, the mark-TWAP oracle is vulnerable to feedback loops (price is derived from its own market's trading activity).
- Max price bound on the Prelaunch oracle prevents unbounded runaway but may create a ceiling effect on legitimate price discovery.

## Disputed claims
None.

## Related
[[concepts/listing/listing-playbook]] . [[concepts/market-microstructure/oracle-spec]] . [[concepts/risk/insurance-fund-sizing]]

## Sources
[^drift-docs-2026-04-28-protocol-trading-prelaunch-markets]: [[sources/drift-docs-2026-04-28-protocol-trading-prelaunch-markets]]
[^drift-docs-2026-04-28-protocol-trading-market-specs]: [[sources/drift-docs-2026-04-28-protocol-trading-market-specs]]
