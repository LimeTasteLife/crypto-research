# Liquidations

Source: https://docs.asterdex.com/trading/perpetuals/fees-and-specs/liquidations-1

### Understanding Liquidation Mechanics

Liquidation occurs when your account's margin balance is insufficient to cover the required maintenance margin for your open positions. When this happens, the system automatically closes your position to prevent your balance from going negative.

A forced liquidation is triggered when:

Margin = Initial Collateral + Realized PnL + Unrealized PnL < Maintenance margin

To avoid liquidation (i.e., when the risk ratio hits 100%), it's recommended to keep your margin ratio below 80% by adding sufficient margin or reducing your position size.

### How Liquidation Price is Determined

Forced liquidation occurs when the Mark Price reaches the liquidation price. Aster uses the Mark Price to keep liquidations fair and minimize the impact of price manipulation.

- In cross margin mode with hedge trading, both long and short positions of the same contract share the same liquidation price.
- In isolated margin mode, long and short positions have separate liquidation prices based on the margin allocated to each.

### What is Maintenance Margin?

Maintenance Margin is the minimum amount of margin required to keep a position open. Different positions have different maintenance margin requirements. If your account margin ratio falls below the maintenance margin requirement, liquidation is triggered.

### The Liquidation Process

When your account margin falls below the required maintenance level, Aster initiates a forced liquidation using a staged, priority-driven process that attempts to avoid full liquidation where possible.

Step 1: Cancel open orders
All open orders tied to the affected account are immediately canceled to prevent new orders from affecting the liquidation flow.

Step 2: Attempt position close with an IOC order
The system issues one large Immediate-or-Cancel (IOC) order.
The IOC fills as much as the market allows, and any unfilled portion is canceled. This step attempts to reduce the position size and eliminate the margin deficit without fully closing the position.

Step 3: Recheck margin
After the IOC executes, the engine recalculates your available margin accounting for realized losses and the liquidation fee. If the remaining assets meet the maintenance requirement, liquidation stops and your remaining position stays open.

Step 4: Bankruptcy and insurance fund takeover
If the IOC cannot fully eliminate the deficit, the leftover portion becomes a bankrupt position. That portion is closed at the bankruptcy price and transferred to the Insurance Fund, which covers losses arising from the bankrupt position to the extent possible.

Step 5: Negative balance handling
If closing the bankrupt position still leaves the trader's balance negative, the insurance fund covers the shortfall if possible. If the insurance fund cannot fully cover losses, the system may trigger Auto-Deleveraging (ADL), in which profitable opposing positions are reduced to make up the deficit.

To avoid liquidation (i.e. when the risk ratio hits 100%), it's recommended to keep your margin ratio below 80% by adding sufficient margin or reducing your position size.

#### Additional notes

- Smart Liquidation principle
The protocol uses a smart liquidation approach that prioritizes partial close via the IOC to avoid a full forced close when possible.
- Bankruptcy price
The bankrupt portion is closed at the bankruptcy price, which is the protocol price used to finalize the bankrupt position. Profits or remaining assets from handling bankrupt positions are retained by the insurance fund.
- Position size and margin tiering
Smaller positions often have less buffer and are more likely to be liquidated fully. Larger positions may receive more gradual, tiered liquidation treatment that helps avoid immediate full liquidation.
- Fees and recommendations
Liquidation involves realized loss plus a liquidation fee. To avoid forced liquidation and fees, close positions manually before you approach the maintenance margin threshold, reduce leverage, or add collateral.

### Liquidation Settlement and Negative Balance Handling

If your account ends up with a negative balance after liquidation, Aster may use funds from the insurance fund to cover the loss, but only under specific conditions.

To qualify for automatic settlement, all of the following must apply:

- The negative balance is in a USDT perpetual account.
- The account has no open positions (cross or isolated margin).
- The negative balance does not exceed 5,000 USDT.
- No funds have been transferred into the account after liquidation to offset the loss.

### Why the Liquidation Price Keep Changing

The liquidation price is dynamic because it depends on your position and margin, any change in your total account equity will adjust the liquidation threshold automatically. You can refer to some key factors below:

- Funding payments
- Collateral value fluctuations
- New positions opened or closed
- Cross margin effects

### Liquidation Fee

When your position is liquidated, a portion of the liquidation fee is allocated to the insurance fund (shown in your transaction history as "Insurance clear"). The fee is calculated based on the applicable liquidation fee rate and the notional value of the liquidated position.

Aster strongly encourages traders to manage leverage and margin carefully in order to avoid forced liquidation. In periods of extreme volatility, the insurance fund may be required to take over liquidation positions directly. When this happens, the takeover is executed at the bankruptcy price, which can be less favorable than the normal liquidation price and may result in greater loss for the trader.

#### Additional notes:

- Bankruptcy prices may fall outside the contract's current market range.
- Due to latency or syncing issues, some numerical values may update without notice.

### How Cross Margin Affects Liquidation

Aster uses cross margin by default. This means all your collateral and unrealized PnL from other positions help support your open trades.

This can reduce the chance of liquidation, but it also means all positions share the same risk pool.

### Does Leverage Directly Affect Liquidation Risk?

Yes. Higher leverage means a smaller buffer between your entry price and your liquidation price.

For example, a 50x position is much more likely to be liquidated than a 5x position because the room for price movement is very small.

### What Happens to my Collateral After Liquidation?

After your position is forcibly closed:

- The system uses your collateral to cover losses
- Any remaining collateral stays in your account

If losses exceed collateral, insurance funds or protocol buffers cover the difference.

### How to Reduce Liquidation Risk

- Use lower leverage
- Add more collateral
- Set a stop loss
- Monitor funding fees
- Avoid oversized positions
- Close positions before high-volatility events
