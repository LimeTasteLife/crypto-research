---
type: entity
subtype: network
name: Arbitrum
status: live
launched: 2021-Q3
sources_count: 1
last_reviewed: 2026-04-28
disputed: false
---

# Arbitrum

> Ethereum L2 (optimistic rollup). Referenced here only as a USDC deposit source for Hyperliquid; full Arbitrum coverage is out of current scope.

## Snapshot
- Used by [[entities/perpdex/hyperliquid]] as the canonical USDC deposit corridor[^hl-docs-2026-04-27-onboarding-how-to-start-trading]

## Mechanism
Stub. To deposit on Hyperliquid, USDC is bridged from Arbitrum into the Hyperliquid bridge contract; deposits become HyperCore margin once consensus confirms[^hl-docs-2026-04-27-onboarding-how-to-start-trading].

## Relations
- [[entities/network/arbitrum]] **bridges_to** [[entities/perpdex/hyperliquid]] (USDC deposit corridor)[^hl-docs-2026-04-27-onboarding-how-to-start-trading]

## Parameters
_(none yet — Arbitrum-side parameters out of current ingest scope)_

## Open questions
- Are alternative deposit networks supported?

## Disputed claims
None at first ingest.

## Related
[[entities/perpdex/hyperliquid]]

## Sources
[^hl-docs-2026-04-27-onboarding-how-to-start-trading]: [[sources/hl-docs-2026-04-27-onboarding-how-to-start-trading]]
