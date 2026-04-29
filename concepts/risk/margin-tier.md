---
type: concept
domain: risk
name: Margin tier
last_reviewed: 2026-04-28
disputed: false
---

# Margin tier

## Definition
A margin tier is a per-asset rule that maps a position's notional size to an `(initial_margin_pct, maintenance_margin_pct)` pair[^hl-docs-2026-04-27-trading-margining]. Tiered margin caps the effective leverage available at large position sizes, keeping per-asset insolvency risk bounded as a single position grows.

## Mechanism on Hyperliquid

**Initial margin formula:** `initial_margin = position_size * mark_price / leverage`[^hl-docs-2026-04-27-trading-margining]. Leverage may be set to any integer in `[1, max_leverage]`; max leverage is per-asset[^hl-docs-2026-04-27-trading-margining]. Leverage is checked only on opening a position — users self-monitor afterwards to avoid liquidation[^hl-docs-2026-04-27-trading-margining]. Leverage can be increased on an existing position without closing it[^hl-docs-2026-04-27-trading-margining].

**Tiered maintenance leverage at liquidation.** For assets with margin tiers, the maintenance leverage used in the [[concepts/risk/liquidation]] price formula depends on the unique tier corresponding to the position value at the liquidation price (not at entry)[^hl-docs-2026-04-27-trading-liquidations]. Maintenance margin is half of initial margin at max leverage[^hl-docs-2026-04-27-trading-margining].

**Margin modes.**

| mode | scope | margin removal | use case |
|---|---|---|---|
| **cross** | shared across all cross positions | unrestricted (subject to transfer floor) | default; cross-PnL aids new positions[^hl-docs-2026-04-27-trading-margining] |
| **isolated** | bounded to one position | unrestricted | risk-bounded single position[^hl-docs-2026-04-27-trading-margining] |
| **strict isolated** | bounded to one position | disabled (releases proportional to close) | venue-imposed for high-risk markets[^hl-docs-2026-04-27-trading-margining] |
| **HIP-3 no-cross** | one position | margin removal allowed; no cross | HIP-3 deployer-configured[^hl-docs-2026-04-27-trading-margining] |

**HIP-3 cross-margin scope.** Under unified or portfolio-margin account abstraction, cross-margin positions in HIP-3 DEXs sharing the same collateral share margin across DEXs[^hl-docs-2026-04-27-trading-margining]. Under standard account abstraction, cross-margin only applies to assets within the same DEX[^hl-docs-2026-04-27-trading-margining].

**Cross PnL behavior.** Cross unrealized PnL is automatically available as initial margin for new positions; isolated unrealized PnL acts as additional margin only on the open isolated position[^hl-docs-2026-04-27-trading-margining].

**Transfer-margin floor.** When transferring margin out (withdrawal, transfer to spot wallet, isolated reduction), the transfer must respect: `transfer_margin_required = max(initial_margin_required, 0.1 * total_position_value)`[^hl-docs-2026-04-27-trading-margining]. This prevents under-collateralization shortly before a margin run.

## Variants in the wild

| venue | tier scheme | max leverage range | check timing | cross-DEX cross? |
|---|---|---|---|---|
| [[entities/perpdex/hyperliquid]] | per-asset, position-value-keyed[^hl-docs-2026-04-27-trading-liquidations] | 3x – 40x[^hl-docs-2026-04-27-trading-liquidations] | open-only[^hl-docs-2026-04-27-trading-margining] | yes under unified/portfolio-margin abstraction; no under standard[^hl-docs-2026-04-27-trading-margining] |
| [[entities/perpdex/aster]] | tier-based on total position size[^aster-docs-2026-04-28-trading-perpetuals-margin] | not surfaced | not surfaced | modes: Cross (default) + Isolated (opt-in, locked once position/order submitted)[^aster-docs-2026-04-28-trading-perpetuals-margin] |
| [[entities/perpdex/dydx]] | 8 Liquidity Tiers (Large-Cap 0 through IML 5x 7); OI-scaling IMF formula `effective_IMF = min(base_IMF + scaling_factor×(1−base_IMF), 1.0)`; IMF→100% at upper_cap; MMF fixed per tier[^dydx-docs-2026-04-28-concepts-trading-margin] | not surfaced (tier-specific; Large-Cap IMF=5%→20x)[^dydx-docs-2026-04-28-concepts-trading-margin] | open-only (leverage checked only at position open)[^dydx-docs-2026-04-28-concepts-trading-margin] | cross (default) + isolated (`market_type` flag, v5.0.0; segregated collateral + IF per isolated market)[^dydx-docs-2026-04-28-concepts-trading-margin] |

## Edge cases
- A position straddling tier boundaries uses the tier matching the position value at the liquidation price[^hl-docs-2026-04-27-trading-liquidations].
- Strict-isolated mode prevents users from siphoning margin out of a position that is already at-risk — but also prevents healthy de-risking via partial margin removal.

## Disputed claims
None at first ingest.

## Related
[[concepts/risk/liquidation]] · [[concepts/risk/leverage-cap]] · [[parameters/hyperliquid/listed-markets-roster]] · [[entities/perpdex/hyperliquid]]

## Sources
[^hl-docs-2026-04-27-trading-margining]: [[sources/hl-docs-2026-04-27-trading-margining]]
[^hl-docs-2026-04-27-trading-liquidations]: [[sources/hl-docs-2026-04-27-trading-liquidations]]
[^aster-docs-2026-04-28-trading-perpetuals-margin]: [[sources/aster-docs-2026-04-28-trading-perpetuals-margin]]
[^dydx-docs-2026-04-28-concepts-trading-margin]: [[sources/dydx-docs-2026-04-28-concepts-trading-margin]]
