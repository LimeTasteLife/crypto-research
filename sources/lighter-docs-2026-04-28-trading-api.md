---
type: source
id: lighter-docs-2026-04-28-trading-api
title: API
publisher: Lighter Docs
author: Lighter team
date: null
original_url: https://docs.lighter.xyz/trading/api
mirror_snapshot: lighter-docs-2026-04-28
mirror_page: pages/trading-api.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# API

## TL;DR
Top-level summary of Lighter's API surface and account model. Full API docs live at apidocs.lighter.xyz; the team operates a public Telegram channel for API updates. Each main account or sub-account may register up to 256 API keys, used to sign and verify requests. Account creation begins by signing a message with an Ethereum wallet, which then allows deposits via Lighter's smart contracts. Users may create multiple sub-accounts under the same Ethereum wallet.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Lighter's API documentation is published at https://apidocs.lighter.xyz/docs/get-started. | [[entities/perpdex/lighter]] | A4-PI |
| #c2 | Lighter operates a Telegram API updates channel at https://t.me/lighter_api_updates. | [[entities/perpdex/lighter]] | A4-PI |
| #c3 | Each Lighter account or sub-account may register up to 256 API keys. | [[entities/perpdex/lighter]] | A4-PI |
| #c4 | API keys are owned by the account and are used to sign requests; the exchange verifies signatures to confirm authorization. | [[entities/perpdex/lighter]] | A4-PI |
| #c5 | Account creation requires an Ethereum wallet; users register the main account by signing a message that associates the Ethereum address with Lighter. | [[entities/perpdex/lighter]] | A1-PI |
| #c6 | Assets are deposited by sending a transaction from the Ethereum wallet to Lighter's smart contracts. | [[entities/perpdex/lighter]] | A1-PI |
| #c7 | Users may create multiple sub-accounts linked to the same Ethereum wallet. | [[entities/perpdex/lighter]] | A1-PI |

## Conflicts raised
