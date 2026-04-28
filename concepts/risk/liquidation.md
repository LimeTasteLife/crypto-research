---
type: concept
domain: risk
name: Liquidation
last_reviewed: 2026-04-28
disputed: false
---

# Liquidation

## Definition
A liquidation is the forced closure of a leveraged position when the trader's account equity (or isolated-position equity) drops below the maintenance-margin requirement[^hl-docs-2026-04-27-trading-liquidations][^hl-docs-2026-04-27-trading-margining]. The mechanism converts under-margined exposure back to solvent state, transferring residual loss either to the order book, a backstop pool, or — as a last resort — to surviving counterparties via [[concepts/risk/adl-waterfall]].

## Mechanism on Hyperliquid

**Trigger.** A liquidation begins when account equity falls below maintenance margin[^hl-docs-2026-04-27-trading-liquidations]. Maintenance margin is half of initial margin at max leverage and ranges from 1.25% (40x max-leverage assets) to 16.7% (3x max-leverage assets) — a function of the listed asset's max leverage[^hl-docs-2026-04-27-trading-liquidations].

For cross positions: liquidation triggers when `account_value (incl. unrealized PnL) < maintenance_margin × total_open_notional`[^hl-docs-2026-04-27-trading-margining]. For isolated positions: same rule restricted to the isolated margin and notional[^hl-docs-2026-04-27-trading-margining].

**Step 1 — book liquidation.** A market order for the full size of the position is sent to the order book; the position may close fully or partially[^hl-docs-2026-04-27-trading-liquidations]. If closure brings equity back ≥ maintenance margin, residual collateral remains with the trader[^hl-docs-2026-04-27-trading-liquidations]. There is no clearance fee[^hl-docs-2026-04-27-trading-liquidations].

**Step 2 — backstop liquidation.** If equity drops below 2/3 of maintenance margin without successful book closure, the position is taken over by the [[parameters/hyperliquid/hlp]] Liquidator Vault[^hl-docs-2026-04-27-trading-liquidations]. Cross-position backstop transfers all of the trader's cross positions and cross margin to the liquidator; isolated-position backstop transfers only the isolated position and its isolated margin[^hl-docs-2026-04-27-trading-liquidations]. The trader's maintenance margin is not returned during backstop — HLP keeps it as the buffer that makes backstop liquidations profitable on average[^hl-docs-2026-04-27-trading-liquidations].

**Partial liquidations.** For positions over 100,000 USDC (10,000 USDC on testnet), only 20% of position size is sent as a market liquidation order[^hl-docs-2026-04-27-trading-liquidations]. After a block in which any position is partially liquidated, there is a 30-second cooldown during which any further market liquidation is for the full remaining position[^hl-docs-2026-04-27-trading-liquidations].

**Price input.** Liquidations use the [[concepts/market-microstructure/mark-price-formula|mark price]], which combines external CEX prices with Hyperliquid book state — robust against single-instantaneous-book-price manipulation[^hl-docs-2026-04-27-trading-liquidations].

**Liquidation price formula:**

```
liq_price = price - side * margin_available / position_size / (1 - l * side)

l = 1 / MAINTENANCE_LEVERAGE   (margin-tier dependent at the liquidation point)
side = 1 (long) or -1 (short)
margin_available (cross)    = account_value - maintenance_margin_required
margin_available (isolated) = isolated_margin - maintenance_margin_required
```

[^hl-docs-2026-04-27-trading-liquidations]

For cross positions, the actual liquidation price is independent of user-set leverage (lower leverage simply consumes more collateral)[^hl-docs-2026-04-27-trading-liquidations]. For isolated positions, the liquidation price depends on user-set leverage because isolated margin is set by the leverage choice[^hl-docs-2026-04-27-trading-liquidations].

## Variants in the wild

| venue | trigger | book step? | backstop pool | partial-liq threshold | clearance fee | residual handling |
|---|---|---|---|---|---|---|
| [[entities/perpdex/hyperliquid]] | account_value < MM × notional[^hl-docs-2026-04-27-trading-margining] | yes (full size) | [[parameters/hyperliquid/hlp]] vault | 100k USDC (10k testnet) | none[^hl-docs-2026-04-27-trading-liquidations] | book closure: residual to trader. backstop: MM forfeited[^hl-docs-2026-04-27-trading-liquidations] |
| [[entities/perpdex/aster]] | maintenance margin breach (tier-based)[^aster-docs-2026-04-28-trading-perpetuals-liquidations] | yes (1 large IOC partial close)[^aster-docs-2026-04-28-trading-perpetuals-liquidations] | Insurance Fund[^aster-docs-2026-04-28-trading-perpetuals-liquidations] | not surfaced | not surfaced | 5-step waterfall: cancel orders → IOC → recheck → IF transfer at bankruptcy price → ADL fall-through; negative-balance ≤5,000 USDT auto-IF-cover (USDT-perp accounts only, no open positions, no offsetting transfers)[^aster-docs-2026-04-28-trading-perpetuals-liquidations] |

(Other perpdex venues to be added in subsequent ingest passes.)

## Edge cases
- A trader can avoid maintenance-margin forfeiture by using stop-loss orders or exiting before mark price reaches `liq_price`[^hl-docs-2026-04-27-trading-liquidations].
- During high volatility or for highly leveraged positions, mark price may diverge significantly from book price; precise monitoring requires the formula above[^hl-docs-2026-04-27-trading-liquidations].
- If both book and backstop fail (HLP undercapitalized for the impact), the next layer is [[concepts/risk/adl-waterfall]].

## Disputed claims
None at first ingest.

## Related
[[concepts/risk/margin-tier]] · [[concepts/risk/adl-waterfall]] · [[concepts/market-microstructure/mark-price-formula]] · [[parameters/hyperliquid/hlp]] · [[entities/perpdex/hyperliquid]]

## Sources
[^hl-docs-2026-04-27-trading-liquidations]: [[sources/hl-docs-2026-04-27-trading-liquidations]]
[^hl-docs-2026-04-27-trading-margining]: [[sources/hl-docs-2026-04-27-trading-margining]]
[^aster-docs-2026-04-28-trading-perpetuals-liquidations]: [[sources/aster-docs-2026-04-28-trading-perpetuals-liquidations]]
