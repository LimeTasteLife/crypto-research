---
type: parameter
entity: [[aster]]
parameter: peg-config
unit: ratio
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: false
---

# Aster USDF peg

## Current (as of 2026-04-28)

**Three-mechanism peg defense.** USDF maintains its 1:1 USD peg through three named mechanisms[^aster-docs-2026-04-28-usdf-maintaining-the-peg]:

1. **Rigid 1:1 redemption against USDT.** Holders can redeem USDF for USDT at a fixed 1:1 rate at any time. The redemption guarantee depends on Aster maintaining an equal underlying balance available for redemption[^aster-docs-2026-04-28-usdf-maintaining-the-peg].
2. **Market arbitrage.** Price deviations of USDF in third-party liquidity pools are stabilized by **external arbitrageurs**, not by an internal market-making program — peg stability is contingent on third-party arbitrage activity[^aster-docs-2026-04-28-usdf-maintaining-the-peg].
3. **Delta-neutral hedging.** Aster operates delta-neutral positions in underlying assets as a secondary peg-defense mechanism, stated to generate fee yield via liquidity mechanisms while suppressing volatile-asset exposure[^aster-docs-2026-04-28-usdf-maintaining-the-peg].

**Documented arbitrage paths**[^aster-docs-2026-04-28-usdf-maintaining-the-peg]:

- *Overvalued USDF (1.02):* redeem 100 USDF → 100 USDT → swap to 102 USDT-equivalent USDF on a DEX → 2% gain on revert.
- *Undervalued USDF (0.98):* purchase USDF at discount → redeem at 1:1 for USDT → capture spread.

**Trade & Earn integration.** USDF as Multi-Asset Mode collateral has a **99.99% collateral ratio**[^aster-docs-2026-04-28-program-trade-and-earn]. The 100,000-USDF per-account cap on USDF holdings counted toward Trade & Earn rewards took effect on **2025-09-04**[^aster-docs-2026-04-28-program-trade-and-earn]. See [[parameters/programmes/aster-trade-and-earn]].

**Disclosure gaps (open questions).** The peg-defense page does **not** disclose[^aster-docs-2026-04-28-usdf-maintaining-the-peg]:

- A redemption fee.
- A redemption SLA, redemption queue policy, or maximum daily redemption capacity.
- The venue or counterparty of the delta-neutral hedge.
- How the short leg of the delta-neutral hedge is liquidated under stress.

## Time series

| effective | redemption | arbitrage | delta-neutral hedge | T&E collateral ratio | T&E USDF cap | source |
|---|---|---|---|---|---|---|
| 2025-09-04 | 1:1 USDT (fee/SLA undisclosed) | external arbitrageurs | enabled (venue undisclosed) | 99.99% | 100,000 USDF per account | [^aster-docs-2026-04-28-program-trade-and-earn] |
| 2026-04-28 | 1:1 USDT (fee/SLA undisclosed) | external arbitrageurs | enabled (venue undisclosed) | 99.99% | 100,000 USDF per account | [^aster-docs-2026-04-28-usdf-maintaining-the-peg][^aster-docs-2026-04-28-program-trade-and-earn] |

## Tiering rules / formulae

Not applicable — parameter is a peg-defense mechanism description, not a tier table. Redemption is a fixed 1:1 against USDT; the page does not surface a fee or rate-tier ladder.

## Disputed values
None at first ingest.

## Sources
[^aster-docs-2026-04-28-usdf-maintaining-the-peg]: [[sources/aster-docs-2026-04-28-usdf-maintaining-the-peg]]
[^aster-docs-2026-04-28-program-trade-and-earn]: [[sources/aster-docs-2026-04-28-program-trade-and-earn]]
