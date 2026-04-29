# Rate Limits

Source: https://docs.dydx.xyz/concepts/trading/limits/rate-limits

All rate limits are subject to change. The latest limits can be queried via the `https:// /dydxprotocol/clob/block_rate` endpoint.

## Block Rate Limits

Example response:

```
{
    "block_rate_limit_config": {
        "max_short_term_orders_per_n_blocks": [],
        "max_stateful_orders_per_n_blocks": [
            {
                "num_blocks": 1,
                "limit": 2
            },
            {
                "num_blocks": 100,
                "limit": 20
            }
        ],
        "max_short_term_order_cancellations_per_n_blocks": [],
        "max_short_term_orders_and_cancels_per_n_blocks": [
            {
                "num_blocks": 5,
                "limit": 4000
            }
        ]
    }
}
```

### Active Fields

`max_stateful_orders_per_n_blocks`: How many stateful order place attempts (successful and failed) are allowed for an account per N blocks. Note that the rate limits are applied in an AND fashion such that an order placement must pass all rate limit configurations.

`max_short_term_orders_and_cancels_per_n_blocks`: How many short term order place and cancel attempts (successful and failed) are allowed for an account per N blocks.

### Deprecated Fields

`max_short_term_order_cancellations_per_n_blocks`, `max_short_term_orders_per_n_blocks` — these fields are not used at this time.

### Examples

- 2 long-term orders can be placed for each of the first 10 blocks and then a new long-term order would be rate limited on the 11th block since the limit of 20 long-term orders over the past 100 blocks would apply.

## Indexer Rate Limits

Indexer calls are rate limited per IP at a 100 requests / 10 sec rate. For websocket from Indexer, the following channel limits per connection are in place:

```
V4_ACCOUNTS_CHANNEL_LIMIT: 256
V4_PARENT_ACCOUNTS_CHANNEL_LIMIT: 256

V4_CANDLES_CHANNEL_LIMIT: 32
V4_MARKETS_CHANNEL_LIMIT: 32
V4_ORDERBOOK_CHANNEL_LIMIT: 32
V4_TRADES_CHANNEL_LIMIT: 32
```
