---
type: source
id: dydx-community-2026-04-28-dydx-features-instant-market-listings
title: Instant Market Listings
publisher: dYdX Community Docs
author: dYdX community
date: null
original_url: https://docs.dydx.community/dydx/dydx-features/instant-market-listings
mirror_snapshot: dydx-community-2026-04-28
mirror_page: pages/dydx-features-instant-market-listings.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Instant Market Listings

## TL;DR
Permissionless listing flow: users add 10,000 USDC to a new asset's MegaVault sub-vault to launch the perp market — no governance vote needed. Funds are locked for 2,592,000 blocks (~30 days at 1s avg block time, but actual could be longer). Skip is the elected Market Map Updater that maintains the on-chain "launchable" set; not all assets are eligible. Coverage: most assets from Base, Ethereum, Solana, and CEXs. Funds added are NOT principal-protected — they sit in MegaVault and bear MM trading risk and slippage. US/Canada users explicitly prohibited.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Instant Market Listings enable users to list and trade perpetuals on virtually any eligible asset on dYdX without governance approvals or third-party permissions. | [[entities/perpdex/dydx-v4]], [[parameters/dydx-v4/listing-policy]] | A1-PI |
| #c2 | A user lists a market by adding 10,000 USDC to the new asset's sub-vault. | [[parameters/dydx-v4/listing-policy]] | A1-PI |
| #c3 | The 10,000 USDC ensures the new market launches with sufficient liquidity for efficient trading. | [[parameters/dydx-v4/listing-policy]], [[parameters/dydx-v4/megavault]] | A4-PI |
| #c4 | Skip, a third-party entity elected by the dYdX community as the Market Map Updater, manages the "launchable" markets on-chain. | [[parameters/dydx-v4/listing-policy]], [[entities/actor/skip-protocol]] | A1-PI, A7-PI |
| #c5 | Listed markets must meet specific volume and liquidity thresholds defined by the Market Map Updater. | [[parameters/dydx-v4/listing-policy]] | A1-PI |
| #c6 | Most assets from Base, Ethereum, Solana, and centralized exchanges (CEXs) are supported as launchable markets; the Market Mapper is actively expanding the list to include more assets including perpetual prediction markets. | [[parameters/dydx-v4/listing-policy]] | A1-PII |
| #c7 | The lock-up period for the 10,000 USDC is 2,592,000 dYdX blocks; the 30-day estimate assumes an average block time of one second, but actual block times could be longer. | [[parameters/dydx-v4/listing-policy]] | A1-PII |
| #c8 | The 10,000 USDC amount and lock-up period are governance-adjustable parameters. | [[parameters/dydx-v4/listing-policy]] | A7-PI |
| #c9 | Funds added through Instant Market Listings are treated identically to other MegaVault funds, except for the 30-day lock-up. | [[parameters/dydx-v4/listing-policy]], [[parameters/dydx-v4/megavault]] | A1-PI |
| #c10 | Users are NOT guaranteed to get back their 10,000 USDC after 30 days; the funds enter MegaVault, which supports high-risk illiquid volatile markets and carries material risk of loss. | [[parameters/dydx-v4/listing-policy]] | A1-PII, A4-PI |
| #c11 | When a user launches a market, 10,000 USDC is atomically added into that market's sub-vault; the MegaVault operator can subsequently adjust liquidity. | [[parameters/dydx-v4/listing-policy]] | A4-PI |
| #c12 | Users in the US, Canada, or any other prohibited jurisdiction may not launch a market via Instant Market Listings. | [[parameters/dydx-v4/listing-policy]], [[parameters/dydx-v4/compliance]] | A9-PI |
