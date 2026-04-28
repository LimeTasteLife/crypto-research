# Spot Trading – Drift Protocol
URL: https://docs.drift.trade/protocol/trading/spot-trading

# Spot Trading

Spot Trading is the direct purchase or sale of an asset. The delivery of the assets is immediate and the transaction settles on-chain. Once the spot trade has been confirmed, the settlement will be instantaneous, and you will be able to see the increase or decrease in the asset immediately in your account balances.

Spot trading on Drift v3 uses liquidity from OpenBook DEX as well as our own DLOB. By default, margin trading is not enabled. Learn how to enable it in the next section.

### Navigate to spot trading

Select "Trade" then "Spot" from the top navigation.

### Select the market

Select a market in the top bar or the market's dropdown menu

### Choose direction and order type

Select your direction (e.g. Buy or Sell) and order type (e.g. Market, Limit)

### Enter asset amount or notional value

Input the asset amount you'd like to trade or the notional value

### Confirm and fill

Once you've confirmed your order and it has been filled, your Balances tab will update to reflect your balance changes

## Enable Spot Margin Trading

Margin trading allows you to leverage your assets as collateral to borrow funds for the trade. The leverage a trader can take in each spot market is determined by the protocol's risk engine. Margin needs to be enabled per subaccount.

## FAQ

### Why is Drift's spot market better for takers (versus alternatives)?

Takers enter a JIT auction, which can offer price improvement, and otherwise can fill via an external program. (e.g. Serum).

Takers can also utilise special order types such as oracle-offset limit orders, which appropriately can cap fills using slippage tolerance versus the oracle provider's fair value. This allows ordinary takers on a UI to control swapping at the fairest price, even without access to advanced infrastructure / bots.

### Better for makers (versus alternatives)?

Market makers can provide liquidity to an ongoing JIT auction, removing latency-based adverse selection.

Additionally, as an active market maker, all resting orders earn interest within the protocol's borrow / lend.

Example: on a USDT-USDC spot market one can offer deep liquidity without compromising on lending interest

Last updated on February 27, 2026
