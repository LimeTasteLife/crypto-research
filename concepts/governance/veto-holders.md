---
type: concept
domain: governance
name: Veto Holders
last_reviewed: 2026-04-29
disputed: false
---

# Veto Holders

## Definition
Actors with authority to block or roll back a governance proposal before execution. Captures who holds the veto right (foundation, multisig, token quorum, validator set), the threshold required, the window it applies in, and the historical record of use. Maps to frame axis A7 (see [[schema/frame]]).

## Variants in the wild

| venue | veto authority | threshold | history |
|---|---|---|---|
| [[entities/perpdex/dydx]] | bonded-DYDX stakers (validators inherit-by-default for unvoted delegations); proposals failing veto are burned (`burn_vote_veto=True`)[^dydx-community-2026-04-28-modules-governance][^dydx-community-2026-04-28-modules-governance-proposal-lifecycle] | veto_threshold = 33.4% of votes cast (with quorum 33.4%, threshold 50%)[^dydx-community-2026-04-28-modules-governance] | not surfaced |

## Edge cases
_(populated as claims are backfilled in Phase 2.)_

## Disputed claims
None.

## Related
[[concepts/governance/parameter-mutation-cadence]] . [[concepts/governance/emergency-pause-authority]] . [[concepts/governance/governance-vs-ops-separation]]

## Sources
[^dydx-community-2026-04-28-modules-governance]: [[sources/dydx-community-2026-04-28-modules-governance]]
[^dydx-community-2026-04-28-modules-governance-proposal-lifecycle]: [[sources/dydx-community-2026-04-28-modules-governance-proposal-lifecycle]]
