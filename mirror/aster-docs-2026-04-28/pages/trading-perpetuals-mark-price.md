# Mark Price

Source: https://docs.asterdex.com/trading/perpetuals/fees-and-specs/mark-price

On Aster Perps, the Mark Price serves as a reference price for calculating a trader's unrealized profit and loss (PnL) and for triggering liquidations. Its primary purpose is to prevent unnecessary forced liquidations during periods of abnormal market volatility and to ensure fair, accurate pricing for perpetual contracts. Unlike the last traded price — which can be affected by sudden swings or manipulation — the Mark Price provides a more stable and reliable benchmark.

### Price Index

The Price Index is a weighted average of prices from major spot exchanges such as Binance, HTX, Kraken, and other key markets. Exchanges with higher trading volume carry greater weight in the index. This index represents the "fair value" of an asset's spot price and is the primary component used to calculate the Mark Price.

Example: For BTC perpetual contracts, the index might include BTC/USDT prices from Binance, Kraken, and Huobi, weighted by trading volume, to reflect the fair spot price of BTC.

### How the Mark Price is Calculated

The Mark Price is determined by taking the median of three prices:

- Price 1: Price index × (1 + Funding rate × (Time to next funding rate in hours ÷ 8))
- Price 2: Price index + 5-minute moving average of (Bid 1 + Ask 1) ÷ 2 − Price index
- Contract Price: The current contract price

The 5-minute moving average is sampled every minute over a 5-minute interval:

Moving average = Average of ((bid 1 + ask 1) ÷ 2 − Price index)

The Mark Price is the median of Price 1, Price 2, and the Contract Price. For example, if Price 1 < Price 2 < Contract Price, then Price 2 is selected as the Mark Price.

### Protective Measures During Abnormal Market Conditions

- Single exchange deviation: If a price from one exchange deviates more than 5% from the median of all sources, that exchange's weight is set to zero.
- Multiple exchange deviations: If multiple exchanges show deviations above 5%, the median of all sources is used as the index value instead of the weighted average.
- Exchange connectivity issues: If an exchange fails to update its price feed within 3 seconds, it is removed from the price index calculation.
- Last trade price protection: If the latest contract trade deviates more than 5% from the Mark Price and no new trade occurs within 5 seconds, the Contract Price is replaced with the current Mark Price in calculations.

### Why the Mark Price Matters

- Unrealized PnL: Determines the unrealized PnL for open positions.
- Liquidation reference: Prevents unfair liquidation due to sudden spikes in contract prices.
- Funding calculations: Influences funding payments between long and short positions.

### FAQs

#### What is the difference between Mark Price and Last Price?

The Mark Price is a reference used to calculate unrealized PnL and trigger liquidations; it's designed to prevent unfair forced liquidations. The Last Price is the most recent trade price on the contract and can fluctuate more quickly during high volatility.

#### How is the Price Index calculated?

It's a weighted average of spot prices from major exchanges. Exchanges with higher trading volumes carry more weight and represent the fair market value of the asset.

#### Why does Aster use the median of three prices to determine Mark Price?

Using the median smooths out sudden spikes or drops, reducing unnecessary liquidations.

#### What protective measures exist if market conditions are abnormal?

- If one or more exchanges deviate significantly (>5%) from the median, their influence is reduced or removed.
- If trade prices stray far from the Mark Price with no updates, the system replaces the contract price with the Mark Price in calculations.
- Exchanges with delayed feeds are temporarily excluded from the Price Index.

#### Can the Mark Price differ from the actual market price?

Yes. During high volatility or abnormal conditions, the Mark Price may deviate from the Last Price.

#### How does Mark Price affect liquidations?

The Mark Price acts as a reference price to calculate a trader's unrealized profit and loss (PnL) and to trigger liquidations.

#### Is the Mark Price used for funding payments?

Yes. Funding payments between long and short positions are calculated using the Mark Price to maintain fairness.
