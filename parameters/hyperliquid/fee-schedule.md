---
type: parameter
entity: [[hyperliquid]]
parameter: fee-schedule
unit: percent
last_change: 2026-04-27
last_reviewed: 2026-04-28
disputed: false
---

# Hyperliquid fee schedule

## Current (as of 2026-04-27)

**Tier basis.** Tiers based on rolling 14-day weighted volume, assessed daily at UTC end-of-day[^hl-docs-2026-04-27-trading-fees]. One fee tier per user across all assets including perps, HIP-3 perps, and spot[^hl-docs-2026-04-27-trading-fees].

**Volume weighting.** `14d_weighted = 14d_perps + 2 * 14d_spot`[^hl-docs-2026-04-27-trading-fees]. Sub-account volume aggregates to the master[^hl-docs-2026-04-27-trading-fees]; vault volume is treated separately[^hl-docs-2026-04-27-trading-fees].

**Maker rebates** are paid out continuously per trade directly to the trading wallet[^hl-docs-2026-04-27-trading-fees].

### Perps fee tiers (base)

| Tier | 14d weighted volume ($) | Base Taker | Base Maker |
|---|---|---|---|
| 0 | (any) | 0.045% | 0.015% |
| 1 | >5M | 0.040% | 0.012% |
| 2 | >25M | 0.035% | 0.008% |
| 3 | >100M | 0.030% | 0.004% |
| 4 | >500M | 0.028% | 0.000% |
| 5 | >2B | 0.026% | 0.000% |
| 6 | >7B | 0.024% | 0.000% |

[^hl-docs-2026-04-27-trading-fees]

### Spot fee tiers (base)

| Tier | 14d weighted volume ($) | Base Taker | Base Maker |
|---|---|---|---|
| 0 | (any) | 0.070% | 0.040% |
| 1 | >5M | 0.060% | 0.030% |
| 2 | >25M | 0.050% | 0.020% |
| 3 | >100M | 0.040% | 0.010% |
| 4 | >500M | 0.035% | 0.000% |
| 5 | >2B | 0.030% | 0.000% |
| 6 | >7B | 0.025% | 0.000% |

[^hl-docs-2026-04-27-trading-fees]

(Per-tier × staking-tier intersection — Diamond/Platinum/Gold/Silver/Bronze/Wood columns — yields full grid in primary docs[^hl-docs-2026-04-27-trading-fees]. Recorded summary above; full grid recoverable from source page.)

### Staking-tier discount ladder

| Tier | HYPE staked | Trading fee discount |
|---|---|---|
| Wood | >10 | 5% |
| Bronze | >100 | 10% |
| Silver | >1,000 | 15% |
| Gold | >10,000 | 20% |
| Platinum | >100,000 | 30% |
| Diamond | >500,000 | 40% |

[^hl-docs-2026-04-27-trading-fees]

## Tiering rules / formulae

**Stable-pair scaling** (spot pair between two spot quote assets): apply scaling factor 0.2 to maker rate, taker rate, and volume contribution[^hl-docs-2026-04-27-trading-fees].

**Aligned-quote-token scaling**:
- Taker scale = `(1 − deployerShare) * 0.8 + deployerShare`
- Rebate scale = `(1 − deployerShare) * 1.5 + deployerShare`

[^hl-docs-2026-04-27-trading-fees]

This produces 20% lower taker fees, 50% better maker rebates, and 20% more fee-tier volume contribution for aligned-quote-asset pairs[^hl-docs-2026-04-27-trading-fees].

**HIP-3 deployer config.** Deployers can configure additional fee share between 0–300% (0–100% in growth mode); above 100% the protocol fee scales up to match the deployer fee[^hl-docs-2026-04-27-trading-fees]. **Growth mode** reduces protocol fees, rebates, volume contributions, and L1 user rate-limit contributions by 90%[^hl-docs-2026-04-27-trading-fees].

**Referral economics.** Referral rewards apply for a referrer's first $1B in referred-user volume; referral discounts apply for a referred user's first $25M in volume[^hl-docs-2026-04-27-trading-fees]. See [[concepts/incentives/referral-design]].

**Bridge withdrawal fee.** 1 USDC, paid on Hyperliquid (no Arbitrum ETH required from the user)[^hl-docs-2026-04-27-hypercore-bridge].

**Liquidation fee.** None — there is no clearance fee on liquidations[^hl-docs-2026-04-27-trading-liquidations].

**Staking-trading link.** A staking user can be permanently linked to a trading user so that staked HYPE attributes to the trading user's fee discount[^hl-docs-2026-04-27-trading-fees]. The link is irrevocable; the staking user gains unilateral control of the trading account funds[^hl-docs-2026-04-27-trading-fees]. The trading user initiates; the staking user finalizes[^hl-docs-2026-04-27-trading-fees].

## Time series

| effective  | base perps tier 0 (mkr/tkr) | base spot tier 0 (mkr/tkr) | tier 6 cap | source              |
|------------|------------------------------|-----------------------------|------------|---------------------|
| 2026-04-27 | 0.015% / 0.045% | 0.040% / 0.070% | 0.024% taker (perps); 0.025% taker (spot)[^hl-docs-2026-04-27-trading-fees] | [^hl-docs-2026-04-27-trading-fees] |

(Snapshot of current-state crawl; prior schedule revisions to be added when historical sources are ingested.)

## Disputed values
None.

## Sources
[^hl-docs-2026-04-27-trading-fees]: [[sources/hl-docs-2026-04-27-trading-fees]]
[^hl-docs-2026-04-27-hypercore-bridge]: [[sources/hl-docs-2026-04-27-hypercore-bridge]]
[^hl-docs-2026-04-27-trading-liquidations]: [[sources/hl-docs-2026-04-27-trading-liquidations]]
