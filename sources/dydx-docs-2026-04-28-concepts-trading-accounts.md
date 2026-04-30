---
type: source
id: dydx-docs-2026-04-28-concepts-trading-accounts
title: Accounts and Subaccounts
publisher: dYdX Docs
author: dYdX team
date: null
original_url: https://docs.dydx.xyz/concepts/trading/accounts
mirror_snapshot: dydx-docs-2026-04-28
mirror_page: pages/concepts-trading-accounts.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Accounts and Subaccounts

## TL;DR
dYdX separates identity from trading via the main-account / subaccount model. Main accounts hold the keypair and tokens (used for gas), but cannot trade. Subaccounts are the trading unit: each main account can have up to 128,001 subaccounts, identified by `(main address, integer)`. Subaccounts are auto-created on first deposit, require USDC collateral to trade, and don't burn gas. Only the main account can sign transactions on behalf of a subaccount.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | A main account is associated with a public-private keypair and the trader's on-chain identity; it holds tokens used for gas and collateral. | [[entities/perpdex/dydx]] | - |
| #c2 | Gas for transactions is paid from the main account. | [[entities/perpdex/dydx]] | - |
| #c3 | Main accounts cannot trade. | [[entities/perpdex/dydx]] | - |
| #c4 | Each main account can have 128,001 subaccounts. | [[entities/perpdex/dydx]], [[parameters/dydx-v4/account-limits]] | A1-PI |
| #c5 | Each subaccount is uniquely identified by `(main account address, integer)`. | [[entities/perpdex/dydx]] | - |
| #c6 | A subaccount is automatically created when funds are deposited to a valid subaccount ID. | [[entities/perpdex/dydx]] | - |
| #c7 | Only the main account can send transactions on behalf of a subaccount. | [[entities/perpdex/dydx]] | - |
| #c8 | Subaccounts do not require gas (no gas is used for trading). | [[entities/perpdex/dydx]] | A2-PI |
| #c9 | Subaccounts require collateral token (currently USDC) in order to trade. | [[entities/perpdex/dydx]], [[entities/token/usdc]] | A2-PI |
