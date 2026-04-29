---
type: concept
domain: market-structure
name: vAMM
last_reviewed: 2026-04-28
disputed: false
---

# vAMM

## Definition
A virtual automated market maker (vAMM) uses a bonding-curve formula (typically constant-product `x*y=k`) to provide synthetic liquidity for perpetual contracts without requiring physical token reserves; the curve tracks virtual reserves and a peg that adjusts toward the oracle price[^drift-docs-2026-04-28-protocol-about-v3-drift-amm].

## Variants in the wild

| venue | model | current value | notes |
|---|---|---|---|
| [[entities/perpdex/drift]] | constant-product + BAL + concentration factor + dynamic spread/peg | backstop role in three-layer matching[^drift-docs-2026-04-28-protocol-about-v3-drift-amm] | bid/ask = reservation_price +/- base_spread + f(inventory, balance, ...); max spread capped as % of oracle; peg moves toward oracle each fill; AMM-fill minimum duration 10 slots; effective leverage widens spread when levered/in-debt[^drift-docs-2026-04-28-protocol-about-v3-drift-amm] |

## Edge cases
- vAMMs can accumulate unbounded unrealized PnL when traders consistently enter/exit against the AMM in one direction; settling gains requires offsetting losses to exist in the system.
- A vAMM in backstop role receives systematically adverse (leftover) flow, making inventory management and dynamic spread critical.

## Disputed claims
None.

## Related
[[concepts/market-structure/hybrid]] . [[concepts/market-structure/clob]] . [[concepts/operations/matching-engine]]

## Sources
[^drift-docs-2026-04-28-protocol-about-v3-drift-amm]: [[sources/drift-docs-2026-04-28-protocol-about-v3-drift-amm]]
