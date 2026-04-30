---
type: concept
domain: lp
name: Protocol-owned liquidity
last_reviewed: 2026-04-30
disputed: false
---

# Protocol-owned liquidity

## Definition

**Protocol-owned liquidity (POL)** is a capital pool **owned and operated by the protocol itself** — not a third-party MM firm and not an open AMM curve — where the protocol-controlled vault is the **counterparty** for trades, liquidations, or both, and depositor PnL accrues pro-rata to vault shares with no off-chain bilateral agreement[^hl-docs-2026-04-27-trading-liquidations][^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies][^aster-docs-2026-04-28-earn-aster-alp][^dydx-docs-2026-04-28-concepts-trading-megavault]. Two distinguishing traits separate POL from neighbouring constructs:

- **vs. external MM (mm-firm-as-LP).** External MM firms quote under bilateral agreements with rebate ladders, uptime SLAs, and exclusivity terms (see [[concepts/mm-agreement/quote-obligation]]); POL has no such agreement — depositors are the residual risk-bearer and the venue is the operator. POL replaces "the venue pays an MM to quote" with "depositors pay themselves to quote, at risk of their own capital."[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies][^aster-docs-2026-04-28-earn-aster-alp]
- **vs. open AMM LP.** Open AMM LP positions provide passive curve-based quotes against any counterparty; POL is asset-allocated and discretionary (an operator runs strategies or quotes against the venue's own book) and **frequently doubles as the insurance fund of last resort**[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund][^hl-docs-2026-04-27-trading-liquidations].

POL is a role lens — the same vault construct described in [[concepts/lp/vault]] (aggregation mechanism) and [[concepts/lp/venue-owned-lp]] (ownership), viewed through the **counterparty role** the protocol assumes once depositors hand it capital.

### POL vs. neighbouring liquidity constructs

| trait | external MM (mm-firm-as-LP) | open AMM LP | protocol-owned liquidity (this page) |
|---|---|---|---|
| operator | external firm under bilateral agreement | none (passive curve) | venue / protocol-elected operator |
| counterparty role | yes (under MM agreement) | yes (curve quotes) | yes — and frequently *also* IF/backstop |
| PnL recipient | MM firm + venue (rebates, fees) | LP depositors (curve PnL) | depositors pro-rata to vault shares |
| obligation source | [[concepts/mm-agreement/quote-obligation]] (uptime SLA, depth, spread) | none (curve math) | none externally; vault internal IMR / strategy mandate |
| eligibility | whitelisted MM firms | open | open or stake-gated (LIT, DRIFT, asset stakers) |
| insurance-fund overlap | none (MM is not IF) | none (LP is not IF) | common — see [[concepts/risk/insurance-fund-sizing]] for sizing the IF role |

## Mechanism

### Three role variants

A single vault often combines roles. Filing convention: file under the dominant role, note overlaps in the body.

1. **Protocol-MM.** Vault quotes bid/ask on listed markets against arriving order flow; depositors share the MM PnL.
   - HLP MM strategy[^hl-docs-2026-04-27-trading-liquidations]
   - ALP (single MM counterparty across all perp pairs)[^aster-docs-2026-04-28-earn-aster-alp]
   - LLP-as-MM (treated as MM under Lighter points-program rules)[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]
   - OmniVault Strategy Provider quoting on Orderly orderbook[^orderly-docs-2026-04-29-omnivault-mechanics]
   - MegaVault per-market sub-vaults running automated AMM strategies[^dydx-docs-2026-04-28-concepts-trading-megavault]
2. **IF / backstop.** Vault is the takeover counterparty when ordinary book liquidation fails — absorbing positions before [[concepts/risk/adl-waterfall|ADL]] is invoked.
   - HLP Liquidator Vault (book-step failure → HLP takeover)[^hl-docs-2026-04-27-trading-liquidations]
   - LLP Full-Liquidation absorber (gated by LLP's own IMR self-protection)[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]
   - Drift IF (per-asset USDC/BTC/ETH/SOL pools) + DSM (DRIFT-staked second layer)[^drift-docs-2026-04-28-protocol-insurance-fund][^drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module]
3. **Hybrid (MM + IF).** A single vault carries both roles. HLP and LLP are the canonical hybrids — same depositor capital quotes the book *and* eats backstop residuals[^hl-docs-2026-04-27-trading-liquidations][^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies].

### Funding sources

Most vaults blend several inflows. The mix determines whether NAV growth is attributable to MM skill, fee-skim luck, or governance-allocated subsidy.

- **Depositor capital.** Open-mint principal (HLP, ALP, OmniVault, MegaVault[^hl-docs-2026-04-27-trading-liquidations][^aster-docs-2026-04-28-earn-aster-alp][^orderly-docs-2026-04-29-omnivault-overview][^dydx-community-2026-04-28-dydx-features-megavault]) or stake-gated (LLP at 1 LIT → 10 USDC capacity[^lighter-docs-2026-04-28-about-lighter-lit-utility]).
- **MM PnL retention.** Quoting profit accrues directly to vault NAV — e.g. ALP's "Simple Mode MM P&L" stream[^aster-docs-2026-04-28-earn-aster-alp].
- **Fee skim.** Protocol routes a fixed share of trading / liquidation / funding fees into vault NAV.
  - ALP: five auto-NAV streams (MM P&L + trading fees + funding fees + liquidation captures + platform fees)[^aster-docs-2026-04-28-earn-aster-alp]
  - OmniVault: up to 40% of net protocol revenue + a portion of IF liquidation fees[^orderly-docs-2026-04-29-omnivault-mechanics]
  - MegaVault: 50% trading-fee share, governance-approved 2024-11-15[^dydx-community-2026-04-28-dydx-features-megavault]
  - LLP: up to 1% of partial-liquidation overshoot[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]
  - Drift IF: exchange + liquidation premiums[^drift-docs-2026-04-28-protocol-insurance-fund]
- **Token emission / staking gate.** Drift DSM accepts DRIFT stakes that backstop bad debt and earn a hourly Revenue Pool share `staker_share = total_staked / total_IF`[^drift-docs-2026-04-28-protocol-insurance-fund-staking][^drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module].

### Eligibility

Eligibility design trades **capacity** (open-mint scales) against **quality of capital** (stake-gating filters depositors and adds skin-in-the-game).

- **Open-mint:** HLP[^hl-docs-2026-04-27-trading-liquidations], ALP (BNB Chain + Arbitrum, chain-specific deposit assets)[^aster-docs-2026-04-28-earn-aster-alp], OmniVault (USDC from Arbitrum/Base/Optimism/Sei)[^orderly-docs-2026-04-29-omnivault-overview], MegaVault (US/Canada/prohibited-jurisdiction excluded)[^dydx-community-2026-04-28-dydx-features-megavault].
- **Stake-gated:** LLP via LIT[^lighter-docs-2026-04-28-about-lighter-lit-utility]; Drift IF via asset staking and DSM via DRIFT staking[^drift-docs-2026-04-28-protocol-insurance-fund-staking][^drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module].

### Lockup / withdrawal queue

- **Direct lockup.** Drift IF: 13-day unstake cooldown, blocked when 1h-TWAP utilization > 80%; only one pending unstake per vault, cancellation restarts the clock[^drift-docs-2026-04-28-protocol-insurance-fund-staking]. MegaVault: ~30d IML lock per new sub-vault[^dydx-community-2026-04-28-dydx-features-megavault]. OmniVault: 3h vault period; deposits/withdrawals batched at boundaries (8 periods/day from 0200H UTC)[^orderly-docs-2026-04-29-omnivault-mechanics].
- **Indirect lockup.** LLP capacity is sticky on exit because LIT unstaking carries a 3-day lockup — depositors who want out of LLP must first wait out the LIT lockup before reclaiming free USDC[^lighter-docs-2026-04-28-about-lighter-lit-utility].
- **Not surfaced.** HLP and ALP do not document direct lockup or stressed-exit mechanics (caps, queue, withdrawal blocking) in primary docs[^hl-docs-2026-04-27-trading-liquidations][^aster-docs-2026-04-28-earn-aster-alp].

### Strategy isolation

- **Single-pool.** HLP and ALP commingle all market exposure into one NAV / share class — depositors take whichever directional and adverse-selection risk the venue's order flow inflicts on the pool[^hl-docs-2026-04-27-trading-liquidations][^aster-docs-2026-04-28-earn-aster-alp].
- **Multi-shard.** LLP partitions internal collateral into named strategy buckets (Crypto Perps / FX / Equities-RWAs) where each market maps to exactly one strategy and risk is isolated at the shard boundary[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]. Drift IF separates per-asset USDC/BTC/ETH/SOL pools plus isolated per-market funds for highly volatile markets[^drift-docs-2026-04-28-protocol-insurance-fund].
- **Per-market topology.** MegaVault uses per-market sub-vaults; the operator (Greave) can reallocate capital between sub-vaults — explicit topology rather than implicit shards[^dydx-community-2026-04-28-dydx-features-megavault].

### Loss socialization

- **Pro-rata across all depositors** in single-pool designs — backstop loss reduces share value for everyone in the vault.
- **Strategy-isolated** in multi-shard designs — only the depleted shard enters [[concepts/risk/adl-waterfall|ADL]]; other shards continue normally with their own collateral intact. See [[concepts/lp/vault]] §"Edge cases" for the LLP $1M-shard worked example[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies].
- **Layered slashing.** Drift's DSM slashes staked DRIFT for residual bad debt; risk is asset-isolated to DRIFT pairs only, with DSM bankruptcy risk compensated by the Revenue Pool[^drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module].

## Variants in the wild

| venue | vault | primary role | counterparty model | eligibility | lockup | strategy isolation |
|---|---|---|---|---|---|---|
| [[entities/perpdex/hyperliquid]] | [[parameters/hyperliquid/hlp]] | hybrid (protocol-MM + liquidator backstop) | single takeover account when book step fails[^hl-docs-2026-04-27-trading-liquidations] | open mint, USDC | none documented in primary docs[^hl-docs-2026-04-27-trading-liquidations] | single pool, two component strategies (MM + Liquidator)[^hl-docs-2026-04-27-trading-liquidations] |
| [[entities/perpdex/aster]] | [[parameters/aster/alp]] | protocol-MM (single MM counterparty for all perp pairs) | NAV moves with overall pool P&L; LPs bear directional + adverse-selection risk[^aster-docs-2026-04-28-earn-aster-alp] | open mint on BNB Chain + Arbitrum, chain-specific deposit assets[^aster-docs-2026-04-28-earn-aster-alp] | not surfaced in primary docs; stressed-exit caps/queues unspecified[^aster-docs-2026-04-28-earn-aster-alp] | single pool — five auto-NAV streams (MM P&L, trading fees, funding fees, liquidation captures, platform fees)[^aster-docs-2026-04-28-earn-aster-alp] |
| [[entities/perpdex/orderly]] | [[parameters/orderly/omnivault]] | protocol-MM via Strategy Provider + primary liquidator for selected symbols[^orderly-docs-2026-04-29-omnivault-mechanics] | SP (Kronos Research) executes MM strategies on Orderly orderbook; not direct counterparty on every trade[^orderly-docs-2026-04-29-omnivault-mechanics] | permissionless USDC deposit from Arbitrum/Base/Optimism/Sei (omnichain in-out)[^orderly-docs-2026-04-29-omnivault-overview][^orderly-docs-2026-04-29-omnivault-mechanics] | 3h vault periods; deposits/withdrawals batched at boundaries[^orderly-docs-2026-04-29-omnivault-mechanics] | single SP today; Permissionless Vault on roadmap 2026 H1[^orderly-docs-2026-04-29-roadmap] |
| [[entities/perpdex/drift]] | [[parameters/drift/insurance-fund]] (IF + DSM); separately a vAMM provides quoting | IF/backstop (multi-layer); vAMM is a separate quoting surface[^drift-docs-2026-04-28-protocol-insurance-fund][^drift-docs-2026-04-28-protocol-about-v3-drift-amm] | per-asset IF pools (USDC/BTC/ETH/SOL) gated to asset stakers; DSM gated to DRIFT stakers[^drift-docs-2026-04-28-protocol-insurance-fund-staking][^drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module] | 13-day unstake cooldown + cannot unstake when 1h-TWAP utilization > 80%[^drift-docs-2026-04-28-protocol-insurance-fund-staking] | per-asset pool isolation + isolated-IF for highly volatile markets + DSM as separate DRIFT-pair-only layer[^drift-docs-2026-04-28-protocol-insurance-fund][^drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module] |
| [[entities/perpdex/lighter]] | [[parameters/lighter/llp]] | hybrid (protocol-MM + IF + ADL backstop)[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies] | single account counterparty for all LLP trading + Full-Liquidation absorber, gated by LLP's own IMR[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund] | LIT-staking gated: 1 LIT → 10 USDC LLP capacity[^lighter-docs-2026-04-28-about-lighter-lit-utility] | indirect 3-day lockup via LIT unstake[^lighter-docs-2026-04-28-about-lighter-lit-utility] | multi-strategy shards (Crypto Perps · FX · Equities-RWAs); each market maps to one strategy; depletion-isolated ADL[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies] |
| [[entities/perpdex/dydx]] | [[parameters/dydx-v4/megavault]] | protocol-MM (per-market sub-vaults running automated AMM strategies)[^dydx-docs-2026-04-28-concepts-trading-megavault][^dydx-community-2026-04-28-dydx-features-megavault] | depositors fund USDC sub-vaults; operator (Greave) tunes parameters and reallocates capital[^dydx-community-2026-04-28-dydx-features-megavault] | open mint USDC; US/Canada/prohibited-jurisdiction users excluded[^dydx-community-2026-04-28-dydx-features-megavault] | IML 10k USDC creates new sub-vault with ~30d lock; otherwise no general lockup[^dydx-community-2026-04-28-dydx-features-megavault][^dydx-community-2026-04-28-dydx-features-instant-market-listings] | per-market sub-vault topology; operator can reallocate between sub-vaults[^dydx-community-2026-04-28-dydx-features-megavault] |

(The same venues appear in [[concepts/lp/vault]] §"Variants in the wild" with a different lens — that page emphasizes the vault-as-aggregation-mechanism and includes additional non-counterparty-role vaults like Lighter Public Pools and XLP. This page restricts the table to **POL-as-counterparty** rows only.)

## Edge cases

- **HLP single-pool MM + IF combo.** HLP's MM strategy and Liquidator Vault share one share class — depositors who came in for MM yield also eat backstop residuals, and there is no internal ring-fence between the two roles[^hl-docs-2026-04-27-trading-liquidations]. Backstop-liquidated positions enter the ADL queue on equal terms, so HLP loss can still cascade into ADL when its absorption capacity is exhausted[^hl-docs-2026-04-27-trading-auto-deleveraging].
- **LLP multi-strategy isolation with self-IMR gate.** LLP only absorbs a Full-Liquidation position if doing so keeps its own TAV above its own IMR — positions that would push LLP under-collateralised are skipped and routed straight to ADL[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]. Combined with strategy-shard accounting, this means a $1M strategy taking a $1M loss caps the contagion to that shard's depositors and that shard's ADL counterparty pool — other shards continue normally[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies].
- **Drift's IF + DSM two-layer separation.** Drift splits the protocol-owned backstop into two **independent** layers: (a) the standard IF (multi-asset USDC/BTC/ETH/SOL pools plus isolated per-market funds) covers debt up to per-market limits[^drift-docs-2026-04-28-protocol-insurance-fund]; (b) the Drift Safety Module (DSM) is a separate DRIFT-staked layer that auto-slashes for residual bad debt with risk asset-isolated to DRIFT pairs only[^drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module]. The waterfall is IF → vAMM lifetime profit → socialised loss[^drift-docs-2026-04-28-protocol-trading-liquidations-liquidation-engine] — note Drift also has a vAMM as a *separate* venue-owned quoting surface alongside the IF/DSM backstop[^drift-docs-2026-04-28-protocol-about-v3-drift-amm].
- **MegaVault revenue share with protocol fees.** dYdX governance approved a **50% trading-fee share** flowing into MegaVault on 2024-11-15 — this is a tokenomics-level commitment that turns the vault into a structural beneficiary of protocol activity, distinct from MM PnL[^dydx-community-2026-04-28-dydx-features-megavault]. APR formula `(30d PnL / current TVL) × (365/30)` will mechanically decrease as TVL grows, creating a self-balancing capacity signal[^dydx-community-2026-04-28-dydx-features-megavault].
- **ALP five auto-NAV streams.** ALP is unusual in that NAV reflects **five independent inflows** simultaneously — Simple Mode MM P&L, trading fees, funding fees, liquidation captures, and platform-level fees — all auto-reflected in NAV with no claim step[^aster-docs-2026-04-28-earn-aster-alp]. This makes ALP's APY harder to attribute to MM skill (vs. fee-skim luck) than HLP's MM-only stream.
- **OmniVault is not the IF.** OmniVault explicitly does **not** replace Orderly's insurance fund — they operate in parallel, with OmniVault receiving up to 40% of net protocol revenue plus a portion of IF liquidation fees but leaving final-backstop duty to the IF proper[^orderly-docs-2026-04-29-omnivault-mechanics]. Contrast HLP/LLP where the same vault serves both functions.
- **MM-points self-redistribution (Lighter LLP).** When LLP qualifies for market-maker points under the [[entities/programme/lighter-points-program|Lighter Points Program]], the points it would earn are scaled out and redistributed to other (external-MM) participants so the total weekly MM pool stays at 50,000 points[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]. This avoids a protocol-owned MM cannibalising third-party MM rewards while keeping the snapshot scoring rule symmetric — a governance pattern specific to hybrid POL where the vault is treated as an MM under the same accounting rules as external participants.

### Cells flagged as gap (next ingest)

- **HLP TVL / APY tracking** not in primary docs; should be filled from on-chain analytics or app dashboards[^hl-docs-2026-04-27-trading-liquidations].
- **HLP and ALP stressed-exit mechanics** (caps, queue, withdrawal blocking, cooldown) not surfaced in primary docs[^hl-docs-2026-04-27-trading-liquidations][^aster-docs-2026-04-28-earn-aster-alp].
- **LLP per-strategy collateral sizes** and IF coverage ratio (allocated-collateral vs max-OI × stress slippage × gap%) not published; documented gap on [[entities/perpdex/lighter]] frame-coverage A6/PIII.
- **ALP TaxBasisPoints disputed** — page lists 0.05% (USDT) but worked BTC example uses 0.45%; resolution requires direct on-chain inspection[^aster-docs-2026-04-28-earn-aster-alp].
- **Drift IF + DSM ratio targets** (what fraction of total expected-bad-debt is covered by IF vs DSM vs socialised loss) not surfaced in primary docs[^drift-docs-2026-04-28-protocol-insurance-fund][^drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module].

## Filing convention

When ingesting a new protocol-owned vault:

- File the parameter page as `parameters/<entity>/<pool-id>.md` (HLP, ALP, OmniVault, LLP, MegaVault) or `parameters/<entity>/insurance-fund.md` when the dominant role is IF (Drift).
- File the entry on **this** concept page (POL) when the vault assumes a counterparty role for trades or liquidations.
- File the same vault on [[concepts/lp/vault]] when the lens is *aggregation mechanism* (vault structure, multi-role taxonomy, lockup design).
- File on [[concepts/lp/venue-owned-lp]] when the lens is *ownership* (venue vs external operator).
- File on [[concepts/risk/insurance-fund-sizing]] when the vault doubles as IF and the question is sizing adequacy (allocated-collateral vs max-OI × stress slippage × gap%).
- A single vault appears on multiple concept pages under different lenses — that is by design, not duplication.

## Related

[[concepts/lp/vault]] · [[concepts/lp/venue-owned-lp]] · [[concepts/risk/insurance-fund-sizing]] · [[concepts/risk/adl-waterfall]] · [[concepts/risk/liquidation]] · [[concepts/mm-agreement/quote-obligation]] · [[parameters/hyperliquid/hlp]] · [[parameters/aster/alp]] · [[parameters/orderly/omnivault]] · [[parameters/drift/insurance-fund]] · [[parameters/lighter/llp]] · [[parameters/dydx-v4/megavault]]

## Sources

[^hl-docs-2026-04-27-trading-liquidations]: [[sources/hl-docs-2026-04-27-trading-liquidations]]
[^hl-docs-2026-04-27-trading-auto-deleveraging]: [[sources/hl-docs-2026-04-27-trading-auto-deleveraging]]
[^aster-docs-2026-04-28-earn-aster-alp]: [[sources/aster-docs-2026-04-28-earn-aster-alp]]
[^orderly-docs-2026-04-29-omnivault-overview]: [[sources/orderly-docs-2026-04-29-omnivault-overview]]
[^orderly-docs-2026-04-29-omnivault-mechanics]: [[sources/orderly-docs-2026-04-29-omnivault-mechanics]]
[^orderly-docs-2026-04-29-roadmap]: [[sources/orderly-docs-2026-04-29-roadmap]]
[^drift-docs-2026-04-28-protocol-insurance-fund]: [[sources/drift-docs-2026-04-28-protocol-insurance-fund]]
[^drift-docs-2026-04-28-protocol-insurance-fund-staking]: [[sources/drift-docs-2026-04-28-protocol-insurance-fund-staking]]
[^drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module]: [[sources/drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module]]
[^drift-docs-2026-04-28-protocol-trading-liquidations-liquidation-engine]: [[sources/drift-docs-2026-04-28-protocol-trading-liquidations-liquidation-engine]]
[^drift-docs-2026-04-28-protocol-about-v3-drift-amm]: [[sources/drift-docs-2026-04-28-protocol-about-v3-drift-amm]]
[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]: [[sources/lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]]
[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]: [[sources/lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]]
[^lighter-docs-2026-04-28-about-lighter-lit-utility]: [[sources/lighter-docs-2026-04-28-about-lighter-lit-utility]]
[^dydx-docs-2026-04-28-concepts-trading-megavault]: [[sources/dydx-docs-2026-04-28-concepts-trading-megavault]]
[^dydx-community-2026-04-28-dydx-features-megavault]: [[sources/dydx-community-2026-04-28-dydx-features-megavault]]
[^dydx-community-2026-04-28-dydx-features-instant-market-listings]: [[sources/dydx-community-2026-04-28-dydx-features-instant-market-listings]]
