---
type: parameter
entity: [[drift]]
parameter: mm-rebate-tiers
unit: bps
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: false
---

# Drift MM rebate tiers

## Current (as of 2026-04-28)

**Base maker rebate.** Non-BTC/ETH perpetuals: flat -0.25 bps maker rebate (AMM and User counterparty); `post only` flag required[^drift-docs-2026-04-28-protocol-market-makers-maker-fee-rebate].

**AMM-fill carve-out.** Maker orders filling against the AMM are NOT eligible for rebate[^drift-docs-2026-04-28-protocol-about-v3-decentralized-orderbook].

**DRIFT staking boost.** +5% to +40% rebate boost stacking on the -0.25 bps base (Kickstarter 1k / Racer 10k / Elite 50k / Master 100k / Champion 250k DRIFT)[^drift-docs-2026-04-28-protocol-market-makers-maker-fee-rebate][^drift-docs-2026-04-28-protocol-trading-trading-fees].

**Opt-in MM Rewards Alpha Program.** Advertised as available; details not fully surfaced in this snapshot[^drift-docs-2026-04-28-index].

**Reference bots.** Drift open-sources FloatingPerpMaker (oracle-offset DLOB) and JitMaker (JIT fills via `JitterSniper` / `JitterShotgun` from `@drift-labs/jit-proxy`)[^drift-developers-docs-2026-04-28-developers-market-makers]. Drift itself runs the floating maker bot on-platform for-profit with additional risk parameters (explicit protocol-as-MM disclosure)[^drift-docs-2026-04-28-protocol-market-makers-market-maker-participation].

**Three MM strategies.** DLOB MM (resting two-sided post-only, oracle offset orders, ~30 tx/day), JIT-only (react to taker auctions, capital on fill only), SWIFT API (100-500ms head-start offchain signed-message flow)[^drift-developers-docs-2026-04-28-developers-market-makers]. All three earn the same maker rebates with no additional SWIFT-specific fees[^drift-developers-docs-2026-04-28-developers-market-makers-swift-api].

**Maker rebate program subject to change.** Drift disclaims permanence of the maker rebate program[^drift-docs-2026-04-28-protocol-market-makers-maker-fee-rebate].

## Time series

| effective | base rebate (non-BTC/ETH) | staking boost range | AMM-fill eligible | source |
|---|---|---|---|---|
| 2026-04-28 | -0.25 bps | +5% to +40% | no | [^drift-docs-2026-04-28-protocol-market-makers-maker-fee-rebate] |

## Disputed values
None.

## Sources
[^drift-docs-2026-04-28-protocol-market-makers-maker-fee-rebate]: [[sources/drift-docs-2026-04-28-protocol-market-makers-maker-fee-rebate]]
[^drift-docs-2026-04-28-protocol-about-v3-decentralized-orderbook]: [[sources/drift-docs-2026-04-28-protocol-about-v3-decentralized-orderbook]]
[^drift-docs-2026-04-28-protocol-trading-trading-fees]: [[sources/drift-docs-2026-04-28-protocol-trading-trading-fees]]
[^drift-docs-2026-04-28-index]: [[sources/drift-docs-2026-04-28-index]]
[^drift-developers-docs-2026-04-28-developers-market-makers]: [[sources/drift-developers-docs-2026-04-28-developers-market-makers]]
[^drift-developers-docs-2026-04-28-developers-market-makers-swift-api]: [[sources/drift-developers-docs-2026-04-28-developers-market-makers-swift-api]]
[^drift-docs-2026-04-28-protocol-market-makers-market-maker-participation]: [[sources/drift-docs-2026-04-28-protocol-market-makers-market-maker-participation]]
