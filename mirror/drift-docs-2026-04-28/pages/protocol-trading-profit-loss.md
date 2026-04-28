# Introduction to Profit & Loss – Drift Protocol
URL: https://docs.drift.trade/protocol/trading/profit-loss

# Introduction to Profit & Loss

This guide explains how to track your Profit and Loss (P&L or PnL) on Drift to understand the performance of your open positions in perpetual markets.

### What is P&L?

P&L reflects the potential profit or loss on your open positions. It's a dynamic value that changes based on the current market price of the underlying asset compared to your average entry price. In simpler terms, it indicates whether your positions are currently trending towards profit or loss.

A user's current position on Drift is the cumulative sum of all their filled orders (increasing, reducing, or closing) over time. All trading lots, per market and per subaccount, are combined into a single position to determine P&L. The P&L in the table above is calculated as the difference between the position's `Entry Price` with the current mark price (can toggle to oracle price) multiplied by the `Size` (view can be switched between $ and %).

P&L in the Positions tab is unrealised P&L (uP&L) and as such doesn't represent actual withdrawable amount (claimed and settled P&L). Read the Types of P&L for more details.

### Types of P&L

- `Unrealised P&L (uP&L)`: Potential profit or loss on open positions based on current market price vs. your entry price. It fluctuates with the market.
- `Settled P&L`: Actual realised profit and loss (can be settled without closing the position).
- `Claimable / Unsettled P&L`: Claimable P&L represents the portion of unsettled P&L that is available to be claimed at this moment. It is possible to have unsettled P&L that is not claimable due to insufficient funds in the P&L Pool, invalid oracle, or other reasons.

What is the difference between Settling P&L and Realising P&L?

The key difference lies in the availability for withdrawal:

- Realised P&L doesn't automatically guarantee immediate withdrawal. You need sufficient settled funds in the Market's P&L Pool, which comes from accumulated settled losses from other users.
- Settled P&L is the realised profit that's already been processed and added to the pool. This is the portion you can withdraw immediately.

### P&L Settlement and Withdrawal

- Settling P&L moves profit/loss from a perpetual market to your USDC balance.
- Requires claiming settled P&L before withdrawal.
- P&L pool liquidity determines if settled P&L pool is claimable immediately.

Withdrawing realised P&L requires settling/claiming it first. Closing your position realizes your P&L, but it doesn't automatically make it available for withdrawal.

### Claiming Settled P&L

1. On any trades screen navigate to the "Balances" tab.
2. Select "Claim" for specific positions or "Claim All".

Users can claim positive P&L when:

the open position has been closed or reduced (i.e. your uP&L has been partially or wholly realised); note: this step is only necessary when the P&L pool balance is limited

the market's P&L Pool has available balances to claim; and

their Cost Basis is below the Entry Price for longs or above the Entry Price for shorts.

Automatic P&L Settlement

P&L settlement is a permissionless action - anyone could settle two account's P&Ls at any time.

Settling the P&L will improve the accounts health.

Last updated on February 27, 2026
