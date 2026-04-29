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

## Mechanism on Lighter

**Trigger schedule.** Each Lighter market specifies three margin levels per position with the strict ordering `C_i < M_i < I_i` (Close-Out < Maintenance < Initial)[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]. Five health states gate behavior[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]: **Healthy** (TAV ≥ all reqs); **Pre-Liquidation** (TAV < IMR but ≥ MMR — only operations that do not decrease the TAV/MMR ratio and do not increase any position size are allowed); **Partial Liquidation** (TAV < MMR but ≥ CMR — open orders cancelled, IoC limit orders sent at zero price for the full position one by one until TAV ≥ MMR); **Full Liquidation** (TAV < CMR — LLP takes over positions in ascending unrealized-PnL order, only when LLP stays above its own IMR); and **ADL** (LLP undercapitalized — see [[concepts/risk/adl-waterfall]]).

**Step 1 — book liquidation (Partial).** All open orders are cancelled, then for each position the engine sends an IoC limit order for the full amount at the **zero price** — the price that preserves the TAV/MMR ratio[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]. Most liquidations are absorbed at this stage by the order book[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]. Liquidation halts as soon as TAV recovers above MMR[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]. **Liquidation fee:** if a partial-liquidation IoC fills at a better price than the zero price, up to a **1% liquidation fee** on the overshoot above maintenance margin is taken and routed to LLP[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund].

**Zero-price formula.**

```
zero_price (long)  = markPrice · (1 − M_i · TAV / MMR)
zero_price (short) = markPrice · (1 + M_i · TAV / MMR)
```

[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]

A trade at the zero price preserves the TAV/MMR ratio (i.e. it is a health-preserving fill — neither user nor counterparty changes margin status)[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund].

**Step 2 — backstop (Full Liquidation via LLP).** When TAV falls below CMR, the [[parameters/lighter/llp]] takes over positions in ascending order of unrealized PnL — but **only** if LLP's own TAV stays above LLP's IMR after the takeover[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]. Positions that would push LLP below its IMR are skipped and routed directly to ADL[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]. LLP is the single counterparty account for all backstop trading and ADL[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies].

**Cross vs Simple-account isolation.** Lighter exposes two account abstractions: Simple Trading Accounts (spot and perp balances strictly separated, no shared collateral) and Unified Trading Accounts (UTA) with cross-margin across spot and perp USDC balances; isolated positions in either flavor use a separate AllocatedMargin scoped to the single position and follow the same waterfall but evaluated on AllocatedMargin instead of cross collateral[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund].

**Margin-tier ladder.** The per-position `(I_i, M_i, C_i)` triple is set by the market's [[parameters/lighter/margin-tiers]]; max leverage on Lighter ranges from 50x (BTC) down to 3x for the most volatile RWAs, with `M_i ≈ 0.6·I_i` and `C_i ≈ 0.4·I_i` typical[^lighter-docs-2026-04-28-trading-contract-specifications].

**Verifiable liquidations.** Lighter's matching engine emits SNARK-aggregated proofs that liquidation transitions are valid executions of the published rules — every state transition is verifiable on Ethereum, so a liquidation cannot be issued maliciously by the operator[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund][^lighter-docs-2026-04-28-trading-order-types-and-matching][^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core].

## Variants in the wild

| venue | trigger | book step? | backstop pool | partial-liq threshold | clearance fee | residual handling |
|---|---|---|---|---|---|---|
| [[entities/perpdex/hyperliquid]] | account_value < MM × notional[^hl-docs-2026-04-27-trading-margining] | yes (full size) | [[parameters/hyperliquid/hlp]] vault | 100k USDC (10k testnet) | none[^hl-docs-2026-04-27-trading-liquidations] | book closure: residual to trader. backstop: MM forfeited[^hl-docs-2026-04-27-trading-liquidations] |
| [[entities/perpdex/aster]] | maintenance margin breach (tier-based)[^aster-docs-2026-04-28-trading-perpetuals-liquidations] | yes (1 large IOC partial close)[^aster-docs-2026-04-28-trading-perpetuals-liquidations] | Insurance Fund[^aster-docs-2026-04-28-trading-perpetuals-liquidations] | not surfaced | not surfaced | 5-step waterfall: cancel orders → IOC → recheck → IF transfer at bankruptcy price → ADL fall-through; negative-balance ≤5,000 USDT auto-IF-cover (USDT-perp accounts only, no open positions, no offsetting transfers)[^aster-docs-2026-04-28-trading-perpetuals-liquidations] |
| [[entities/perpdex/dydx]] | TAV < MMR[^dydx-docs-2026-04-28-concepts-trading-liquidations] | yes (fillable-price limit order matched against book)[^dydx-docs-2026-04-28-concepts-trading-liquidations] | Insurance Fund (cross-shared + per-isolated-market segregated)[^dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism] | not surfaced (per-block per-position caps governance-adjustable)[^dydx-docs-2026-04-28-concepts-trading-liquidations] | max 1.5% penalty (100% to IF)[^dydx-docs-2026-04-28-concepts-trading-liquidations] | IF widens limit price (max 1.5×MMF spread); immediate deleveraging when account value goes negative (IF bypassed)[^dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism] |

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
[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]: [[sources/lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]]
[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]: [[sources/lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]]
[^lighter-docs-2026-04-28-trading-prelaunch-markets]: [[sources/lighter-docs-2026-04-28-trading-prelaunch-markets]]
[^lighter-docs-2026-04-28-trading-order-types-and-matching]: [[sources/lighter-docs-2026-04-28-trading-order-types-and-matching]]
[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]: [[sources/lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]]
[^lighter-docs-2026-04-28-trading-contract-specifications]: [[sources/lighter-docs-2026-04-28-trading-contract-specifications]]
[^dydx-docs-2026-04-28-concepts-trading-liquidations]: [[sources/dydx-docs-2026-04-28-concepts-trading-liquidations]]
[^dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism]: [[sources/dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism]]
