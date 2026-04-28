# LLP Strategies | Lighter Docs

URL: https://docs.lighter.xyz/trading/liquidations-and-llp-insurance-fund/llp-strategies

# LLP Strategies

LLP funds are held within a single account, which acts as the counterparty to all LLP trading and liquidations. For additional details on Liquidations and ADL, please refer to the relevant section of the documentation.

Under the existing structure, Auto-Deleverage (ADL) events are fully backstopped by LLP, meaning that liquidity providers absorb the associated risk.

LLP Strategies allow collateral to be allocated across distinct strategy buckets (that now includes RWAs, too). Each market is assigned to a specific strategy. From a system perspective, each strategy behaves similarly to a segregated collateral shard (comparable to a sub-account for risk purposes). However, strategies are not separate accounts — all positions remain under the LLP — but risk and losses are isolated at the strategy level.

For example, LLP may allocate:

- One strategy for Crypto Perpetuals
- One strategy for FX
- One strategy for Equities / RWAs

The exact market-to-strategy mappings will be communicated separately.

Under this framework, if a given strategy has $1M in allocated collateral, its maximum loss exposure is limited to that $1M. If the allocated collateral is fully depleted, the strategy would be subject to ADL, while collateral allocated to other strategies remains unaffected.

### RWAs & LLP Strategies

The Real World Assets (RWA) perpetual markets are now subject to standard liquidation fees, consistent with all other markets, as LLP serves as the primary protocol liquidity provider.
