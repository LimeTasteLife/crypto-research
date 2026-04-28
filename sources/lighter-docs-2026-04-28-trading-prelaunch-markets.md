---
type: source
id: lighter-docs-2026-04-28-trading-prelaunch-markets
title: Prelaunch Markets
publisher: Lighter Docs
author: Lighter team
date: null
original_url: https://docs.lighter.xyz/trading/prelaunch-markets
mirror_snapshot: lighter-docs-2026-04-28
mirror_page: pages/trading-prelaunch-markets.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Prelaunch Markets

## TL;DR
Prelaunch markets on Lighter operate in isolated mode only (no cross-margin) due to volatility. Liquidity is supplied by XLP (Experimental Liquidity Provider), a pool separate from LLP — LLP has no exposure to prelaunch markets and does not act as MM there. Prelaunch markets carry no liquidation fee. The liquidation flow is custom: when margin falls between Maintenance Margin and Close-Out Margin, the exchange sends an Immediate-or-Cancel (IoC) order on the user's behalf at no fee. Below Close-Out Margin, the user is directly Auto-Deleveraged (ADL) — bypassing the normal LLP-takeover step. Counterparties on the other side of an ADL receive a more favorable execution price because ADL on prelaunch is triggered before bankruptcy.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | All prelaunch markets operate in isolated margin mode only; cross-margin positions cannot be opened on prelaunch markets. | [[concepts/listing/pre-launch-perp]], [[parameters/lighter/listed-markets-roster]] | A1-PI, A6-PI |
| #c2 | The cross-margin restriction on prelaunch markets exists due to the experimental and volatile nature of these markets. | [[concepts/listing/pre-launch-perp]] | A6-PI, A6-PII |
| #c3 | LLP does not act as a market maker on prelaunch markets; XLP (Experimental Liquidity Provider) provides liquidity for prelaunch markets instead. | [[parameters/lighter/llp]], [[concepts/listing/pre-launch-perp]] | A4-PI |
| #c4 | LLP has no exposure to prelaunch markets. | [[parameters/lighter/llp]] | A4-PI, A6-PI |
| #c5 | XLP acts solely as a liquidity provider on prelaunch markets, without a special role in the liquidation flow. | [[concepts/listing/pre-launch-perp]] | A4-PI |
| #c6 | Prelaunch markets have no liquidation fee. | [[parameters/lighter/fee-schedule]], [[parameters/lighter/liquidation-params]] | A2-PI |
| #c7 | When a user's margin falls below Maintenance Margin but stays above Close-Out Margin, the exchange sends an Immediate-or-Cancel (IoC) order on the user's behalf to close the position; this carries no fee. | [[concepts/risk/liquidation]] | A6-PI |
| #c8 | If the user falls below Close-Out Margin on a prelaunch market, the position is directly Auto-Deleveraged (ADL). | [[concepts/risk/adl-waterfall]], [[concepts/listing/pre-launch-perp]] | A6-PI |
| #c9 | Prelaunch ADL flow differs from crypto markets: in normal markets the entire account would typically be transferred to LLP first; ADL is used only when LLP lacks funds to cover bankrupt-account losses. | [[concepts/risk/adl-waterfall]] | A6-PI, A6-PII |
| #c10 | Prelaunch ADL is triggered when a user falls below Close-Out Margin — this does not imply bankruptcy, so the counterparty on the other side of the ADL receives a more favorable execution price. | [[concepts/risk/adl-waterfall]] | A6-PI |

## Conflicts raised
- #c3/#c4 (XLP-as-prelaunch-LP) vs `lighter-docs-2026-04-28-trading-real-world-assets-rwas`#c2/#c3 (LLP now manages liquidity for RWAs, replacing XLP for RWAs). These are consistent in scope: XLP retains prelaunch markets but no longer covers RWAs; LLP took over RWAs. Filed for cross-page consistency tracking, not as a contradiction.
