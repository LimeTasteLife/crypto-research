# Funding | Lighter Docs

URL: https://docs.lighter.xyz/trading/funding

# Funding

### Overview

The funding mechanism is a crucial component of perpetual futures trading. It ensures that the price of the perpetual contract closely tracks the underlying asset's spot price. Unlike traditional futures contracts, perpetual futures do not have an expiration date. To maintain price stability and avoid significant deviations from the spot price, a periodic funding mechanism is implemented.

Funding payments occur at each hour mark. Traders holding long and short positions pay or receive a funding fee based on the difference between the contract price and the spot price. These payments are fully peer-to-peer with no fees taken by the exchange. The funding payment for an account position depends on the size and side of the position, as well as the funding rate.

The funding rate represents the difference between the mark price of the perpetual futures market and the index price, which is equivalent to the spot market price of the underlying asset.

When the funding rate is positive, users with long positions pay a funding fee to users with short positions. When the funding rate is negative, users with short positions pay a fee to users with long positions.

### Funding Rate Calculation

For each minute at a random time, Lighter calculates the premium of each market, which represents the differentiation of the mark price from the index price for the corresponding market with the following formula:

$$
premium_{t} = \frac{Max(0, \text{Impact Bid Price}_{t} - index_{t}) - Max(0, index_{t} - \text{Impact Ask Price}_{t})}{ index_{t}}
$$

At the end of each hour, a 1-hour premium is calculated as the time-weighted average of the 60 premiums calculated over the course of the last hour. In addition to the premium component, each market has a fixed interest rate component that accounts for the difference in interest rates of the base and quote currencies. The funding rate is then calculated as:

$$
\begin{aligned}
premium &:= \text{Average of } premium_{t} \text{ since the latest funding} \\
smallClampedPremium &= InterestRate + premium + \operatorname{clamp}(-premium, -SmallClamp, +SmallClamp) \\
fundingRate &= \operatorname{clamp}(smallClampedPremium, -BigClamp, +BigClamp) / 8 \\
\text{where} \operatorname{clamp}(x,a,b) &= \max\bigl(a,\min(b,x)\bigr)
\end{aligned}
$$

The values used for the majority of the markets are the following:

- SmallClamp = 0.05%
- BigClamp = 4%
- InterestRate = 0.01%

Example:

$$
smallClampedPremium = 0.01\% + 0.1\% - 0.05\% = 0.06\%
$$

$$
fundingRate = InterestRate / 8
$$

$$
0.5\%
$$

Dividing the 1-hour premium by 8 ensures that funding payments for the premium are distributed over 8 hours, closely aligning with the approach adopted by centralized perpetual exchanges.

Funding round payment for account i and market j is calculated as follows:

$$
funding_{account_i,j} := (-1) \times position_{account_i,j} \times mark_{j} \times fundingRate_{j}
$$
