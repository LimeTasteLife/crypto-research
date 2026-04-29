---
type: source
id: orderly-docs-2026-04-29-funding-rate
title: Funding Rate
publisher: Orderly Network Docs
author: Orderly team
date: 2026-04-29
original_url: https://orderly.network/docs/introduction/trade-on-orderly/perpetual-futures/funding-rate
mirror_snapshot: orderly-docs-2026-04-29
mirror_page: pages/funding-rate.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Funding Rate

## TL;DR
Orderly's funding rate uses a piecewise linear function applied to the average premium before clamping to per-market Cap/Floor values. Premium is sampled every 15 seconds using Impact Bid/Ask derived from 1,000 USDC at max leverage. Three slope regions: 1x (abs < 0.5%), 2x (0.5% ≤ abs < 1.5%), 4x (abs ≥ 1.5%). Interest rate fixed at 0.01% for most markets. Per-market funding intervals: 1h, 4h, or 8h. BTC/ETH cap ±0.30%, SOL ±0.375%, most alts ±2.00%, RWA ±0.30%.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Funding fees are periodically exchanged between long and short position holders to keep futures price aligned with Index Price | [[concepts/fee-model/funding-rate]] | - |
| #c2 | Settlement schedule: 1h (every hour), 4h (00:00/04:00/08:00/12:00/16:00/20:00), 8h (00:00/08:00/16:00) UTC | [[parameters/orderly/funding-config]] | A6-PI |
| #c3 | Premium sampled every 15 seconds: Premium = [Max(0, Impact Bid - I) - Max(0, I - Impact Ask)] / I | [[parameters/orderly/funding-config]] | A6-PI |
| #c4 | Impact Margin Notional = notional available to trade with 1,000 USDC of collateral at max leverage | [[parameters/orderly/funding-config]] | A6-PI |
| #c5 | Piecewise linear funding function: Low region (abs < 0.5%, slope 1x), Medium (0.5% ≤ abs < 1.5%, slope 2x), Large (abs ≥ 1.5%, slope 4x) | [[parameters/orderly/funding-config]] | A6-PI |
| #c6 | Interest rate fixed at 0.01% for most perpetual markets (USDC interest 0.06%, asset interest 0.03%) | [[parameters/orderly/funding-config]] | A6-PI |
| #c7 | Final Funding Rate = clamp[Funding Function(Avg Premium) + clamp(IR - Avg Premium, cap_ir, floor_ir) / (8/N), Cap Funding, Floor Funding] | [[parameters/orderly/funding-config]] | A6-PI |
| #c8 | BTC: 8h interval, cap ±0.30%, IR 0.01% | [[parameters/orderly/funding-config]] | A6-PI |
| #c9 | ETH: 8h interval, cap ±0.30%, IR 0.01% | [[parameters/orderly/funding-config]] | A6-PI |
| #c10 | SOL: 8h interval, cap ±0.375%, IR 0.01% | [[parameters/orderly/funding-config]] | A6-PI |
| #c11 | Most alts: 4h or 8h, cap ±2.00%, IR 0.005-0.01% | [[parameters/orderly/funding-config]] | A6-PI |
| #c12 | RWA (GOOGL, TSLA, NVDA, XAU, XAG, SPX500, NAS100): 4-8h, cap ±0.30%, IR 0.01% | [[parameters/orderly/funding-config]] | A6-PI |
| #c13 | Accrued Funding = Position Size × Mark Price × Funding Rate; positive rate → longs pay shorts | [[concepts/fee-model/funding-rate]] | - |
| #c14 | In extreme conditions, Orderly may adjust Cap/Floor funding parameters | [[parameters/orderly/funding-config]] | A7-PV |

## Conflicts raised
None.
