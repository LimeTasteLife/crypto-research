# Prelaunch Markets | Lighter Docs

URL: https://docs.lighter.xyz/trading/prelaunch-markets

# Prelaunch Markets

### Market structure

All prelaunch markets will operate in isolated mode only. It is not possible to open positions in cross-margin mode due to the experimental and volatile nature of these markets.

### XLP

Because prelaunch markets are volatile, we are taking precautions in deploying them. LLP will not act as a market maker on these markets. Instead, a new pool called XLP (Experimental Liquidity Provider) will offer liquidity for these markets. LLP will have no exposure to prelaunch markets.

XLP will act solely as a liquidity provider for these markets, without a special role in the liquidation flow. More details on liquidations can be found below.

### Liquidations

Due to the nature of prelaunch markets and the addition of XLP, the liquidation flow is different. Prelaunch markets have no liquidation fee.

If a user needs to be liquidated — that is, when their margin falls below the Maintenance Margin but remains above the Close-Out Margin — the exchange will send an Immediate-or-Cancel (IoC) order on behalf of the user to close the position. This will not have a fee associated with it.

If the user falls below the Close-Out Margin, they will be directly Auto-Deleveraged (ADL). This flow differs from crypto markets, where the entire account would typically be transferred to LLP. In normal cases, ADL is used only when LLP does not have sufficient funds to cover the losses of a bankrupt account.

Note: ADL occurs when a user is below the Close-Out Margin. This does not imply that the user is bankrupt. Because of this, the counterparty (the trader on the other side of the ADL) receives a more favorable execution price.
