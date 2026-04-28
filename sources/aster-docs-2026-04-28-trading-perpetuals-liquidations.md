---
type: source
id: aster-docs-2026-04-28-trading-perpetuals-liquidations
title: Liquidations
publisher: Aster Docs
author: Aster team
date: null
original_url: https://docs.asterdex.com/trading/perpetuals/fees-and-specs/liquidations-1
mirror_snapshot: aster-docs-2026-04-28
mirror_page: pages/trading-perpetuals-liquidations.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Liquidations

## TL;DR
Aster runs a five-step "smart liquidation" waterfall: (1) cancel open orders, (2) issue one large IOC to partially close, (3) recheck margin and stop if maintenance is restored, (4) transfer any remaining bankrupt portion to the Insurance Fund at the bankruptcy price, (5) if still in deficit, fall through to ADL. Liquidation triggers when (Initial Collateral + Realized PnL + Unrealized PnL) < Maintenance Margin, with mark price as the trigger reference. Cross-margin hedge mode shares one liquidation price across long+short of the same contract; isolated mode keeps them separate. Negative balances ≤5,000 USDT in USDT-perp accounts may be auto-covered by the insurance fund only if the account has no open positions and no offsetting transfers post-liquidation. The platform recommends keeping margin ratio under 80% (risk ratio threshold is 100%).

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Liquidation occurs when account margin balance is insufficient to cover required maintenance margin. | [[concepts/risk/liquidation]] | - |
| #c2 | Forced liquidation is triggered when Margin = Initial Collateral + Realized PnL + Unrealized PnL < Maintenance Margin. | [[concepts/risk/liquidation]] | - |
| #c3 | The risk ratio of 100% corresponds to the liquidation trigger threshold. | [[concepts/risk/liquidation]] | A6-PIV |
| #c4 | Aster recommends keeping margin ratio below 80% to avoid liquidation. | [[concepts/risk/liquidation]] | A6-PIV |
| #c5 | Forced liquidation occurs when Mark Price reaches the liquidation price. | [[concepts/risk/liquidation]] | - |
| #c6 | Aster uses Mark Price for liquidation triggers to minimize impact of price manipulation. | [[concepts/risk/liquidation]] | - |
| #c7 | In cross-margin mode with hedge trading, both long and short positions of the same contract share the same liquidation price. | [[concepts/risk/liquidation]] | A6-PIV |
| #c8 | In isolated margin mode, long and short positions have separate liquidation prices based on margin allocated to each. | [[concepts/risk/liquidation]] | A6-PIV |
| #c9 | Liquidation step 1: all open orders tied to the affected account are immediately canceled. | [[concepts/risk/liquidation]] | - |
| #c10 | Liquidation step 2: the system issues one large Immediate-or-Cancel (IOC) order; unfilled portions are canceled. | [[concepts/risk/liquidation]] | A6-PIV |
| #c11 | Liquidation step 3: after the IOC, the engine rechecks margin accounting for realized losses and the liquidation fee; if maintenance is restored, liquidation stops. | [[concepts/risk/liquidation]] | A6-PIV |
| #c12 | Liquidation step 4: leftover bankrupt portion is closed at the bankruptcy price and transferred to the Insurance Fund. | [[concepts/risk/liquidation]] | A6-PIV |
| #c13 | Liquidation step 5: if insurance fund cannot fully cover losses, Auto-Deleveraging (ADL) may be triggered. | [[concepts/risk/adl-waterfall]] | - |
| #c14 | Smart Liquidation principle: protocol prioritizes partial close via IOC to avoid full forced close when possible. | [[concepts/risk/liquidation]] | A6-PIV |
| #c15 | Bankruptcy price is the protocol price used to finalize the bankrupt portion. | [[concepts/risk/liquidation]] | - |
| #c16 | Profits or remaining assets from handling bankrupt positions are retained by the insurance fund. | [[concepts/risk/liquidation]] | A6-PIV |
| #c17 | Larger positions may receive more gradual, tiered liquidation treatment that helps avoid immediate full liquidation. | [[concepts/risk/margin-tier]] | A6-PIV |
| #c18 | Smaller positions often have less buffer and are more likely to be liquidated fully. | [[concepts/risk/margin-tier]] | A6-PIV |
| #c19 | Liquidation involves realized loss plus a liquidation fee. | [[concepts/risk/liquidation]] | - |
| #c20 | A portion of the liquidation fee is allocated to the insurance fund (shown as "Insurance clear" in transaction history). | [[parameters/aster/revenue-distribution]] | A2-PI, A6-PIV |
| #c21 | Liquidation fee is calculated based on the applicable liquidation fee rate and notional value of the liquidated position. | [[concepts/risk/liquidation]] | A6-PIV |
| #c22 | Negative-balance auto-cover requires the negative balance to be in a USDT perpetual account. | [[concepts/risk/liquidation]] | A6-PIV |
| #c23 | Negative-balance auto-cover requires the account to have no open positions (cross or isolated margin). | [[concepts/risk/liquidation]] | A6-PIV |
| #c24 | Negative-balance auto-cover requires the negative balance not to exceed 5,000 USDT. | [[concepts/risk/liquidation]] | A6-PIV |
| #c25 | Negative-balance auto-cover requires that no funds have been transferred into the account after liquidation to offset the loss. | [[concepts/risk/liquidation]] | A6-PIV |
| #c26 | Liquidation price is dynamic and changes with funding payments, collateral value fluctuations, new positions, and cross-margin effects. | [[concepts/risk/liquidation]] | - |
| #c27 | Aster uses cross margin by default. | [[concepts/risk/liquidation]] | A6-PIV |
| #c28 | In cross margin, all collateral and unrealized PnL from other positions support open trades, but all positions share the same risk pool. | [[concepts/risk/liquidation]] | - |
| #c29 | Bankruptcy prices may fall outside the contract's current market range. | [[concepts/risk/liquidation]] | - |
| #c30 | After liquidation, the system uses collateral to cover losses; remaining collateral stays in the account. | [[concepts/risk/liquidation]] | - |
| #c31 | If losses exceed collateral, insurance funds or protocol buffers cover the difference. | [[concepts/risk/liquidation]] | - |
