---
type: source
id: lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies
title: LLP Strategies
publisher: Lighter Docs
author: Lighter team
date: null
original_url: https://docs.lighter.xyz/trading/liquidations-and-llp-insurance-fund/llp-strategies
mirror_snapshot: lighter-docs-2026-04-28
mirror_page: pages/trading-liquidations-and-llp-insurance-fund-llp-strategies.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# LLP Strategies

## TL;DR
LLP funds sit in a single account that is the counterparty to all LLP trading and liquidations. ADL events are fully backstopped by LLP — LPs absorb the residual risk. LLP Strategies allow collateral to be allocated across distinct strategy buckets (Crypto Perps, FX, Equities/RWAs); each market is mapped to one strategy. Strategies behave like segregated collateral shards (sub-account-like for risk purposes) but remain inside the single LLP account; risk and losses are isolated at the strategy level. If a strategy's allocated collateral is fully depleted, only that strategy is subject to ADL — other strategies are unaffected. RWA perps are now subject to standard liquidation fees because LLP is the primary protocol LP for RWAs.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | LLP funds are held within a single account, which acts as the counterparty to all LLP trading and liquidations. | [[parameters/lighter/llp]], [[parameters/lighter/insurance-fund]] | A4-PI |
| #c2 | Under the existing LLP structure, ADL events are fully backstopped by LLP — liquidity providers absorb the associated risk. | [[parameters/lighter/llp]], [[concepts/risk/adl-waterfall]] | A4-PIII, A6-PI |
| #c3 | LLP Strategies allow collateral to be allocated across distinct strategy buckets, including RWAs. | [[parameters/lighter/llp]] | A4-PI |
| #c4 | Each market is assigned to a specific LLP strategy. | [[parameters/lighter/llp]] | A4-PI |
| #c5 | From a system perspective, each strategy behaves similarly to a segregated collateral shard (comparable to a sub-account for risk purposes). | [[parameters/lighter/llp]], [[concepts/risk/insurance-fund-sizing]] | A4-PIV, A6-PI |
| #c6 | Strategies are not separate accounts — all positions remain under the LLP — but risk and losses are isolated at the strategy level. | [[parameters/lighter/llp]] | A4-PI |
| #c7 | Example LLP strategy split: one strategy for Crypto Perpetuals, one for FX, one for Equities/RWAs. | [[parameters/lighter/llp]] | A4-PI |
| #c8 | If a strategy has $1M in allocated collateral, its maximum loss exposure is limited to that $1M; if depleted, that strategy alone becomes subject to ADL. | [[parameters/lighter/llp]], [[concepts/risk/insurance-fund-sizing]] | A6-PI |
| #c9 | Collateral allocated to other strategies remains unaffected when one strategy is depleted. | [[parameters/lighter/llp]] | A4-PI, A6-PI |
| #c10 | Exact market-to-strategy mappings are communicated separately (not in the docs page). | [[parameters/lighter/llp]] | A7-PI |
| #c11 | RWA perpetual markets are now subject to standard liquidation fees, consistent with all other markets, as LLP serves as the primary protocol liquidity provider for RWAs. | [[parameters/lighter/fee-schedule]], [[parameters/lighter/llp]] | A2-PI, A4-PI |

## Conflicts raised
- #c11 vs `lighter-docs-2026-04-28-trading-prelaunch-markets`#c6 (prelaunch markets have no liquidation fee). Consistent — prelaunch and RWA fee treatments are different and explicitly stated; not a contradiction.
