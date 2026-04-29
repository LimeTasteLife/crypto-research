---
type: source
id: uniswap-v4-protocol-fee-2026-04-29-concepts-fees
title: Protocol Fee Configuration
publisher: Uniswap Docs
author: Uniswap team
date: 2026-04-29
original_url: https://developers.uniswap.org/docs/protocols/protocol-fee/concepts/fees
mirror_snapshot: uniswap-v4-protocol-fee-2026-04-29
mirror_page: pages/concepts-fees.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-29
---

# Protocol Fee Configuration

## TL;DR
Protocol fees are a governance-configurable portion of swap fees redirected from LPs to protocol-controlled collection contracts. Currently active on all v2 pools and selected v3 pools. Fee splits: v2 all pools LP 0.25% / protocol 0.05%; v3 by tier — 0.01% (LP 0.0075%, proto 0.0025%), 0.05% (0.0375% / 0.0125%), 0.30% (0.25% / 0.05%), 1.00% (0.8334% / 0.1666%). v2 protocol fee is fixed at 1/6 of swap fee, enabled via feeTo on factory. v3 configuration via governance-controlled flows. v4 adapters can be enabled through governance.

## Claims extracted
| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Protocol fees are a portion of swap fees redirected to protocol fee collection contracts instead of LPs | [[parameters/uniswap-v4/protocol-fee-config]] | - |
| #c2 | Protocol fees currently active on all Uniswap v2 pools and selected v3 pools | [[parameters/uniswap-v4/protocol-fee-config]] | - |
| #c3 | v2 fee split: LP 0.25%, protocol 0.05% (fixed at 1/6 of 0.30% total swap fee) | [[parameters/uniswap-v4/protocol-fee-config]] | - |
| #c4 | v3 fee splits by tier: 0.01% (LP 0.0075%, proto 0.0025%), 0.05% (0.0375% / 0.0125%), 0.30% (0.25% / 0.05%), 1.00% (0.8334% / 0.1666%) | [[parameters/uniswap-v4/protocol-fee-config]] | - |
| #c5 | v2 protocol fee enabled/disabled globally by setting feeTo on v2 factory through governance | [[parameters/uniswap-v4/protocol-fee-config]] | - |
| #c6 | v4 fee adapters are part of the broader protocol-fees architecture and can be enabled through governance | [[parameters/uniswap-v4/protocol-fee-config]] | - |
| #c7 | Participants submit release transactions to burn a required UNI amount and claim configured assets | [[parameters/uniswap-v4/protocol-fee-config]] | - |

## Conflicts raised
None.
