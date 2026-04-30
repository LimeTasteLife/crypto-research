---
type: concept
domain: risk
name: Insurance fund sizing
last_reviewed: 2026-04-30
disputed: false
---

# Insurance fund sizing

## Definition

Insurance fund sizing is the risk-management policy governing the capital base, coverage scope, and replenishment of a perp DEX's solvency backstop — the pool that absorbs losses from bankrupt positions before [[concepts/risk/adl-waterfall|socialized loss]] applies to surviving counterparties[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund][^hl-docs-2026-04-27-trading-liquidations][^drift-docs-2026-04-28-protocol-insurance-fund]. A correctly sized fund prevents loss cascades to solvent counterparties (via ADL) under normal conditions[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]. Key design dimensions: topology (single pool vs per-asset vs per-strategy vs per-market), inflow mechanism (liquidation-fee skimming, depositor capital, protocol revenue), outflow trigger (bankruptcy vs pre-bankruptcy backstop), and sizing constraint (depositor-driven, target-ratio, stake-gated, or implicit)[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies][^aster-docs-2026-04-28-earn-aster-alp]. A common informal metric is the IF coverage ratio — IF balance relative to (max-OI × stress-slippage × gap-move probability) — but no surveyed venue publishes such a target ratio.

## Mechanism

**Inflow.** Insurance funds grow through:
- Liquidation fee skimming: a fraction of the fee paid on liquidated positions is credited to the pool[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund][^aster-docs-2026-04-28-trading-perpetuals-liquidations][^dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism].
- Depositor capital: external LPs supply collateral to the pool in exchange for a yield claim (HLP / LLP / ALP / DSM stake) — fund size is determined by market demand or stake gating[^aster-docs-2026-04-28-earn-aster-alp][^hl-docs-2026-04-27-trading-liquidations][^drift-docs-2026-04-28-protocol-insurance-fund-staking].

**Outflow.** The pool absorbs loss when:
- A full liquidation cannot be closed through the order book (backstop step)[^hl-docs-2026-04-27-trading-liquidations][^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund].
- A bankrupt position is transferred to the IF at the bankruptcy price[^aster-docs-2026-04-28-trading-perpetuals-liquidations][^drift-docs-2026-04-28-protocol-trading-liquidations-liquidation-engine].

**ADL trigger.** When the fund is exhausted (or a strategy's allocation is depleted), the venue falls back to Auto-Deleveraging — matching the bankrupt account's position against profitable opposite-side traders[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund][^aster-docs-2026-04-28-trading-perpetuals-liquidations][^hl-docs-2026-04-27-trading-liquidations][^drift-docs-2026-04-28-protocol-insurance-fund].

**IF coverage ratio.** Informally `IF / (max-OI × stress-slippage × gap%)`; no surveyed perpdex publishes a target value (see Variants table column).

## Variants in the wild

| venue | pool name | topology | sizing constraint | inflow | outflow trigger | ADL threshold | coverage ratio published? |
|---|---|---|---|---|---|---|---|
| [[entities/perpdex/hyperliquid]] | [[parameters/hyperliquid/hlp]] Liquidator Vault | single pool — HLP is both protocol-MM and insurance vault[^hl-docs-2026-04-27-trading-liquidations] | depositor-driven (community deposits to HLP)[^hl-docs-2026-04-27-trading-liquidations] | MM P&L + maintenance margin forfeited on backstop[^hl-docs-2026-04-27-trading-liquidations] | account equity < 2/3 maintenance margin without book closure[^hl-docs-2026-04-27-trading-liquidations] | HLP undercapitalized for the backstop impact[^hl-docs-2026-04-27-trading-liquidations] | no |
| [[entities/perpdex/aster]] | Aster Insurance Fund + [[parameters/aster/alp]] | separate IF from ALP; ALP captures liquidation P&L as one of five yield sources[^aster-docs-2026-04-28-earn-aster-alp][^aster-docs-2026-04-28-trading-perpetuals-liquidations] | not stated in docs; IF balance not published[^aster-docs-2026-04-28-trading-perpetuals-liquidations] | liquidation fee fraction credited to IF; ALP captures realized surplus[^aster-docs-2026-04-28-trading-perpetuals-liquidations][^aster-docs-2026-04-28-earn-aster-alp] | bankrupt residual after IOC close (step 4)[^aster-docs-2026-04-28-trading-perpetuals-liquidations] | IF cannot cover remaining deficit (step 5)[^aster-docs-2026-04-28-trading-perpetuals-liquidations] | no |
| [[entities/perpdex/lighter]] | [[parameters/lighter/llp]] / [[parameters/lighter/insurance-fund]] | single LLP account with per-strategy isolation (Crypto Perps / FX / Equities-RWAs); each market assigned to one strategy[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies] | LIT-staking-gated: 1 LIT staked → up to 10 USDC LLP capacity[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies] | up to 1% liquidation fee on partial-liq overshoot routed to LLP[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund] | TAV < CMR → LLP takes over positions (Full Liquidation)[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund] | strategy-level: LLP position would push LLP below its own IMR → ADL for that strategy only[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies] | no |
| [[entities/perpdex/drift]] | [[parameters/drift/insurance-fund]] + DRIFT Safety Module | multi-asset (USDC / BTC / ETH / SOL) + per-market isolated IF + DSM (DRIFT-staked backstop with asset-isolated slashing)[^drift-docs-2026-04-28-protocol-insurance-fund][^drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module] | per-asset IF covers same-denomination liabilities; isolated IF for speculative markets; DSM stake backed by DRIFT[^drift-docs-2026-04-28-protocol-insurance-fund][^drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module] | external IF capture from liquidation fees + DSM staking; 13-day unstake cooldown; 80% utilization gate[^drift-docs-2026-04-28-protocol-insurance-fund-staking] | perp bankruptcy waterfall: external IF → vAMM lifetime profit → socialized loss pro rata; spot covered in full; perp up to per-market limit[^drift-docs-2026-04-28-protocol-insurance-fund][^drift-docs-2026-04-28-protocol-trading-liquidations-liquidation-engine] | per-market IF exhaustion → socialized loss for perp; speculative-tier markets bypass standard IF[^drift-docs-2026-04-28-protocol-insurance-fund][^drift-docs-2026-04-28-protocol-trading-liquidations-liquidation-engine] | no |
| [[entities/perpdex/dydx]] | dYdX Insurance Fund | not surfaced in primary docs (gap A6/PIII) | not surfaced in primary docs | IF receives 100% of 1.5% liquidation penalty[^dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism] | bankrupt position routed to IF; IF aggression limited to 1.5× MMF spread from oracle[^dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism] | IF depletion → contract-loss / deleveraging[^dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism] | no |

## Edge cases

- **Strategy-level isolation (Lighter).** A depletion event in one strategy (e.g., Equities-RWAs) triggers ADL only within that strategy — Crypto Perps and FX strategies remain solvent[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]. Contains contagion but fragments the total backstop pool, reducing capital available to absorb a large loss in any single strategy.
- **LIT-staking capacity link (Lighter).** LLP's size is a function of LIT token staking behavior — if staking deposits shrink (e.g., due to LIT price decline), LLP capacity shrinks mechanically[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]. Creates a reflexive risk: large drawdowns that reduce LIT price also shrink the insurance fund at the moment it is most needed.
- **Community-owned backstop (Hyperliquid).** HLP explicitly contrasts with CEX/MM internalization of backstop economics: all backstop PnL flows to community depositors[^hl-docs-2026-04-27-trading-liquidations]. Aligns incentives but means fund size is market-driven — if HLP APY declines, deposits may exit.
- **Negative-balance auto-cover (Aster).** Aster automatically covers negative USDT-perp account balances ≤5,000 USDT from the IF under strict conditions (no open positions, no offsetting transfers post-liquidation)[^aster-docs-2026-04-28-trading-perpetuals-liquidations]. Creates a categorical floor for small retail accounts but adds an unconditional IF drain not present on other platforms.
- **Multi-asset IF isolation (Drift).** A shortfall in SOL cannot be covered by the USDC pool[^drift-docs-2026-04-28-protocol-insurance-fund]. Same-denomination matching prevents cross-asset bailouts but increases per-asset capital requirements.
- **Speculative-tier IF bypass (Drift).** Speculative and Highly Speculative tier markets explicitly cannot draw from the standard Insurance Fund — they rely solely on the per-market fee pool, structurally elevating ADL probability for those markets[^drift-docs-2026-04-28-protocol-insurance-fund][^drift-docs-2026-04-28-protocol-trading-liquidations-liquidation-engine].
- **DSM cooldown gate (Drift).** DRIFT Safety Module stakers face a 13-day unstake cooldown and an 80% utilization gate — providing time for governance response under stress but limiting LP exit speed during fast drawdowns[^drift-docs-2026-04-28-protocol-insurance-fund-staking].
- **IF aggression cap (dYdX).** dYdX's IF cannot bid more aggressively than 1.5× the maintenance-margin-fraction spread from the oracle when taking over bankrupt positions[^dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism]. Bounds IF loss per-takeover but may cap the IF's ability to clear positions in extreme dislocations.

## Disputed claims
None.

## Related
[[concepts/operations/insurance-fund]] · [[concepts/risk/liquidation]] · [[concepts/risk/adl-waterfall]] · [[parameters/lighter/llp]] · [[parameters/lighter/insurance-fund]] · [[parameters/hyperliquid/hlp]] · [[parameters/aster/alp]] · [[parameters/drift/insurance-fund]]

## Sources
[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]: [[sources/lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]]
[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]: [[sources/lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]]
[^hl-docs-2026-04-27-trading-liquidations]: [[sources/hl-docs-2026-04-27-trading-liquidations]]
[^aster-docs-2026-04-28-trading-perpetuals-liquidations]: [[sources/aster-docs-2026-04-28-trading-perpetuals-liquidations]]
[^aster-docs-2026-04-28-earn-aster-alp]: [[sources/aster-docs-2026-04-28-earn-aster-alp]]
[^drift-docs-2026-04-28-protocol-insurance-fund]: [[sources/drift-docs-2026-04-28-protocol-insurance-fund]]
[^drift-docs-2026-04-28-protocol-insurance-fund-staking]: [[sources/drift-docs-2026-04-28-protocol-insurance-fund-staking]]
[^drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module]: [[sources/drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module]]
[^drift-docs-2026-04-28-protocol-trading-liquidations-liquidation-engine]: [[sources/drift-docs-2026-04-28-protocol-trading-liquidations-liquidation-engine]]
[^dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism]: [[sources/dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism]]
