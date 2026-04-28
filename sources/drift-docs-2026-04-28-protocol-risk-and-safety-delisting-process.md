---
type: source
id: drift-docs-2026-04-28-protocol-risk-and-safety-delisting-process
title: Delisting Process
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/protocol/risk-and-safety/delisting-process
mirror_snapshot: drift-docs-2026-04-28
mirror_page: pages/protocol-risk-and-safety-delisting-process.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Delisting Process

## TL;DR
Delisting follows an on-chain four-stage procedure analogous to derivatives expiry. Stage 1 — once an expiry date is set, the perp market enters reduce-only mode: all new orders forced to reduce-only; risk-increasing orders cancelled on fill; no funding updates; users cannot pre-settle unrealised P&L. Stage 2 — after expiry, anyone calls `settle_expired_market` to lock in a settlement price (target = 5-min oracle TWAP, altered to allow full solvency). Stage 3 — after expiry + optional settlement-duration buffer, users settle expired positions at the settlement price; insurance fund draws and/or social loss may occur; taker fee applied at closure (encouraging early reduce-only close). Stage 4 — once user count hits zero, remaining PnL Pool balance settles into the quote asset's Revenue Pool. Spot delisting: reduce-only mode blocks new borrows/deposits/buys; force-close mode is "coming soon."

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Delisting a perpetuals market can occur in a tail risk event via an on-chain procedure similar to derivatives expiry. | [[concepts/listing/delisting-policy]] | A1-PII, A6-PII |
| #c2 | Once an expiry date is set, a perpetual market immediately enters reduce-only mode. | [[concepts/listing/delisting-policy]] | A6-PII |
| #c3 | In reduce-only mode all new orders are forced to have the reduce-only flag. | [[concepts/listing/delisting-policy]] | A6-PII |
| #c4 | In reduce-only mode current orders that would increase risk are cancelled on fill attempts. | [[concepts/listing/delisting-policy]] | A6-PII |
| #c5 | In reduce-only mode no new funding rate updates occur. | [[concepts/listing/delisting-policy]] | A6-PII |
| #c6 | In reduce-only mode users cannot settle unrealised P&L prior to expiry. | [[concepts/listing/delisting-policy]] | A6-PII |
| #c7 | After the expiry date, the market can lock in a settlement price by calling the `settle_expired_market` instruction. | [[concepts/listing/delisting-policy]] | A6-PII |
| #c8 | The target settlement price is the AMM's calculated 5-min oracle TWAP, altered to allow full solvency across all users. | [[concepts/listing/delisting-policy]] | A6-PII |
| #c9 | After expiry plus the optional settlement-duration buffer, users can settle expired positions at the settlement price. | [[concepts/listing/delisting-policy]] | A6-PII |
| #c10 | At expired-position settlement, any necessary insurance fund draws and/or socialized loss can occur. | [[concepts/listing/delisting-policy]], [[parameters/drift/insurance-fund]] | A6-PII |
| #c11 | At expired-position closure the taker fee is applied to encourage close during reduce-only mode. | [[concepts/listing/delisting-policy]] | A2-PII, A6-PII |
| #c12 | When user count in the market reaches zero, the remaining PnL Pool balance can be settled into the quote asset's Revenue Pool. | [[concepts/listing/delisting-policy]] | A6-PII |
| #c13 | For spot markets, reduce-only mode (when an expiry date is set) blocks new borrows, new deposits, and new buys. | [[concepts/listing/delisting-policy]] | A6-PII |
| #c14 | A spot market force-close mode (sending deposits back to user up to margin requirement, allowing borrow liquidation / collateral swap) is documented as "coming soon". | [[concepts/listing/delisting-policy]] | A6-PII |
