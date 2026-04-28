---
type: source
id: dydx-community-2026-04-28-modules-governance-markets
title: Markets (Governance Adjustable Parameters)
publisher: dYdX Community Docs
author: dYdX community
date: null
original_url: https://docs.dydx.community/dydx/modules/governance/governance-adjustable-parameters/markets
mirror_snapshot: dydx-community-2026-04-28
mirror_page: pages/modules-governance-markets.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Markets (Governance Adjustable Parameters)

## TL;DR
Per-market parameter schema (id, pair, exponent, min_exchanges, min_price_change_ppm, exchange_config_json oracle setup). Liquidity Tier table — the on-chain ppm-encoded version (e.g. Large-Cap Tier 0: initial_margin_ppm 20000 = 0.02, maintenance_fraction_ppm 600000 = 0.6, base_position_notional 1,000,000 USDC, impact_notional 10,000 USDC). Two market types: Cross (shared collateral pool + insurance fund) and Isolated (segregated). Recommended criteria for upgrading isolated → cross: ≥2 oracle sources with >$1M USD volume each, ≥2 sources with >$150K depth within 2% of mid, ≥4 total oracle sources, ≥30 days of historical data.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Each market on dYdX Chain has governance-adjustable parameters: id, pair, exponent (price exponent), min_exchanges, min_price_change_ppm, and exchange_config_json (oracle config). | [[parameters/dydx-v4/listing-policy]], [[parameters/dydx-v4/oracle-config]] | A1-PI, A6-PI, A7-PI |
| #c2 | min_exchanges is the minimum number of exchanges that must be reporting a live price for a price update to be considered valid. | [[parameters/dydx-v4/oracle-config]] | A6-PI |
| #c3 | min_price_change_ppm is the minimum allowable price change (in parts per million) that triggers a price update. | [[parameters/dydx-v4/oracle-config]] | A6-PI |
| #c4 | Liquidity Tier 0 (Large-Cap) on-chain values: initial_margin_ppm 20,000 (0.02); maintenance_fraction_ppm 600,000 (0.6); base_position_notional 1,000,000 USDC; impact_notional 10,000 USDC. | [[parameters/dydx-v4/margin-tiers]] | A1-PI |
| #c5 | Liquidity Tier 1 (Small-Cap) on-chain values: initial_margin_ppm 100,000 (0.1); maintenance_fraction_ppm 500,000 (0.5); base_position_notional 250,000 USDC; impact_notional 5,000 USDC. | [[parameters/dydx-v4/margin-tiers]] | A1-PI |
| #c6 | Liquidity Tier 2 (Long-Tail) on-chain values: initial_margin_ppm 200,000 (0.2); maintenance_fraction_ppm 500,000 (0.5); base_position_notional 100,000 USDC; impact_notional 2,500 USDC. | [[parameters/dydx-v4/margin-tiers]] | A1-PI |
| #c7 | Liquidity Tier 3 (Safety) on-chain values: initial_margin_ppm 1,000,000 (1.0); maintenance_fraction_ppm 200,000 (0.02); base_position_notional 1,000 USDC; impact_notional 2,500 USDC. | [[parameters/dydx-v4/margin-tiers]] | A1-PI |
| #c8 | Liquidity Tier 4 (Isolated) on-chain values: initial_margin_ppm 50,000 (0.05); maintenance_fraction_ppm 600,000 (0.6); base_position_notional 0; impact_notional 2,500 USDC. | [[parameters/dydx-v4/margin-tiers]] | A1-PI |
| #c9 | Liquidity Tier 5 (Mid-Cap) on-chain values: initial_margin_ppm 50,000 (0.05); maintenance_fraction_ppm 600,000 (0.6); base_position_notional 0; impact_notional 5,000 USDC. | [[parameters/dydx-v4/margin-tiers]] | A1-PI |
| #c10 | Liquidity Tier 6 (FX) on-chain values: initial_margin_ppm 10,000 (0.01); maintenance_fraction_ppm 500,000 (0.5); base_position_notional 500,000 USDC; impact_notional 2,500 USDC. | [[parameters/dydx-v4/margin-tiers]] | A1-PI |
| #c11 | Liquidity Tier 7 (IML 5x) on-chain values: initial_margin_ppm 200,000 (0.2); maintenance_fraction_ppm 500,000 (0.5); base_position_notional 0; impact_notional 2,500 USDC. | [[parameters/dydx-v4/margin-tiers]] | A1-PI |
| #c12 | Cross Margin markets share the same collateral pool and insurance fund. | [[concepts/risk/margin-tier]] | A6-PI |
| #c13 | Isolated Margin markets have segregated collateral pools and their own insurance fund per market. | [[concepts/risk/margin-tier]] | A6-PI |
| #c14 | Recommended criteria for upgrading an isolated market to cross: at least two oracle sources each with >$1M USD trading volume. | [[parameters/dydx-v4/listing-policy]] | A1-PI, A6-PI |
| #c15 | Recommended criteria for upgrading an isolated market to cross: at least two oracle sources each with >$150K depth within 2% of the mid-price. | [[parameters/dydx-v4/listing-policy]] | A1-PI, A6-PI |
| #c16 | Recommended criteria for upgrading an isolated market to cross: a minimum of four total oracle sources. | [[parameters/dydx-v4/listing-policy]] | A1-PI, A6-PI |
| #c17 | Recommended criteria for upgrading an isolated market to cross: availability of at least 30 days of historical data. | [[parameters/dydx-v4/listing-policy]] | A1-PI |

## Conflicts raised
- #c4-#c11 (community-docs Liquidity Tier values, e.g. Tier 0 impact_notional 10,000 USDC, base_position_notional 1,000,000 USDC) vs `dydx-docs-2026-04-28-concepts-trading-governance`#c14-#c21 (which gives Tier 0 impact_notional 25,000 USDC and uses lower-cap/upper-cap rather than base_position_notional). Two divergent versions of the Liquidity Tier table. Phase 2 must reconcile — likely the docs.dydx.xyz table reflects an older or proposed schema while the on-chain values shown in community docs are the current effective ones.
