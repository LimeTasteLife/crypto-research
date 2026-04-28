---
type: source
id: hl-docs-2026-04-27-onboarding-how-to-start-trading
title: How to start trading
publisher: Hyperliquid Docs
author: Hyperliquid team
date: null
original_url: https://hyperliquid.gitbook.io/hyperliquid-docs/onboarding/how-to-start-trading
mirror_snapshot: hl-docs-2026-04-27
mirror_page: pages/onboarding-how-to-start-trading.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-27
---

# How to start trading

## TL;DR
End-user onboarding guide. Two onboarding paths: defi-wallet connect or email login with auto-generated address. Deposit collateral options span multiple chains: USDC and ETH on Arbitrum, BTC on Bitcoin, ETH/ENA on Ethereum, SOL/2Z/BONK/FARTCOIN/PUMP/SPX on Solana, MON on Monad, XPL on Plasma. Trading on Hyperliquid does not cost gas. Native bridge runs between Hyperliquid and Arbitrum; withdrawal of USDC carries a flat $1 fee. Lists supported frontends including Based, Dexari, MetaMask, Phantom, and app.hyperliquid.xyz.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Trading on Hyperliquid does not cost gas to the user. | [[entities/perpdex/hyperliquid]], [[parameters/hyperliquid/fee-schedule]] | A2-PIV |
| #c2 | Hyperliquid's native bridge connects Hyperliquid and Arbitrum. | [[entities/perpdex/hyperliquid]], [[entities/network/arbitrum]] | A6-PII |
| #c3 | USDC withdrawal from Hyperliquid carries a $1 flat withdrawal fee (in lieu of gas). | [[parameters/hyperliquid/fee-schedule]] | A2-PIV |
| #c4 | Supported deposit collateral: USDC + ETH on Arbitrum, BTC on Bitcoin, ETH/ENA on Ethereum, SOL/2Z/BONK/FARTCOIN/PUMP/SPX on Solana, MON on Monad, XPL on Plasma. | [[entities/perpdex/hyperliquid]] | A6-PII |
| #c5 | Email-based login auto-generates a new blockchain address for the email (custodial-feel onboarding flow). | [[entities/perpdex/hyperliquid]] | A6-PII |
| #c6 | Perpetual trading uses USDC as collateral; position size = leverage × collateral. | [[concepts/market-microstructure/contract-size]], [[concepts/risk/leverage-cap]] | A1-PI |
| #c7 | Approved frontends include Based, Dexari, MetaMask, Phantom, and app.hyperliquid.xyz. | [[entities/perpdex/hyperliquid]] | A9-PV |
| #c8 | Non-USDC spot deposits must be sold for USDC, USDH, or USDT (depending on listed quote asset) before perps trading. | [[entities/perpdex/hyperliquid]] | A6-PII |
