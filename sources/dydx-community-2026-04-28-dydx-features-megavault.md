---
type: source
id: dydx-community-2026-04-28-dydx-features-megavault
title: MegaVault (Community Docs)
publisher: dYdX Community Docs
author: dYdX community
date: null
original_url: https://docs.dydx.community/dydx/dydx-features/megavault
mirror_snapshot: dydx-community-2026-04-28
mirror_page: pages/dydx-features-megavault.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# MegaVault (Community Docs)

## TL;DR
User-facing MegaVault page: deposits = USDC providing liquidity across markets in exchange for yield. Yield from PnL on vault positions, funding payments, and 50% trading-fee revenue share (community-approved Nov 15, 2024 — adjustable by governance). MegaVault has no general lock-up except for instant market listings. APR formula: `(30d PnL / current TVL) × (365/30)`. MegaVault uses cross-margined funds. Operator: Greave (elected Nov 21, 2024). Slippage scenarios: 0% slip at no positions; 4.9-35.5% at medium leverage; 100% (full loss) at high (8x) leverage in worst case. US/Canada/prohibited-jurisdiction users excluded.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | MegaVault enables dYdX users to add USDC to provide liquidity to various markets and earn yield. | [[parameters/dydx-v4/megavault]], [[entities/perpdex/dydx]] | A4-PI |
| #c2 | MegaVault operates multiple sub-vaults; each sub-vault uses users' USDC to run an automated market-making strategy for a given market. | [[parameters/dydx-v4/megavault]] | A4-PI |
| #c3 | Users can add funds to MegaVault at any time and start earning yield immediately. | [[parameters/dydx-v4/megavault]] | A4-PII |
| #c4 | Users can think of adding funds as owning a percentage of the vault's net equity (vault USDC + position values). | [[parameters/dydx-v4/megavault]] | A4-PI |
| #c5 | Users can remove funds from MegaVault at any time after adding them, except in the case of Instant Market Listings (where funds are locked ~30 days). | [[parameters/dydx-v4/megavault]] | A4-PII |
| #c6 | MegaVault yield comes from profit & loss on vault positions, funding rate payments, and 50% trading fee revenue share. | [[parameters/dydx-v4/megavault]] | A4-PI, A2-PI |
| #c7 | The 50% trading-fee revenue share to MegaVault was approved by the dYdX community on November 15, 2024 and can be adjusted by governance anytime. | [[parameters/dydx-v4/megavault]], [[parameters/dydx-v4/revenue-distribution]] | A2-PII, A7-PI |
| #c8 | On November 21, 2024 the dYdX community elected Greave as MegaVault's operator, granting it ability to update parameters. | [[parameters/dydx-v4/megavault]], [[entities/actor/greave]] | A4-PI, A7-PI |
| #c9 | MegaVault APR is calculated as `(30 day PnL / current TVL) × (365/30)`, or for less than 30 days `(total PnL / current TVL) × (365 / number of days for which data was available)`. | [[parameters/dydx-v4/megavault]] | A4-PI |
| #c10 | MegaVault APR will likely decrease as TVL increases because more users share the protocol revenue received by MegaVault. | [[parameters/dydx-v4/megavault]] | A4-PI |
| #c11 | Users can lose money depositing to MegaVault; MegaVault is designed to support the protocol and not maximize returns. | [[parameters/dydx-v4/megavault]] | A4-PI |
| #c12 | MegaVault uses cross-margined funds; depositing increases the user's cross-margin usage if they have any cross-positions open. | [[parameters/dydx-v4/megavault]] | A4-PI, A6-PI |
| #c13 | Users custody their MegaVault position via the private keys associated with their wallet address. | [[parameters/dydx-v4/megavault]] | A4-PI |
| #c14 | US/Canada or any other prohibited-jurisdiction residents may not add funds to MegaVault. | [[parameters/dydx-v4/megavault]], [[parameters/dydx-v4/compliance]] | A9-PI |
| #c15 | MegaVault positions can be diluted; the number of users and amount of funds is unlimited and each addition dilutes existing fee revenue and PnL share. | [[parameters/dydx-v4/megavault]] | A4-PI |
| #c16 | Withdrawal slippage scenario — low leverage (no positions, all idle): 0% slippage on removal. | [[parameters/dydx-v4/megavault]] | A4-PI |
| #c17 | Withdrawal slippage scenario — medium leverage (one isolated margin sub-vault, 1x leverage, IMF=10%, MMF=50%, half-spread=30bps, skew=2): 4.9% – 35.5% depending on TVL impact. | [[parameters/dydx-v4/megavault]] | A4-PI |
| #c18 | Withdrawal slippage scenario — high leverage (8x leverage, IMF=20%, MMF=10%): 100% slippage, $0 received. | [[parameters/dydx-v4/megavault]] | A4-PI |
| #c19 | Currently users cannot directly deposit into or withdraw from specific sub-vaults. | [[parameters/dydx-v4/megavault]] | A4-PI |
