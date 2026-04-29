---
type: source
id: uniswap-v4-protocol-fee-2026-04-29-deployments
title: Protocol Fee Deployments
publisher: Uniswap Docs
author: Uniswap team
date: 2026-04-29
original_url: https://docs.uniswap.org/contracts/protocol-fee/deployments
mirror_snapshot: uniswap-v4-protocol-fee-2026-04-29
mirror_page: pages/deployments.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-29
---

# Protocol Fee Deployments

## TL;DR
Protocol fee system deployed on Ethereum mainnet and Unichain. Ethereum: MainnetDeployer (0xd3Aa…0C), TokenJar/AssetSink (0xf385…85), Firepit Releaser (0x0D5C…21), V3FeeAdapter (0x5E74…7d), UNI (0x1f98…84). Unichain: UnichainDeployer (0xD16c…ea), TokenJar (0xD576…b5), OptimismBridgedResourceFirepit (0xe0A7…eB). The MainnetDeployer constructor atomically: deploys AssetSink, deploys Firepit with UNI threshold, sets Firepit as releaser, transfers ownership of both to Uniswap Governance Timelock, deploys V3FeeController with AssetSink destination, sets initial feeSetter as Governance Timelock. Enabling fee values requires governance vote: setFeeTo on v2 factory + setMerkleRoot on V3FeeController.

## Claims extracted
| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Protocol fee system deployed on Ethereum mainnet and Unichain | [[parameters/uniswap-v4/protocol-fee-config]] | - |
| #c2 | Ethereum mainnet contracts: TokenJar (0xf38521f130fcCF29dB1961597bc5d2B60F995f85), Firepit (0x0D5Cd355e2aBEB8fb1552F56c965B867346d6721), V3FeeAdapter (0x5E74C9f42EEd283bFf3744fBD1889d398d40867d) | [[parameters/uniswap-v4/protocol-fee-config]] | - |
| #c3 | All ownership transfers go to Uniswap Governance Timelock | [[parameters/uniswap-v4/governance-params]] | - |
| #c4 | Enabling fee values requires a Uniswap Governance vote: setFeeTo on v2 factory + setMerkleRoot on V3FeeController | [[parameters/uniswap-v4/governance-params]] | - |
| #c5 | Unichain uses OptimismBridgedResourceFirepit for cross-chain fee relay | [[parameters/uniswap-v4/protocol-fee-config]] | - |

## Conflicts raised
None.
