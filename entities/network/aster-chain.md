---
type: entity
subtype: network
name: Aster Chain
status: live
launched: 2025
sources_count: 4
last_reviewed: 2026-04-28
disputed: false
---

# Aster Chain

> A purpose-built L1 for privacy-focused perpetuals trading, advertising 100,000+ TPS and 50ms block latency, with an encrypted-order pipeline that hides order content from on-chain observers until execution.

## Snapshot
- Consensus: not named in primary docs (validator-PoS implied via [[parameters/aster/staking-rewards]] Base APY allocated by share of network transactions processed)[^aster-docs-2026-04-28-aster-chain-staking-how-staking-works]
- Throughput target: 100,000+ TPS[^aster-docs-2026-04-28-overview-what-is-aster]
- Latency target: 50ms block latency[^aster-docs-2026-04-28-overview-what-is-aster]
- Privacy mechanism: orders encrypted before reaching the chain, decrypted only at execution; order book entries do not expose position size, entry, or liquidation level[^aster-docs-2026-04-28-overview-what-is-aster]
- Hosts: [[entities/perpdex/aster]] (Perps, Shield Mode, 1001x, Spot) plus Aster Earn products (asBNB, asUSDF, asBTC, asCAKE) and the [[entities/token/usdf]] stablecoin[^aster-docs-2026-04-28-overview-what-is-aster][^aster-docs-2026-04-28-overview-smart-contracts]

## Mechanism

**Performance claims.** Aster Chain is described as an L1 built specifically for private perps trading, targeting 100,000+ transactions per second and 50ms block latency[^aster-docs-2026-04-28-overview-what-is-aster]. These figures are stated as design targets in the "What is Aster?" overview and are not corroborated against benchmark data anywhere in the primary docs.

**Encrypted-order pipeline.** The defining differentiator is that every order is encrypted before it reaches the chain and only decrypted at execution; order book entries do not expose position size, entry point, or liquidation level to on-chain observers[^aster-docs-2026-04-28-overview-what-is-aster]. The docs frame this as a direct response to position-hunting on transparent perpdexes. The cryptographic primitive (e.g., MPC, threshold decryption, FHE, TEE) is not specified in any of the surveyed pages.

**Validator and staking model.** Aster Chain runs a validator-PoS model in which validator and delegator stake is denominated in $ASTER, tying chain security to the native token via Base APY plus Loyalty Rewards[^aster-docs-2026-04-28-aster-chain-staking-how-staking-works]. Epochs are weekly (Monday 00:00 UTC snapshot, Sunday 00:00 UTC settlement)[^aster-docs-2026-04-28-aster-chain-staking-how-staking-works]. Each validator's share of the Base APY pool is computed as Validator Transactions ÷ Total Network Transactions, and user Base Reward = Validator Reward × (User Stake ÷ Total Validator Stake) × (1 − Validator Commission)[^aster-docs-2026-04-28-aster-chain-staking-how-staking-works]. At launch, total emission is 450,000 $ASTER per Epoch (150K Base + 300K Loyalty), with the Loyalty pool weighted by veASTER × Trading Volume Boost — coupling validator security to platform usage[^aster-docs-2026-04-28-aster-chain-staking-how-staking-works]. See [[parameters/aster/staking-rewards]].

**Lifecycle delay.** New deposits, top-ups, lock extensions, and redeem requests all take effect in the *next* Epoch rather than immediately[^aster-docs-2026-04-28-aster-chain-staking-how-staking-works]. This batched-by-epoch design avoids intra-epoch validator-set churn but introduces a one-week lag for any staking action.

**Products hosted.** Aster Chain is the execution venue for the Aster perpdex's four trading types (order-book Perpetuals, AMM-style Shield Mode, 1001x, order-book Spot) and the Aster Earn product line (asBNB liquid staking, USDF stablecoin, asUSDF, asBTC, asCAKE)[^aster-docs-2026-04-28-overview-what-is-aster]. Note: the Aster smart-contracts registry lists the Earn products and USDF only on BNB Chain, indicating those product contracts live on BNB Chain rather than Aster Chain itself[^aster-docs-2026-04-28-overview-smart-contracts]. The relationship between Aster Chain (the privacy L1) and the BNB-Chain-resident Earn contracts is not made explicit in the surveyed docs.

**Audit coverage.** Aster's published audit registry contains seven 2024 reports covering the Vault, Earn, asBNB, asCAKE, asUSDF, and USDF token + minting contracts — but no audit on this page covers the Aster Chain L1 itself or the perp matching engine[^aster-docs-2026-04-28-overview-audit-reports]. All listed reports are dated within 2024 (Sept–Dec) and predate the 2025 product timeline implied by other docs.

## Relations

(No canonical relations originate from this entity; the inverse `runs_on` relation is filed on [[entities/perpdex/aster]]. Validator-stake security in $ASTER and the 450K $ASTER per Epoch emission are described in the Mechanism section as protocol-internal facts rather than entity-to-entity relations.)

## Parameters
- [[parameters/aster/staking-rewards]] — emission, ve-style time weighting, Trading Volume Boost tiers, Epoch cadence
- [[parameters/aster/audits]] — 2024 audits cover Vault/Earn/stablecoin contracts; Aster Chain L1 audit absent

## Open questions
- What is the consensus algorithm name — HotStuff variant, Tendermint, custom BFT? The docs imply validator-PoS but never name the protocol.
- What is the validator set size, how is it bounded, and what is the entry threshold (self-delegation, lockup, commission floor)?
- Is the validator set permissioned (Aster Foundation / approved partners) or permissionless? Decentralization status is not stated.
- What cryptographic primitive backs the encrypted-order pipeline (MPC, threshold decryption, FHE, TEE)? Where does decryption happen, and who holds the keys?
- Is the Aster Chain L1 or perp matching engine audited? The published audit page covers only Vault/Earn/stablecoin contracts.
- What is the relationship between Aster Chain (the privacy L1) and BNB Chain (where Earn-product and USDF contracts live)? Is there a bridge, light client, or separate runtime?

## Disputed claims
None at first ingest.

## Related
[[entities/perpdex/aster]] · [[entities/token/aster]] · [[entities/token/usdf]] · [[parameters/aster/staking-rewards]] · [[parameters/aster/audits]]

## Sources
[^aster-docs-2026-04-28-overview-what-is-aster]: [[sources/aster-docs-2026-04-28-overview-what-is-aster]]
[^aster-docs-2026-04-28-aster-chain-staking-how-staking-works]: [[sources/aster-docs-2026-04-28-aster-chain-staking-how-staking-works]]
[^aster-docs-2026-04-28-overview-smart-contracts]: [[sources/aster-docs-2026-04-28-overview-smart-contracts]]
[^aster-docs-2026-04-28-overview-audit-reports]: [[sources/aster-docs-2026-04-28-overview-audit-reports]]
