---
type: concept
domain: governance
name: Emergency Pause Authority
last_reviewed: 2026-04-29
disputed: false
---

# Emergency Pause Authority

## Definition
Who can halt trading, freeze a market, or suspend liquidations without going through the full governance process; the trigger conditions; and the published SLA for resumption or rollback. Captures the asymmetry between fast-path safety actions and slow-path policy changes. Maps to frame axis A7 (see [[schema/frame]]).

## Variants in the wild

| venue | pause authority | trigger conditions | resumption SLA |
|---|---|---|---|
| [[entities/perpdex/dydx]] | governance via Bridge Module enable/disable; software-upgrade procedure pauses chain at upgrade block height (validators signal readiness)[^dydx-docs-2026-04-28-concepts-trading-governance][^dydx-community-2026-04-28-modules-governance-proposal-lifecycle] | bridge fault, scheduled software upgrades (e.g. v5.0.0, v9 historical examples)[^dydx-community-2026-04-28-modules-governance-proposal-lifecycle] | not surfaced |
| [[entities/perpdex/orderly]] | Orderly may unilaterally adjust funding parameters in extreme conditions; multi-sig governance reserved authority[^orderly-docs-2026-04-29-funding-rate][^orderly-docs-2026-04-29-security] | permissionless-listing circuit breakers (depth, IF, funding anomalies) automatically force REDUCE_ONLY or delist; all-oracle-unavailable forces reduce-only mode[^orderly-docs-2026-04-29-permissionless-listing] | not surfaced |
| [[entities/perpdex/drift]] | State-account admin holds protocol-wide emergency flags via ExchangeStatus bitflag (DEPOSIT_PAUSED, WITHDRAW_PAUSED, AMM_PAUSED, FILL_PAUSED, LIQ_PAUSED, FUNDING_PAUSED, SETTLE_PNL_PAUSED, AMM_IMMEDIATE_FILL_PAUSED, PAUSED=255)[^drift-sdk-docs-2026-04-28-concepts-overview][^drift-developers-docs-2026-04-28-developers-concepts-account-model] | oracle 4-rule validity guard (Stale-AMM 10 slots, Stale-Margin 120 slots, InvalidPrice, TooVolatile, TooUncertain) blocks fills/withdraws/liquidations/funding when invalid; ≥50% deviation from 5-min oracle TWAP blocks liquidations[^drift-docs-2026-04-28-protocol-trading-oracles][^drift-docs-2026-04-28-protocol-trading-liquidations-liquidation-engine] | not surfaced |

## Edge cases
_(populated as claims are backfilled in Phase 2.)_

## Disputed claims
None.

## Related
[[concepts/governance/parameter-mutation-cadence]] . [[concepts/governance/veto-holders]] . [[concepts/security/incident-response-sla]]

## Sources
[^dydx-docs-2026-04-28-concepts-trading-governance]: [[sources/dydx-docs-2026-04-28-concepts-trading-governance]]
[^dydx-community-2026-04-28-modules-governance-proposal-lifecycle]: [[sources/dydx-community-2026-04-28-modules-governance-proposal-lifecycle]]
[^orderly-docs-2026-04-29-funding-rate]: [[sources/orderly-docs-2026-04-29-funding-rate]]
[^orderly-docs-2026-04-29-security]: [[sources/orderly-docs-2026-04-29-security]]
[^orderly-docs-2026-04-29-permissionless-listing]: [[sources/orderly-docs-2026-04-29-permissionless-listing]]
[^drift-sdk-docs-2026-04-28-concepts-overview]: [[sources/drift-sdk-docs-2026-04-28-concepts-overview]]
[^drift-developers-docs-2026-04-28-developers-concepts-account-model]: [[sources/drift-developers-docs-2026-04-28-developers-concepts-account-model]]
[^drift-docs-2026-04-28-protocol-trading-oracles]: [[sources/drift-docs-2026-04-28-protocol-trading-oracles]]
[^drift-docs-2026-04-28-protocol-trading-liquidations-liquidation-engine]: [[sources/drift-docs-2026-04-28-protocol-trading-liquidations-liquidation-engine]]
