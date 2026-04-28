---
type: parameter
entity: [[aster]]
parameter: pool-spec
pool_id: ALP
pool_class: venue-owned-lp
status: live
deposit_tokens: [USDT, BTC, ETH, BNB, "and chain-specific assets"]
strategy_summary: protocol-as-MM counterparty + multi-source NAV accrual
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: true
---

# Aster ALP

## Current pool spec

**Architecture.** ALP is Aster's venue-owned LP token: holders mint ALP to act as the **market-maker counterparty for perp trades across all pairs** on Aster, in the same architectural pattern as Hyperliquid's HLP and GMX's GLP[^aster-docs-2026-04-28-earn-aster-alp]. NAV moves with the pool's overall P&L — token price can rise or fall with trading activity and market conditions, so LPs bear directional / adverse-selection risk[^aster-docs-2026-04-28-earn-aster-alp].

**Multi-chain mint surface.** ALP can be minted on **BNB Chain** and **Arbitrum**, with chain-specific deposit assets — cross-chaining the LP risk surface across two networks[^aster-docs-2026-04-28-earn-aster-alp].

**Five yield sources** (all auto-reflected in NAV; no separate claim step)[^aster-docs-2026-04-28-earn-aster-alp]:

1. ALP's share of **market-making P&L** from Simple Mode trading activity.
2. **Trading fees** collected on perp trades.
3. **Funding fees** from perpetual contract funding rate mechanisms.
4. **Liquidation captures** — profit captured from liquidation events within the pool.
5. **Platform-level fee collection** — NAV boost from broader platform fees.

**Mint / burn fee mechanism.** Fees adjust dynamically to push the pool toward target weights. **Base parameters (USDT)**: `FeeBasisPoints = 0.25%`, `TaxBasisPoints = 0.05%`[^aster-docs-2026-04-28-earn-aster-alp-fees].

**Round-trip asymmetry.** The mechanism rewards rebalancing actions and penalizes destabilizing actions — the published example shows a **0% mint fee** for adding underweight BTC and a **0.7% burn fee** for removing scarce BTC, a 70bps round-trip asymmetry that disincentivizes draining underweight assets[^aster-docs-2026-04-28-earn-aster-alp-fees].

**UI disclosure.** The interface displays the exact mint or burn fee before transaction confirmation; live pool composition (asset quantities, values, target vs. current weights) is viewable on the ALP product page[^aster-docs-2026-04-28-earn-aster-alp-fees].

## Lifecycle events

- **Mint:** user deposits a chain-specific asset on BNB Chain or Arbitrum; mint fee is computed at execution time per the formulae below[^aster-docs-2026-04-28-earn-aster-alp][^aster-docs-2026-04-28-earn-aster-alp-fees].
- **NAV accrual:** all five yield streams accrue continuously to NAV — no claim required[^aster-docs-2026-04-28-earn-aster-alp].
- **Burn:** user burns ALP for chosen redemption asset; burn fee computed by the same target-weight rebalancing formula as mint[^aster-docs-2026-04-28-earn-aster-alp-fees].

(Offboarding-symmetry under stress — caps, queue, withdrawal blocking — is not specified in primary docs.)

## Time series

| effective | base FeeBasisPoints | base TaxBasisPoints | mint chains | yield sources | source |
|---|---|---|---|---|---|
| 2026-04-28 | 0.25% (USDT) | 0.05% (USDT, per page) | BNB Chain, Arbitrum | MM P&L, trading fees, funding fees, liquidation captures, platform fees | [^aster-docs-2026-04-28-earn-aster-alp][^aster-docs-2026-04-28-earn-aster-alp-fees] |

## Tiering rules / formulae

**Toward target (mint):**
`MintFee = max(FeeBasisPoints − TaxBasisPoints × InitialDiff / TargetValue, 0)`[^aster-docs-2026-04-28-earn-aster-alp-fees]

**Away from target (mint):**
`MintFee = FeeBasisPoints + TaxBasisPoints × min((InitialDiff + AfterDiff)/2, TargetValue) / TargetValue`[^aster-docs-2026-04-28-earn-aster-alp-fees]

**Toward target (burn):**
`BurnFee = max(FeeBasisPoints − TaxBasisPoints × InitialDiff / TargetValue, 0)`[^aster-docs-2026-04-28-earn-aster-alp-fees]

**Away from target (burn):**
`BurnFee = FeeBasisPoints + TaxBasisPoints × min((InitialDiff + AfterDiff)/2, TargetValue) / TargetValue`[^aster-docs-2026-04-28-earn-aster-alp-fees]

**Inputs:**
- `InitialValue = AssetValueInPool + AssetUnrealizedPnL`[^aster-docs-2026-04-28-earn-aster-alp-fees]
- `TargetValue (mint) = (TotalPoolValue + TotalUnrealizedPnL) × TargetWeight`[^aster-docs-2026-04-28-earn-aster-alp-fees]
- `TargetValue (burn) = TotalPoolValue × TargetWeight` (excluding unrealized PnL)[^aster-docs-2026-04-28-earn-aster-alp-fees]

## Disputed values

**#dispute-alp-tax-basis-points.** The ALP Fees page lists `TaxBasisPoints (USDT) = 0.05%`, but the worked BTC example uses **`TaxBasisPoints = 0.45%`** — a 9× difference[^aster-docs-2026-04-28-earn-aster-alp-fees]. Either per-asset tax parameters exist (with BTC = 0.45%) and the page omits the table, or one of the values is stale / inconsistent. Both readings are documented; resolution requires direct on-chain inspection of the mint/burn contract.

## Sources
[^aster-docs-2026-04-28-earn-aster-alp]: [[sources/aster-docs-2026-04-28-earn-aster-alp]]
[^aster-docs-2026-04-28-earn-aster-alp-fees]: [[sources/aster-docs-2026-04-28-earn-aster-alp-fees]]
