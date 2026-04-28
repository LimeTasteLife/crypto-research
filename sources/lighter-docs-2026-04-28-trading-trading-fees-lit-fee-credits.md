---
type: source
id: lighter-docs-2026-04-28-trading-trading-fees-lit-fee-credits
title: LIT Fee Credits
publisher: Lighter Docs
author: Lighter team
date: null
original_url: https://docs.lighter.xyz/trading/trading-fees/lit-fee-credits
mirror_snapshot: lighter-docs-2026-04-28
mirror_page: pages/trading-trading-fees-lit-fee-credits.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# LIT Fee Credits

## TL;DR
LIT Fee Credits is a paid shortcut to Premium Account staking tiers — instead of locking the full staked LIT amount required for a higher discount, users buy time-bounded "credits" that count toward a chosen fee/latency tier. The example in docs is concrete: 100,000 LIT staked + 200,000 LIT-equivalent in Fee Credits qualifies for the next staking tier. Activation requires acquiring LIT, navigating to the Staking page → LIT Fee Credits, choosing credit amount and duration, and confirming via L1 signature with upfront LIT payment. Notable mechanism: 100% of Fee Credits proceeds are streamed to LIT stakers as daily rewards across the credit duration — making this a direct user-pays-staker yield routing on top of the buyback channel. The page does not specify the exchange rate of LIT-staked-equivalent to Fee Credits or duration bounds, leaving them as gaps to source from app UI.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | The LIT Fee Credits program supports market participants making use of Premium Accounts that have not yet committed to staking. | [[parameters/lighter/fee-schedule]] | A2-PIV |
| #c2 | Instead of staking the full amount required for a higher discount tier, users can buy LIT Fee Credits that count toward a desired fee and latency tier. | [[parameters/lighter/fee-schedule]] | A2-PIV |
| #c3 | A participant with 100,000 LIT staked may use an additional 200,000 staked LIT via LIT Fee Credits to qualify for the next staking tier. | [[parameters/lighter/fee-schedule]] | A2-PIV |
| #c4 | Participants must acquire LIT if they do not already hold it before purchasing LIT Fee Credits. | [[parameters/lighter/fee-schedule]] | A2-PIV |
| #c5 | LIT Fee Credits are configured by selecting a credit amount and duration on the Lighter Staking page. | [[parameters/lighter/fee-schedule]] | A2-PIV |
| #c6 | The credit amount and duration determine the applicable trading tier under LIT Fee Credits. | [[parameters/lighter/fee-schedule]] | A2-PIV |
| #c7 | LIT Fee Credit tiers activate upon confirming an L1 signature and completing the upfront LIT payment. | [[parameters/lighter/fee-schedule]] | A2-PIV |
| #c8 | All proceeds from the LIT Fee Credits program are distributed to LIT stakers. | [[entities/token/lit]], [[concepts/tokenomics/fee-distribution]] | A2-PI |
| #c9 | The upfront LIT Fee Credits fee is streamed as daily rewards over the full duration of the access period. | [[entities/token/lit]] | A2-PI |

## Conflicts raised
- (none)
