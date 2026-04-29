# Liquidations

Liquidation is the process of closing out a trader's positions when their account no longer has enough margin to support them.

## When does liquidation happen?

An account is subject to liquidation if its Account Margin Ratio falls below its Maintenance Margin Ratio. Orderly uses the Mark Price to evaluate positions, not the last traded price.

When an account enters liquidation:
1. All open orders on the account are cancelled.
2. The account's USDC balance is frozen.

## Decentralized liquidations

Instead of dumping positions onto the order book, Orderly transfers them to liquidators at a discount. Anyone with an Orderly account can act as a liquidator, as long as they have enough margin to take over the positions.

## Liquidation tiers

| Tier | Perp Markets |
|---|---|
| Low | BTC; ETH |
| High | Others |

Low Tier: Liquidators must claim a proportional share of all low-tier positions.
High Tier: Liquidators can claim a single symbol at a time.

## How much gets liquidated?

The system calculates how much needs to be liquidated to bring the Account Margin Ratio back up to the Initial Margin Ratio. The goal is to do the minimum necessary.

## Liquidation fees

| Perp Market | Liquidation Fee | Liquidator Fee |
|---|---|---|
| BTC | 0.60% | 0.30% |
| ETH | 0.60% | 0.30% |
| SOL | 0.60% | 0.30% |
| Others | 1.20% | 0.60% |

Fee split depends on remaining margin:
- Plenty of margin: Split evenly between Insurance Fund and liquidator (each 0.5 * User Liquidation Fee).
- Low margin: Liquidator gets 0.5 * User Liquidation Fee, remainder to IF.
- Almost no margin: Entire balance and positions transferred to Insurance Fund.

## Full vs. partial liquidator takeover

- Low-tier below 10,000 USDC notional: must take all positions.
- High-tier below 5,000 USDC notional: must claim entire position.
- Above thresholds: liquidator can take a percentage.
