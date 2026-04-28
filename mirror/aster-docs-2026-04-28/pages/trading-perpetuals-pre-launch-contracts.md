# Pre-Launch Contracts

Source: https://docs.asterdex.com/trading/perpetuals/pre-launch-contracts

Pre-launch contracts or pre-markets allow users to trade token pairs before they are officially listed on major exchanges. They are structured as expiry futures contracts, but may also take the form of perpetual futures. Once the token launches and begins trading, the pre-market symbol on Aster Perps converts to a regular perp futures contract.

Aster has the right to initiate the delivery process automatically when a token launches on an external exchange or when the token's tokenomics are released. Pre-market mode will switch to a perpetual contract automatically.

Aster retains final authority over the delivery price and the right to delist the contract.

### Mark Price (Pre-Launch USDT-Margined Futures Contracts)

Aster uses the Mark Price to avoid unnecessary liquidations and to prevent market manipulation. The Price Index for pre-launch markets is calculated differently from regular perpetual futures.

The Mark Price formula:

(1) Mark Price = Median × (Price 1 , Price 2 , Contract Price)

(2) Price 1 = ( Bid 1 + Ask 1) / 2 × (1 + Funding Rate × (Time to Next Funding Rate (h)/8 ))

(3) Price 2 = ( Bid 1 + Ask 1) / 2

Bid 1 & Ask 1 are sourced from the pre-market order book.

The median is the middle value of Price 1, Price 2, and the Contract Price. For example, if Price 1 < Price 2 < Contract Price, then Price 2 is taken as the Mark Price.

Price 2 logic may be updated based on market conditions.

Once the pre-market symbol transitions to a regular perpetual futures contract, the index price calculation also switches to the standard perpetual futures methodology.

#### Related docs:

- https://docs.asterdex.com/product/asterex-pro/mark-price
- https://docs.asterdex.com/product/asterex-pro/liquidations
- https://docs.asterdex.com/product/asterex-pro/adl
