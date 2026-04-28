---
type: entity
subtype: token
name: ASTER
ticker: ASTER
network: [[entities/network/aster-chain]]
total_supply: 8000000000
status: live
launched: 2025
sources_count: 4
last_reviewed: 2026-04-28
disputed: false
---

# ASTER

> Aster's native governance and utility token. Drives perp-fee discounts, validator-PoS Base APY plus veToken-style Loyalty Rewards on Aster Chain, and serves as the receiving asset for protocol-revenue buybacks routed through the Aster Foundation.

## Snapshot
- Total supply: 8,000,000,000 $ASTER[^aster-docs-2026-04-28-usdaster-tokenomics]
- Distribution: Airdrop 53.5% (4.28B) / Ecosystem & Community 30% (2.4B) / Treasury 7% (560M) / Team 5% (400M) / Liquidity & Listings 4.5% (360M)[^aster-docs-2026-04-28-usdaster-tokenomics]
- TGE unlock: 704M (8.8% of supply) for Aster Spectra and Aster Gems participants; Liquidity & Listings (4.5%) fully unlocked at TGE[^aster-docs-2026-04-28-usdaster-tokenomics]
- Primary network: [[entities/network/aster-chain]]
- Multi-chain treasury footprint: BNB Chain, Ethereum, Solana, Arbitrum (4 networks)[^aster-docs-2026-04-28-overview-smart-contracts]

## Asset profile
- volatility class: unknown (not in primary docs)
- holder distribution: unknown (not in primary docs)
- narrative class: infra + DeFi (L1 native staking + perpdex utility token)
- supply unlock: 8.8% at TGE; Airdrop ~80mo; Team 12mo cliff + 40mo linear at 10M/mo; Treasury locked-by-governance; Ecosystem & Community via staking emissions post-Jan 2026[^aster-docs-2026-04-28-usdaster-tokenomics]
- parent ecosystem: [[entities/network/aster-chain]]

## Mechanism

**Distribution and vesting.** Airdrop (53.5%, 4.28B) releases gradually over approximately 80 months (~7 years) post-TGE, with unclaimed tokens redirected back to the Airdrop & Community Rewards pool[^aster-docs-2026-04-28-usdaster-tokenomics]. The Team allocation (5%, 400M) has a 12-month cliff from TGE and then 40 months of linear vesting at 10M $ASTER per month[^aster-docs-2026-04-28-usdaster-tokenomics]. Treasury (7%, 560M) does not enter circulating supply at TGE and only unlocks via governance-approved mechanisms[^aster-docs-2026-04-28-usdaster-tokenomics]. Liquidity & Listings (4.5%, 360M) is fully unlocked upon TGE[^aster-docs-2026-04-28-usdaster-tokenomics]. Eligible APX holders/stakers can swap APX for $ASTER during a designated period at a conversion rate that decreases over time, with unclaimed tokens redirected to the Airdrop pool[^aster-docs-2026-04-28-usdaster-tokenomics].

**Regime change in Ecosystem & Community vesting.** This is a meaningful tokenomics signal: the Ecosystem & Community allocation (30%, 2.4B) was originally vested over 20 months on a linear distribution model, but linear vesting was active for only 4 months (October 2025 – January 2026) before being replaced by a staking emission model[^aster-docs-2026-04-28-usdaster-tokenomics]. After January 2026, staking rewards are the sole active use of that bucket — meaning post-Jan 2026 emissions are gated on staking participation rather than time[^aster-docs-2026-04-28-usdaster-tokenomics].

**Utility 1 — fee discount.** Depositing $ASTER into the perp wallet (or transferring from spot to perp) yields a flat 5% discount on perpetual trading fees, applied automatically to cover fees[^aster-docs-2026-04-28-trading-perpetuals-fees]. This is the canonical tokenomics ↔ fee linkage on the platform. See [[parameters/aster/fee-schedule]].

**Utility 2 — staking.** Aster Chain emits 450,000 $ASTER per weekly Epoch at launch, split into a 150K Base pool and a 300K Loyalty pool[^aster-docs-2026-04-28-aster-chain-staking-how-staking-works]. The Base pool distributes to validators by share of network transactions processed (Validator Share = Validator Transactions ÷ Total Network Transactions), then pro-rata within a validator after commission[^aster-docs-2026-04-28-aster-chain-staking-how-staking-works]. The Loyalty pool weights stakers by Power = veASTER × Trading Volume Boost, where veASTER = Locked Amount × (Remaining Lock ÷ 208 weeks max) and Trading Volume Boost is tiered at >$500K → 1.05×, >$50M → 1.15×, >$200M → 1.25×[^aster-docs-2026-04-28-aster-chain-staking-how-staking-works]. The Loyalty design explicitly couples governance authority to platform usage. See [[parameters/aster/staking-rewards]].

**Utility 3 — buyback endpoint.** A portion of protocol revenue is redirected to $ASTER buybacks via the Aster Foundation; buybacks fund a Foundation allocation for long-term price stabilization and also fund governance rewards distributed to incentivize participation in Aster's decentralized governance[^aster-docs-2026-04-28-usdaster-tokenomics]. Buyback cadence (TWAP vs discretionary) and the percentage of revenue redirected are not specified.

**Multi-chain treasury footprint.** The Aster Treasury is deployed across four networks: BNB Chain (0x128463A60784c4D3f46c23Af3f65Ed859Ba87974), Ethereum (0x604DD02d620633Ae427888d41bfd15e38483736E), Solana (EhUtRgu9iEbZXXRpEvDj6n1wnQRjMi2SERDo3c6bmN2c), and Arbitrum (0x9E36CB86a159d479cEd94Fa05036f235Ac40E1d5)[^aster-docs-2026-04-28-overview-smart-contracts]. The cross-chain Treasury footprint suggests cross-chain stack-accounting and treasury operations, but bridge withdrawal authority, multi-sig topology, and emergency-pause authority across the four networks are not documented in primary sources.

## Relations
- [[entities/token/aster]] **runs_on** [[entities/network/aster-chain]] (validator-PoS native token)[^aster-docs-2026-04-28-aster-chain-staking-how-staking-works]
- [[entities/token/aster]] **applies_to** [[parameters/aster/fee-schedule]] as a flat 5% trading-fee discount when deposited into the perp wallet[^aster-docs-2026-04-28-trading-perpetuals-fees]
- [[entities/perpdex/aster]] **distributes_to** [[entities/token/aster]] via protocol-revenue buybacks routed through the Aster Foundation[^aster-docs-2026-04-28-usdaster-tokenomics]

## Parameters
- [[parameters/aster/tokenomics]] — 8B supply, 53.5/30/7/5/4.5 split, vesting schedules, governance regime change Jan 2026
- [[parameters/aster/staking-rewards]] — 450K/Epoch emission, ve-style time weighting, Trading Volume Boost tiers
- [[parameters/aster/fee-schedule]] — flat 5% $ASTER fee discount on perps
- [[parameters/aster/contract-addresses]] — Treasury addresses on BNB Chain / Ethereum / Solana / Arbitrum

## Open questions
- What is circulating supply at TGE beyond the 704M (8.8%) immediate unlock plus the 360M (4.5%) Liquidity & Listings? What fraction of the 4.28B Airdrop has actually been claimed?
- What is the holder distribution (top-10, top-100 concentration)? Not documented.
- What fraction of total supply is currently staked, and what is the Base APY ↔ Loyalty APY split for typical participants?
- What is the buyback cadence — continuous TWAP, periodic batch, or discretionary? What percentage of protocol revenue is redirected, and is the rate fixed or governance-set?
- What are the unlock cliff dates for each allocation bucket? The docs give relative durations (12mo cliff, 40mo linear, ~80mo airdrop) but no absolute calendar.
- What APX → $ASTER conversion rate schedule applies, and when does the swap window close?

## Disputed claims
None at first ingest.

## Related
[[entities/network/aster-chain]] · [[entities/perpdex/aster]] · [[entities/token/usdf]] · [[parameters/aster/tokenomics]] · [[parameters/aster/staking-rewards]] · [[parameters/aster/fee-schedule]]

## Sources
[^aster-docs-2026-04-28-usdaster-tokenomics]: [[sources/aster-docs-2026-04-28-usdaster-tokenomics]]
[^aster-docs-2026-04-28-aster-chain-staking-how-staking-works]: [[sources/aster-docs-2026-04-28-aster-chain-staking-how-staking-works]]
[^aster-docs-2026-04-28-trading-perpetuals-fees]: [[sources/aster-docs-2026-04-28-trading-perpetuals-fees]]
[^aster-docs-2026-04-28-overview-smart-contracts]: [[sources/aster-docs-2026-04-28-overview-smart-contracts]]
