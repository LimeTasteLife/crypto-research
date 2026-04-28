---
type: concept
domain: market-microstructure
name: Lot size
last_reviewed: 2026-04-28
disputed: false
---

# Lot size

## Definition
Lot size is the minimum size increment for a quote on a given market. Every order's size must be an integer multiple of the lot size. Together with [[concepts/market-microstructure/tick-size|tick size]] it sets the granularity of the venue's orderable grid.

## Mechanism on Hyperliquid

Orders must have size as an integer multiple of lot size[^hl-docs-2026-04-27-hypercore-order-book]. Per-asset lot sizes are stored in [[parameters/hyperliquid/listed-markets-roster]].

## Variants in the wild

| venue | enforced? | grid scope |
|---|---|---|
| [[entities/perpdex/hyperliquid]] | yes[^hl-docs-2026-04-27-hypercore-order-book] | per-asset[^hl-docs-2026-04-27-hypercore-order-book] |
| [[entities/perpdex/aster]] | not surfaced (primary docs) — per-pair MM-program minimums exist (see [[parameters/aster/listed-markets-roster]]) but a size-quantization grid is not separately documented | per-asset (per-pair minimums separately documented at [[parameters/aster/listed-markets-roster]]) |

(Other perpdex venues to be added in subsequent ingest passes.)

## Related
[[concepts/market-microstructure/tick-size]] · [[concepts/market-structure/clob]] · [[parameters/hyperliquid/listed-markets-roster]]

## Sources
[^hl-docs-2026-04-27-hypercore-order-book]: [[sources/hl-docs-2026-04-27-hypercore-order-book]]
