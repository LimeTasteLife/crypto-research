# Conversion Utilities
URL: https://mintlify.com/drift-labs/protocol-v2/api/math/conversion

# Conversion Utilities

Number conversion functions for converting between BN and number types.

## Functions

```typescript
convertToNumber(bigNumber: BN, precision?: BN): number
```

Divides the BN by precision (defaults to 1 if omitted) and returns a JavaScript number. Use for display only.

```typescript
driftClient.convertToPerpPrecision(amount: number): BN  // BASE_PRECISION
driftClient.convertToPricePrecision(amount: number): BN // PRICE_PRECISION
driftClient.convertToSpotPrecision(marketIndex: number, amount: number): BN
```

## Precision Constants

| Constant | Value |
| --- | --- |
| `QUOTE_PRECISION` | 1e6 |
| `PRICE_PRECISION` | 1e6 |
| `BASE_PRECISION` | 1e9 |
| `AMM_RESERVE_PRECISION` | 1e9 |
| `PEG_PRECISION` | 1e6 |
| `MARGIN_PRECISION` | 1e4 |
| `SPOT_BALANCE_PRECISION` | 1e9 |
| `SPOT_MARKET_RATE_PRECISION` | 1e6 |
| `TEN_THOUSAND` | 1e4 |
| `FIVE_MINUTE` | 300 |
| `ONE_HOUR` | 3600 |
| `ONE_DAY` | 86400 |
| `ONE_YEAR` | 31536000 |
