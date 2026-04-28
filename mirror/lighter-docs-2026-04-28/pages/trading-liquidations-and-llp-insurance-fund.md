# Liquidations & LLP (Insurance Fund) | Lighter Docs

URL: https://docs.lighter.xyz/trading/liquidations-and-llp-insurance-fund

# Liquidations & LLP (Insurance Fund)

### Overview

Each market in Lighter has different margin requirement configurations, which essentially define how much leverage an account can have in its positions without getting liquidated. When the value of an account falls below the margin requirements, liquidation occurs. Lighter has three different levels of margin requirements, each triggering different actions by the exchange.

For a specific account, the margin requirements are defined as follows:

$$
\begin{aligned}
S_i &:= |pos_i| \\
I_i &:= \text{initial margin fraction for the market} \\
M_i &:= \text{maintenance margin fraction for the market} \\
C_i &:= \text{close out margin fraction for the market} \\
\\
\text{Initial Margin Req} &:= \sum S_i \times mark_i \times I_i \\
\text{Maintenance Margin Req} &:= \sum S_i \times mark_i \times M_i \\
\text{Close Out Margin Req} &:= \sum S_i \times mark_i \times C_i \\
\\
\text{Account Value} &= Collateral + \sum (markPrice_i - \text{avgEntryPrice}_i) \times position_i
\end{aligned}
$$

$$
C_i < M_i < I_i
$$

Note: Users can change their leverage on the markets. In that case, the initial margin fraction of the market will be the `min(margin fraction set by the user, minimum fraction allowed for the market)`.

### Liquidation Waterfall

1. **Healthy Account:** An account is considered healthy when its account value is greater than all the margin requirements. It can execute any type of exchange operation as long as its position remains healthy after the execution of the transaction.
2. **Pre-Liquidation:** An account is in pre-liquidation mode when its account value is below the initial margin requirements but above the maintenance margin requirements. In pre-liquidation mode, only exchange operations that do not decrease the account value to the maintenance margin requirement ratio and do not increase the size of any position can be executed.
3. **Partial Liquidation:** In the case of partial liquidation, liquidation engine first cancels all of the open orders of the user. If the account value is still below the maintenance margin, liquidation engine orders open positions of the underwater account by a heuristic, then sends IoC limit orders on behalf of the margin called user with corresponding zero price one by one for the full amount of the position. If the user goes above the maintenance margin requirement after fully executing a trade, then the liquidation engine stops the liquidations. If the user gets filled at a better price than the zero price, liquidation engine takes up to 1% liquidation fee and sends it to LLP (insurance fund). One important aspect of the zero price is, when a trade gets executed at the zero price, total account value to maintenance margin ratio stays the same. Thus any trade that happens in partial liquidation phase only increases the account health, since the trade price is at least as good as the zero price. If all of the account positions are closed (i.e. maintenance margin requirement is 0) at the zero price, account value also becomes zero.

$$
\begin{aligned}
zeroPrice_i(short) &= markPrice_i \times \left(1 + \frac{M_i \times \text{Account Value}}{\text{Maintenance Margin Req}}\right) \\
zeroPrice_i(long) &= markPrice_i \times \left(1 - \frac{M_i \times \text{Account Value}}{\text{Maintenance Margin Req}}\right)
\end{aligned}
$$

**Deriving Zero Price For a Long Position:**

$$
\begin{aligned}
\text{TAV}' &= \text{TAV} + (\text{ZP} - \text{MP}) \times \text{TS} \\
\text{MMR}' &= \text{MMR} - \text{TS} \times \text{MP} \times M_i \\
\frac{\text{TAV}'}{\text{MMR}'} &= \frac{\text{TAV} + \text{ZP} \times \text{TS} - \text{MP} \times \text{TS}}{\text{MMR} - \text{MP} \times \text{TS} \times M_i} = \frac{\text{TAV}}{\text{MMR}} \\
(\text{TAV} + \text{ZP} \times \text{TS} - \text{MP} \times \text{TS}) \times \text{MMR} &= \text{TAV} \times (\text{MMR} - \text{MP} \times \text{TS} \times M_i) \\
\text{ZP} \times \text{TS} \times \text{MMR} - \text{MP} \times \text{TS} \times \text{MMR} &= - \text{MP} \times \text{TS} \times \text{TAV} \times M_i \\
\text{ZP} \times \text{MMR} &= \text{MP} \times (\text{MMR} - \text{TAV} \times M_i) \\
\text{ZP} &= \text{MP} \times \left(1 - \frac{\text{TAV} \times M_i}{\text{MMR}}\right)
\end{aligned}
$$

Where: TAV = Total Account Value, MMR = Maintenance Margin Requirement, ZP = Zero Price, MP = Mark Price, TS = Trade Size.

4. **Full Liquidation:** If a user goes below the close-out margin requirement, the LLP closes all of the user's positions by taking them over in ascending order of unrealized PnL. For each position, the LLP takes it over only if doing so would keep the LLP's total account value above the Initial Margin Requirement. Any positions that would cause the LLP to fall below this threshold are instead auto-deleveraged.
5. **Auto-deleveraging (ADL):** When an account has a negative value and the LLP does not have enough capital to cover the losses of the bankrupt account, the exchange initiates auto-deleveraging (ADL) for the bankrupt account's positions. A bankrupt account, by definition, has at least one open position. The exchange identifies positions on the opposite side of the bankrupt positions and executes trades between these accounts if their zero prices align. This ensures that ADL does not decrease the health of any account, as the execution price cannot be worse than the zero price of the position. When selecting positions for ADL on the opposite side, the system ranks users based on their leverage and unrealized PnL.

### Isolated Liquidations

When a users sets a market to the isolated mode, the position will be treated as a separate account and won't be affected by the other positions. The calculations and the flow will be the same as above, but the collateral for an isolated position is called AllocatedMargin.
