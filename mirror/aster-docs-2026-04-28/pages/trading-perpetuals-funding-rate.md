# Funding Rate

Source: https://docs.asterdex.com/trading/perpetuals/fees-and-specs/funding-rate

### What is the Funding Rate?

In perpetual futures contracts, the funding rate is a periodic payment exchanged between traders holding long and short positions. This mechanism keeps the contract price close to the underlying spot price.

- Positive funding rate: The contract price is above the Mark Price — long traders pay short traders.
- Negative funding rate: The contract price is below the Mark Price — short traders pay long traders.

Note: There is a 15-second deviation between the actual time and when the funding fee is charged. For example, if you open a position at 16:00:05 UTC, you may still be charged a funding fee for that interval. Pay attention to your exact entry time.

### Funding Rate Formula

Funding Rate (F)= [Average Premium Index (P) + clamp (interest rate - Premium Index (P), 0.05%, -0.05%) ] / (8/N)

Where interest rate = 0.01%, except BNBUSDT perpetual contract, for which the interest rate is set to 0%.

N = funding interval

Example (ASTERUSDT at 4-hour funding interval)

Funding Rate (F)

= [Average Premium Index (P) + clamp (interest rate - Premium Index (P), 0.05%, -0.05%) ]/ (8/4)

= [Average Premium Index (P) + clamp (0.01% - Premium Index (P), 0.05%, -0.05%) ] / 2

In the event of extreme market volatility, Aster reserves the right to adjust the funding rate floor, cap, and the funding interval for perpetual contracts, which may differ from the default 8-hour interval.

For the latest funding rates and intervals, please visit our real-time funding rate and funding rate history pages.

Please be aware that any applicable funding fees will be deducted from your Perps Account balance. If your balance is insufficient, fees may be taken from your position margin, potentially impacting your liquidation price. It is essential to manage your positions carefully to mitigate liquidation risks.

### Premium Index Calculation

Premium index = [max(0, Impact bid price − Index price) − max(0, Index price − Impact ask price)] / Index price

Where:

- Index price = Weighted average price from external spot exchanges
- Impact bid price = Average price to sell a fixed notional value using the current bid depth
- Impact ask price = Average price to buy a fixed notional value using the current ask depth

Aster calculates the premium index every 5 seconds.

For symbols of which the funding interval is greater than 1 hour.
 Average Premium Index (P) = (1 Premium_Index_1 + 2 Premium_Index_2 + 3 Premium_Index_3 +···+ n Premium_Index_n) / (1+2+3+···+n)

For symbols of which the funding interval is 1 hour.
 Average Premium Index (P) = (Premium_Index_1 + Premium_Index_2 + Premium_Index_3 +···+ Premium_Index_n) / n

### How to Calculate Impact Bid Price

To determine the impact bid price, identify the level in the order book where the cumulative quote value exceeds the Impact Margin Notional (IMN).

Impact Margin Notional (IMN) is used to determine the average impact bid or ask price in the order book. IMN represents the notional value that can be traded using Impact Margin Amount((price quote in USDT).

Impact Margin Notional (IMN) = Impact Margin Amount/ Initial Margin Rate at the Maximum Leverage

This formula determines the size of the order book depth used to calculate the impact price, based on the margin required at the maximum leverage setting.

(Note: The Impact Margin Amount is a configurable parameter and may vary instead of being fixed)

To help visualize the calculation, the following table shows how quote notional values accumulate across levels in the order book:

In this table:

- Quote Notional Quantity = price × quantity × contract multiplier
- Accumulated Quote Notional Quantity is the sum of quote notional values up to that level.

Once the accumulated quote notional exceeds the IMN, the corresponding level is used in the final Impact Bid (or Ask) Price formula.

If:

Contract multiplier × ∑px × qx > IMN

and

Contract multiplier × ∑px-1 × qx-1 < IMN

Then level x is used to calculate the Impact Bid Price using: Impact Bid Price = IMN / [(IMN − Contract Multiplier × ∑px−1 × qx−1) / px + Contract Multiplier × ∑qx−1]

Where:

- px = Price at level x
- qx = Quantity at level x
- IMN = Impact margin notional (predefined value)
- Contract multiplier = Multiplier for the contract (usually 1)

### Example Order Book (Bid-Side)

Assume the bid-side of the order book is:

| Level | Price (px) | Quantity (qx) |
| --- | --- | --- |
| 1 | 100 | 5 |
| 2 | 99 | 10 |
| 3 | 98 | 15 |

To calculate the Impact Bid Price, accumulate quoted value by level until it meets or exceeds the IMN (Impact Margin Notional). Then apply the formula above using the correct level data.

### Funding Amount

The funding amount is how much you will pay or receive based on the funding rate.

Funding amount = Position size × Mark price × Funding rate

This value is transferred between long and short traders depending on the direction of the funding rate. Aster does not charge or receive funding — it is a peer-to-peer transfer.
