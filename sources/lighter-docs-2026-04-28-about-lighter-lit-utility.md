---
type: source
id: lighter-docs-2026-04-28-about-lighter-lit-utility
title: LIT Utility
publisher: Lighter Docs
author: Lighter team
date: null
original_url: https://docs.lighter.xyz/about-lighter/lit-utility
mirror_snapshot: lighter-docs-2026-04-28
mirror_page: pages/about-lighter-lit-utility.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# LIT Utility

## TL;DR
LIT is the Lighter native token; staking unlocks two active programs — LLP access (gated 1 LIT staked → up to 10 USDC LLP capacity) and staking APR. Unstaking is subject to a 3-day lockup. Staking yield is currently bootstrapped via company funds and pre-TGE revenue, with LIT bought from a specific funding wallet (`0x5E52...FC91`); the docs hint at a forthcoming benefit-transfer market where users sell their staking-derived discount rights to others, with proceeds streamed back to LIT stakers. Buybacks of LIT are funded by trading fee revenue and executed as daily 24h TWAPs (with shorter timeframes possible). The treasury account that conducts these buybacks is listed as the Ethereum zero address `0x0000...0000` — distinctive (and worth flagging) because that address would normally indicate a burn rather than a buyback wallet.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | The LIT Staking Pool (https://app.lighter.xyz/staking) is designed to align long-term participants with the core economics of the Lighter protocol. | [[entities/token/lit]] | A2-PIV |
| #c2 | Staking LIT grants participants access to platform benefits aligned with how they interact with the Lighter exchange. | [[entities/token/lit]] | A2-PIV |
| #c3 | Unstaking LIT is subject to a 3-day lockup period. | [[entities/token/lit]] | A2-PIV |
| #c4 | The currently active LIT staking programs are LLP Access and Staking APR. | [[entities/token/lit]] | A2-PIV |
| #c5 | The Lighter Liquidity Pool (LLP) is exclusively accessible to LIT stakers. | [[parameters/lighter/llp]] | A6-PII |
| #c6 | For every 1 LIT staked, participants may deposit up to 10 USDC into the LLP. | [[parameters/lighter/llp]] | A6-PII |
| #c7 | Staking participants currently earn APR through staking rewards. | [[entities/token/lit]] | A2-PIV |
| #c8 | In the short term, Lighter is bootstrapping LIT staking yield using company funds and pre-TGE revenue. | [[entities/token/lit]] | A2-PIV |
| #c9 | LIT used to fund staking rewards is bought from the address 0x5E52363E65C99fefC0E356F0DC6c37b75bf8FC91. | [[entities/token/lit]] | A2-PIV |
| #c10 | A forthcoming feature will allow staking participants who do not use certain staking benefits (such as trading fee discounts) to transfer those benefits to others, with upfront payments distributed to LIT stakers as yield. | [[entities/token/lit]] | A2-PIV, A3-PIV |
| #c11 | LIT is bought back by the Lighter protocol using trading fee revenue. | [[entities/token/lit]], [[concepts/tokenomics/buyback]] | A2-PI |
| #c12 | LIT buybacks are executed via daily 24-hour TWAPs, with the flexibility to use shorter timeframes depending on market conditions. | [[entities/token/lit]], [[concepts/tokenomics/buyback]] | A2-PI |
| #c13 | The treasury account that conducts LIT buybacks is 0x0000000000000000000000000000000000000000. | [[entities/token/lit]] | A2-PI |

## Conflicts raised
- (none)
