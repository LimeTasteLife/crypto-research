---
type: source
id: dydx-docs-2026-04-28-concepts-trading-oracle
title: Oracle Prices
publisher: dYdX Docs
author: dYdX team
date: null
original_url: https://docs.dydx.xyz/concepts/trading/oracle
mirror_snapshot: dydx-docs-2026-04-28
mirror_page: pages/concepts-trading-oracle.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Oracle Prices

## TL;DR
Oracle prices are aggregated from external exchanges (Binance, Bitfinex, Bitstamp, Bybit, Coinbase, crypto.com, GateIO, others) by validator-run sidecars (Slinky). Each validator submits prices via vote extensions; proposers aggregate; consensus accepts the block; oracle prices update. Used for collateralization checks, liquidation triggering, and stop-limit/take-profit triggers. Caveats: max number of markets per block, minimum price-change threshold.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Oracle prices are aggregated prices providing up-to-date price data for assets, used for ensuring well-collateralization, determining when to liquidate, and triggering stop-limit/take-profit orders. | [[parameters/dydx-v4/oracle-config]], [[concepts/market-microstructure/oracle-spec]] | A6-PI |
| #c2 | Oracle prices are determined by the current validator set of the network. | [[parameters/dydx-v4/oracle-config]] | A6-PI |
| #c3 | Each validator runs a sidecar that pulls prices from oracle providers and external exchanges including Binance, Bitfinex, Bitstamp, Bybit, Coinbase, crypto.com, GateIO. | [[parameters/dydx-v4/oracle-config]] | A6-PI |
| #c4 | Each validator submits its view of oracle prices via vote extensions. | [[parameters/dydx-v4/oracle-config]] | A6-PI |
| #c5 | The oracle update path is: validators submit vote extensions → proposer aggregates and proposes → network accepts the block → oracle prices update. | [[parameters/dydx-v4/oracle-config]] | A6-PI |
| #c6 | Oracle updates are subject to a maximum number of markets that can be updated per block and a minimum threshold on price changes. | [[parameters/dydx-v4/oracle-config]] | A6-PI |
