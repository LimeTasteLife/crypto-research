---
type: source
id: hl-docs-2026-04-27-trading-liquidations
title: Liquidations
publisher: Hyperliquid Docs
author: Hyperliquid team
date: null
original_url: https://hyperliquid.gitbook.io/hyperliquid-docs/trading/liquidations
mirror_snapshot: hl-docs-2026-04-27
mirror_page: pages/trading-liquidations.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-27
---

# Liquidations

## TL;DR
Liquidations begin when account equity drops below maintenance margin (1.25% to 16.7% depending on max leverage 3x–40x). The first attempt is a market-order book liquidation of the full position; partially closed positions may keep residual margin. If equity drops below 2/3 of maintenance margin without success, backstop liquidation routes to the Liquidator Vault (a component of HLP). Cross backstop transfers all cross positions and margin to the liquidator; isolated backstop transfers only the isolated position and its margin. During backstop the maintenance margin is forfeited (HLP buffer). For positions >100k USDC ($10k testnet), only 20% is sent per liquidation block, with a 30-second cooldown. There is no clearance fee on liquidations. Backstop PnL flows entirely to the community via HLP — explicitly contrasted with CEX/MM internalization.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | A liquidation is triggered when account equity drops below maintenance margin, where maintenance margin = half of initial margin at max leverage. | [[concepts/risk/liquidation]] | A6-PI |
| #c2 | Maintenance margin ranges from 1.25% (40x max-leverage assets) to 16.7% (3x max-leverage assets). | [[concepts/risk/liquidation]] | A6-PI |
| #c3 | First-step liquidation: full-size market order is sent to the order book; full or partial closure is possible. | [[concepts/risk/liquidation]] | A6-PI |
| #c4 | If first-step closure brings equity ≥ maintenance margin, residual collateral remains with the trader. | [[concepts/risk/liquidation]] |  |
| #c5 | If equity drops below 2/3 of maintenance margin without book-liquidation success, backstop liquidation occurs via the Liquidator Vault. | [[concepts/risk/liquidation]], [[parameters/hyperliquid/hlp]] | A4-PI, A6-PI |
| #c6 | Cross-position backstop transfers all of the trader's cross positions and cross margin to the liquidator. | [[concepts/risk/liquidation]] | A6-PI |
| #c7 | Isolated-position backstop transfers only the isolated position and its isolated margin to the liquidator. | [[concepts/risk/liquidation]] | A6-PI |
| #c8 | During backstop liquidation, the trader's maintenance margin is not returned (HLP keeps it as buffer). | [[concepts/risk/liquidation]], [[parameters/hyperliquid/hlp]] | A4-PI |
| #c9 | Liquidations use the mark price, which combines external CEX prices with Hyperliquid book state. | [[concepts/market-microstructure/mark-price-formula]] | A6-PI |
| #c10 | Hyperliquid charges no clearance fee on liquidations (in contrast to CEXs). | [[parameters/hyperliquid/fee-schedule]] | A2-PI |
| #c11 | For positions >100,000 USDC (10,000 USDC on testnet), only 20% of position is sent as a market liquidation order. | [[concepts/risk/liquidation]] | A6-PI |
| #c12 | After a partial liquidation block, there is a 30-second cooldown during which any further market liquidation is for the full remaining position. | [[concepts/risk/liquidation]] | A6-PI |
| #c13 | The Liquidator Vault is a component strategy of HLP. | [[parameters/hyperliquid/hlp]], [[concepts/lp/venue-owned-lp]] | A4-PI [ambiguous: Gap-1] |
| #c14 | All backstop-liquidation PnL flows to the community via HLP (vs CEX exchange-operator or privileged-MM internalization). | [[parameters/hyperliquid/hlp]], [[concepts/tokenomics/rev-share]] | A4-PI, A2-PI |
| #c15 | Liquidation price formula: liq_price = price - side * margin_available / position_size / (1 - l * side), where l = 1/MAINTENANCE_LEVERAGE. | [[concepts/risk/liquidation]] | A6-PI |
| #c16 | For cross margin: margin_available = account_value - maintenance_margin_required. | [[concepts/risk/liquidation]] | A6-PI |
| #c17 | For isolated margin: margin_available = isolated_margin - maintenance_margin_required. | [[concepts/risk/liquidation]] | A6-PI |
| #c18 | For assets with margin tiers, maintenance leverage depends on the unique tier corresponding to the position value at the liquidation price. | [[concepts/risk/margin-tier]] | A6-PI |
| #c19 | For cross-margin positions, actual liquidation price is independent of the leverage set by the user (lower leverage simply consumes more collateral). | [[concepts/risk/liquidation]] |  |
| #c20 | For isolated-margin positions, liquidation price depends on user-set leverage (which determines isolated margin). | [[concepts/risk/liquidation]] |  |
