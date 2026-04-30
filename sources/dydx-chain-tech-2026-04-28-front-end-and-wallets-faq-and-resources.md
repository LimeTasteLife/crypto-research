---
type: source
id: dydx-chain-tech-2026-04-28-front-end-and-wallets-faq-and-resources
title: FAQ & Resources (Front-end & Wallets)
publisher: dYdX Community Docs (chain technical)
author: dYdX community
date: null
original_url: https://docs.dydx.community/dydx-chain-technical-docs/front-end-and-wallets/faq-and-resources
mirror_snapshot: dydx-chain-tech-2026-04-28
mirror_page: pages/front-end-and-wallets-faq-and-resources.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# FAQ & Resources (Front-end & Wallets)

## TL;DR
FE/wallet integrator Q&A. Officially recognized wallets: Keplr, Leap. Multi-sig/MPCs: Keplr Multisig, Fordefi. BuyingPower must be computed client-side (per-market max leverage differs); equity and freeCollateral come from `/v4/addresses/<address>`. Market orders need to be short-term (with GoodTilBlock). MetaMask → dYdX address derivation requires signing a message. v4-web is open-source. WS: no new-block channel (use REST `/getheight` or run a local full node). Orderbook updates do not happen one-per-block (offchain). Trade confirmations via `v4_subaccount` channel.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Officially recognized dYdX wallets are Keplr and Leap (both popular Cosmos wallets). | [[entities/perpdex/dydx]] | - |
| #c2 | Multi-sig and MPCs supporting dYdX include Keplr Multisig and Fordefi. | [[entities/perpdex/dydx]] | - |
| #c3 | BuyingPower cannot be retrieved directly from the API because each market has a different maximum leverage; equity and freeCollateral are available via `/v4/addresses/<address>`. | [[entities/perpdex/dydx]] | A1-PI |
| #c4 | Market orders on dYdX must be short-term orders (with GoodTilBlock set); otherwise they fail with "FillOrKill order could not be fully filled". | [[entities/perpdex/dydx]] | A1-PI |
| #c5 | The dYdX address derivation pattern from MetaMask is: MetaMask address → sign a message → dYdX address (the user must own the metamask private key). | [[entities/perpdex/dydx]] | A1-PI |
| #c6 | Custom UI integrations can connect MetaMask wallet, then prompt the user to sign the derivation message; the front-end code is open-source at https://github.com/dydxprotocol/v4-web. | [[entities/perpdex/dydx]] | A9-PV |
| #c7 | A WebSocket heartbeat stream is not needed for dYdX. | [[entities/perpdex/dydx]] | - |
| #c8 | A new-block subscription is not available on WebSocket; use the REST `/getheight` endpoint or run a local full node to track block height (recommended for avoiding REST rate limits). | [[entities/perpdex/dydx]] | A1-PI |
| #c9 | One orderbook update per block per pair cannot be assumed because the order book is off-chain. | [[entities/perpdex/dydx]] | A1-PI |
| #c10 | Trade-confirmation events are received via the WebSocket v4_subaccount channel (delivers fills). | [[entities/perpdex/dydx]] | A1-PI |
