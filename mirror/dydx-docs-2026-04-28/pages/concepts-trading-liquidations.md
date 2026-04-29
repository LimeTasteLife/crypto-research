# Liquidations

Source: https://docs.dydx.xyz/concepts/trading/liquidations

As part of the default settings of the v4 open source software ("dYdX Chain"), accounts whose total value falls below their maintenance margin requirement may have their positions automatically closed by the liquidation engine. Positions are closed via protocol-generated liquidation matches where a protocol-generated liquidation order uses a calculated "Fillable Price" as the limit price to match against liquidity resting on the order book. Profits or losses from liquidations are taken on by the insurance fund. A liquidated subaccount may have its position partially or fully closed. v4 open source software includes a liquidations configuration which — as determined by the applicable Governance Community — will determine how much of the position is liquidated.

## Liquidation Penalty

As part of the default settings of the v4 open source software, when an account is liquidated, up to the entire remaining value of the account may be taken as penalty and transferred to an insurance fund.

The liquidation engine will attempt to leave funds in accounts of positive value where possible after they have paid the Maximum Liquidation Penalty of 1.5%. The 1.5% fee contemplated in the default v4 software will be subject to adjustments by the applicable Governance Community.

## Isolated Liquidation Price

This is the price at which a specific position reaches the point of liquidation.

The liquidation price `p'` is calculated using:
```
p' = (e - s * p) / (|s| * MMF - s)
```

Where:
- `e` is the current equity in the account.
- `s` is the size of the position.
- `p` is the original price of the position.
- `MMF` is the maintenance margin fraction, a percentage that indicates the minimum equity required to keep the position open.

Example: Trader deposits $1,000 (`e = 1000`), shorts 3 ETH contracts (`s = -3`) at $3,000 per contract, MMF=5%. Then `p' = (1000 - (-3*3000)) / (3*0.05 - (-3)) = 10000/3.15 ≈ 3174.60`. If ETH rises to $3,174.60, the position will reach the liquidation threshold.

## Cross Liquidation Price

For cross-margining (multiple positions sharing the same margin), the calculation is adjusted to account for the margin used by other positions.

- Total Maintenance Margin Requirement (`MMR_t`): margin needed for all positions at current prices: `MMR_t = |s| · p · MMF`
- Other Positions' Margin Requirement (`MMR_o`): subtract the margin requirement of the position in question from MMR_t
- Liquidation Price Formula: `p' = (e - s * p - MMR_o) / (|s| * MMF - s)`

## "Fillable Price" for Liquidations

As part of the default settings of dYdX Chain, the "fillable price" (or the limit price of a liquidation order) for a position being liquidated is calculated as follows:

```
Fillable Price (Short or Long) = P x (1 - ((SMMR x MMF) x (BA x (1 - Q))))
```

Where:
- `P` is the oracle price for the market
- `SMMR` is the spread to maintenance margin ratio (`Config.FillablePriceConfig.SpreadToMaintenanceMarginRatioPpm`)
- `MMF` is the maintenance margin fraction for the position
- `BA` is the bankruptcy adjustment (`Config.FillablePriceConfig.BankruptcyAdjustmentPpm`, ≥ 1)
- `Q = V / TMMR` where `V` is the total account value, and `TMMR` is the total maintenance margin requirement

The "Close Price" will be the sub-ticks of whatever maker order(s) the liquidation order matches against.

## FAQ

What price is used to determine liquidations? Oracle Price is used to estimate the value of an account's positions. If the account's value falls below the account's maintenance margin requirement, the account is liquidatable.

Who receives the liquidation fees? The insurance fund receives liquidation fees / penalty. The applicable Governance Community needs to initially fund the insurance fund from the applicable community treasury.
