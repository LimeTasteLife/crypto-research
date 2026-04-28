---
type: source
id: drift-docs-2026-04-28-protocol-market-makers-maker-fee-rebate
title: Maker Fee Rebate
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/protocol/market-makers/maker-fee-rebate
mirror_snapshot: drift-docs-2026-04-28
mirror_page: pages/protocol-market-makers-maker-fee-rebate.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Maker Fee Rebate

## TL;DR
For non-BTC/ETH perpetuals, the maker rebate is a flat −0.25 bps regardless of taker counterparty (AMM or User). The 'post only' flag is required for an order to qualify as maker; otherwise even resting orders may match as taker. DRIFT staking can add up to 40% extra rebate on top of this base rebate (stacking on the volume-tier breakdown documented in Trading Fees). The page disclaims that the incentive program is subject to change.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | For non-BTC/ETH perpetuals, the flat maker rebate when filled by AMM counterparty is −0.25 bps. | [[parameters/drift/mm-rebate-tiers]], [[parameters/drift/fee-schedule]] | A2-PI, A4-PI |
| #c2 | For non-BTC/ETH perpetuals, the flat maker rebate when filled by User counterparty is also −0.25 bps. | [[parameters/drift/mm-rebate-tiers]], [[parameters/drift/fee-schedule]] | A2-PI, A4-PI |
| #c3 | An order requires the 'post only' flag to qualify as a maker order; otherwise even resting orders can match as taker. | [[concepts/operations/matching-engine]] | A4-PI |
| #c4 | Up to 40% extra rebate on maker fees can be earned by staking DRIFT (stacking with regular rebates). | [[parameters/drift/mm-rebate-tiers]], [[entities/token/drift]] | A2-PIV, A4-PI |
| #c5 | The maker incentive program documented on this page is subject to change. | [[parameters/drift/mm-rebate-tiers]] | A4-PII |
