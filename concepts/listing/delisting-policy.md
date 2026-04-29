---
type: concept
domain: listing
name: Delisting policy
last_reviewed: 2026-04-28
disputed: false
---

# Delisting policy

## Definition
A delisting policy defines the criteria, procedure, and settlement mechanics for removing a perpetual or spot market from a venue's active roster[^drift-docs-2026-04-28-protocol-risk-and-safety-delisting-process].

## Variants in the wild

| venue | model | current value | notes |
|---|---|---|---|
| [[entities/perpdex/drift]] | four-stage on-chain procedure analogous to derivatives expiry | Stage 1: reduce-only + no funding; Stage 2: settle_expired_market at 5-min oracle TWAP settlement price; Stage 3: user settlement with IF/socialized loss; Stage 4: remaining PnL to Revenue Pool[^drift-docs-2026-04-28-protocol-risk-and-safety-delisting-process] | taker fee applied at Stage-3 closure (incentivizes early reduce-only close); spot delisting: reduce-only blocks new borrows/deposits/buys; spot force-close "coming soon"[^drift-docs-2026-04-28-protocol-risk-and-safety-delisting-process] |

## Edge cases
- A market with majority extreme positive unsettled PnL may be eligible for the Delisting Process (settlement-edge mechanic for unbounded unrealized PnL).
- Stage 2 settlement price may be altered to allow full solvency, deviating from the pure 5-min oracle TWAP.

## Disputed claims
None.

## Related
[[concepts/listing/listing-playbook]] . [[concepts/listing/pre-launch-perp]] . [[concepts/risk/liquidation]]

## Sources
[^drift-docs-2026-04-28-protocol-risk-and-safety-delisting-process]: [[sources/drift-docs-2026-04-28-protocol-risk-and-safety-delisting-process]]
