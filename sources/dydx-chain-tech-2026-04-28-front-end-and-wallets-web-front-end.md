---
type: source
id: dydx-chain-tech-2026-04-28-front-end-and-wallets-web-front-end
title: Web Front End
publisher: dYdX Community Docs (chain technical)
author: dYdX community
date: null
original_url: https://docs.dydx.community/dydx-chain-technical-docs/front-end-and-wallets/web-front-end
mirror_snapshot: dydx-chain-tech-2026-04-28
mirror_page: pages/front-end-and-wallets-web-front-end.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Web Front End

## TL;DR
v4-web is the dYdX official web front-end (Node 18, pnpm). Deployment options: Vercel or IPFS (web3.storage / IPFS Kubo). Recommended Cloudflare WAF rule blocks OFAC-sanctioned countries — Cuba, Iran, North Korea, Syria, Myanmar, plus three Ukrainian regions (Crimea UA-09, Donetsk UA-14, Luhansk UA-43) — with a custom blocked-page message that allows users to withdraw from the protocol.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | The dYdX web front-end repository is v4-web at https://github.com/dydxprotocol/v4-web. | [[entities/perpdex/dydx]] | A9-PV |
| #c2 | v4-web requires Node.js v18, pnpm, a Wallet Connect account, and (optionally) a Vercel or web3.storage account or IPFS Kubo client for deployment. | [[entities/perpdex/dydx]] | A9-PV |
| #c3 | v4-web supports two deployment paths: Vercel (Vite framework preset) and IPFS (via web3.storage or IPFS Kubo). | [[entities/perpdex/dydx]] | A9-PV |
| #c4 | The recommended Cloudflare WAF rule for v4-web deployments blocks the following ISO country codes: CU (Cuba), IR (Iran), KP (North Korea), SY (Syria), MM (Myanmar). | [[parameters/dydx-v4/compliance]] | A9-PI |
| #c5 | The recommended Cloudflare WAF rule for v4-web also blocks specific Ukrainian subdivision codes UA-09 (Crimea), UA-14 (Donetsk), and UA-43 (Luhansk). | [[parameters/dydx-v4/compliance]] | A9-PI |
| #c6 | The suggested blocked-jurisdiction page message indicates the user has been blocked due to ToS violation but allows them to withdraw funds at any time. | [[parameters/dydx-v4/compliance]] | A9-PI, A9-PII |
