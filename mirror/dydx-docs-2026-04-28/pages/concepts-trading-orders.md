# Orders

Source: https://docs.dydx.xyz/concepts/trading/orders

An order is the way a trader manages positions in the dYdX markets. Different types of orders exist to support different trading strategies.

## Short-term vs Long-term

Short-term orders are short-lived orders that are not stored on-chain unless filled. These orders stay in-memory of the network validators, for up to 20 blocks, with only their fill amount and expiry block height being committed to state. Short-term orders are mainly intended for use by market makers with high throughput or for market orders.

Long-term orders are "stateful orders" that are committed to the blockchain. Long-term orders encompass any order that lives on the orderbook for longer than the short block window. The short block window represents the maximum number of blocks past the current block height that a short-term `MsgPlaceOrder` or `MsgCancelOrder` message will be considered valid by a validator. Currently the default short block window is 20 blocks.

### Comparison

Short-term orders:
- Short-lived orders meant to be placed immediately (in the same block the order was received). These orders stay in-memory up to 20 blocks, with only their fill amount and expiry block height being committed to state.
- Intended for use by market makers with high throughput, or for market orders.
- IoC and FoK orders are also considered short-term orders. Short-term orders do not survive a network restart.
- Placement message: `MsgPlaceOrder`
- Cancellation: `MsgCancelOrder` — best-effort, only gossiped, not in MsgProposedOperations
- Expirations: Good-Till-Block (GTB), maximum of current block height + ShortBlockWindow (currently 20 blocks ~30 seconds)
- Inclusion in block: `OperationRaw_ShortTermOrderPlacement` inside `MsgProposedOperations.OperationsQueue` — only if matched
- Signature verification: custom (because included in app-injected transaction)
- Replay prevention: kept in state until after Good-Till-Block

Stateful orders:
- Long-lived orders which may execute far in the future. Two types: Long-Term Orders and Conditional Orders.
- Long-Term Orders: meant to be added to the orderbook as soon as possible. Due to certain technical limitations, long-term orders are placed in the block after they are written to state. E.g. if `MsgPlaceOrder` is included in block N, taker order matching would occur for the long-term order in block N+1. Order types requiring immediate execution such as fill-or-kill / immediate-or-cancel are disallowed.
- Conditional Orders: execute when the oracle price becomes either LTE or GTE to specified trigger price (e.g. stop loss sell = LTE, take profit buy = GTE). Orders are placed in the block after their condition is met and they become triggered.
- Placement message: `MsgPlaceOrder`, long term or conditional order flag enabled. Valid OrderFlags values are 32 (conditional), 64 (long-term), and 128 (TWAP) for stateful orders.
- Cancellation: `MsgCancelOrder`, long term or conditional order flag enabled.
- Expirations: Good-Till-Block-Time (GTBT), max of current block time + StatefulOrderTimeWindow (currently 95 days).
- Inclusion in block: Normal cosmos transaction.
- Signature verification: Normal cosmos transaction signature verification.
- Replay prevention: Cosmos SDK sequence numbers, verified to be strictly increasing.

## Types

Currently, dYdX supports 6 different order types:

- Market Order
- Limit Order
- Stop Market Order
- Stop Limit Order
- Take Profit Market Order
- Take Profit Limit Order

### Market Order

A Market Order is an order to buy or sell a given asset and will execute immediately at the best price dependent on the liquidity on the other side of the order book. By default, the front end submits market orders as Immediate-or-Cancel orders, meaning the order will fill immediately and any part that isn't filled will be canceled. Market orders are also used to close positions.

### Limit Order

A Limit Order is an order to buy or sell a given asset at a specified (or better) price. A limit order to buy will only execute at the limit price or lower, and a limit order to sell will only execute at the limit price or higher.

### Stop Market Order

A Stop Market Order protects against losses by closing a trader's position once the Oracle Price or the last traded price crosses the trigger price. The trigger price can be triggered by either the Oracle Price or the last traded price.

### Stop Limit Order

A Stop Limit Order will execute only when the Oracle Price or the last traded price crosses a specified Trigger Price. Once triggered, the resulting limit order may either be immediately filled or may rest on the orderbook at the limit price.

### Take Profit Market Order

Take Profit Market orders allow traders to set targets and protect profits on positions by specifying a price at which to close an open position for profit.

### Take Profit Limit Order

Take Profit Limit orders allow traders to set targets and protect profits on positions by specifying a price at which to close an open position for profit. They enable profit taking like take profit market orders, but with the versatility and control of a limit order.

### TWAP Orders (release in v9.0)

TWAP (Time weighted average price) orders enable users to submit orders that will be executed at certain time intervals at the current market price. When submitting a TWAP order with TWAP parameters supplied, the `OrderFlags` value must be set to 128 (TWAP) on `MsgPlaceOrder.Order.OrderId.OrderFlags`.
