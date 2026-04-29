---
type: source
id: uniswap-v4-protocol-fee-2026-04-29-guides-best-practices
title: Protocol Fee Best Practices
publisher: Uniswap Docs
author: Uniswap team
date: 2026-04-29
original_url: https://docs.uniswap.org/contracts/protocol-fee/guides/best-practices
mirror_snapshot: uniswap-v4-protocol-fee-2026-04-29
mirror_page: pages/guides-best-practices.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-29
---

# Protocol Fee Best Practices

## TL;DR
Security best practices for the protocol fee system. Nonce mechanism: never read nonce at transaction time (front-running vulnerable); caller reads Firepit.nonce() off-chain and passes as calldata. v3 fees must be collected to AssetSink before release eligibility via IV3FeeController.collect(). UNI approval risk: threshold is updateable by thresholdSetter; max-approving UNI may lead to unexpected higher burn; mitigations include balance checks, exact-amount approvals, minimal UNI holdings. Recipients must be payable (system can release native ETH). v2 protocol fees are automatically pushed as ERC-20 LP tokens; underlying value computation requires pool-reserve math with slippage validation.

## Claims extracted
| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Nonce mechanism prevents front-running; a successful front-run would cause victim to burn substantial UNI for little/no assets | [[parameters/uniswap-v4/protocol-fee-config]] | - |
| #c2 | Firepit.threshold() is updateable by thresholdSetter; max-approving UNI carries excess-burn risk | [[parameters/uniswap-v4/protocol-fee-config]] | - |
| #c3 | v3 fees must be collected to AssetSink before release eligibility via IV3FeeController.collect() | [[parameters/uniswap-v4/protocol-fee-config]] | - |
| #c4 | v2 protocol fees are automatically pushed as ERC-20 LP tokens to AssetSink | [[parameters/uniswap-v4/protocol-fee-config]] | - |
| #c5 | Protocol fee system can release native tokens (ETH); recipients must be payable | [[parameters/uniswap-v4/protocol-fee-config]] | - |

## Conflicts raised
None.
