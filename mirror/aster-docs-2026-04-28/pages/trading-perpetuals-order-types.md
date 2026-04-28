# Order Types

Source: https://docs.asterdex.com/trading/perpetuals/order-types

Aster Perps supports several order types to give traders precise control over how and when their trades are executed.

Aster Pro's order tab

### Order Types

#### 1. Market Order

A market order is an instruction to buy or sell immediately at the best available price. It prioritizes speed over exact price. Use market orders when you want to enter or exit a position quickly and are comfortable with potential slippage.

#### 2. Limit Order

A limit order lets you set the exact price at which you want to buy or sell. The order only executes if the market reaches your chosen price, giving you full price control.

Example: BTC is trading at 62,000 USDT. If you want to buy only if the price dips, you can place a limit buy at 61,800. The order will sit on the order book and only execute if the market reaches that level.

#### 3. Stop Limit Order

A stop limit order combines two prices: a stop price and a limit price. When the stop price is reached, the system places a limit order at your specified limit price. This gives more control than a stop market order because execution is based on a limit price.

Example: You hold a long BTC position at 62,000 and want to protect against a drop. You set a stop price at 61,500 and a limit price at 61,480. If BTC falls to 61,500, a limit sell at 61,480 is placed. If the market falls too fast and never trades at 61,480, the order may remain unfilled.

#### 4. Stop Market Order

A stop market order converts into a market order once the stop price is reached. It prioritizes guaranteed execution, though the final fill price may differ from the stop price due to market volatility.

Example: You're long BTC from 62,000 and want to cut losses if it breaks support. You set a stop market at 61,500. If BTC drops to 61,500, a market sell is triggered at the best available price — which may be 61,490 or 61,470 depending on conditions.

#### 5. Trailing Stop order

A trailing stop order sets a stop price that follows the market as it moves in your favor. If the price reverses by a set percentage, a market order is triggered. For more details, refer to: Trailing Stop Order

#### 6. Post Only Order

A post only order ensures your limit order is added to the order book as a maker order. If your order would immediately match an existing order, it will be rejected. This is useful when you want to avoid taker fees.

Example: BTC is at 62,000. You place a post only limit sell at 62,001. If that price is already matched by a buyer, the platform rejects your order because it would execute immediately. If the best bid is 62,000, your order is posted as a maker order at 62,001.

---

### Order modifiers

#### TP/SL (Take Profit / Stop Loss)

TP and SL let you set automatic exit levels when opening a position.

- Take Profit (TP): Closes your position once the market reaches your target profit level, securing gains without manual monitoring.
- Stop Loss (SL): Closes your position if the price moves against you, limiting losses and managing risk.

Aster gives you two price references for TP/SL:

- Mark price: The fair price used for liquidation checks. TP/SL based on mark price tends to be more stable during volatility.
- Last price: The latest traded price on the order book. TP/SL based on last price reacts more quickly but can be triggered by wicks or sudden spikes.

#### Reduce Only

A Reduce Only order guarantees that your order will never open or increase a position — it can only reduce or fully close an existing one.

Use this when:

- You want to close part of a position without accidentally flipping direction.
- You are setting TP or SL and want them to act as exits only.
- You want to avoid accidentally adding to a position when intending to scale out.

#### BBO (Best Bid/Offer)

A BBO order places a limit order at the best bid or ask price. For a buy order, BBO sets the price at the lowest current ask; for a sell order, it sets the price at the highest bid.

If using Post Only mode, the order will only be placed if it adds liquidity. Due to market fluctuations, the order may fail to place if the market moves before it's confirmed.

Different BBO options such as [Counterparty 1] and [Queue 1] adjust the order price based on the market side and position (best or fifth-best price).

### Time-in-Force (TIF) Options

Time-in-Force settings control how long your order remains active and under what conditions it should be canceled.

GTC (Good Till Cancelled): The order stays open until filled or manually canceled. Default for most limit orders.

IOC (Immediate or Cancel): Fills immediately at the available quantity; any unfilled portion is canceled.

Example: You place a limit order for 1 BTC and only 0.6 BTC is available at your price. The system fills 0.6 BTC and cancels the remaining 0.4 BTC.

FOK (Fill or Kill): The entire order must fill immediately; if it can't, the whole order is canceled.

Example: You place a limit order for 1 BTC and only 0.9 BTC is available. The entire order is canceled — nothing is filled.
