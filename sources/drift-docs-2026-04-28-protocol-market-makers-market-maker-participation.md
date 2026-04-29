---
type: source
id: drift-docs-2026-04-28-protocol-market-makers-market-maker-participation
title: Market Maker Participation
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/protocol/market-makers/market-maker-participation
mirror_snapshot: drift-docs-2026-04-28
mirror_page: pages/protocol-market-makers-market-maker-participation.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Market Maker Participation

## TL;DR
Drift's market making is permissionless — any user can MM via two paths: JIT auctions or post-only orders on the DLOB. JIT participation gives makers a ~5-second peek at retail flow before it hits the market (running a JIT Maker Bot). DLOB participation is via UI post-only orders or programmatic placement through the SDK. Drift open-sources a "floating maker bot" (FloatingPerpMaker, github.com/drift-labs/keeper-bots-v2/blob/master/src/bots/floatingMaker.ts) that programmatically quotes around oracle, with quotes auto-updating as the oracle moves. Critically: Drift itself runs this bot on-platform for-profit (with additional risk parameters) — explicit disclosure of protocol-as-MM.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Any user can participate as a Market Maker on Drift Protocol. | [[entities/perpdex/drift]] | A4-PI |
| #c2 | Market Makers can provide liquidity through Just-in-Time (JIT) liquidity or Post-Only orders on the decentralized orderbook. | [[concepts/mm-agreement/quote-obligation]] | A4-PI |
| #c3 | Makers in the JIT auction get a ~5-second look at retail flow before it hits the market. | [[concepts/market-microstructure/jit-auction]] | A4-PIII |
| #c4 | Market Makers can participate in the JIT system by running a JIT Maker Bot. | [[parameters/drift/mm-rebate-tiers]] | A4-PI |
| #c5 | Placing a 'Post-Only' limit order via Drift's UI qualifies the order as a maker order. | [[concepts/operations/matching-engine]] | A4-PI |
| #c6 | Post-only orders won't be executed against the AMM nor go through the JIT — they sit on the DLOB until matched. | [[concepts/operations/matching-engine]] | A4-PI |
| #c7 | Drift open-sources a floating maker bot (FloatingPerpMaker) that programmatically quotes bids and asks around the oracle price. | [[parameters/drift/mm-rebate-tiers]] | A4-PI |
| #c8 | The floating maker bot's quotes are automatically updated as the oracle price moves. | [[parameters/drift/mm-rebate-tiers]] | A4-PI |
| #c9 | Drift currently runs the floating maker bot on the platform for-profit with additional risk parameters (protocol-as-MM disclosure). | [[entities/perpdex/drift]] | A4-PIII, A4-PIV |
| #c10 | The floating maker bot source is published at https://github.com/drift-labs/keeper-bots-v2/blob/master/src/bots/floatingMaker.ts | [[parameters/drift/mm-rebate-tiers]] | - |
