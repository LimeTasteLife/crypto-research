---
type: concept
domain: risk
name: Leverage cap
last_reviewed: 2026-04-28
disputed: false
---

# Leverage cap

## Definition
A leverage cap is the per-asset upper bound on user-set leverage that the venue enforces at order-submission time. It anchors the [[concepts/risk/margin-tier|margin tier]] system: maintenance margin is typically defined as a fraction of initial margin at max leverage[^hl-docs-2026-04-27-trading-margining].

## Mechanism on Hyperliquid

User-set leverage may be any integer in `[1, max_leverage]`; max leverage is per-asset[^hl-docs-2026-04-27-trading-margining]. Leverage of an existing position can be increased without closing it[^hl-docs-2026-04-27-trading-margining]. Caps observed in primary docs span 3x – 40x across listed assets[^hl-docs-2026-04-27-trading-liquidations].

## Variants in the wild

| venue | range | per-asset? | mid-life increase? |
|---|---|---|---|
| [[entities/perpdex/hyperliquid]] | 3x – 40x integer[^hl-docs-2026-04-27-trading-liquidations] | yes[^hl-docs-2026-04-27-trading-margining] | yes (no close required)[^hl-docs-2026-04-27-trading-margining] |

(Other perpdex venues to be added in subsequent ingest passes.)

## Disputed claims
None.

## Related
[[concepts/risk/margin-tier]] · [[concepts/risk/liquidation]] · [[parameters/hyperliquid/listed-markets-roster]]

## Sources
[^hl-docs-2026-04-27-trading-margining]: [[sources/hl-docs-2026-04-27-trading-margining]]
[^hl-docs-2026-04-27-trading-liquidations]: [[sources/hl-docs-2026-04-27-trading-liquidations]]
