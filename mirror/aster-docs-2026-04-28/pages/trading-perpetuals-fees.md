# Fees

Source: https://docs.asterdex.com/trading/perpetuals/fees-and-specs/fees

### Fee Rates for USDT-Perpetual Contracts

Maker Fee: 0%

A Maker order is one that adds liquidity to the order book. When you place a Maker order, you choose a price above or below the current market price, and your order is not filled immediately. Instead, it sits on the order book, waiting for another trader to match and fill it. You're essentially making the market by placing an order that helps set available prices for others to trade.

Taker Fee: 0.04%

A Taker order is one that removes liquidity from the order book. When you place a Taker order, you're trading immediately against an existing Maker order at the current available price. You're taking liquidity by accepting someone else's open order.

### Fee rates for USD1-Perpetual Contracts

Maker fee: 0%

Taker fee: 0.005%

### Pay Fees with $ASTER and Save 5%

Save 5% on perp trading fees by paying with $ASTER. Simply deposit $ASTER into your perp wallet and it will automatically be used to cover fees. You can also transfer $ASTER from your spot account to your perpetual account to apply the discount.

### How Fees are Calculated

In Aster Perps, transaction fees are based on the nominal value of your order — that is, the total value of the position you're opening or closing.

Formula:

- Transaction fee = Nominal value × Fee rate
- Nominal value = Number of contracts × Transaction price Number of contracts: Each contract typically represents a unit of the base asset — for example, 1 BTC in BTCUSDT contracts. So if you're trading 0.1 BTC, that's 0.1 contracts. Transaction price: The price at which the trade happens (e.g. $80,000 for 1 BTC).

#### Example 1: Market buy (Taker order)

You place a market order to buy 0.1 BTC at $80,000.

- Nominal value = 0.1 × 80,000 = 8,000
- Transaction fee = 8,000 × 0.04% = 3.20 USDT

#### Example 2: Limit sell (Maker order)

Later, you place a limit sell order at $85,000.

- Nominal value = 0.1 × 85,000 = 8,500
- Transaction fee = 8,500 × 0 = 0 USDT
