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
| [[entities/perpdex/aster]] | up to 1001x via the dedicated 1001x one-click product; standard Perpetuals and Shield Mode use tier-based maintenance margin (specific per-pair max-leverage values not surfaced in primary docs)[^aster-docs-2026-04-28-overview-what-is-aster][^aster-docs-2026-04-28-trading-perpetuals-margin] | yes — maintenance margin is tier-based on total position size, not on leverage selection (per-pair tiers)[^aster-docs-2026-04-28-trading-perpetuals-margin] | not surfaced (primary docs) — margin mode (Cross/Isolated) cannot be changed once a position or open order is submitted, but mid-life leverage adjustment policy on existing positions is not explicitly documented[^aster-docs-2026-04-28-trading-perpetuals-margin] |
| [[entities/perpdex/lighter]] | 3×–50× (8 tiers; IMR 2%–33%)[^lighter-docs-2026-04-28-trading-contract-specifications] | per-market tier tables[^lighter-docs-2026-04-28-trading-contract-specifications] | not surfaced |
| [[entities/perpdex/orderly]] | 5x–100x (BTC/ETH/SOL 100x, SUI/HYPE/RWA 20x, ARB/ORDER 10x, IP 5x)[^orderly-docs-2026-04-29-margin-leverage-pnl] | yes — per-market Base IMR determines max leverage (1/BaseIMR)[^orderly-docs-2026-04-29-margin-leverage-pnl] | not surfaced — independent leverage per symbol per mode; can hold both Cross and Isolated on same symbol[^orderly-docs-2026-04-29-isolated-margin] |
## Disputed claims
None.

## Related
[[concepts/risk/margin-tier]] · [[concepts/risk/liquidation]] · [[parameters/hyperliquid/listed-markets-roster]]

## Sources
[^hl-docs-2026-04-27-trading-margining]: [[sources/hl-docs-2026-04-27-trading-margining]]
[^hl-docs-2026-04-27-trading-liquidations]: [[sources/hl-docs-2026-04-27-trading-liquidations]]
[^aster-docs-2026-04-28-overview-what-is-aster]: [[sources/aster-docs-2026-04-28-overview-what-is-aster]]
[^aster-docs-2026-04-28-trading-perpetuals-margin]: [[sources/aster-docs-2026-04-28-trading-perpetuals-margin]]
[^lighter-docs-2026-04-28-trading-contract-specifications]: [[sources/lighter-docs-2026-04-28-trading-contract-specifications]]
[^orderly-docs-2026-04-29-margin-leverage-pnl]: [[sources/orderly-docs-2026-04-29-margin-leverage-pnl]]
[^orderly-docs-2026-04-29-isolated-margin]: [[sources/orderly-docs-2026-04-29-isolated-margin]]
