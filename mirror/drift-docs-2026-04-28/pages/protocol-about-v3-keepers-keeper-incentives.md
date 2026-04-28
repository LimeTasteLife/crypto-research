# Keeper Incentives – Drift Protocol
URL: https://docs.drift.trade/protocol/about-v3/keepers/keeper-incentives

# Keeper Incentives

Keepers keep the Drift network healthy.

## Keeper Rewards

For matching orders, Keepers receive a portion of the taker fee.

For cancelling orders (that can be cancelled see Advanced Orders FAQ), Keepers will receive the `cancel_order_fee` on the state.

Currently, the USDC reward function for keepers (f_keeper) is designed as:

f_keeper = min(0.01 * max(1, t_order)^(1/4), 0.1 * f_user)

where:
- t_order is seconds since the order was placed
- f_user is the taker fee paid by the user who placed the order

A Keeper reward multiplier (for taker price improvement) is applied to the keeper's minimum time-based reward component in the function above. Any percent improvement versus the baseline `oracle +/- 10bps`, increases this multiplier.

30d fill volume for keepers is tracked on-chain via `UserStats`, allowing for logic to reward consistent keepers with a larger multiplier on rewards.
