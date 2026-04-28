# Fair Price Marking | Lighter Docs

URL: https://docs.lighter.xyz/trading/fair-price-marking

# Fair Price Marking

Mark price is the fair price of a perpetual contract. Mark price is calculated using the liquidity in the perpetual market order book and the index price (spot price of the underlying market). At any point in time, mark price is defined as follows:

$$
\begin{aligned}
\text{Impact Notional Amount} &= 500 \text{ USDC} / \text{Initial Margin Fraction} \\
\text{Impact Bid Price}_t &= \text{Avg execution price for a market sell of the impact notional value} \\
\text{Impact Ask Price}_t &= \text{Avg execution price for a market buy of the impact notional value} \\
\text{Impact Price}_t &= (\text{Impact Bid Price}_t + \text{Impact Ask Price}_t) / 2 \\
\\
\text{price1}_t &= index_t + \operatorname{EMA}_{8\,\mathrm{min}}\left(\operatorname{clamp}\left(\text{Impact Price}_t - index_t, -index_t/200, +index_t/200\right)\right) \\
\text{where} \operatorname{clamp}(x,a,b) &= \max\bigl(a, \min(b,x)\bigr) \\
\text{and} \operatorname{EMA}_{8\,\mathrm{min}} &\text{ refers to the Exponential Moving Average of the value over 8 minutes} \\
\\
\text{price2}_t &= median(\text{cexPrices}_t) \\
\text{where cexPrices}_t &\text{ are mark prices from different centralized exchanges} \\
\\
\text{Mark Price} &= Median(\text{Impact Price}_t, price1_t, price2_t)
\end{aligned}
$$

Lighter uses a combination of oracles (Chainlink, Stork, Pyth) to determine the index price.

Note: because the mark price is used when deciding if liquidations should be happening, the mark price should reflect as much as possible the impact price, so that the execution of liquidations should happen close to mark price. Because of this, we chose to incorporate the impact price directly in the mark price formula. Price 1 can be summarised as Index Price + Lighter Perpetual Premium, where the premium is capped at 0.5% of the Index Price. The usage of the EMA makes it so if someone tries to manipulate the order book, they'd need to do so for a prolonged period of time. The cap of 0.5% ensures that the mark price on Lighter will not be bigger than the other external components by more than 0.5%. In summary, the EMA component should yield better results than just using the funding rate due to the shorter time span, while also being resilient to manipulation.
