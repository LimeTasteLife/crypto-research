---
type: source
id: dydx-community-2026-04-28-modules-governance-proposal-lifecycle
title: Proposal Lifecycle
publisher: dYdX Community Docs
author: dYdX community
date: null
original_url: https://docs.dydx.community/dydx/modules/governance/proposal-lifecycle
mirror_snapshot: dydx-community-2026-04-28
mirror_page: pages/modules-governance-proposal-lifecycle.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Proposal Lifecycle

## TL;DR
Eight-stage governance lifecycle: Forum Discussion → DRC Creation (off-chain) → DRC Discussion (~4d) → DIP Creation (JSON file) → On-chain Submission → Deposits → Voting → Tallying & Execution. Each proposal type has specific JSON fields. The voting period starts when min_deposit is reached; depositors are refunded unless NoWithVeto reaches veto_threshold. Stakers who don't vote inherit their validator's vote. Tallying applies quorum/threshold/veto_threshold parameters. Execution depends on type — Parameter Change goes into effect block after voting; Software Upgrade requires validator signaling and chain pause at the upgrade block height.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | dYdX governance proposal lifecycle has 8 stages: Forum Discussion, DRC Creation (off-chain), DRC Discussion (off-chain, ~4 days suggested), DIP Creation (off-chain), Submitting a Proposal (on-chain), Proposal Deposits (on-chain), DIP Voting (on-chain), Tallying & Execution (on-chain). | [[parameters/dydx-v4/governance-params]] | A7-PI, A7-PII |
| #c2 | dYdX governance forums are hosted at https://dydx.forum/. | [[parameters/dydx-v4/governance-params]] | A7-PV |
| #c3 | The DRC Discussion and Feedback step aims to establish rough consensus before a vote starts; four days is the suggested duration. | [[parameters/dydx-v4/governance-params]] | A7-PI |
| #c4 | A proposal must include a JSON file with title, description, deposit (in aDYDX), and type-specific fields (recipient/amount for community-spending, subspace/key/value for parameter-change, plan for software-upgrade). | [[parameters/dydx-v4/governance-params]] | A7-PV |
| #c5 | If the `<proposal type>` argument is left blank, the type defaults to Text proposal; alternatives are `param-change`, `software-upgrade`, or `community-treasury-spend`. | [[parameters/dydx-v4/governance-params]] | A7-PI |
| #c6 | The voting period starts as soon as min_deposit is reached within max_deposit_period. | [[parameters/dydx-v4/governance-params]] | A7-PI |
| #c7 | If min_deposit is not satisfied within max_deposit_period and burn_proposal_deposit_prevote is False, depositors get refunded. | [[parameters/dydx-v4/governance-params]] | A7-PI |
| #c8 | If min_deposit is satisfied, deposit stays in escrow until proposal is finalized; depositors are refunded unless NoWithVeto reaches veto_threshold. | [[parameters/dydx-v4/governance-params]] | A7-PI |
| #c9 | Only staked DYDX tokens can vote on dYdX Chain governance proposals. | [[parameters/dydx-v4/governance-params]] | A7-PI |
| #c10 | Parameter Change Proposals take effect in the block after the voting period ends. | [[parameters/dydx-v4/governance-params]] | A7-PII |
| #c11 | Software Upgrade execution: validators upgrade and signal readiness; at the specified block height the chain pauses; validators apply the upgrade and restart their nodes. | [[parameters/dydx-v4/governance-params]] | A7-PII, A8-PII |
