---
type: source
id: drift-docs-2026-04-28-protocol-trading-trading-fees
title: Trading Fees
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/protocol/trading/trading-fees
mirror_snapshot: drift-docs-2026-04-28
mirror_page: pages/protocol-trading-trading-fees.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Trading Fees

## TL;DR
Drift's perp fee schedule is two-dimensional: a 30-day-volume tier (1: ≤$2M Rookie/$2M up Champion … through Tier 6: VIP >$200M) crossed with a DRIFT-staking tier (Rookie 0; Kickstarter 1k; Racer 10k; Elite 50k; Master 100k; Champion 250k DRIFT). Volume Tier 1 Rookie taker = 0.0350% / maker rebate −0.0025%; Tier 6 VIP Master taker = 0.0140% / maker rebate −0.0033%. DRIFT staking adds taker discount (5% → 40%) and stacking maker rebate boost (5% → 40%). Fees are on filled notional, charged in USDC. High Leverage Mode doubles the bottom-tier taker fee. Referee discount + referrer reward applied on the effective taker fee. Filler reward up to 10% of effective taker fee. Fee-Adjusted Markets allow per-market increases or flat discounts. Spot fee table renders client-side and was a "Loading…" placeholder at crawl.

## Claims extracted

## Source confidence

The Spot Market Fees table on this page rendered client-side via JavaScript and appeared as "Loading…" to the crawler. Spot fee values are NOT extracted from this snapshot. Re-crawl with a headless browser is needed for exact spot taker/maker/referrer-reward/filler-reward values.

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Drift fees are calculated per trade based on filled notional position size, charged in the market's quote asset (USDC). | [[parameters/drift/fee-schedule]] | A2-PI |
| #c2 | Drift's perp fees are tiered on an on-chain calculation of 30-Day Volume. | [[parameters/drift/fee-schedule]] | A2-PI |
| #c3 | Volume tiers and example Rookie taker / maker rebate per tier (perp): Tier 1 (≤$2M) 0.0350% / −0.0025%; Tier 2 (>$2M) 0.0300% / −0.0025%; Tier 3 (>$10M) 0.0275% / −0.0025%; Tier 4 (>$20M) 0.0250% / −0.0025%; Tier 5 (>$80M) 0.0225% / −0.0025%; VIP (>$200M) 0.0200% / −0.0025%. | [[parameters/drift/fee-schedule]] | A2-PI |
| #c4 | DRIFT staking tiers and benefits: Rookie (0 staked) 0% / 0%; Kickstarter (1,000) −5% taker / +5% maker; Racer (10,000) −10% / +10%; Elite (50,000) −20% / +20%; Master (100,000) −30% / +30%; Champion (250,000) −40% / +40%. | [[parameters/drift/fee-schedule]], [[entities/token/drift]] | A2-PIV |
| #c5 | DRIFT staking fee benefits stack on top of the volume tier and apply to perp fees only. | [[parameters/drift/fee-schedule]] | A2-PIV |
| #c6 | Worked example: a Tier 3 taker (0.0275%) with 20% staking discount pays 0.022% effective fee. | [[parameters/drift/fee-schedule]] | A2-PIV |
| #c7 | Worked example: a maker (-0.0025% rebate) with 20% staking gets a -0.003% rebate. | [[parameters/drift/fee-schedule]] | A2-PIV |
| #c8 | If a user has High Leverage Mode turned on, taker trading fees for all perp markets are 2x the bottom fee tier. | [[parameters/drift/fee-schedule]] | A2-PI, A6-PI |
| #c9 | Referee Discount and Referrer Reward percentages are applied on top of the effective taker fee paid. | [[parameters/drift/fee-schedule]] | A3-PI |
| #c10 | Filler rewards are variable, up to 10% of the effective taker fee paid by the user. | [[parameters/drift/fee-schedule]] | A4-PV |
| #c11 | Longer-tail assets can have increased fees; some markets periodically have flat discounts applied to all fee tiers (Fee-Adjusted Markets). | [[parameters/drift/fee-schedule]] | A2-PI |
| #c12 | Drift Protocol reserves the right to end the promotional period and the Taker Incentive Program at any time, without required notice. | [[parameters/drift/fee-schedule]] | A2-PII |
| #c13 | If a user holds only non-USDC assets, a USDC borrow may be triggered upon settlement of a loss in perpetual markets. | [[concepts/risk/liquidation]] | A6-PI |
