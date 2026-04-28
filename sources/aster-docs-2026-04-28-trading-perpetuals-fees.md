---
type: source
id: aster-docs-2026-04-28-trading-perpetuals-fees
title: Fees
publisher: Aster Docs
author: Aster team
date: null
original_url: https://docs.asterdex.com/trading/perpetuals/fees-and-specs/fees
mirror_snapshot: aster-docs-2026-04-28
mirror_page: pages/trading-perpetuals-fees.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Fees

## TL;DR
Aster's published Perps fee schedule is split by quote asset: USDT-perps charge 0% maker / 0.04% taker, while USD1-perps charge 0% maker / 0.005% taker — making USD1 perps an order of magnitude cheaper on the taker side. Paying fees with $ASTER (deposited into the perp wallet, or transferred from spot) yields a flat 5% discount that auto-applies. Fees are computed on nominal value (contracts × transaction price). The page contradicts the Perps overview page (which advertises 0.01% maker / 0.035% taker), suggesting the overview is marketing language while this page reflects the actual rate card.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | USDT-perpetual contracts charge a 0% maker fee. | [[parameters/aster/fee-schedule]] | A2-PI |
| #c2 | USDT-perpetual contracts charge a 0.04% taker fee. | [[parameters/aster/fee-schedule]] | A2-PI |
| #c3 | USD1-perpetual contracts charge a 0% maker fee. | [[parameters/aster/fee-schedule]] | A2-PI |
| #c4 | USD1-perpetual contracts charge a 0.005% taker fee. | [[parameters/aster/fee-schedule]] | A2-PI |
| #c5 | Paying fees with $ASTER yields a flat 5% discount on perp trading fees. | [[parameters/aster/fee-schedule]], [[entities/token/aster]] | A2-PIV |
| #c6 | The 5% $ASTER discount is applied by depositing $ASTER into the perp wallet and is used automatically to cover fees. | [[parameters/aster/fee-schedule]], [[entities/token/aster]] | A2-PIV |
| #c7 | Users can transfer $ASTER from spot account to perpetual account to apply the 5% fee discount. | [[parameters/aster/fee-schedule]], [[entities/token/aster]] | A2-PIV |
| #c8 | Transaction fees are based on nominal value of the order (total value of position opened or closed). | [[parameters/aster/fee-schedule]] | - |
| #c9 | Transaction fee formula: Transaction fee = Nominal value × Fee rate. | [[parameters/aster/fee-schedule]] | - |
| #c10 | Nominal value formula: Number of contracts × Transaction price. | [[parameters/aster/fee-schedule]] | - |
| #c11 | Each contract typically represents a unit of the base asset (e.g., 1 BTC in BTCUSDT contracts). | [[parameters/aster/fee-schedule]] | - |
| #c12 | A maker order adds liquidity to the order book and is not filled immediately. | [[parameters/aster/fee-schedule]] | - |
| #c13 | A taker order removes liquidity by trading immediately against an existing maker order. | [[parameters/aster/fee-schedule]] | - |
