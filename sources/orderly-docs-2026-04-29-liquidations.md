---
type: source
id: orderly-docs-2026-04-29-liquidations
title: Liquidations
publisher: Orderly Network Docs
author: Orderly team
date: 2026-04-29
original_url: https://orderly.network/docs/introduction/trade-on-orderly/perpetual-futures/liquidations
mirror_snapshot: orderly-docs-2026-04-29
mirror_page: pages/liquidations.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Liquidations

## TL;DR
Liquidation triggers when Account Margin Ratio falls below Maintenance Margin Ratio, evaluated against Mark Price. Orderly uses decentralized liquidation: positions are transferred to liquidators at a discount rather than dumped onto the order book. Two liquidation tiers: Low (BTC/ETH — must take proportional share) and High (others — can take single symbol). Liquidation fees: BTC/ETH/SOL 0.60% (liquidator gets 0.30%), others 1.20% (liquidator gets 0.60%). Fee split varies by remaining margin. If remaining margin is near zero, Insurance Fund absorbs positions.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Liquidation triggers when Account Margin Ratio falls below Maintenance Margin Ratio, evaluated against Mark Price | [[concepts/risk/liquidation]] | A6-PI |
| #c2 | Decentralized liquidation model: positions transferred to liquidators at a discount, not dumped on order book | [[concepts/risk/liquidation]] | A6-PI |
| #c3 | When liquidation triggers: all open orders cancelled and USDC balance frozen | [[concepts/risk/liquidation]] | A6-PI |
| #c4 | Two liquidation tiers: Low (BTC, ETH) — must claim proportional share; High (others) — can claim single symbol | [[parameters/orderly/liquidation-params]] | A6-PI |
| #c5 | Low-tier below 10,000 USDC notional: must take all positions; High-tier below 5,000 USDC notional: must take entire position | [[parameters/orderly/liquidation-params]] | A6-PI |
| #c6 | Liquidation fees: BTC/ETH/SOL 0.60% total (0.30% liquidator), others 1.20% total (0.60% liquidator) | [[parameters/orderly/liquidation-params]] | A6-PI |
| #c7 | Fee split: plenty of margin → 50/50 IF and liquidator; low margin → liquidator gets 0.5 × User Liquidation Fee, remainder to IF; near zero → entire balance and positions → IF | [[parameters/orderly/liquidation-params]] | A6-PI |
| #c8 | System calculates minimum liquidation amount needed to restore Account Margin Ratio to IMR | [[concepts/risk/liquidation]] | A6-PI |
| #c9 | Anyone with an Orderly account can act as a liquidator with sufficient margin | [[concepts/risk/liquidation]] | A6-PI |

## Conflicts raised
None.
