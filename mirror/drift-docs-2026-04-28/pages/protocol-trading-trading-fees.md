# Trading Fees

Source: https://docs.drift.trade/protocol/trading/trading-fees

Drift offers a highly competitive fee structure with low taker fees and attractive maker rebates across all tiers, with the potential for even lower fees as trading volume increases. Fees are calculated per trade based on the filled notional position size and are charged in the market's quote asset (USDC), affecting the position's cost basis.

If a user holds only non-USDC assets, a USDC borrow may be triggered upon settlement of a loss in perpetual markets (see P&L).

Drift's tiered fees for futures markets are based on an on-chain calculation of 30-Day Volume. You can earn discounts on taker fees and extra rebates on maker fees by staking DRIFT. These apply on top of your volume tier.

## Perp Market Fees

| Tier | 30D Volume | Rookie Taker | Rookie Maker | Champion Taker | Champion Maker | Kickstarter Taker | Kickstarter Maker | Racer Taker | Racer Maker | Elite Taker | Elite Maker | Master Taker | Master Maker |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | ≤ $2M | 0.0350% | -0.0025% | 0.0210% | -0.0035% | 0.0333% | -0.0026% | 0.0315% | -0.0028% | 0.0280% | -0.0030% | 0.0245% | -0.0033% |
| 2 | > $2M | 0.0300% | -0.0025% | 0.0180% | -0.0035% | 0.0285% | -0.0026% | 0.0270% | -0.0028% | 0.0240% | -0.0030% | 0.0210% | -0.0033% |
| 3 | > $10M | 0.0275% | -0.0025% | 0.0165% | -0.0035% | 0.0261% | -0.0026% | 0.0248% | -0.0028% | 0.0220% | -0.0030% | 0.0193% | -0.0033% |
| 4 | > $20M | 0.0250% | -0.0025% | 0.0150% | -0.0035% | 0.0238% | -0.0026% | 0.0225% | -0.0028% | 0.0200% | -0.0030% | 0.0175% | -0.0033% |
| 5 | > $80M | 0.0225% | -0.0025% | 0.0135% | -0.0035% | 0.0214% | -0.0026% | 0.0203% | -0.0028% | 0.0180% | -0.0030% | 0.0158% | -0.0033% |
| VIP | > $200M | 0.0200% | -0.0025% | 0.0120% | -0.0035% | 0.0190% | -0.0026% | 0.0180% | -0.0028% | 0.0160% | -0.0030% | 0.0140% | -0.0033% |

### Fee Benefits via DRIFT Staking

Earn additional discounts on taker fees and extra rebates on maker fees by staking DRIFT. These stack on top of your volume tier. These benefits only apply to perp fees.

| Tier | DRIFT Staked | Taker Fee Discount | Maker Fee Rebate |
| --- | --- | --- | --- |
| Rookie | 0 | 0% | 0% |
| Kickstarter | 1,000 | -5% | +5% |
| Racer | 10,000 | -10% | +10% |
| Elite | 50,000 | -20% | +20% |
| Master | 100,000 | -30% | +30% |
| Champion | 250,000 | -40% | +40% |

Examples:

- A Tier 3 taker (0.0275%) with 20% staking discount pays 0.022% effective fee.
- A maker (-0.0025% rebate) with 20% staking gets -0.003% rebate.

## Spot Market Fees

| Tier | Maker Fee | Taker Fee | Referree Taker Discount | Referrer Reward | Filler Reward |
| --- | --- | --- | --- | --- | --- |
| Loading... |

(Spot fee table renders client-side via JS; placeholder visible to crawler. Re-fetch via headless browser if exact spot values needed.)

---

### Drift staking benefits

The fee benefits via DRIFT staking only apply to perpetual contract fees.

### Taker Fees (High Leverage Mode)

If a user has High Leverage Mode turned on, taker trading fees for all perp markets will be 2x the bottom fee tier.

### Referee Discount / Referer Reward

These apply to accounts that were signed up using a referred account. These percentages are applied to the effective taker fee paid.

### Filler Reward

Filler rewards are variable but up to 10% of the effective taker fee paid by the user. See Keeper Incentives.

### Fee Adjustments

Longer tail assets can have increased fees to stay in line with external markets fee schedules. Some markets will periodically have flat discounts applied to all fee tiers. See Fee-Adjusted Markets

### Disclaimers

Drift Protocol reserves the right to end the promotional period and the Taker Incentive Program at any time. If the Drift Protocol chooses to do so, it will provide notice to participating users, but such notice is not required in order to conclude the program early or extend the program. Please note that the terms and conditions of this program are subject to change without notice.

There are risks associated with Insurance Fund Staking. Read more about the Insurance Fund Staking and Risks).**

Last updated on February 27, 2026
