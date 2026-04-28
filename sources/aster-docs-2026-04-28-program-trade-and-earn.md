---
type: source
id: aster-docs-2026-04-28-program-trade-and-earn
title: Trade & Earn
publisher: Aster Docs
author: Aster team
date: null
original_url: https://docs.asterdex.com/program-and-rewards/trade-and-earn
mirror_snapshot: aster-docs-2026-04-28
mirror_page: pages/program-trade-and-earn.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Trade & Earn

## TL;DR
Trade & Earn pays additional yield for using Aster's yield-bearing assets (USDF, asBNB) as perp trading collateral via Multi-Asset Mode. Collateral value ratios: USDF 99.99%, asBNB 95%. Eligibility: trader must be active ≥2 days/week with weekly volume ≥50,000 USD (raised from prior threshold on Nov 20, 2025). USDF rewards have two streams: Deposit Rewards (hold >1 USDF; calculated hourly off snapshot) and Trading Rewards (volume threshold + USDF holdings, capped at 100,000 USDF per account since Sept 4, 2025). Reward weeks run Thursday → following Wednesday; payouts distributed in USDF within 7 business days. asBNB yield comes from BNB Launchpools (auto-reflected in exchange rate), HODLer airdrops, and Megadrops (manual claim). Wash trading and bulk-account farming trigger disqualification. The structure incentivizes "double-utility" margin and creates measurable toxic-flow / wash-trading exposure.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Trade & Earn rewards users for using USDF and asBNB as margin in Aster perp trades. | [[entities/programme/aster-trade-and-earn]], [[parameters/programmes/aster-trade-and-earn]] | A3-PI |
| #c2 | Collateral continues earning passive yield while being used as trading margin (no opportunity cost separation). | [[parameters/programmes/aster-trade-and-earn]] | A3-PI |
| #c3 | asBNB is Aster's liquid staking token, minted by staking BNB or slisBNB. | [[entities/perpdex/aster]] | A5-PI |
| #c4 | asBNB has a 95% collateral value ratio when used as trading collateral. | [[parameters/programmes/aster-trade-and-earn]] | A3-PI |
| #c5 | asBNB yield sources include BNB Launchpools, HODLer airdrops, and Megadrops. | [[parameters/programmes/aster-trade-and-earn]] | A3-PI |
| #c6 | Launchpool rewards are reflected directly in the asBNB exchange rate (no manual claim). | [[parameters/programmes/aster-trade-and-earn]] | A3-PIV |
| #c7 | HODLer airdrops require manual claiming within the platform. | [[parameters/programmes/aster-trade-and-earn]] | A3-PIV |
| #c8 | Megadrops require manual claiming within the platform. | [[parameters/programmes/aster-trade-and-earn]] | A3-PIV |
| #c9 | USDF is fully backed and redeemable 1:1 with USDT. | [[entities/token/usdf]] | A6-PI |
| #c10 | USDF has a 99.99% collateral value ratio when used as trading collateral. | [[parameters/programmes/aster-trade-and-earn]] | A3-PI |
| #c11 | USDF Deposit Rewards: holders with >1 USDF in their trading account earn rewards calculated hourly off a holdings snapshot, distributed proportionally. | [[parameters/programmes/aster-trade-and-earn]] | A3-PI |
| #c12 | USDF Trading Rewards: requires being active at least 2 days per week with minimum weekly volume of 50,000 USDT. | [[parameters/programmes/aster-trade-and-earn]] | A3-PIII |
| #c13 | The maximum USDF holdings counted toward Trade & Earn reward calculations is capped at 100,000 USDF per account. | [[parameters/programmes/aster-trade-and-earn]] | A3-PIV |
| #c14 | The 100,000 USDF per-account cap took effect on September 4, 2025. | [[parameters/programmes/aster-trade-and-earn]] | A3-PV |
| #c15 | The weekly trading volume requirement was raised to 50,000 USD effective November 20, 2025. | [[parameters/programmes/aster-trade-and-earn]] | A3-PV |
| #c16 | USDF reward weeks are calculated Thursday to the following Wednesday. | [[parameters/programmes/aster-trade-and-earn]] | A3-PIV |
| #c17 | Rewards are distributed within seven business days after each week ends. | [[parameters/programmes/aster-trade-and-earn]] | A3-PIV |
| #c18 | Rewards are paid in USDF directly to the user's Futures account. | [[parameters/programmes/aster-trade-and-earn]] | A3-PIV |
| #c19 | Multi-Asset Mode must be enabled in Settings before USDF or asBNB can be used as collateral. | [[parameters/programmes/aster-trade-and-earn]] | - |
| #c20 | Users can swap USDT or BNB/slisBNB to USDF or asBNB inside the trading account UI. | [[entities/perpdex/aster]] | - |
| #c21 | Wash trading is grounds for disqualification from the program. | [[parameters/programmes/aster-trade-and-earn]] | A3-PIII |
| #c22 | Market manipulation is grounds for disqualification from the program. | [[parameters/programmes/aster-trade-and-earn]] | A3-PIII |
| #c23 | Bulk account creation for bonus farming results in disqualification. | [[parameters/programmes/aster-trade-and-earn]] | A3-PIII |
| #c24 | All program rules may be amended or cancelled at Aster's discretion. | [[parameters/programmes/aster-trade-and-earn]] | A3-PV, A7-PV |
| #c25 | Aster disclaims liability for trading losses and frames Trade & Earn output as not financial advice. | [[parameters/programmes/aster-trade-and-earn]] | A9-PI |
| #c26 | The combination of trade-volume threshold + collateral cap creates measurable wash-trading exposure (volume gating + reward cap incentivize cross-account farming). | [[parameters/programmes/aster-trade-and-earn]] | A3-PIII |
