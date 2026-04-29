---
type: concept
domain: listing
name: Listing playbook
last_reviewed: 2026-04-28
disputed: false
---

# Listing playbook

## Definition
A listing playbook is the venue's documented procedure for getting a new asset live on the order book — covering listing modality (auction / governance / depth-gated / deposit-gated / pre-launch tier), risk-param calibration at launch, oracle composition during the listing window, and the corresponding delisting/sunset procedure (the offboarding half — `concepts/listing/delisting-policy` page TBD).

## Mechanism on Hyperliquid

**Permissionless spot via auction.** An ERC-20 on HyperEVM can be linked to a HyperCore spot asset deployed permissionlessly via spot auction[^hl-docs-2026-04-27-hyperevm]. This is the canonical Hyperliquid spot listing path (HIP-1).

**Permissionless perp via HIP-3.** HIP-3 deployers configure the perp's fee share, growth-mode flag, and (for funding) the funding-rate multiplier and interest rate[^hl-docs-2026-04-27-trading-fees][^hl-docs-2026-04-27-trading-funding]. Protocol fees scale with deployer share if share > 100%[^hl-docs-2026-04-27-trading-fees].

(Full launch-time risk-param calibration policy, FDV sanity bound, and the symmetric delisting playbook are not surfaced in primary docs at this snapshot — flagged as A1/PII gap on Hyperliquid's Frame coverage.)

## Variants in the wild

| venue | spot listing | perp listing | delisting symmetry |
|---|---|---|---|
| [[entities/perpdex/hyperliquid]] | permissionless auction (HIP-1)[^hl-docs-2026-04-27-hyperevm] | permissionless deployer (HIP-3)[^hl-docs-2026-04-27-trading-fees] | not surfaced |
| [[entities/perpdex/aster]] | not surfaced | pre-launch expiry futures auto-converting to perp + standard listing for crypto and equity perps (AAPL/TSLA/NVDA/AMZN/META/GOOG/MSFT)[^aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts][^aster-docs-2026-04-28-trading-perpetuals-market-maker-program] | not surfaced |
| [[entities/perpdex/orderly]] | no spot market | dual-path: standard (Orderly-approved, $20M mcap, 3+ oracles, LP depth) + permissionless (Diamond Tier Builders, POST_ONLY→ACTIVE depth gate, per-Builder IF $50k/symbol); circuit breakers → REDUCE_ONLY / delisting[^orderly-docs-2026-04-29-permissionless-listing][^orderly-listing-2026-04-29-listing] | yes — circuit breakers (depth/IF/funding) trigger REDUCE_ONLY or delisting; per-Builder IF depletion scopes ADL to single market[^orderly-docs-2026-04-29-permissionless-listing] |
## Disputed claims
None at first ingest.

## Related
[[parameters/hyperliquid/listed-markets-roster]] · [[concepts/market-microstructure/oracle-spec]] · [[concepts/risk/leverage-cap]]

## Sources
[^hl-docs-2026-04-27-hyperevm]: [[sources/hl-docs-2026-04-27-hyperevm]]
[^hl-docs-2026-04-27-trading-fees]: [[sources/hl-docs-2026-04-27-trading-fees]]
[^hl-docs-2026-04-27-trading-funding]: [[sources/hl-docs-2026-04-27-trading-funding]]
[^aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts]: [[sources/aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts]]
[^aster-docs-2026-04-28-trading-perpetuals-market-maker-program]: [[sources/aster-docs-2026-04-28-trading-perpetuals-market-maker-program]]
[^orderly-docs-2026-04-29-permissionless-listing]: [[sources/orderly-docs-2026-04-29-permissionless-listing]]
[^orderly-listing-2026-04-29-listing]: [[sources/orderly-listing-2026-04-29-listing]]
