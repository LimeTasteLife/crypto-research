# Funding Rate

Funding Fees are cash flows periodically exchanged between long and short position holders. These fees are based on a Funding Rate designed to keep the futures price aligned with the underlying Index Price.

## Settlement schedule

| Period | Settlement times (UTC) |
|---|---|
| 1 hour | Every hour on the hour |
| 4 hours | 00:00, 04:00, 08:00, 12:00, 16:00, 20:00 |
| 8 hours | 00:00, 08:00, 16:00 |

## Rate components

### Premium calculation

Every 15 seconds, Orderly computes the Premium:

```
Premium = [Max(0, Impact Bid Price - I) - Max(0, I - Impact Ask Price)] / I
where I = Index Price
```

Impact Margin Notional = notional available to trade with 1,000 USDC of collateral at max leverage.

### Piecewise linear funding function

| Region | Condition | Slope | Formula |
|---|---|---|---|
| Low | abs(x) < 0.5% | 1x | f(x) = x |
| Medium | 0.5% <= abs(x) < 1.5% | 2x | f(x) = 0.5% * sign(x) + (x - 0.5% * sign(x)) * 2 |
| Large | abs(x) >= 1.5% | 4x | f(x) = 2.5% * sign(x) + (x - 1.5% * sign(x)) * 4 |

### Interest Rate

Fixed at 0.01% for most perpetual markets (USDC interest 0.06%, asset interest 0.03%).

## Final Funding Rate

```
Funding Rate = clamp[Funding Function(Average Premium) + clamp(Interest Rate - Average Premium, cap_ir, floor_ir) / (8/N), Cap Funding, Floor Funding]
```

Per-market Cap/Floor Funding values apply. In extreme conditions, Orderly may adjust these parameters.

Selected per-market funding config:

| Market | Interval | Cap Funding | Floor Funding | Interest Rate |
|---|---|---|---|---|
| BTC | 8h | 0.30% | -0.30% | 0.01% |
| ETH | 8h | 0.30% | -0.30% | 0.01% |
| SOL | 8h | 0.375% | -0.375% | 0.01% |
| Most alts | 4h or 8h | 2.00% | -2.00% | 0.005-0.01% |
| RWA (GOOGL, TSLA, NVDA, XAU, XAG, SPX500, NAS100) | 4-8h | 0.30% | -0.30% | 0.01% |

## Accrued Funding

```
Accrued Funding = Position Size x Mark Price x Funding Rate
```

Positive funding rate: longs pay shorts. Negative: shorts pay longs.
