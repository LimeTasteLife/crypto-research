---
type: concept
domain: market-structure
name: Hybrid
last_reviewed: 2026-04-28
disputed: false
---

# Hybrid

## Definition
A hybrid market structure combines two or more matching paradigms (e.g. CLOB + AMM, auction + orderbook) within a single venue, routing order flow through a priority waterfall rather than a single engine[^drift-docs-2026-04-28-protocol-about-v3].

## Variants in the wild

| venue | model | current value | notes |
|---|---|---|---|
| [[entities/perpdex/drift]] | JIT auction -> DLOB CLOB -> backstop vAMM | three-layer priority waterfall[^drift-docs-2026-04-28-protocol-about-v3][^drift-docs-2026-04-28-protocol-about-v3-matching-engine] | backstop AMM compared against resting and JIT liquidity before each fill; spot can also route through external venues (Phoenix, OpenBook, Jupiter)[^drift-developers-docs-2026-04-28-developers-market-makers-orderbook-and-matching] |

## Edge cases
- In a hybrid model, the AMM backstop can receive systematically adverse flow (only gets fills that no informed maker wanted); inventory management and dynamic spread widening are critical defenses.

## Disputed claims
None.

## Related
[[concepts/market-structure/clob]] . [[concepts/market-structure/vamm]] . [[concepts/market-microstructure/jit-auction]]

## Sources
[^drift-docs-2026-04-28-protocol-about-v3]: [[sources/drift-docs-2026-04-28-protocol-about-v3]]
[^drift-docs-2026-04-28-protocol-about-v3-matching-engine]: [[sources/drift-docs-2026-04-28-protocol-about-v3-matching-engine]]
[^drift-developers-docs-2026-04-28-developers-market-makers-orderbook-and-matching]: [[sources/drift-developers-docs-2026-04-28-developers-market-makers-orderbook-and-matching]]
