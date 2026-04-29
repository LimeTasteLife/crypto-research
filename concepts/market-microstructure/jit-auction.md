---
type: concept
domain: market-microstructure
name: JIT auction
last_reviewed: 2026-04-28
disputed: false
---

# JIT auction

## Definition
A Just-In-Time (JIT) auction is a reverse Dutch auction triggered by an incoming taker order, giving market makers a brief window to compete on price before the order reaches the resting book[^drift-developers-docs-2026-04-28-developers-market-makers-jit-auctions].

## Variants in the wild

| venue | model | current value | notes |
|---|---|---|---|
| [[entities/perpdex/drift]] | reverse Dutch, ~10 Solana slots (~5s) | `AuctionPrice(slot) = start + (end - start) * min(1, (current - start_slot) / duration)`[^drift-developers-docs-2026-04-28-developers-market-makers-jit-auctions] | starts at taker's best price, deteriorates toward worst; multiple makers can fill same taker (best-price pro-rata priority); unfilled size goes to DLOB then AMM; limit orders that don't cross spread bypass auction; JIT makers see retail flow ~5s before market[^drift-developers-docs-2026-04-28-developers-market-makers-jit-auctions][^drift-docs-2026-04-28-protocol-market-makers-market-maker-participation] |

## Edge cases
- Solana network congestion stretches the JIT auction window (slot times > 400ms); makers must account for variable wall-clock duration.
- JIT-only MM strategy reduces adverse selection from stale quotes by committing capital only on fill.

## Disputed claims
None.

## Related
[[concepts/market-structure/hybrid]] . [[concepts/operations/matching-engine]] . [[entities/perpdex/drift]]

## Sources
[^drift-developers-docs-2026-04-28-developers-market-makers-jit-auctions]: [[sources/drift-developers-docs-2026-04-28-developers-market-makers-jit-auctions]]
[^drift-docs-2026-04-28-protocol-market-makers-market-maker-participation]: [[sources/drift-docs-2026-04-28-protocol-market-makers-market-maker-participation]]
