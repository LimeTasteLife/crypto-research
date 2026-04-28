---
type: source
id: drift-sdk-docs-2026-04-28-concepts-oracles
title: Oracles
publisher: Drift Protocol v2 SDK Docs (Mintlify)
author: Drift Labs
date: null
original_url: https://mintlify.com/drift-labs/protocol-v2/concepts/oracles
mirror_snapshot: drift-sdk-docs-2026-04-28
mirror_page: pages/concepts-oracles.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Oracles

## TL;DR
Oracle providers supported via OracleSource enum: PYTH, PYTH_1K, PYTH_1M, PYTH_PULL, PYTH_1K_PULL, PYTH_1M_PULL, SWITCHBOARD, QUOTE_ASSET, PYTH_STABLE_COIN, PYTH_STABLE_COIN_PULL, Prelaunch, SWITCHBOARD_ON_DEMAND, PYTH_LAZER, PYTH_LAZER_1K, PYTH_LAZER_1M, PYTH_LAZER_STABLE_COIN. Pyth is primary; Pyth Pull requires user to submit price update in same tx as trade. Pyth Lazer ~100ms updates (lowest latency). Switchboard ~1000ms; SWITCHBOARD_ON_DEMAND per-tx. Prelaunch oracle for pre-listing markets (admin-set price + maxPrice). OracleValidity enum: NonPositive, TooVolatile, TooUncertain, StaleForMargin, InsufficientDataPoints, StaleForAMMLowRisk, isStaleForAmmImmediate, Valid. OracleGuardRails fields: priceDivergence (markOraclePercentDivergence, oracleTwap5MinPercentDivergence) and validity (slotsBeforeStaleForAmm, slotsBeforeStaleForMargin, confidenceIntervalMaxSize, tooVolatileRatio). Default thresholds: slotsBeforeStaleForAmm=50 (~20s @ 400ms/slot), slotsBeforeStaleForMargin=120 (~48s). HistoricalOracleData tracks 1-hour and 5-min TWAPs. Margin offset: `offset = min(maxSpread × oraclePrice, confidence + baseSpread × oraclePrice)`. Margin price for long = oracle − offset; short = oracle + offset.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Drift Protocol relies on decentralized oracle networks for marking positions to market, calculating margin, determining funding rates, and validating order prices. | [[parameters/drift/oracle-config]] | A6-PI |
| #c2 | Pyth is the primary oracle provider for Drift. | [[parameters/drift/oracle-config]] | A6-PI |
| #c3 | Pyth Pull oracles require the user to submit a price update in the same transaction as their trade, ensuring the latest price is always used. | [[parameters/drift/oracle-config]] | A6-PI |
| #c4 | Drift supports Pyth Lazer with ~100ms update frequency (lowest latency among supported oracle types). | [[parameters/drift/oracle-config]] | A6-PI |
| #c5 | Drift supports Switchboard with ~1000ms update frequency, plus SWITCHBOARD_ON_DEMAND for per-transaction triggering. | [[parameters/drift/oracle-config]] | A6-PI |
| #c6 | Prelaunch oracle is admin-set with both `price` and `maxPrice` fields and is used for markets without external oracles. | [[parameters/drift/oracle-config]] | A1-PI, A6-PI |
| #c7 | OracleValidity enum: NonPositive, TooVolatile, TooUncertain, StaleForMargin, InsufficientDataPoints, StaleForAMMLowRisk, isStaleForAmmImmediate, Valid. | [[parameters/drift/oracle-config]] | A6-PI |
| #c8 | OracleGuardRails configuration includes priceDivergence (markOraclePercentDivergence, oracleTwap5MinPercentDivergence) and validity (slotsBeforeStaleForAmm, slotsBeforeStaleForMargin, confidenceIntervalMaxSize, tooVolatileRatio). | [[parameters/drift/oracle-config]] | A6-PI |
| #c9 | Default oracle staleness thresholds: slotsBeforeStaleForAmm=50 (~20 seconds at 400ms/slot), slotsBeforeStaleForMargin=120 (~48 seconds). | [[parameters/drift/oracle-config]] | A6-PI |
| #c10 | TWAP calculation: `TWAP_new = TWAP_old + (price_current − TWAP_old) × Δt / period`, where period is the TWAP window (e.g. 3600s for 1-hour TWAP). | [[parameters/drift/oracle-config]] | A6-PI |
| #c11 | Oracle margin offset formula: `offset = min(maxSpread × oraclePrice, confidence + baseSpread × oraclePrice)`. | [[parameters/drift/oracle-config]] | A6-PI |
| #c12 | Margin price calculation: long uses `oraclePrice − offset` (more conservative); short uses `oraclePrice + offset`. | [[parameters/drift/oracle-config]] | A6-PI |
| #c13 | Oracle precision tiers: Standard 6 decimals; 1K (3 decimals, higher-priced assets); 1M (0 decimals, very high-priced assets); StableCoin (6 decimals, tighter bounds). | [[parameters/drift/oracle-config]] | - |
| #c14 | Drift normalizes all oracle prices internally to PRICE_PRECISION (1e6). | [[parameters/drift/oracle-config]] | - |
| #c15 | Oracle fallback chain: (1) use last valid price within staleness threshold; (2) use TWAP; (3) use alternative oracle; (4) pause operations. | [[parameters/drift/oracle-config]] | A6-PI |
