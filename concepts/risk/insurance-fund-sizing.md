---
type: concept
domain: risk
name: Insurance fund sizing
last_reviewed: 2026-04-28
disputed: false
---

# Insurance fund sizing

## Definition

Insurance fund sizing refers to the mechanism by which a perpetual DEX determines the capital stock of its backstop pool — the pool that absorbs losses when a liquidated position cannot be fully closed through the order book[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund][^hl-docs-2026-04-27-trading-liquidations]. A correctly sized insurance fund prevents losses from cascading to solvent counterparties (via ADL) under normal market conditions[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]. Key design dimensions: topology (single vs per-asset vs per-strategy vs per-market pool), inflow mechanism (liquidation fee skimming, depositor capital, or protocol revenue), outflow trigger (at bankruptcy vs before bankruptcy), and sizing constraint (depositor-driven, target-ratio, or implicit)[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies][^aster-docs-2026-04-28-earn-aster-alp].

## Mechanism

**Inflow.** Insurance funds grow through:
- Liquidation fee skimming: a fraction of the fee paid on liquidated positions is credited to the pool[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund][^aster-docs-2026-04-28-trading-perpetuals-liquidations].
- Depositor capital: external LPs supply collateral to the pool in exchange for a yield claim (HLP/LLP/ALP) — fund size is determined by market demand[^aster-docs-2026-04-28-earn-aster-alp][^hl-docs-2026-04-27-trading-liquidations].

**Outflow.** The pool absorbs loss when:
- A full liquidation cannot be closed through the book (backstop step)[^hl-docs-2026-04-27-trading-liquidations][^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund].
- A bankrupt position is transferred to the IF at the bankruptcy price[^aster-docs-2026-04-28-trading-perpetuals-liquidations].

**ADL trigger.** When the fund is exhausted (or a strategy's allocation is depleted), the venue falls back to Auto-Deleveraging — matching the bankrupt account's position against profitable opposite-side traders[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund][^aster-docs-2026-04-28-trading-perpetuals-liquidations][^hl-docs-2026-04-27-trading-liquidations].

## Variants in the wild

| venue | pool name | topology | sizing constraint | inflow mechanism | outflow trigger | ADL threshold |
|---|---|---|---|---|---|---|
| [[entities/perpdex/hyperliquid]] | [[parameters/hyperliquid/hlp]] Liquidator Vault | single pool (HLP is both MM and insurance vault)[^hl-docs-2026-04-27-trading-liquidations] | depositor-driven (community deposits to HLP)[^hl-docs-2026-04-27-trading-liquidations] | MM P&L + liquidation backstop economics; maintenance margin forfeited on backstop[^hl-docs-2026-04-27-trading-liquidations] | account equity < 2/3 maintenance margin without book closure[^hl-docs-2026-04-27-trading-liquidations] | HLP undercapitalized for the backstop impact[^hl-docs-2026-04-27-trading-liquidations] |
| [[entities/perpdex/aster]] | Aster Insurance Fund + [[parameters/aster/alp]] | separate IF from ALP; ALP captures liquidation P&L as one of five yield sources[^aster-docs-2026-04-28-earn-aster-alp][^aster-docs-2026-04-28-trading-perpetuals-liquidations] | not stated in docs; IF balance not published[^aster-docs-2026-04-28-trading-perpetuals-liquidations] | liquidation fee fraction credited to IF; ALP captures realized surplus[^aster-docs-2026-04-28-trading-perpetuals-liquidations][^aster-docs-2026-04-28-earn-aster-alp] | bankrupt residual after IOC close (step 4)[^aster-docs-2026-04-28-trading-perpetuals-liquidations] | IF cannot cover remaining deficit (step 5)[^aster-docs-2026-04-28-trading-perpetuals-liquidations] |
| [[entities/perpdex/lighter]] | [[parameters/lighter/llp]] / [[parameters/lighter/insurance-fund]] | single LLP account with per-strategy isolation (Crypto Perps / FX / Equities-RWAs); each market assigned to one strategy[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies] | LIT-staking-gated: 1 LIT staked → up to 10 USDC LLP capacity[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies] | up to 1% liquidation fee on partial-liq overshoot routed to LLP[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund] | TAV < CMR → LLP takes over positions (Full Liquidation)[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund] | strategy-level: LLP position would push LLP below its own IMR → ADL for that strategy only[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies] |

## Edge cases
- **Strategy-level isolation (Lighter).** Lighter's per-strategy approach means a depletion event in one strategy (e.g., Equities-RWAs) triggers ADL only within that strategy — Crypto Perps and FX strategies remain solvent[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]. This contains contagion but also fragments the total backstop pool, reducing the capital available to absorb a large loss in any single strategy.
- **LIT-staking capacity link (Lighter).** LLP's size is a function of LIT token staking behavior — if staking deposits shrink (e.g., due to LIT price decline), LLP capacity shrinks mechanically[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]. This creates a reflexive risk: large drawdowns that reduce LIT price also shrink the insurance fund at the moment it is most needed.
- **Community-owned backstop (Hyperliquid).** HLP explicitly contrasts with CEX/MM internalization of backstop economics: all backstop PnL flows to community depositors[^hl-docs-2026-04-27-trading-liquidations]. This aligns incentives but also means the fund size is market-driven — if HLP APY declines, deposits may exit.
- **Negative-balance auto-cover (Aster).** Aster automatically covers negative USDT-perp account balances ≤5,000 USDT from the IF under strict conditions (no open positions, no offsetting transfers post-liquidation)[^aster-docs-2026-04-28-trading-perpetuals-liquidations]. This creates a categorical floor that protects small retail accounts from full loss but adds an unconditional IF drain not present on other platforms.

## Disputed claims
None.

## Related
[[concepts/risk/liquidation]] · [[concepts/risk/adl-waterfall]] · [[parameters/lighter/llp]] · [[parameters/hyperliquid/hlp]] · [[parameters/aster/alp]] · [[parameters/lighter/insurance-fund]]

## Sources
[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]: [[sources/lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]]
[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]: [[sources/lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]]
[^hl-docs-2026-04-27-trading-liquidations]: [[sources/hl-docs-2026-04-27-trading-liquidations]]
[^aster-docs-2026-04-28-trading-perpetuals-liquidations]: [[sources/aster-docs-2026-04-28-trading-perpetuals-liquidations]]
[^aster-docs-2026-04-28-earn-aster-alp]: [[sources/aster-docs-2026-04-28-earn-aster-alp]]
