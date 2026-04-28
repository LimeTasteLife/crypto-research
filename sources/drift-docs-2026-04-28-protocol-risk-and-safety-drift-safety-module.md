---
type: source
id: drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module
title: Drift Safety Module
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/protocol/risk-and-safety/drift-safety-module
mirror_snapshot: drift-docs-2026-04-28
mirror_page: pages/protocol-risk-and-safety-drift-safety-module.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Drift Safety Module

## TL;DR
The Drift Safety Module (DSM) is a fully on-chain automated bad-debt cover system. Users stake DRIFT into a DSM insurance fund pool; if a deficit arises in a given asset, staked DRIFT is automatically used as backstop, eliminating the need for governance intervention. Risk is asset-isolated: staking DRIFT covers bad debt in DRIFT pairs ONLY. Slashing is the symmetric risk to receiving safety incentives. Safety incentives can be defined via successfully-passed DAO governance proposals, and DAO proposals can also extend DRIFT utility (validator functions, etc.) over time. DSM is interactable via the app.drift.trade UI.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | The Drift Safety Module (DSM) is a fully on-chain system for automatically covering bad debt and managing protocol risk. | [[parameters/drift/insurance-fund]] | A6-PI, A8-PI |
| #c2 | DSM allows users to stake DRIFT into its insurance fund. | [[entities/token/drift]], [[parameters/drift/insurance-fund]] | A5-PI, A8-PI |
| #c3 | DSM enables corresponding staked assets to act as a backstop for bankruptcies if a deficit occurs in that asset, removing the need for governance decisions or manual intervention. | [[parameters/drift/insurance-fund]] | A6-PI, A7-PI |
| #c4 | DSM safety incentive parameters are determined by successfully-passed governance proposals by the DAO. | [[parameters/drift/insurance-fund]] | A7-PI |
| #c5 | Further DRIFT utility (validator and other network functions) can be added over time through DAO proposals. | [[entities/token/drift]] | A7-PI |
| #c6 | DSM stakers accept the possibility of slashing if a deficit arises on the specific pool and asset where their DRIFT is staked. | [[parameters/drift/insurance-fund]] | A5-PI, A6-PI |
| #c7 | Staking risk in DSM is isolated to the specific asset and network where the DRIFT is staked (e.g. staking DRIFT helps cover bad debt in DRIFT pairs only). | [[parameters/drift/insurance-fund]] | A6-PI |
| #c8 | Bankruptcy risk in DSM is compensated by the revenue pool, similar to other Insurance Fund pools on Drift. | [[parameters/drift/insurance-fund]] | A5-PI |
| #c9 | DSM can be interacted with using the app.drift.trade interface. | [[parameters/drift/insurance-fund]] | - |
