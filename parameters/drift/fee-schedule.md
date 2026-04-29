---
type: parameter
entity: [[drift]]
parameter: fee-schedule
unit: percent
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: false
---

# Drift fee schedule

## Current (as of 2026-04-28)

**Tier basis.** Tiers based on rolling on-chain 30-day volume; six tiers from Tier 1 (Rookie) through VIP[^drift-docs-2026-04-28-protocol-trading-trading-fees].

**Maker rebate.** Flat -0.0025% maker rebate at every volume tier[^drift-docs-2026-04-28-protocol-trading-trading-fees]. For non-BTC/ETH perpetuals, the flat maker rebate is -0.25 bps regardless of taker counterparty (AMM or User); `post only` flag required to qualify as maker[^drift-docs-2026-04-28-protocol-market-makers-maker-fee-rebate]. Maker orders filling against the AMM are NOT eligible for rebate[^drift-docs-2026-04-28-protocol-about-v3-decentralized-orderbook].

**Staking discount.** DRIFT staking tiers stack on top of the volume tier and apply to perp fees only[^drift-docs-2026-04-28-protocol-trading-trading-fees]. Maker rebate boost up to +40% applies to the -0.25 bps base[^drift-docs-2026-04-28-protocol-market-makers-maker-fee-rebate].

**High Leverage Mode.** Doubles the bottom-tier taker fee (2x penalty for the lowest-IM mode)[^drift-docs-2026-04-28-protocol-trading-trading-fees].

**Fee-Adjusted Markets.** Allow per-market increases (longer-tail assets) or flat discounts across all tiers[^drift-docs-2026-04-28-protocol-trading-trading-fees].

**Filler rewards.** Variable, up to 10% of the effective taker fee paid by the user[^drift-docs-2026-04-28-protocol-trading-trading-fees].

**Spot fees.** NOT extracted in this snapshot (rendered client-side, "Loading..." placeholder at crawl)[^drift-docs-2026-04-28-protocol-trading-trading-fees].

**Sunset clause.** Drift reserves the right to end the promotional period and the Taker Incentive Program at any time without notice[^drift-docs-2026-04-28-protocol-trading-trading-fees].

### Perp volume tiers

| tier | name | 30d volume threshold | taker | maker |
|---|---|---|---|---|
| 1 | Rookie | <= $2M | 0.0350% | -0.0025% |
| 2 | Contender | > $2M | 0.0300% | -0.0025% |
| 3 | Specialist | > $10M | 0.0275% | -0.0025% |
| 4 | Expert | > $50M | 0.0250% | -0.0025% |
| 5 | Pro | > $100M | 0.0225% | -0.0025% |
| VIP | VIP | > $200M | 0.0200% | -0.0025% |

[^drift-docs-2026-04-28-protocol-trading-trading-fees]

### DRIFT staking tiers

| tier | DRIFT staked | taker discount | maker rebate boost |
|---|---|---|---|
| Rookie | 0 | 0% | 0% |
| Kickstarter | 1,000 | -5% | +5% |
| Racer | 10,000 | -10% | +10% |
| Elite | 50,000 | -20% | +20% |
| Master | 100,000 | -30% | +30% |
| Champion | 250,000 | -40% | +40% |

[^drift-docs-2026-04-28-protocol-trading-trading-fees]

**Worked examples:** a Tier 3 taker (0.0275%) with 20% staking discount pays 0.022% effective; a maker (-0.0025% rebate) with 20% staking gets a -0.003% rebate[^drift-docs-2026-04-28-protocol-trading-trading-fees].

## Time series

| effective | taker (Tier 1) | maker | notes | source |
|---|---|---|---|---|
| 2026-04-28 | 0.0350% | -0.0025% | snapshot values; historical rate card not available in this snapshot | [^drift-docs-2026-04-28-protocol-trading-trading-fees] |

## Tiering rules / formulae

Effective fee = base volume-tier rate x (1 - staking discount)[^drift-docs-2026-04-28-protocol-trading-trading-fees].

Maker rebate boost = base rebate x (1 + staking boost %)[^drift-docs-2026-04-28-protocol-market-makers-maker-fee-rebate].

## Disputed values
None.

## Sources
[^drift-docs-2026-04-28-protocol-trading-trading-fees]: [[sources/drift-docs-2026-04-28-protocol-trading-trading-fees]]
[^drift-docs-2026-04-28-protocol-market-makers-maker-fee-rebate]: [[sources/drift-docs-2026-04-28-protocol-market-makers-maker-fee-rebate]]
[^drift-docs-2026-04-28-protocol-about-v3-decentralized-orderbook]: [[sources/drift-docs-2026-04-28-protocol-about-v3-decentralized-orderbook]]
