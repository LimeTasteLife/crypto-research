# Public Pools | Lighter Docs

URL: https://docs.lighter.xyz/trading/public-pools

# Public Pools

Public Pools allow participants to combine funds under a designated operator who trades on their behalf. Whitelisted users can create a Public Pools to attract participants and manage pooled capital. Profits are distributed to participants after deducting the operator's fee.

#### Pool Operators

Operators are, currently, whitelisted by the protocol to run strategies. Trading is conducted via a Sub Account in the Operator's account. Considerations:

- Operator Fee: The percentage of profits allocated to the operator upon participant withdrawals as compensation for managing the pool.
- Minimum Operator Share: The minimum ownership percentage the operator must maintain in the pool to remain aligned with its performance. For example, if the minimum operator share is set at 10% and the operator deposits 10,000 USDC, participants may deposit up to 90,000 USDC.
- Isolated Margin: Public Pools do not support isolated positions.

#### Pool Depositors

Depositors allocate capital to pools running strategies they are interested in. When depositing into a Public Pool, depositors receive pool shares, which are redeemed upon withdrawal. Unlike many DeFi vaults, Public Pools do not impose lockup periods, and funds can be withdrawn at any time.
