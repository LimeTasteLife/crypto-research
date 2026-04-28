---
type: entity
subtype: network
name: Hyperliquid L1
status: live
launched: 2023-Q2
sources_count: 5
last_reviewed: 2026-04-28
disputed: false
---

# Hyperliquid L1

> A purpose-built proof-of-stake L1 secured by HyperBFT consensus, hosting both a fully on-chain CLOB exchange (HyperCore) and a general-purpose EVM (HyperEVM).

## Snapshot
- Consensus: [[concepts/operations/sequencer]] — HyperBFT (HotStuff-variant BFT)[^hl-docs-2026-04-27-hyperliquid-docs][^hl-docs-2026-04-27-hypercore-overview]
- Native token: [[entities/token/hype]] (staked for validator set selection)
- Execution layers: HyperCore (perp/spot CLOB) + HyperEVM (general EVM)
- Hosts: [[entities/perpdex/hyperliquid]]

## Mechanism

**Consensus.** HyperBFT is a custom HotStuff-derived BFT algorithm; both the algorithm and the networking stack are optimized from the ground up for the L1[^hl-docs-2026-04-27-hyperliquid-docs]. Validator block production is weighted by staked HYPE (delegated proof-of-stake; "delegate" and "stake" are interchangeable)[^hl-docs-2026-04-27-hypercore-overview][^hl-docs-2026-04-27-hypercore-staking].

**Quorum.** A quorum is any validator set holding more than 2/3 of total stake[^hl-docs-2026-04-27-hypercore-staking].

**Epochs.** The validator set is static within a staking epoch; epochs are 100k consensus rounds, approximately 90 minutes on mainnet[^hl-docs-2026-04-27-hypercore-staking].

**Validator security.** Validators may vote (quorum required) to jail peers exhibiting inadequate latency or response frequency; jailed validators cease consensus participation and produce no rewards for delegators, with rate-limited on-chain unjailing[^hl-docs-2026-04-27-hypercore-staking]. Slashing is reserved for provably malicious behavior such as double-signing and is distinct from jailing; no automatic slashing is currently implemented[^hl-docs-2026-04-27-hypercore-staking].

**HyperEVM relation.** HyperEVM is not a separate chain; it is secured by the same HyperBFT consensus as HyperCore[^hl-docs-2026-04-27-hyperevm]. This unified-chain design avoids the bridging surface that separate-chain L2 architectures introduce.

## Relations
- [[entities/network/hyperliquid-l1]] **operates** [[entities/perpdex/hyperliquid]][^hl-docs-2026-04-27-hyperliquid-docs]
- [[entities/network/hyperliquid-l1]] **uses** [[concepts/operations/sequencer]] (HyperBFT)[^hl-docs-2026-04-27-hypercore-overview]

## Parameters
- [[parameters/hyperliquid/validator-requirements]] — self-delegation, lockup, commission, jailing
- [[parameters/hyperliquid/staking-rewards]] — distribution cadence, sqrt-stake formula

## Open questions
- What is the validator set size, and how is it bounded?
- How is double-sign slashing implemented in code, given "no automatic slashing currently"?

## Disputed claims
None.

## Related
[[entities/perpdex/hyperliquid]] · [[entities/token/hype]] · [[concepts/operations/sequencer]] · [[parameters/hyperliquid/validator-requirements]]

## Sources
[^hl-docs-2026-04-27-hyperliquid-docs]: [[sources/hl-docs-2026-04-27-hyperliquid-docs]]
[^hl-docs-2026-04-27-hypercore-overview]: [[sources/hl-docs-2026-04-27-hypercore-overview]]
[^hl-docs-2026-04-27-hypercore-staking]: [[sources/hl-docs-2026-04-27-hypercore-staking]]
[^hl-docs-2026-04-27-hyperevm]: [[sources/hl-docs-2026-04-27-hyperevm]]
[^hl-docs-2026-04-27-about-hyperliquid]: [[sources/hl-docs-2026-04-27-about-hyperliquid]]
