---
type: parameter
entity: [[aster]]
parameter: listed-markets-roster
unit: count
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: false
---

# Aster listed markets roster

## Current (as of 2026-04-28)

**Coverage.** Aster's MM qualification table documents **250+ pairs** spanning crypto perps, equity perps, and commodity perps[^aster-docs-2026-04-28-trading-perpetuals-market-maker-program]. The full roster is recoverable from the Market Maker program page; this file captures the canonical sample with the per-pair MM-qualification parameters relevant to listing identity.

**Sample roster.** Crypto perps include the major-cap pairs (BTCUSDT, ETHUSDT, SOLUSDT, ASTERUSDT, HYPEUSDT, BNBUSDT, ADAUSDT) plus a long tail of altcoin perps. Equity perps cover **AAPLUSDT, TSLAUSDT, NVDAUSDT, AMZNUSDT, METAUSDT, GOOGUSDT, MSFTUSDT**[^aster-docs-2026-04-28-trading-perpetuals-market-maker-program]. Pre-launch contracts (expiry futures, sometimes perps) auto-convert to standard perps on token launch — see [[parameters/aster/listing-policy]][^aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts].

**Per-pair MM parameters** (sample)[^aster-docs-2026-04-28-trading-perpetuals-market-maker-program]:

| Pair | Spread cap | Min size (contracts) | Type |
|---|---|---|---|
| BTCUSDT | 0.10% | 2 | (per docs table) |
| ETHUSDT | 0.10% | 60 | Not Applicable |
| SOLUSDT | 0.10% | 1,000 | (per docs table) |
| BNBUSDT | (per table) | (per table) | H |
| ADAUSDT | (per table) | (per table) | N |
| ASTERUSDT | 0.25% | 30,000 | (per docs table) |
| HYPEUSDT | 0.25% | 800 | (per docs table) |
| AAPLUSDT / TSLAUSDT / NVDAUSDT / AMZNUSDT / METAUSDT / GOOGUSDT / MSFTUSDT | 1.00% | (per docs table) | (equity perp) |

**Type column open question.** The "Type" column carries values **H**, **N**, and **Not Applicable** — examples include `BNBUSDT=H`, `ETHUSDT=Not Applicable`, `ADAUSDT=N`[^aster-docs-2026-04-28-trading-perpetuals-market-maker-program]. The column is tabulated but never glossed in the docs; meaning is captured as an open question on the parent entity.

## Time series

| effective | total pairs (approx) | crypto perps | equity perps | commodity perps | pre-launch contracts | source |
|---|---|---|---|---|---|---|
| 2026-04-28 | 250+ | yes (BTC/ETH/SOL/BNB/ASTER/HYPE + long tail) | AAPL/TSLA/NVDA/AMZN/META/GOOG/MSFT | yes (per MM table) | yes (auto-convert to perps) | [^aster-docs-2026-04-28-trading-perpetuals-market-maker-program] |

## Tiering rules / formulae

Not applicable — parameter is a registry / list, not formulaic. Per-pair MM spread caps and minimum sizes are documented as tiering rules of the [[parameters/aster/mm-rebate-tiers]] parameter, not as listing identity.

## Disputed values

None on the roster itself. The "Type" column glossary is missing from primary docs and is tracked as an open question on the entity.

## Sources
[^aster-docs-2026-04-28-trading-perpetuals-market-maker-program]: [[sources/aster-docs-2026-04-28-trading-perpetuals-market-maker-program]]
[^aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts]: [[sources/aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts]]
