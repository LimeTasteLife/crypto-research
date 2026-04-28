# Trading Workflows – Drift Protocol
URL: https://docs.drift.trade/developers/trading-automation/trading-workflows

# Trading Workflows

This page is for builders who want to execute trades programmatically. Core SDK flow: connect -> read markets -> place orders -> manage risk -> manage collateral.

### Set up the SDK + wallet

Create a `DriftClient`, connect to RPC, initialize wallet and environment.

### Read markets + oracles

Fetch market metadata, oracle prices, and subscriptions before trading.

### Place and cancel orders

Use order helpers for limit/market/oracle/trigger orders; handle cancels/edits.

### Monitor PnL and risk

Track margin, health, and PnL before and after trades.

### Manage collateral and exits

Deposit/withdraw collateral, settle PnL, close positions safely.

Last updated on February 27, 2026
