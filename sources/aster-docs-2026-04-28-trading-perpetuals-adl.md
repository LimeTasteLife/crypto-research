---
type: source
id: aster-docs-2026-04-28-trading-perpetuals-adl
title: Auto-Deleveraging (ADL)
publisher: Aster Docs
author: Aster team
date: null
original_url: https://docs.asterdex.com/trading/perpetuals/fees-and-specs/auto-deleveraging-adl
mirror_snapshot: aster-docs-2026-04-28
mirror_page: pages/trading-perpetuals-adl.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Auto-Deleveraging (ADL)

## TL;DR
ADL is Aster's last-resort risk mechanism, triggered only when liquidation cannot complete before mark hits the bankruptcy price and the insurance fund cannot absorb the loss. Counterparties are ranked by a Leverage PnL quantile = (PnL percent × Margin ratio), where PnL percent = max(0, Unrealized profit) / max(1, Wallet balance) and Margin ratio = Maintenance margin / (Wallet balance + Unrealized profit). The most profitable + most highly leveraged opposing positions are reduced first, without warning. The Pro UI exposes a 4-bar LeveragePnLQuantile indicator, and traders can reset their queue position by closing and reopening their position. ADL primarily affects high-leverage holders with large unrealized profits.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | ADL is a risk management mechanism that activates during extreme market conditions. | [[concepts/risk/adl-waterfall]] | - |
| #c2 | ADL is used only when other protective systems (liquidation, insurance fund) cannot cover losses in time. | [[concepts/risk/adl-waterfall]] | - |
| #c3 | ADL triggers when liquidation cannot be completed before the Mark Price hits the bankruptcy price. | [[concepts/risk/adl-waterfall]] | A6-PIV |
| #c4 | ADL forcibly reduces opposite-side positions held by other traders, starting with most profitable and most highly leveraged. | [[concepts/risk/adl-waterfall]] | - |
| #c5 | ADL ranking metric "PnL percent" = max(0, Unrealized profit) ÷ max(1, Wallet balance). | [[concepts/risk/adl-waterfall]] | A6-PIV |
| #c6 | ADL ranking "Margin ratio" = Maintenance margin ÷ (Wallet balance + Unrealized profit) when (Wallet balance + Unrealized profit) > 0. | [[concepts/risk/adl-waterfall]] | A6-PIV |
| #c7 | ADL Margin ratio = 0 when (Wallet balance + Unrealized profit) ≤ 0. | [[concepts/risk/adl-waterfall]] | A6-PIV |
| #c8 | ADL "Leverage PnL" = PnL percent × Margin ratio. | [[concepts/risk/adl-waterfall]] | A6-PIV |
| #c9 | ADL "Leverage PnL quantile" = User's leverage PnL rank ÷ Total number of users. | [[concepts/risk/adl-waterfall]] | A6-PIV |
| #c10 | Higher Leverage PnL quantile means higher ADL risk. | [[concepts/risk/adl-waterfall]] | - |
| #c11 | The LeveragePnLQuantile bar indicator displays risk of being auto-deleveraged with up to 4 bars. | [[concepts/risk/adl-waterfall]] | A6-PIV |
| #c12 | 4 bars on the LeveragePnLQuantile indicator means high ADL risk. | [[concepts/risk/adl-waterfall]] | A6-PIV |
| #c13 | Fewer bars on the LeveragePnLQuantile indicator means lower ADL risk. | [[concepts/risk/adl-waterfall]] | - |
| #c14 | The LeveragePnLQuantile bar is shown in the Aster Pro interface. | [[entities/perpdex/aster]] | - |
| #c15 | A trader can reduce ADL risk by lowering leverage. | [[concepts/risk/adl-waterfall]] | - |
| #c16 | A trader can reduce ADL risk by closing and reopening their position to reset queue priority. | [[concepts/risk/adl-waterfall]] | A6-PIV |
| #c17 | ADL reduces a position partially or fully without warning to the trader. | [[concepts/risk/adl-waterfall]] | - |
| #c18 | A trader can re-enter the market at any time after being ADL'd. | [[concepts/risk/adl-waterfall]] | - |
| #c19 | The bankruptcy price might fall outside the current trading range, making it harder to fully close before losses exceed margin. | [[concepts/risk/adl-waterfall]] | - |
| #c20 | ADL mostly affects traders with high leverage and large unrealized profits. | [[concepts/risk/adl-waterfall]] | - |
