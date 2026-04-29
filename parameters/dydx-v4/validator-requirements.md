---
type: parameter
entity: [[dydx]]
parameter: validator-requirements
unit: mixed
last_change: 2026-04-28
last_reviewed: 2026-04-29
disputed: true
---

# dYdX v4 validator-requirements

## Current (as of 2026-04-28)
- max_validators: 60[^dydx-docs-2026-04-28-concepts-trading-rewards]
- min_commission_rate: 5%[^dydx-docs-2026-04-28-concepts-trading-rewards]
- Default validator commission rate: 100%[^dydx-docs-2026-04-28-concepts-trading-rewards]
- Unbonding period: 21 days (disputed: 30 days per docs.dydx.xyz)[^dydx-community-2026-04-28-modules-staking][^dydx-docs-2026-04-28-concepts-trading-rewards]
- Slashing window: signed_blocks_window = 8,192 blocks (~3h11m at 1.4s blocks)[^dydx-community-2026-04-28-modules-slashing]
- min_signed_per_window: 0.2 (20%)[^dydx-community-2026-04-28-modules-slashing]
- downtime_jail_duration: 7,200s (2h)[^dydx-community-2026-04-28-modules-slashing]
- slash_fraction_double_sign: 0.0 (no monetary slash; tombstoning still applies)[^dydx-community-2026-04-28-modules-slashing][^dydx-docs-2026-04-28-concepts-trading-rewards]
- slash_fraction_downtime: 0.0 (no monetary slash; jailing still applies)[^dydx-community-2026-04-28-modules-slashing]
- Hardware: >=500 GiB locally-attached SSD, >=64 GiB RAM, >=8-core x86_64 (AWS r6id.2xlarge equivalent)[^dydx-chain-tech-2026-04-28-validators-getting-set-up-hardware-requirements]
- Winding-down validators: 45-60 days notice, notify dYdX Operations subDAO[^dydx-community-2026-04-28-modules-staking]
- Liveness formula: `maxMissed = signed_blocks_window - min_signed_per_window * signed_blocks_window`[^dydx-community-2026-04-28-modules-slashing]

## Time series

| effective | param | value | source |
|---|---|---|---|
| 2026-04-28 (community docs) | unbonding_time | 21 days | [^dydx-community-2026-04-28-modules-staking] |
| 2026-04-28 (docs.dydx.xyz) | unbonding_time | 30 days | [^dydx-docs-2026-04-28-concepts-trading-rewards] |

## Tiering rules / formulae
- Active Set updated each EndBlock by stake weight[^dydx-docs-2026-04-28-concepts-trading-rewards]
- Jailed validators must send `MsgUnjail` to return after downtime jailing[^dydx-community-2026-04-28-modules-slashing]

## Disputed values

### #dispute-unbonding-period

**Claim A** . confidence: high . recency: 2026-04 . authority: high
  Unbonding period: 21 days[^dydx-community-2026-04-28-modules-staking].

**Claim B** . confidence: medium . recency: 2026-04 . authority: high
  UnbondingTime = 30 days[^dydx-docs-2026-04-28-concepts-trading-rewards].
  status: likely_superseded

## Sources
[^dydx-docs-2026-04-28-concepts-trading-rewards]: [[sources/dydx-docs-2026-04-28-concepts-trading-rewards]]
[^dydx-community-2026-04-28-modules-staking]: [[sources/dydx-community-2026-04-28-modules-staking]]
[^dydx-community-2026-04-28-modules-slashing]: [[sources/dydx-community-2026-04-28-modules-slashing]]
[^dydx-chain-tech-2026-04-28-validators-getting-set-up-hardware-requirements]: [[sources/dydx-chain-tech-2026-04-28-validators-getting-set-up-hardware-requirements]]
