# Order Types & Matching | Lighter Docs

URL: https://docs.lighter.xyz/trading/order-types-and-matching

# Order Types & Matching

### Market Orders

A market order is an order that executes immediately at the current market price for a given position size. Users can set an average execution price to limit how much their execution price can deviate from the mid-price of the order book. If there is insufficient liquidity in the market, or if subsequent fills would cause the average execution price to exceed the set limit, the market order will be partially filled.

#### Execution options

- The Reduce-Only execution option ensures that changes to the position only move it closer to zero, regardless of whether the position is positive or negative.

### Limit Orders

A limit order is a buy or sell order that executes at the limit price user sets or better. Limit orders also support enhanced order options like expiration and execution instructions.

#### Execution options

- The Post-Only execution option ensures that a limit order is placed only as a maker order. If there are crossing orders on the opposite side of the order book at the time of placement, the exchange automatically cancels the post-only order to prevent it from becoming a taker order. If no crossing orders are present, the order is inserted into the order book. This guarantees that the order acts only as a maker and will pay maker fees for any trades.
- The Reduce-Only limit order reduces the position size towards zero, executing partially if the order size exceeds the position, with any remaining portion canceled once the position reaches zero.

#### Time in Force

Time-in-force options allow users specify the lifetime of an order.

- Good 'Til Time option allows users to specify a time until which the order remains valid. If the expiry time of an active order in the order book passes, the exchange automatically cancels the order.
- The Immediate or Cancel option automatically cancels an order if it is not immediately filled. These orders are not placed into the order book as maker orders.

### Stop-loss and Take-profit Orders

A stop-loss (SL) order is an instruction to sell (or buy) an asset when its price hits a trigger price, with the goal of limiting potential losses. On the other hand, a take-profit (TP) order specifies a trigger price at which an asset will be sold (or bought) to lock in gains. Both orders are automatically triggered.

In addition, there are stop-loss limit orders and take-profit limit orders. A stop-loss limit order combines the stop-loss trigger with a limit order, ensuring the asset will be sold (or bought) only at the specified price or better once the mark price reaches the trigger price. Similarly, a take-profit limit order sets a price at which the asset will be sold (or bought) to secure profits, but only if the market price meets or exceeds the trigger price. These limit orders offer more control over the execution price compared to standard stop-loss or take-profit orders.

#### Trigger Conditions

Stop-Loss Sell Order & Take-Profit Buy Order:

$$
\text{markPrice} \le \text{triggerPrice}
$$

Stop-Loss Buy Order & Take-Profit Sell Order:

$$
\text{markPrice} \ge \text{triggerPrice}
$$

#### Time in Force

- The Good 'Til Time option is available for SL/TP limit orders and it allows users to set an expiration time, after which the order is automatically canceled if not triggered.

#### Execution options

- The Reduce-Only option works the same way as for Limit Orders, ensuring the position size decreases towards zero and canceling the order if further fills would cause the position to exceed zero.

### TWAP

TWAP (Time-Weighted Average Price) Orders are a type of order designed to execute a large order over a specified time period at an average price, aiming to minimize the market impact of the order. The goal is to match the average price of the asset over the execution period, rather than executing all at once at a specific price.

#### Running Time

The running time option for a TWAP order defines the total time over which the order will be filled. Every 30 seconds, a new market order will be placed with a size of:

$$
\text{order size} = \frac{\text{total amount}}{\text{\#orders}}
$$

where #orders is calculated as:

$$
\text{\#orders} = \frac{\text{execution duration}}{30\text{s}} + 1
$$

#### Execution options

- The Reduce-Only option ensures that a trade is executed only if it reduces the position towards 0. The TWAP order will not be canceled when the position reaches 0; it will continue attempting to execute until it expires, but a trade will only happen if the position moves closer to 0. Partial fills may occur during this process.

---

### Order Margin

The Matching Engine performs risk checks after every trade to ensure that the health of trading accounts is maintained:

1. Healthy Accounts: A trade must not cause a currently healthy account to become unhealthy.
2. Unhealthy Accounts: If an account is unhealthy prior to a trade, the trade must improve the account's health.

If a trade violates these rules, the Matching Engine auto-cancels the corresponding order(s) that violates the risk checks.

To ensure the order book accurately reflects orders that are likely to be executable (i.e., orders that wouldn't trigger an auto-cancellation upon trade execution), the Risk Engine employs a margining system for limit orders placed onto the book. Each limit order consumes a certain amount of Order Margin.

Margin consumed by these orders does not affect the position margin; it is merely a checking mechanism used only when placing new orders. Order margin usage does not affect liquidations, etc. Available order margin is calculated as follows:

$$
\begin{align*}
\text{orderValue}_{\text{ask/bid}} &= \sum_{i \in \text{activeLimitOrders}_{\text{ask/bid}}} (\text{limitPrice}_i \times \text{orderSize}_i) \\
\text{orderMargin}_{\text{sameSide}} &= \frac{\text{orderValue}_{\text{ask/bid}}}{\text{leverage}} \\
\text{orderMargin}_{\text{oppositeSide}} &=
\begin{cases}
\frac{ \text{orderValue}_{\text{ask/bid}} - 2 \times (|\text{position}| \times \text{markPrice} ) }{\text{leverage}} & \text{if Cross Margin} \\
\frac{ \text{orderValue}_{\text{ask/bid}}}{\text{leverage}} - \text{TAV}_{\text{isolated}} - \text{IMR}_{\text{isolated}} & \text{if Isolated Margin}
\end{cases} \\
\text{availableOrderMargin}_{\text{mi}} &= \text{TAV}_{\text{cross}} - \text{IMR}_{\text{cross}} - \mathbf{M}_{\text{other}} - \mathbf{M}_{\text{current}}
\end{align*}
$$

where

$$
\begin{align*}
\mathbf{M}_{\text{other}} &= \sum_{i \neq \text{mi}} \left[ \max\left( \text{orderMargin}_{i,\text{sameSide}}, \text{orderMargin}_{i,\text{oppositeSide}} \right) \right] \\
\mathbf{M}_{\text{current}} &=
\begin{cases}
\text{orderMargin}_{\text{mi},\text{sameSide}} & \text{if New Order Side} = \text{Position Side} \\
\text{orderMargin}_{\text{mi},\text{oppositeSide}} & \text{if New Order Side} \neq \text{Position Side}
\end{cases}
\end{align*}
$$

---

### Price Checks

Price checks are used to guarantee that order prices remain within acceptable and realistic ranges, helping to prevent erroneous or extreme values.

Fat Finger Prevention Check
This check ensures that the price of a limit order is within a reasonable range to prevent errors.

- For an ask order, the price must be at least:

$$
max(MarkPrice, bestBid) \times 0.95
$$

- For a bid order, the price must be at most:

$$
min(MarkPrice, bestAsk) \times 1.05
$$

If the bestBid or bestAsk does not exist, only the markPrice is used for validation.

The same check applies to SL/TP limit orders, but in this case, the TriggerPrice set in the order is used instead of the MarkPrice.

---

### Order Matching

When matching orders, Lighter uses a price-time priority system. When a new order is placed as the taker, the Lighter Matching Engine finds the highest-priority order on the opposite side of the order book, meaning the order with the best price. If there are multiple orders with the same best price, the oldest one is selected. The matching engine then executes the trade at the maker's price. If the taker order is not fully filled, this process continues until the taker order is completely filled or until there are no more crossing orders. If the taker order is a limit order that needs to be placed in the order book, the Lighter Matching Engine inserts it on the corresponding side.

> The Lighter Matching Engine ensures that price-time priority is always respected by utilizing SNARKs to generate cryptographic proofs for fair order book matching execution. As a result, the Lighter Matching Engine operates as a trustless service, bound to function in a predefined way, making it mathematically impossible for it to act maliciously.
