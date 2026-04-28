# AMM Calculations
URL: https://mintlify.com/drift-labs/protocol-v2/math/amm

# AMM Calculations

Drift uses a virtual AMM (vAMM) with constant product formula.

## Core AMM Formula

`k = baseAssetReserve * quoteAssetReserve` (stored as sqrtK)

## Price Calculation

```
Price = (quoteAssetReserve * pegMultiplier * PRICE_PRECISION) / (baseAssetReserve * PEG_PRECISION)
```

```typescript
calculatePrice(baseAssetReserves: BN, quoteAssetReserves: BN, pegMultiplier: BN): BN
```

## Bid/Ask Spread

The AMM applies spread around the oracle price.

```typescript
calculateBidAskPrice(amm: AMM, oraclePriceData: OraclePriceData): [BN, BN]
```

Returns [bidPrice, askPrice]; spread depends on inventory and base spread.

## Reserve Updates on Swap

For a swap of `baseAmount`:
- New base reserve: `baseReserve + baseAmount`
- New quote reserve: `k / newBaseReserve`
- Quote required: `quoteReserve - newQuoteReserve`

## Repegging

`pegMultiplier` adjusts to track oracle price. Repeg cost is paid from protocol fees.

## Concentration Factor

K is increased by concentration_factor while base reserve max/min are tightened, providing the same liquidity in a tighter price range.

Last updated: see source URL.
