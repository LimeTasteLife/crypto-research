---
type: source
id: dydx-community-2026-04-28-modules-governance
title: Governance
publisher: dYdX Community Docs
author: dYdX community
date: null
original_url: https://docs.dydx.community/dydx/modules/governance
mirror_snapshot: dydx-community-2026-04-28
mirror_page: pages/modules-governance.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Governance

## TL;DR
dYdX governance uses CosmosSDK's standard x/gov module. Five proposal types (text, parameter change, community spending, software upgrade, new market). Vote weight equals actively-staked DYDX (1:1). Stakers who don't vote inherit their validator's vote. Voting options: Yes / No / NoWithVeto / Abstain. Key parameters: min_deposit 2,000 DYDX (2,000,000,000,000,000,000,000 adydx), max_deposit_period 7 days, min_initial_deposit_ratio 20%, voting_period ~4 days, quorum 33.4%, threshold 50%, veto_threshold 33.4%, expedited threshold 75% with 1-day voting. burn_vote_veto=True (failed-by-veto deposits are burned). Conflicts with docs.dydx.xyz/concepts/trading/rewards which lists 10,000-token min deposit and 1-day max-deposit-period — community page reflects current on-chain values.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | dYdX Chain governance uses the standard x/gov module in the Cosmos SDK. | [[parameters/dydx-v4/governance-params]] | A7-PI |
| #c2 | A DYDX holder's vote weight equals the amount of actively-staked DYDX (1:1); unstaked or unbonding DYDX does not count. | [[parameters/dydx-v4/governance-params]] | A7-PI |
| #c3 | If a DYDX staker does not vote on a proposal, they inherit the vote of their validator. | [[parameters/dydx-v4/governance-params]] | A7-PI |
| #c4 | Governance min_deposit = 2,000 DYDX (2,000,000,000,000,000,000,000 adydx). | [[parameters/dydx-v4/governance-params]] | A7-PI |
| #c5 | Governance max_deposit_period = 604,800 seconds (7 days). | [[parameters/dydx-v4/governance-params]] | A7-PI |
| #c6 | Governance min_initial_deposit_ratio = 0.2 (20% of min_deposit must be submitted by the proposer). | [[parameters/dydx-v4/governance-params]] | A7-PI |
| #c7 | Governance voting_period = 345,600 seconds (~4 days). | [[parameters/dydx-v4/governance-params]] | A7-PI |
| #c8 | Governance quorum = 0.334 (33.4%). | [[parameters/dydx-v4/governance-params]] | A7-PI |
| #c9 | Governance threshold = 0.5 (50% Yes votes required to pass; Abstain not counted). | [[parameters/dydx-v4/governance-params]] | A7-PI |
| #c10 | Governance veto_threshold = 0.334 (33.4% NoWithVeto rejects regardless of Yes vote count). | [[parameters/dydx-v4/governance-params]] | A7-PI |
| #c11 | burn_vote_veto = True — vetoed proposal deposits are burned. | [[parameters/dydx-v4/governance-params]] | A7-PI |
| #c12 | burn_vote_quorum = False — proposal deposits are not burned if quorum is missed. | [[parameters/dydx-v4/governance-params]] | A7-PI |
| #c13 | burn_proposal_deposit_prevote = False — deposits are refunded if the proposal does not enter the voting period. | [[parameters/dydx-v4/governance-params]] | A7-PI |
| #c14 | Expedited proposal threshold = 0.75 (75% Yes votes), with quorum 33.4% and shortened voting period of 86,400 seconds (~1 day). | [[parameters/dydx-v4/governance-params]] | A7-PI |
| #c15 | If an expedited proposal does not meet threshold within the shortened voting period, it converts to a regular proposal and voting restarts. | [[parameters/dydx-v4/governance-params]] | A7-PI |
| #c16 | Expedited proposals can be used for any vote type (Text, Community Spend, Parameter Change, Adding Markets, Software Upgrades). | [[parameters/dydx-v4/governance-params]] | A7-PI |
| #c17 | dYdX governance includes 5 proposal types: text, parameter change, community spending, software upgrade, new market. | [[parameters/dydx-v4/governance-params]] | A7-PI |
| #c18 | Voting options on dYdX: Yes, No, NoWithVeto, Abstain. | [[parameters/dydx-v4/governance-params]] | A7-PI |

## Conflicts raised
- #c4 (min_deposit 2,000 DYDX) vs `dydx-docs-2026-04-28-concepts-trading-rewards`#c26 (which says MinDeposit = 10,000 governance token). Likely the docs.dydx.xyz value reflects the initial/genesis default while the community-docs value (2,000 DYDX) is the current on-chain value.
- #c5 (max_deposit_period 7 days) vs `dydx-docs-2026-04-28-concepts-trading-rewards`#c26 (which says Max Deposit Period = 1 Days). Same likely cause.
