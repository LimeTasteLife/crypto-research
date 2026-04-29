---
type: entity
subtype: token
name: DRIFT
network: [[entities/network/solana]]
status: live
launched: null
sources_count: 4
last_reviewed: 2026-04-28
disputed: false
---

# DRIFT

> Protocol-level governance and backstop token of Drift Protocol on Solana.

## Snapshot
- Network: [[entities/network/solana]]
- Venue: [[entities/perpdex/drift]]
- Utility: fee-discount staking, Drift Safety Module backstop, governance

## Asset profile

DRIFT is the protocol-level governance and backstop token of Drift Protocol[^drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module].

- **Fee-discount staking** with six tiers (Rookie 0 / Kickstarter 1k / Racer 10k / Elite 50k / Master 100k / Champion 250k DRIFT) granting 0% / 5% / 10% / 20% / 30% / 40% taker discount with matching maker rebate boost -- applied to perp fees only and stacking on the volume tier[^drift-docs-2026-04-28-protocol-trading-trading-fees]. Maker rebate boost up to +40% applies to the -0.25 bps base[^drift-docs-2026-04-28-protocol-market-makers-maker-fee-rebate].
- **Drift Safety Module backstop** -- DRIFT staked into DSM acts as an automated bad-debt cover for DRIFT-pair markets only (asset-isolated), with slashing as the symmetric risk to safety incentives[^drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module].
- **Governance** -- DSM safety incentive parameters and further DRIFT utility (validator and other network functions) are added through successfully-passed DAO governance proposals[^drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module].
- **Bankruptcy compensation source** -- DSM stakers' bankruptcy risk is compensated by the Revenue Pool, the same source that funds standard IF Staking yield[^drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module].

Out of this snapshot's scope (deferred to future ingest): total supply, vesting schedule, treasury / team / community / airdrop / ecosystem allocation breakdown, listing date, contract address, current holder distribution.

## Relations
- [[entities/token/drift]] **applies_to** [[parameters/drift/fee-schedule]] as a six-tier staking discount[^drift-docs-2026-04-28-protocol-trading-trading-fees]
- [[entities/token/drift]] **is_collateral_for** the Drift Safety Module (DRIFT staked into DSM covers bad debt in DRIFT-pair markets only)[^drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module]
- [[entities/perpdex/drift]] **distributes_to** [[entities/token/drift]] via Revenue Pool flows that fund DSM incentives[^drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module]

## Open questions
- Total DRIFT supply and full unlock/emissions schedule?
- DRIFT holder distribution (top-N concentration)?
- Contract address?

## Disputed claims
None.

## Related
[[entities/perpdex/drift]] . [[parameters/drift/fee-schedule]] . [[parameters/drift/insurance-fund]]

## Sources
[^drift-docs-2026-04-28-protocol-trading-trading-fees]: [[sources/drift-docs-2026-04-28-protocol-trading-trading-fees]]
[^drift-docs-2026-04-28-protocol-market-makers-maker-fee-rebate]: [[sources/drift-docs-2026-04-28-protocol-market-makers-maker-fee-rebate]]
[^drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module]: [[sources/drift-docs-2026-04-28-protocol-risk-and-safety-drift-safety-module]]
