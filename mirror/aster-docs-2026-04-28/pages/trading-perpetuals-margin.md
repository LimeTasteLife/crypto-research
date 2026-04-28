# Margin

Source: https://docs.asterdex.com/trading/perpetuals/margin

Margin trading on Aster Perps lets you amplify your positions by using leverage, allowing you to trade with more size than your actual balance.

### Leverage

Leverage lets you open a larger position with a smaller amount of collateral. For example, with 10× leverage, a $100 margin allows you to open a $1,000 position.

You can set your desired leverage using the slider or input field in the trading panel. Each asset has its own maximum leverage limit.

The initial margin required to open a position is calculated as:

(Position size × Mark price) / Leverage

### Margin Modes

Aster supports two margin modes:

#### Cross Margin (default)

Your margin is shared across all open positions. Profits from one trade can offset losses in another, reducing liquidation risk – but your entire margin balance is at stake.

#### Isolated Margin

Margin is applied to a single position only. If the trade moves against you, only the margin tied to that position is at risk; other positions remain unaffected.

You can select the margin mode in the trading interface (Cross/Isolated) before opening a position. You cannot change the margin mode after submitting a position or placing an open order.

### Monitoring Margin

Your used margin, liquidation price, and available balance are displayed in real time in the position panel. Use these to manage risk and avoid liquidation.

Maintenance margin is the minimum amount required to keep a position open. It's based on the total size of your position rather than the leverage you select. As position size increases, higher portions fall into higher maintenance margin tiers, each with progressively higher rates.

### Liquidation

If your margin falls below the maintenance requirement, your position may be liquidated to prevent further losses. Keep a close eye on your margin ratio and funding rates to stay safe.
