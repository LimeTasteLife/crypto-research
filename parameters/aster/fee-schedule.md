---
type: parameter
entity: [[aster]]
parameter: fee-schedule
unit: percent
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: true
---

# Aster fee schedule

## Current (as of 2026-04-28)

**Quote-asset rate cards.** Aster Perps publishes two distinct rate cards keyed on the quote asset. USDT-quoted perps charge **0% maker / 0.04% taker**, while USD1-quoted perps charge **0% maker / 0.005% taker** — making USD1 perps an order of magnitude cheaper on the taker side[^aster-docs-2026-04-28-trading-perpetuals-fees].

**$ASTER discount.** Depositing $ASTER into the perp wallet (or transferring it from the spot account) yields a **flat 5% discount** on perp trading fees, applied automatically — the canonical tokenomics-to-fee linkage[^aster-docs-2026-04-28-trading-perpetuals-fees].

**Fee basis.** Fees are computed on **nominal value** of the order — `Number of contracts × Transaction price` — not on margin posted. The transaction fee is `Nominal value × Fee rate`[^aster-docs-2026-04-28-trading-perpetuals-fees]. Each contract typically represents one unit of base asset (e.g., 1 BTC in BTCUSDT)[^aster-docs-2026-04-28-trading-perpetuals-fees].

**Maker / taker.** A maker order rests on the book and adds liquidity; a taker order trades immediately against existing maker liquidity[^aster-docs-2026-04-28-trading-perpetuals-fees].

**Liquidation and funding economics.** Aster does not collect or pay funding — funding flows peer-to-peer between longs and shorts[^aster-docs-2026-04-28-trading-perpetuals-funding-rate]. See [[parameters/aster/revenue-distribution]] for protocol-fee disposition (buybacks, governance rewards).

## Time series

| effective | USDT-perp (mkr/tkr) | USD1-perp (mkr/tkr) | $ASTER discount | basis | source |
|---|---|---|---|---|---|
| 2026-04-28 | 0% / 0.04% | 0% / 0.005% | 5% flat (auto-applied) | nominal value (contracts × price) | [^aster-docs-2026-04-28-trading-perpetuals-fees] |

## Tiering rules / formulae

**Transaction fee formula:** `fee = nominal_value × rate`, where `nominal_value = contracts × transaction_price`[^aster-docs-2026-04-28-trading-perpetuals-fees].

**$ASTER discount stack:** post-discount rate = `base_rate × (1 − 0.05)` when $ASTER is held in the perp wallet[^aster-docs-2026-04-28-trading-perpetuals-fees].

No volume-tier ladder is published on the Fees page — the rate card is flat per quote asset (preferential MM rebates are published separately; see [[parameters/aster/mm-rebate-tiers]]).

## Disputed values

**#dispute-fee-rates.** The Perpetuals overview page advertises **0.01% maker / 0.035% taker**, while the dedicated Fees page states **0% / 0.04% (USDT)** and **0% / 0.005% (USD1)**[^aster-docs-2026-04-28-trading-perpetuals][^aster-docs-2026-04-28-trading-perpetuals-fees]. The Fees page TL;DR self-flags the contradiction; neither page is marked authoritative. Treated here as the Fees page being the rate card and the overview as marketing copy, but the contradiction remains unresolved.

## Sources
[^aster-docs-2026-04-28-trading-perpetuals-fees]: [[sources/aster-docs-2026-04-28-trading-perpetuals-fees]]
[^aster-docs-2026-04-28-trading-perpetuals]: [[sources/aster-docs-2026-04-28-trading-perpetuals]]
[^aster-docs-2026-04-28-trading-perpetuals-funding-rate]: [[sources/aster-docs-2026-04-28-trading-perpetuals-funding-rate]]
