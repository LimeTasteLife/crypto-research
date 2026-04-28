---
type: source
id: lighter-docs-2026-04-28-trading-trading-fees
title: Trading Fees
publisher: Lighter Docs
author: Lighter team
date: null
original_url: https://docs.lighter.xyz/trading/trading-fees
mirror_snapshot: lighter-docs-2026-04-28
mirror_page: pages/trading-trading-fees.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Trading Fees

## TL;DR
Lighter operates a two-track fee model. The default Standard Account is fee-free for all participants on both perps and spot, but trades through a deliberately throttled latency stack — 300 ms taker, 200 ms maker, 200 ms cancel. Premium Accounts (opt-in) are charged maker/taker fees that start at 0.0040% / 0.0280% with 200 ms taker latency, and unlock both fee discounts and latency improvements via LIT staking on a flat 8-tier ladder ranging 1k → 500k staked LIT, capping at 30% discount and 140 ms taker latency. Crucially, Premium Accounts have no added latency on cancels or post-only placements, which is the latency edge market makers actually optimize for. Staking is L1-address aggregated: a master and all its sub-accounts share one tier based on combined stake, and the team supports both an address-list registration channel and a planned in-app wallet linker for fee-discount purposes.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | For both perpetual futures and spot markets, Lighter charges no maker or taker fees for Standard Accounts. | [[parameters/lighter/fee-schedule]] | A2-PI |
| #c2 | Standard Accounts can trade across all Lighter markets free of charge. | [[parameters/lighter/fee-schedule]] | A2-PI |
| #c3 | Premium Accounts on Lighter are subject to maker and taker fees. | [[parameters/lighter/fee-schedule]] | A2-PI |
| #c4 | Premium Accounts on Lighter can receive fee discounts by staking LIT. | [[parameters/lighter/fee-schedule]] | A2-PIV |
| #c5 | Standard Account taker latency is 300 ms. | [[parameters/lighter/fee-schedule]] | A2-PIII, A4-PI |
| #c6 | Standard Account maker latency is 200 ms. | [[parameters/lighter/fee-schedule]] | A2-PIII, A4-PI |
| #c7 | Standard Account cancel latency is 200 ms. | [[parameters/lighter/fee-schedule]] | A2-PIII, A4-PI |
| #c8 | For Premium Accounts, all order cancelations and Post-Only order placements are not subject to any additional latency. | [[parameters/lighter/fee-schedule]] | A2-PIII, A4-PI |
| #c9 | Premium Account base tier (0 LIT staked) maker fee is 0.0040%, taker fee is 0.0280%, and taker latency is 200 ms. | [[parameters/lighter/fee-schedule]] | A2-PI |
| #c10 | Premium Account tier with 1,000 LIT staked has a 2.5% maker/taker fee discount, 0.0039% maker, 0.0273% taker, 195 ms taker latency, and 2.5% latency improvement. | [[parameters/lighter/fee-schedule]] | A2-PI, A2-PIV |
| #c11 | Premium Account tier with 3,000 LIT staked has a 5% maker/taker fee discount, 0.0038% maker, 0.0266% taker, 190 ms taker latency, and 5% latency improvement. | [[parameters/lighter/fee-schedule]] | A2-PI, A2-PIV |
| #c12 | Premium Account tier with 10,000 LIT staked has a 10% maker/taker fee discount, 0.0036% maker, 0.0252% taker, 180 ms taker latency, and 10% latency improvement. | [[parameters/lighter/fee-schedule]] | A2-PI, A2-PIV |
| #c13 | Premium Account tier with 30,000 LIT staked has a 15% maker/taker fee discount, 0.0034% maker, 0.0238% taker, 170 ms taker latency, and 15% latency improvement. | [[parameters/lighter/fee-schedule]] | A2-PI, A2-PIV |
| #c14 | Premium Account tier with 100,000 LIT staked has a 20% maker/taker fee discount, 0.0032% maker, 0.0224% taker, 160 ms taker latency, and 20% latency improvement. | [[parameters/lighter/fee-schedule]] | A2-PI, A2-PIV |
| #c15 | Premium Account tier with 300,000 LIT staked has a 25% maker/taker fee discount, 0.0030% maker, 0.0210% taker, 150 ms taker latency, and 25% latency improvement. | [[parameters/lighter/fee-schedule]] | A2-PI, A2-PIV |
| #c16 | Premium Account tier with 500,000 LIT staked has a 30% maker/taker fee discount, 0.0028% maker, 0.0196% taker, 140 ms taker latency, and 30% latency improvement. | [[parameters/lighter/fee-schedule]] | A2-PI, A2-PIV |
| #c17 | All Premium Account fees and latency on Lighter are eligible for staking discounts. | [[parameters/lighter/fee-schedule]] | A2-PIV |
| #c18 | LIT staking discounts are applied at the L1 address level, with total staked LIT calculated as the combined stake across the main account and all associated sub-accounts. | [[parameters/lighter/fee-schedule]] | A2-PIV |
| #c19 | The main account and its sub-accounts share the same staking tier, determined by aggregated LIT stake. | [[parameters/lighter/fee-schedule]] | A2-PIV |
| #c20 | Lighter rate limits will be adjusted to allow users to consolidate trading activity through sub-accounts without downside. | [[parameters/lighter/fee-schedule]] | A2-PIV |
| #c21 | Participants may submit a list of addresses to the Lighter team to share a single staking tier across those addresses based on total staked LIT. | [[parameters/lighter/fee-schedule]] | A2-PIV |
| #c22 | Lighter plans to introduce in-app wallet linking for fee-discount purposes. | [[parameters/lighter/fee-schedule]] | A2-PIV |

## Conflicts raised
- (none)
