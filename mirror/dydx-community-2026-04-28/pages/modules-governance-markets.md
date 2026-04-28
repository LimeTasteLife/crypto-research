# Markets (Governance Adjustable Parameters)

Source: https://docs.dydx.community/dydx/modules/governance/governance-adjustable-parameters/markets

On dYdX Chain, each market pair has a set of parameters that can be adjusted by governance:

| Title | Definition |
| --- | --- |
| `id` | sequentially-generated value |
| `pair` | human-readable name of the market pair |
| `exponent` | exponent of the price. e.g. if `Exponent == -5` then a `Value` of `1,000,000,000` represents `$10,000`. Therefore `10 ^ Exponent` represents the smallest price step (in dollars) that can be recorded. |
| `min_exchanges` | the minimum number of exchanges that should be reporting a live price for a price update to be considered valid. |
| `min_price_change_ppm` | the minimum allowable change in `price` value that would cause a price update on the network. Measured as `1e-6` (parts per million). |
| `exchange_config_json` | A string of json that encodes the configuration for resolving the price of this market on various exchanges, otherwise also known as "oracle". On dYdX Chain, oracles ensure each account is well-collateralized after each trade and determine when an account should be liquidated. |

## Liquidity Tiers

Markets of similar risk are categorized into Liquidity Tiers based on standardized risk parameters. These tiers define the margin requirements for each market.

- `Initial_margin_ppm` = the margin fraction needed to open a position.
- `Maintenance_fraction_ppm` = the fraction of the initial-margin that the maintenance-margin is.
- `Base_position_notional` = the maximum position size at which the margin requirements are not increased over the default values.
- `Impact_notional` = the impact notional amount (in quote quantums); recommended value is 500 USDC / initial margin fraction.

| id | name | initial_margin_ppm | maintenance_fraction_ppm | base_position_notional | impact_notional | impact_notional (as is) |
| --- | --- | --- | --- | --- | --- | --- |
| 0 | Large-Cap | 20000 [0.02] | 600000 [0.6] | 1000000000000 [1,000,000 USDC] | 500 USDC / IM | 10000000000 [10,000 USDC] |
| 1 | Small-Cap | 100000 [0.1] | 500000 [0.5] | 250000000000 [250,000 USDC] | 500 USDC / IM | 5000000000 [5,000 USDC] |
| 2 | Long-Tail | 200000 [0.2] | 500000 [0.5] | 100000000000 [100,000 USDC] | 1,000 USDC / IM | 2500000000 [2,500 USDC] |
| 3 | Safety | 1000000 [1] | 200000 [0.02] | 1000000000 [1,000 USDC] | 1,000 USDC / IM | 2500000000 [2,500 USDC] |
| 4 | Isolated | 50000 [0.05] | 600000 [0.6] | 0 | 1,000 USDC / IM | 2500000000 [2,500 USDC] |
| 5 | Mid-Cap | 50000 [0.05] | 600000 [0.6] | 0 | 500 USDC / IM | 5000000000 [5,000 USDC] |
| 6 | FX | 10000 [0.01] | 500000 [0.5] | 500000000000 [500,000 USDC] | 1,000 USDC / IM | 2500000000 [2,500 USDC] |
| 7 | IML 5x | 200000 [0.2] | 500000 [0.5] | 0 | 1,000 USDC / IM | 2500000000 [2,500 USDC] |

## Market Types

Two market types on dYdX:

1. Cross Margin: Cross-margined markets share the same collateral pool and insurance fund.
2. Isolated Margin: Isolated markets have segregated pools of collateral and their own insurance fund. Each isolated market has its own individual risk properties.

Recommended criteria to determine compatibility with cross-margining (allowing dYdX community to propose upgrading an isolated market to cross):

- At least two oracle sources with > $1M USD in trading volume each.
- At least two oracle sources with > $150K depth within 2% of the mid-price.
- A minimum of four total oracle sources.
- Availability of at least 30 days of historical data.
