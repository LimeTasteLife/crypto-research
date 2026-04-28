# Arbitrage Strategies
URL: https://mintlify.com/drift-labs/protocol-v2/examples/arbitrage

# Arbitrage Strategies

Implement arbitrage strategies on Drift.

## Strategy ideas

- Drift perp vs CEX perp: hedge price differences across venues
- Drift perp vs spot DEX: exploit funding/spot deviations
- Drift markets vs JIT auction: snipe favorable JIT prices
- Cross-pair triangular within Drift spot

## Implementation outline

1. Subscribe to relevant data sources (DLOB for resting orders, oracle for fair value, AuctionSubscriber for JIT)
2. Compare prices, factor in fees and slippage
3. Use `placeAndTakePerpOrder` (atomic taker fill against specific makers) when crossing the spread is profitable
4. Use `cancelAndPlaceOrders` for atomic re-quoting

## Risk factors

- Oracle staleness during arbitrage
- Slippage on large positions
- Funding rate volatility
- Counterparty fill latency

For mature implementations, see `keeper-bots-v2` patterns and the JIT proxy library `@drift-labs/jit-proxy`.
