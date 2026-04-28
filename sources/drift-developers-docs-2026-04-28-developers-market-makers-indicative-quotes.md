---
type: source
id: drift-developers-docs-2026-04-28-developers-market-makers-indicative-quotes
title: Indicative Quotes
publisher: Drift Docs
author: Drift Labs
date: 2026-03-20
original_url: https://docs.drift.trade/developers/market-makers/indicative-quotes
mirror_snapshot: drift-developers-docs-2026-04-28
mirror_page: pages/developers-market-makers-indicative-quotes.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Indicative Quotes

## TL;DR
Indicative quotes let MMs signal liquidity offchain without committing onchain orders. Use cases: UI display (takers see liquidity before placing orders), aggregator routing (Jupiter, etc.), price discovery in thin markets, JIT-only MM visibility without resting onchain. Endpoint: `wss://dlob.drift.trade/quotes/ws`, authenticated via challenge-response with the MM's keypair. Publish via `IndicativeQuotesSender.setQuote({ bidPrice, askPrice, bidBaseAssetAmount, askBaseAssetAmount, marketIndex, isOracleOffset })`. Setting `isOracleOffset: true` interprets bid/ask as offsets from oracle (analogous to oracle offset orders) — quote auto-floats with oracle and only needs updating when changing spread/size. Sending a quote with any null field DELETES the stored quote (used for graceful shutdown). Indicative quotes appear in the L2 orderbook only when `includeIndicative=true`. CRITICAL caveat: indicative quotes are NOT firm commitments — there's no onchain enforcement. Aggregators and UIs display them as available liquidity, but if MM publishes quotes they can't honor, takers experience slippage and routing-algorithm reputation suffers.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Indicative quotes let market makers signal liquidity offchain without committing onchain orders. | [[concepts/mm-agreement/quote-obligation]] | A4-PI |
| #c2 | Indicative quotes are used for UI display, aggregator routing (e.g. Jupiter), price discovery in thin markets, and JIT-only MM visibility. | [[concepts/mm-agreement/quote-obligation]] | A4-PI |
| #c3 | Indicative-quote endpoint: `wss://dlob.drift.trade/quotes/ws`, authenticated via challenge-response with the MM keypair. | [[entities/perpdex/drift]] | - |
| #c4 | Setting `isOracleOffset: true` makes bid/ask interpretations relative to oracle price; the quote auto-floats with the oracle. | [[concepts/mm-agreement/quote-obligation]] | A4-PI |
| #c5 | Sending a quote with any required field set to `null` deletes the stored quote — used for graceful shutdown to avoid showing phantom liquidity. | [[concepts/mm-agreement/quote-obligation]] | A4-PII |
| #c6 | Indicative quotes appear in the L2 orderbook only when `includeIndicative=true` is requested. | [[concepts/operations/matching-engine]] | A4-PI |
| #c7 | Indicative quotes are NOT firm commitments — there is no onchain enforcement; they signal intent only. | [[concepts/mm-agreement/quote-obligation]] | A4-PI, A4-PV |
| #c8 | If MMs publish indicative quotes they cannot honor, takers experience slippage and the MM's reputation with routing algorithms may suffer. | [[concepts/mm-agreement/quote-obligation]] | A4-PV |
| #c9 | If an MM's WebSocket connection drops, indicative quotes disappear from the orderbook — bots should auto-reconnect and re-publish on reconnection. | [[concepts/mm-agreement/quote-obligation]] | A4-PII |
| #c10 | The DLOB WebSocket server may throttle rapid `setQuote` updates; publishing every second is sufficient for most use cases. | [[concepts/mm-agreement/quote-obligation]] | A4-PI |
