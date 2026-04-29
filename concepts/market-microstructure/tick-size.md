---
type: concept
domain: market-microstructure
name: Tick size
last_reviewed: 2026-04-28
disputed: false
---

# Tick size

## Definition
Tick size is the minimum price increment for a quote on a given market. Combined with [[concepts/market-microstructure/lot-size|lot size]], it discretizes the orderable grid: every limit order's price must be an integer multiple of the tick size.

## Mechanism on Hyperliquid

Orders must have price as an integer multiple of tick size and size as an integer multiple of lot size[^hl-docs-2026-04-27-hypercore-order-book]. Per-asset tick sizes are stored in [[parameters/hyperliquid/listed-markets-roster]].

## Variants in the wild

| venue | enforced? | grid scope |
|---|---|---|
| [[entities/perpdex/hyperliquid]] | yes[^hl-docs-2026-04-27-hypercore-order-book] | per-asset[^hl-docs-2026-04-27-hypercore-order-book] |
| [[entities/perpdex/aster]] | not surfaced (primary docs) | not surfaced (primary docs) — pair-specific MM spread caps documented separately at [[parameters/aster/mm-rebate-tiers]] |
## Related
[[concepts/market-microstructure/lot-size]] · [[concepts/market-structure/clob]] · [[parameters/hyperliquid/listed-markets-roster]]

## Sources
[^hl-docs-2026-04-27-hypercore-order-book]: [[sources/hl-docs-2026-04-27-hypercore-order-book]]
