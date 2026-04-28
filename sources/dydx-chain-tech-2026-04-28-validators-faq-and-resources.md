---
type: source
id: dydx-chain-tech-2026-04-28-validators-faq-and-resources
title: FAQ & Resources (Validators)
publisher: dYdX Community Docs (chain technical)
author: dYdX community
date: null
original_url: https://docs.dydx.community/dydx-chain-technical-docs/validators/faq-and-resources
mirror_snapshot: dydx-chain-tech-2026-04-28
mirror_page: pages/validators-faq-and-resources.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# FAQ & Resources (Validators)

## TL;DR
Validator-operator Q&A. No minimum stake but only top 60 validators are active. Active set capped at 60. Most validators are professional staking firms (NOT trading firms). dYdX Foundation hosts the general validator FAQ. Validator logo registration via PR to cosmostation/chainlist. Snapshot example references include backup/recovery of priv_validator_state.json. MEV detection: Skip dashboard has a "subtle bug with the price discrepancy calculation; no authentic MEV detected so far." Nodes should respect cancels as soon as received — failure is treated as MEV. Geographic distribution dashboard exists at observatory-staging-g4ywd.ondigitalocean.app/dydx/countries.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | The dYdX validator general FAQ is managed by dYdX Foundation at https://www.dydx.foundation/validators/faqs-resources. | [[entities/actor/dydx-foundation]] | A7-PV |
| #c2 | There is no minimum stake requirement on dYdX; the active validators are simply the top 60 by total stake (self-bonded + delegators). | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c3 | The active validator set is limited to 60. | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c4 | A non-validating full node does not propose blocks but still validates chain data. | [[parameters/dydx-v4/validator-requirements]] | A1-PI |
| #c5 | The empty Prepare/PrepareProposal flag sets an empty Prepare/PrepareProposal for the application; full nodes do not participate in voting. | [[parameters/dydx-v4/validator-requirements]] | A1-PI |
| #c6 | Validator logo registration is done via a PR to https://github.com/cosmostation/chainlist/tree/main/chain/dydx/moniker. | [[parameters/dydx-v4/validator-requirements]] | - |
| #c7 | Most or all dYdX validators are professional firms in the staking/validating business, not trading firms. | [[parameters/dydx-v4/validator-requirements]] | A4-PI, A8-PI |
| #c8 | A list of mainnet validators is available at https://www.mintscan.io/visualization/validators. | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c9 | A geographic distribution dashboard for dYdX validators is hosted at https://observatory-staging-g4ywd.ondigitalocean.app/dydx/countries. | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c10 | Validators usually do not expose RPC endpoints for direct order submission. | [[parameters/dydx-v4/validator-requirements]] | A4-PI |
| #c11 | The Skip MEV detection dashboard has a known subtle bug in price-discrepancy calculation; no authentic MEV has been detected so far. | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c12 | Nodes should respect cancels as soon as they receive them; failure to do so is treated as MEV. | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c13 | Staking rewards are distributed each block to the block proposer; expected return depends on both fees and total dYdX staked. | [[parameters/dydx-v4/staking-rewards]] | A2-PI |
| #c14 | Locked DYDX can be used to stake to validators. | [[parameters/dydx-v4/staking-rewards]] | A2-PI |
| #c15 | Port 9090 is the gRPC port; port 26657 is for validator/full-node operators (not used by general gRPC clients). | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
