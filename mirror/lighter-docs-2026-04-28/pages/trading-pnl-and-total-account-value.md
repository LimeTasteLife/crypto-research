# PnL And Total Account Value | Lighter Docs

URL: https://docs.lighter.xyz/trading/pnl-and-total-account-value

# PnL And Total Account Value

### Perps Trading

Unrealized PnL shows how much you would gain or lose if you closed your positions at the current mark price.

$$
pos_i
$$

$$
\text{Unrealized PnL} := \sum(\text{markPrice}_i - \text{avgEntryPrice}_i) \times position_i
$$

Realized PnL is the gain / loss that has already been captured from the position after closing or due to funding payments. It is calculated based on the difference in USDC value between your average entry price and exit price. Additionally, all funding payments for the position are immediately applied to its realized PNL.

- When the user is closing a portion of an existing long or short position, average entry price stays the same and exchange realizes the difference in average exit and entry prices.

$$
\Delta Collateral := (\text{exitPrice}_i - \text{avgEntryPrice}_i) \times \Delta position_i
$$

- When the user is increasing the size of their open position, no PnL is realized. Exchange updates the average entry price according to the following formula

$$
\text{avgEntryPrice}_{i, new} := \frac{\text{avgEntryPrice}_{i, old} \times position_{i, old} + tradePrice \times tradeSize}{position_{i, new}}
$$

### Spot Trading

### Total Account Value

Total Account Value represents the total USDC value of an account in Lighter, including all open positions and collateral. It is calculated as follows:

$$
\text{Total Account Value} = \text{Collateral} + \text{Unrealized PnL}
$$

Note: Isolated positions use a separate collateral balance (Allocated Margin) dedicated solely to that specific position. It functions the same as collateral but applies only to the relevant position and should be treated as collateral in the calculations above.
