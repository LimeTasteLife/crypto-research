# Perpetual (Governance Adjustable Parameters)

Source: https://docs.dydx.community/dydx/modules/governance/governance-adjustable-parameters/perpetual

## Funding Rate

Perpetual contracts, unlike traditional futures contracts, lack an expiry date and use funding rates to encourage the perpetual price to align with the underlying asset's price. The Funding Rate is determined algorithmically based on the Index Price and Mid-Market Prices, prompts long traders to pay shorts when the perpetual trades at a premium and vice versa.

These payments are proportional to traders' positions and are exchanged directly between traders, not involving the exchange.

| Title | Value | Definition |
| --- | --- | --- |
| `funding_rate_clamp_factor_ppm` | 6000000 [6%] | Used for clamping 8-hour Funding Rates: `funding_rate_clamp_factor * (initial margin - maintenance margin)`. |
| `premium_vote_clamp_factor_ppm` | 60000000 [60%] | Used for clamping 8-hour Premium Votes: `premium_vote_clamp_factor * (initial margin - maintenance margin)`. |
| `min_num_votes_per_sample` | 15 | Minimum number of premium votes per premium sample. |

## Epoch Information

Funding rate and premium payments are credited or debited at a fixed interval based on the Epoch Information parameters:

- Next Tick: when the next epoch starts in seconds.
- Duration: duration of the epoch in seconds.
- Is Initialized: whether the epoch has been initialized.
- Fast Forward Next Tick: specifies whether `next_tick` should be fast-forwarded to be greater than the current block time.

| Name | Next Tick | Duration (seconds) | Current Epoch | Current Epoch Start Block | Is Initialized | Fast Forward Next Tick |
| --- | --- | --- | --- | --- | --- | --- |
| `funding-sample` | 30 | 60 | 0 | 0 | False | True |
| `funding-tick` | 0 | 3600 | 0 | 0 | False | True |
| `stats-epoch` | 0 | 3600 | 0 | 0 | False | True |
