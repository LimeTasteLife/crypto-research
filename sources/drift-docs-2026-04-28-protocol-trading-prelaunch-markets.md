---
type: source
id: drift-docs-2026-04-28-protocol-trading-prelaunch-markets
title: Prelaunch Market
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/protocol/trading/prelaunch-markets
mirror_snapshot: drift-docs-2026-04-28
mirror_page: pages/protocol-trading-prelaunch-markets.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Prelaunch Market

## TL;DR
Prelaunch Markets let users trade an asset before a reliable external oracle exists. Instead of an external oracle, the market uses a custom oracle source set to the current mark TWAP (with window equal to the funding period). Default contract tier is Highly Speculative — meaning no access to external insurance fund (insurance is fees collected within the market only). To resist manipulation, the market is configured with a custom max-price and conservative open-interest limits. Once a reliable external oracle becomes available, the oracle source can be switched.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Prelaunch Markets allow users to trade before a reliable external oracle is available. | [[concepts/listing/pre-launch-perp]] | A1-PI |
| #c2 | Prelaunch markets use a custom oracle source that is the current mark TWAP (window = the funding period). | [[concepts/listing/pre-launch-perp]], [[parameters/drift/oracle-config]] | A1-PI, A6-PI |
| #c3 | All Prelaunch Markets currently have the Highly Speculative contract tier. | [[concepts/listing/pre-launch-perp]] | A1-PI, A6-PI |
| #c4 | Prelaunch markets have no external insurance fund — all insurance comes from fees collected within the market. | [[parameters/drift/insurance-fund]] | A6-PI |
| #c5 | Prelaunch markets are configured with a custom max price and conservative open-interest limits to prevent manipulation. | [[concepts/listing/pre-launch-perp]] | A1-PI, A6-PI |
| #c6 | Once a reliable external oracle is available, a Prelaunch Market's oracle source can be switched to it. | [[concepts/listing/pre-launch-perp]] | A1-PII |
