---
type: source
id: dydx-community-2026-04-28-modules-staking
title: Staking
publisher: dYdX Community Docs
author: dYdX community
date: null
original_url: https://docs.dydx.community/dydx/modules/staking
mirror_snapshot: dydx-community-2026-04-28
mirror_page: pages/modules-staking.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Staking

## TL;DR
dYdX Chain leverages CosmosSDK's x/staking module. Validators set their own commission rate but must respect `min_commission_rate`. Active Set is determined by stake weight, capped by `max_validators`, and updated each EndBlock. Bonded validators sign blocks, receive rewards, can be slashed, and can receive further delegations. Unbonded validators don't participate or earn rewards but can still receive delegations. Unbonding takes the duration of the `unbonding_time` parameter (this page says 21 days for unbonding, though docs.dydx.xyz says 30 days — see conflict). Redelegation lets a delegator move stake without waiting for unbonding, but slashing risk to the original validator persists for the unbonding period; 30-day cool-down before redelegating from the new validator. Validator winding-down best practices: update moniker, notify Operations subDAO, give 45-60 days notice.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | dYdX Chain leverages the Cosmos SDK Staking module to enable DYDX holders to become validators or delegate validation rights to validators. | [[entities/perpdex/dydx-v4]] | A8-PI |
| #c2 | Validators set their own commission rate but must follow the `min_commission_rate` parameter. | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c3 | The Active Set includes the top validators by total stake (delegated + self-delegated), determined by the `max_validators` parameter. | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c4 | The Active Set is updated during EndBlock by retrieving `validatorsbypower` and `max_validators`. | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c5 | A Bonded validator signs blocks, receives rewards, can receive further delegations, and can be slashed for misbehavior. | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c6 | Unbonded validators do not sign blocks and do not earn rewards but can still receive delegations. | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c7 | Inactive Set validators do not participate in consensus and do not receive rewards. | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c8 | Once a delegator initiates unstaking, DYDX tokens enter an unbonding period that lasts for the duration of the `unbonding_time` parameter. | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c9 | Redelegation moves staked tokens from one validator to another without an unbonding wait; the delegator's slashing risk with the original validator persists until the unbonding period concludes. | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c10 | After redelegating, a 30-day wait is required before redelegating again from the new validator. | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c11 | The unbonding period on dYdX Chain is currently 21 days. | [[parameters/dydx-v4/validator-requirements]] | A8-PI |
| #c12 | Validators winding down should give at least 45–60 days notice after announcement before fully ceasing operations. | [[parameters/dydx-v4/validator-requirements]] | A8-PII |
| #c13 | Validators winding down should notify the dYdX Operations SubDAO so they can be removed from monitoring tools. | [[parameters/dydx-v4/validator-requirements]] | A8-PII, A7-PV |

## Conflicts raised
- #c11 says unbonding is 21 days; `dydx-docs-2026-04-28-concepts-trading-rewards`#c25 says UnbondingTime is 30 days. Phase 2 must reconcile — likely the 30-day value in the docs.dydx.xyz page is the initial genesis default and 21 days is the current on-chain value (or vice versa).
