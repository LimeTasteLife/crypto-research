---
type: entity
subtype: token
name: USDF
ticker: USDF
network: [[entities/network/bnb-chain]]
peg_target: USDT 1:1
status: live
launched: 2024
sources_count: 5
last_reviewed: 2026-04-28
disputed: false
---

# USDF

> Aster's yield-bearing stablecoin pegged 1:1 to USDT, used as perp collateral in Multi-Asset Mode at a 99.99% collateral value ratio and as the reward asset for the Trade & Earn programme.

## Snapshot
- Peg target: 1:1 to USDT (and by extension US Dollar)[^aster-docs-2026-04-28-usdf-maintaining-the-peg]
- Peg defense: three named mechanisms — rigid 1:1 USDT redemption, third-party arbitrage on liquidity-pool deviations, delta-neutral hedging of underlying assets[^aster-docs-2026-04-28-usdf-maintaining-the-peg]
- Use as collateral: 99.99% collateral value ratio in Aster Perp Multi-Asset Mode[^aster-docs-2026-04-28-program-trade-and-earn]
- Trade & Earn cap: rewards counted on at most 100,000 USDF per account, effective 4 September 2025[^aster-docs-2026-04-28-program-trade-and-earn]
- Token contract: 0x5A110fC00474038f6c02E89C707D638602EA44B5 on BNB Chain; minting contract 0xC271fc70dD9E678ac1AB632f797894fe4BE2C345[^aster-docs-2026-04-28-overview-smart-contracts]

## Mechanism

**Three-layer peg defense.** USDF maintains its 1:1 USD peg through three named mechanisms[^aster-docs-2026-04-28-usdf-maintaining-the-peg]:

1. **Rigid 1:1 USDT redemption.** Holders can redeem USDF for USDT at any time at the fixed 1:1 rate, backed by Aster maintaining an equal underlying balance available for redemption. This is the structural anchor.
2. **Market arbitrage.** Price deviations of USDF in third-party liquidity pools are stabilized by external arbitrageurs, not by an internal market-making program. The documented example for overvalued USDF (1.02): redeem 100 USDF → 100 USDT → swap to 102 USDT-equivalent USDF on a DEX → 2% gain. Symmetric path for undervalued USDF (0.98): purchase USDF at discount → redeem at 1:1 for USDT → capture spread.
3. **Delta-neutral hedging.** Aster operates delta-neutral positions in underlying assets to suppress volatility transmission and to generate fee yield via liquidity mechanisms while minimising volatile-asset exposure.

**Yield generation.** USDF is positioned as yield-bearing[^aster-docs-2026-04-28-overview-what-is-aster]. The peg page describes the delta-neutral leg as generating fee yield via liquidity mechanisms — long and short positions in underlying assets are balanced to suppress price-volatility transmission while accruing fee yield to the strategy[^aster-docs-2026-04-28-usdf-maintaining-the-peg].

**Use as perp collateral.** USDF can be enabled as perp collateral via Multi-Asset Mode in Aster Settings, where it carries a 99.99% collateral value ratio — meaning collateral continues earning passive yield while being used as trading margin (no opportunity cost separation)[^aster-docs-2026-04-28-program-trade-and-earn].

**Trade & Earn participation.** USDF is the reward asset and one of two yield-bearing collateral assets (alongside asBNB) in the Trade & Earn programme[^aster-docs-2026-04-28-program-trade-and-earn]. Two reward streams: (1) Deposit Rewards — holders with >1 USDF in their trading account earn rewards calculated hourly off a holdings snapshot, distributed proportionally; (2) Trading Rewards — requires being active ≥2 days per week with weekly volume ≥50,000 USDT (threshold raised on 20 November 2025) and pays a function of volume × USDF holdings[^aster-docs-2026-04-28-program-trade-and-earn]. Rewards counted on USDF holdings are capped at 100,000 USDF per account, effective 4 September 2025[^aster-docs-2026-04-28-program-trade-and-earn]. Reward weeks run Thursday → Wednesday with payouts in USDF to the user's Futures account within 7 business days[^aster-docs-2026-04-28-program-trade-and-earn].

**Audit coverage.** The USDF token has a PeckShield audit (PeckShield-Audit-Report-USDFEarn-v1.0); the USDF + asUSDF combined audit was performed by HALBORN (filed under "Astherus / SSC")[^aster-docs-2026-04-28-overview-audit-reports]. Both audits are dated within 2024[^aster-docs-2026-04-28-overview-audit-reports].

## Relations
- [[entities/token/usdf]] **runs_on** [[entities/network/bnb-chain]] (token + minting contract pair)[^aster-docs-2026-04-28-overview-smart-contracts]
- [[entities/token/usdf]] **is_collateral_for** [[entities/perpdex/aster]] perps via Multi-Asset Mode at 99.99% ratio[^aster-docs-2026-04-28-program-trade-and-earn]
- [[parameters/programmes/aster-trade-and-earn]] **applies_to** [[entities/token/usdf]] (Deposit Rewards + Trading Rewards, 100K USDF cap)[^aster-docs-2026-04-28-program-trade-and-earn]

## Parameters
- [[parameters/aster/usdf-peg]] — three-mechanism peg defense (redemption + arbitrage + delta-neutral); SLA gaps
- [[parameters/aster/contract-addresses]] — USDF token + minting contract addresses
- [[parameters/aster/audits]] — PeckShield USDFEarn report; HALBORN combined USDF + asUSDF report
- [[parameters/programmes/aster-trade-and-earn]] — 99.99% collateral ratio, 100K USDF cap, weekly volume gate

## Open questions
- What is the redemption fee for USDF → USDT? Not disclosed in the peg page.
- What is the redemption SLA — instant, queued, batched? What is the maximum daily redemption capacity?
- Where is the delta-neutral hedge executed (CEX, on-chain perpdex, OTC desk), and who is the counterparty?
- How is the short leg of the delta-neutral hedge liquidated under stress? The page positions delta-neutral as protection "even during uncertain markets" without specifying liquidation handling.
- What is USDF's depeg history — has the 1:1 rigid redemption been tested under stress, and were any redemptions delayed or rationed?
- What are the underlying-asset reserves backing USDF (USDT-only, basket, on-chain attestation cadence)?

## Disputed claims
None at first ingest.

## Related
[[entities/perpdex/aster]] · [[entities/token/aster]] · [[entities/network/aster-chain]] · [[parameters/aster/usdf-peg]] · [[parameters/aster/contract-addresses]] · [[parameters/programmes/aster-trade-and-earn]]

## Sources
[^aster-docs-2026-04-28-usdf-maintaining-the-peg]: [[sources/aster-docs-2026-04-28-usdf-maintaining-the-peg]]
[^aster-docs-2026-04-28-program-trade-and-earn]: [[sources/aster-docs-2026-04-28-program-trade-and-earn]]
[^aster-docs-2026-04-28-overview-smart-contracts]: [[sources/aster-docs-2026-04-28-overview-smart-contracts]]
[^aster-docs-2026-04-28-overview-audit-reports]: [[sources/aster-docs-2026-04-28-overview-audit-reports]]
[^aster-docs-2026-04-28-overview-what-is-aster]: [[sources/aster-docs-2026-04-28-overview-what-is-aster]]
