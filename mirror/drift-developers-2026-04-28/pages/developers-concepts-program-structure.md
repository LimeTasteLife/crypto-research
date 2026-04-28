# Program Structure – Drift Protocol
URL: https://docs.drift.trade/developers/concepts/program-structure

# Program Structure

This page dives deep into how Drift tracks positions, manages orders, and calculates collateral onchain.

## Overview

Drift's account model is built around a few key principles:

Key Design Principles

- Cross-margin - All positions within a wallet share collateral
- Subaccounts - Each wallet can have multiple isolated trading accounts (0, 1, 2…)
- Interest-bearing - Spot balances accrue interest via scaled balance mechanism
- Inline orders - Orders are stored directly in UserAccount (no separate order accounts)
- Account size limits - Fixed limits (8 perp, 8 spot, 32 orders) keep transactions predictable

## Position accounting

### PerpPosition

Tracks long/short exposure in perpetual futures markets.

Key mechanics:

- Position size: `baseAssetAmount` (positive = long, negative = short)
- Entry price: `quoteEntryAmount / baseAssetAmount`
- Unrealized PnL: `(oraclePrice - entryPrice) x baseAssetAmount`
- Funding payments: Tracked via `lastCumulativeFundingRate`

Order locking:

- `openBids` - Notional value locked in buy orders
- `openAsks` - Notional value locked in sell orders

Liquidity provision:

- `lpShares` - If providing liquidity to the AMM

### SpotPosition

Represents deposits (positive) or borrows (negative) in spot markets.

Interest accrual:

- Uses `scaledBalance` mechanism
- Real balance = `scaledBalance x cumulativeIndex`
- Avoids per-user interest calculations onchain
- Interest compounds automatically

Balance types:

- `DepositBalance` - You've deposited/lent tokens
- `BorrowBalance` - You've borrowed tokens

## Order mechanics

Orders are stored inline in UserAccount (no separate order accounts). Up to 32 orders per user including both resting orders and trigger orders.

### Order types

Limit orders - Resting orders at a specific price

- `postOnly` - Only execute as maker (reject if would take)
- `immediateOrCancel` - Fill immediately or cancel

Market orders - Execute immediately at best available price

Oracle orders - Price moves with oracle: `oraclePrice + oraclePriceOffset`

- Useful for market makers who want to maintain a spread without constant updates
- Price automatically adjusts as oracle updates

Trigger orders - Activate when oracle price crosses trigger price

- `triggerMarket` - Becomes market order when triggered
- `triggerLimit` - Becomes limit order when triggered

### JIT auctions

Every order goes through a Just-In-Time (JIT) auction to improve price:

- `auctionStartPrice` - Most aggressive price
- `auctionEndPrice` - Least aggressive price (limit price)
- `auctionDuration` - Slots for auction to run
- Price linearly improves from start to end over the duration

### Order flags

- `reduceOnly` - Order can only reduce position size, not increase or flip it
- `postOnly` - Order must be maker, rejected if would match immediately
- `immediateOrCancel` - Fill what you can immediately, cancel the rest

## Collateral and margin

### Total collateral calculation

```
Total Collateral =
  Sigma (spot deposits x asset weight)
  - Sigma (spot borrows x liability weight)
  + unrealized perp PnL
```

Asset weights (< 1.0)

- Safety buffer for deposits used as collateral
- Example: SOL might have 0.9 weight (90% of value counts)

Liability weights (> 1.0)

- Extra buffer for borrowed funds
- Example: Borrowed SOL might have 1.1 weight (110% of debt counts)

### Margin requirement

```
Margin Requirement = Sigma (position notional x initial margin ratio)
```

Initial margin ratio - Determines minimum collateral to open a position. Varies by market (e.g., 5% for BTC-PERP = 20x max leverage).

Maintenance margin ratio - Lower threshold that triggers liquidation. Typically ~half of initial margin.

### Account health

```
Health = Total Collateral / Margin Requirement
```

Health states:

- > 1.0 - Healthy, can open new positions
- < 1.0 - Liquidation eligible
- < 0.0 - Underwater (negative collateral)

## Cross-margin and subaccounts

All subaccounts under the same wallet share collateral for cross-margin benefits:

- Each wallet can create multiple subaccounts (0, 1, 2, …)
- Deposits in subaccount 0 can back positions in subaccount 1
- Total collateral and margin requirement are calculated across ALL subaccounts
- Liquidation considers all subaccounts together

## State transitions

Deposit / Withdraw / Place order / Order fill / Settle PnL / Liquidation each have specific on-chain effects detailed in the protocol-v2 source. Of note:
- Filled orders remain for history tracking (status flag)
- Settle PnL: Required before withdrawing perp profits
- Partial liquidations are common when health < 1.0

## Account size limits

- Perp positions: Maximum 8
- Spot positions: Maximum 8
- Orders: Maximum 32

Workaround: use multiple subaccounts (each has its own 8/8/32 limits, but share margin across all subaccounts).

Last updated on February 27, 2026
