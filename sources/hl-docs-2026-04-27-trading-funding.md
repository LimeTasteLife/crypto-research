---
type: source
id: hl-docs-2026-04-27-trading-funding
title: Funding
publisher: Hyperliquid Docs
author: Hyperliquid team
date: null
original_url: https://hyperliquid.gitbook.io/hyperliquid-docs/trading/funding
mirror_snapshot: hl-docs-2026-04-27
mirror_page: pages/trading-funding.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-27
---

# Funding

## TL;DR
Funding is the per-hour peer-to-peer payment that anchors mark to spot. Interest-rate component is fixed at 0.01%/8h (≈11.6% APR paid to short). Premium component is sampled every 5s and averaged over the hour. Funding rate F = avg_premium + clamp(interest_rate − premium, −0.0005, 0.0005). Funding is paid every hour at 1/8 of the 8h-equivalent rate. The funding cap is 4%/hour — explicitly noted as much less aggressive than CEX peers. HIP-3 perps use a more responsive premium formula and configurable funding-rate multiplier/interest-rate. Funding payment notional uses the spot oracle price, not the mark price. The page includes a worked numerical example.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Funding payments are peer-to-peer; no fees are collected on the payments. | [[concepts/fee-model/funding-rate]] | A2-PI |
| #c2 | Interest-rate component is fixed at 0.01% per 8 hours (≈0.00125%/hour, ≈11.6% APR paid to short). | [[parameters/hyperliquid/funding-config]], [[concepts/fee-model/funding-rate]] | A6-PI |
| #c3 | Funding rate formula: F = average_premium + clamp(interest_rate − premium, −0.0005, 0.0005). | [[parameters/hyperliquid/funding-config]] | A6-PI |
| #c4 | Premium is sampled every 5 seconds and averaged over the hour. | [[parameters/hyperliquid/funding-config]] | A6-PI |
| #c5 | Funding is paid every hour, at 1/8 of the computed 8h-equivalent rate. | [[parameters/hyperliquid/funding-config]] | A6-PI |
| #c6 | premium = impact_price_difference / oracle_price, where impact_price_difference uses the impact_bid/ask prices (avg execution price for impact_notional_usd). | [[parameters/hyperliquid/funding-config]] | A6-PI |
| #c7 | For HIP-3 perps, premium = 0.5 * (impact_bid_px + impact_ask_px) / oracle_px − 1 (more responsive formula, plus configurable funding-rate multiplier and interest rate). | [[parameters/hyperliquid/funding-config]] | A6-PI, A1-PI |
| #c8 | Funding rate is capped at 4%/hour. The cap and interval do not depend on the asset. | [[parameters/hyperliquid/funding-config]] | A6-PI |
| #c9 | Funding cap is explicitly less aggressive than CEX counterparts (per Hyperliquid docs). | [[parameters/hyperliquid/funding-config]] | A6-PI |
| #c10 | Funding payment notional uses the spot oracle price (not mark price): payment = position_size * oracle_price * funding_rate. | [[parameters/hyperliquid/funding-config]] | A6-PI |
