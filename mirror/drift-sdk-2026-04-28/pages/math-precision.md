# Precision & BigNum Handling
URL: https://mintlify.com/drift-labs/protocol-v2/math/precision

# Precision & BigNum Handling

The Drift SDK uses bn.js (BN) for numerical values. All numbers are integers with specific precision levels.

## Precision Constants

| Constant | Value | Use Case |
| --- | --- | --- |
| `QUOTE_PRECISION` | 10^6 | USDC amounts |
| `PRICE_PRECISION` | 10^6 | Market prices |
| `BASE_PRECISION` | 10^9 | Base asset amounts (e.g., SOL) |
| `AMM_RESERVE_PRECISION` | 10^9 | AMM calculations |
| `PEG_PRECISION` | 10^6 | Peg multiplier |
| `MARGIN_PRECISION` | 10^4 | Margin ratios (4 decimals) |
| `SPOT_BALANCE_PRECISION` | 10^9 | Spot scaled balances |
| `SPOT_MARKET_RATE_PRECISION` | 10^6 | Borrow/deposit rates |

## Conversion

`raw_value / precision = human_value`
`human_value * precision = raw_value`

```typescript
import { BN, PRICE_PRECISION, convertToNumber } from '@drift-labs/sdk';

// BN -> human
const rawPrice = new BN(150_500_000);
const price = convertToNumber(rawPrice, PRICE_PRECISION); // 150.5

// Human -> BN
const oneSol = new BN(1).mul(BASE_PRECISION); // BN(1_000_000_000)
const $21_23 = new BN(21_230_000); // 21.23 * 1e6
```

Or use `driftClient.convertToPerpPrecision(...)`, `convertToPricePrecision(...)`, `convertToSpotPrecision(...)`.

## Best Practices

1. Always use BN for token amounts (never JS floats)
2. Multiply before dividing to avoid precision loss
3. Use precision constants from the SDK
4. For fractional values: `new BN(15).mul(BASE_PRECISION).div(new BN(10))` = 1.5 SOL
