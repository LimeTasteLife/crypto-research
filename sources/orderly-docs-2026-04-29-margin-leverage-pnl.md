---
type: source
id: orderly-docs-2026-04-29-margin-leverage-pnl
title: Margin, Leverage & PnL
publisher: Orderly Network Docs
author: Orderly team
date: 2026-04-29
original_url: https://orderly.network/docs/introduction/trade-on-orderly/perpetual-futures/margin-leverage-and-pnl
mirror_snapshot: orderly-docs-2026-04-29
mirror_page: pages/margin-leverage-pnl.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Margin, Leverage & PnL

## TL;DR
Defines Orderly's margin system: IMR uses a position-size-dependent formula with a 4/5 power scaling (IMR Factor), and MMR scales proportionally with a Base MMR / Base IMR ratio. Max leverage = 1 / Base IMR (e.g., 1% = 100x). Published margin parameters span BTC/ETH (100x), SOL (100x), SUI/HYPE (20x), ARB/ORDER (10x), RWA perps SPX500/NAS100/XAU/GOOGL/TSLA/NVDA (20x), and IP (5x). Max notional: $5M for BTC/ETH, $2M for alts. 90+ perpetual markets listed across crypto and RWA.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | IMR formula: IMR_i = Max(1/Max Account Leverage, Base IMR_i, IMR Factor_i * Abs(Position Notional_i)^(4/5)) | [[parameters/orderly/margin-tiers]] | A6-PI |
| #c2 | MMR formula: MMR_i = Max(Base MMR_i, Base MMR_i / Base IMR_i * IMR Factor_i * Abs(Position Notional_i)^(4/5)) | [[parameters/orderly/margin-tiers]] | A6-PI |
| #c3 | Max leverage = 1 / Base IMR (e.g., Base IMR 1% = 100x leverage) | [[concepts/risk/leverage-cap]] | A6-PI |
| #c4 | BTC-PERP: Base IMR 1% (100x), Base MMR 0.6%, IMR Factor 0.0000000910 | [[parameters/orderly/margin-tiers]] | A6-PI |
| #c5 | ETH-PERP: Base IMR 1% (100x), Base MMR 0.6%, IMR Factor 0.0000001724 | [[parameters/orderly/margin-tiers]] | A6-PI |
| #c6 | SOL-PERP: Base IMR 1% (100x), Base MMR 0.6%, IMR Factor 0.0000010667 | [[parameters/orderly/margin-tiers]] | A6-PI |
| #c7 | SUI-PERP, HYPE-PERP: Base IMR 5% (20x), Base MMR 2.5%, IMR Factor 0.0000028100 | [[parameters/orderly/margin-tiers]] | A6-PI |
| #c8 | ARB-PERP, ORDER-PERP: Base IMR 10% (10x), Base MMR 5% | [[parameters/orderly/margin-tiers]] | A6-PI |
| #c9 | RWA perps (SPX500, NAS100, XAU, GOOGL, TSLA, NVDA): Base IMR 5% (20x), Base MMR 2.5%, IMR Factor ~0 | [[parameters/orderly/margin-tiers]] | A6-PI |
| #c10 | IP-PERP: Base IMR 20% (5x), Base MMR 10% | [[parameters/orderly/margin-tiers]] | A6-PI |
| #c11 | 90+ perpetual markets listed across crypto and RWA categories | [[entities/perpdex/orderly]] | A1-PI |
| #c12 | Max notional: BTC $5M, ETH $5M, Alts $2M | [[parameters/orderly/margin-tiers]] | A6-PI |
| #c13 | Account Margin Ratio = Total Collateral Value / Sum(Abs(Position Notional_i)); default 1000% with no positions | [[concepts/risk/margin-tier]] | - |

## Conflicts raised
None.
