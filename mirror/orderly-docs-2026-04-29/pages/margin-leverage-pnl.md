# Margin, Leverage & PnL

## Notional Value

```
Notional Value = Position Qty * Mark Price
```

## Account Margin Ratio

```
Account Margin Ratio = Total Collateral Value / Sum(Abs(Position Notional i))
```

Default margin ratio with no positions: 1000%.

## Initial Margin Ratio (IMR)

```
IMR i = Max(1 / Max Account Leverage, Base IMR i, IMR Factor i * Abs(Position Notional i)^(4/5))
```

Max leverage = 1 / Base IMR. E.g., Base IMR of 1% = up to 100x leverage.

IMR Factors increase margin requirement for large positions.

## Maintenance Margin Ratio (MMR)

```
MMR i = Max(Base MMR i, Base MMR i / Base IMR i * IMR Factor i * Abs(Position Notional i)^(4/5))
```

Selected margin parameters:

| Market | Base IMR (max leverage) | Base MMR | IMR Factor |
|---|---|---|---|
| BTC-PERP | 1% (100x) | 0.6% | 0.0000000910 |
| ETH-PERP | 1% (100x) | 0.6% | 0.0000001724 |
| SOL-PERP | 1% (100x) | 0.6% | 0.0000010667 |
| SUI-PERP | 5% (20x) | 2.5% | 0.0000028100 |
| HYPE-PERP | 5% (20x) | 2.5% | 0.0000028100 |
| ARB-PERP | 10% (10x) | 5% | 0.0000021481 |
| ORDER-PERP | 10% (10x) | 5% | 0.0000092820 |
| SPX500-PERP | 5% (20x) | 2.5% | 0.0000000001 |
| NAS100-PERP | 5% (20x) | 2.5% | 0.0000000001 |
| XAU-PERP | 5% (20x) | 2.5% | 0.0000000001 |
| GOOGL-PERP | 5% (20x) | 2.5% | 0.0000000001 |
| TSLA-PERP | 5% (20x) | 2.5% | 0.0000000001 |
| NVDA-PERP | 5% (20x) | 2.5% | 0.0000000001 |
| IP-PERP | 20% (5x) | 10% | 0.0000073100 |

90+ perpetual markets listed across crypto, RWA (equity, commodity, index) categories.

## PnL

```
Unrealized PnL = Position Qty * (Mark Price - Average Entry Price)
Realized PnL = Position Qty * (Average Price - Average Entry Price)
```

## Max Notional

| Market | Max Notional (USDC) |
|---|---|
| BTC | 5,000,000 |
| ETH | 5,000,000 |
| Alts | 2,000,000 |
