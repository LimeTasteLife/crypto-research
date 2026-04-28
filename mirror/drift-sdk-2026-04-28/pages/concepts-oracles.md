# Oracles
URL: https://mintlify.com/drift-labs/protocol-v2/concepts/oracles

# Oracles

## Oracle Sources

```typescript
class OracleSource {
  static readonly PYTH;
  static readonly PYTH_1K;
  static readonly PYTH_1M;
  static readonly PYTH_PULL;
  static readonly PYTH_1K_PULL;
  static readonly PYTH_1M_PULL;
  static readonly SWITCHBOARD;
  static readonly QUOTE_ASSET;
  static readonly PYTH_STABLE_COIN;
  static readonly PYTH_STABLE_COIN_PULL;
  static readonly Prelaunch;
  static readonly SWITCHBOARD_ON_DEMAND;
  static readonly PYTH_LAZER;
  static readonly PYTH_LAZER_1K;
  static readonly PYTH_LAZER_1M;
  static readonly PYTH_LAZER_STABLE_COIN;
}
```

### Pyth Network

Primary oracle. Sub-second updates, confidence intervals. Pull model: users submit price updates in transaction. Push model: traditional on-chain. Multiple feeds (standard, 1K, 1M) for different asset price magnitudes.

### Switchboard

On-demand updates, aggregated multi-source data, lower latency.

### Prelaunch Oracle

```typescript
type PrelaunchOracle = {
  price: BN;
  maxPrice: BN;
  confidence: BN;
  ammLastUpdateSlot: BN;
  lastUpdateSlot: BN;
  perpMarketIndex: number;
};
```

Admin-set prices for markets before official feeds exist.

## Oracle Price Data

```typescript
type OraclePriceData = {
  price: BN;
  confidence: BN;
  delay: BN;
  hasSufficientNumberOfDataPoints: boolean;
  maxPrice?: BN;
};

type MMOraclePriceData = OraclePriceData & {
  slot: BN;
  oracleSource: OracleSource;
};
```

## Oracle Validity

```typescript
enum OracleValidity {
  NonPositive = 0,
  TooVolatile = 1,
  TooUncertain = 2,
  StaleForMargin = 3,
  InsufficientDataPoints = 4,
  StaleForAMMLowRisk = 5,
  isStaleForAmmImmediate = 6,
  Valid = 7,
}
```

### Guard Rails

```typescript
type OracleGuardRails = {
  priceDivergence: {
    markOraclePercentDivergence: BN;
    oracleTwap5MinPercentDivergence: BN;
  };
  validity: {
    slotsBeforeStaleForAmm: BN;
    slotsBeforeStaleForMargin: BN;
    confidenceIntervalMaxSize: BN;
    tooVolatileRatio: BN;
  };
};
```

Example checks:
- `if (confidence > price * tooVolatileRatio) -> TooVolatile`
- `if (currentSlot - oracleSlot > slotsBeforeStaleForMargin) -> StaleForMargin`
- divergence > markOraclePercentDivergence -> reject

## Historical Oracle Data + TWAP

```typescript
type HistoricalOracleData = {
  lastOraclePrice: BN;
  lastOracleDelay: BN;
  lastOracleConf: BN;
  lastOraclePriceTwap: BN;      // 1-hour
  lastOraclePriceTwap5Min: BN;  // 5-minute
  lastOraclePriceTwapTs: BN;
};
```

`TWAP_new = TWAP_old + (price_current - TWAP_old) * dt / period`

Used for: funding rate calculations, manipulation detection, guard rails.

## Oracle Price for Margin (conservative)

Long: `marginPrice = oraclePrice - offset`
Short: `marginPrice = oraclePrice + offset`
`offset = min(maxSpread * oraclePrice, confidence + baseSpread * oraclePrice)`

## Oracle Update Frequencies

| Oracle Type | Update Frequency | Latency |
| --- | --- | --- |
| Pyth Push | ~400ms | Low |
| Pyth Pull | Per transaction | Lowest |
| Pyth Lazer | ~100ms | Lowest |
| Switchboard | ~1000ms | Medium |
| Switchboard On-Demand | Per transaction | Low |

### Staleness Thresholds

```typescript
slotsBeforeStaleForAmm: 50,        // ~20s at 400ms/slot
slotsBeforeStaleForMargin: 120,    // ~48s
```

## Oracle Precision Variants

- Standard: 6 decimals
- 1K: 3 decimals (high-priced assets)
- 1M: 0 decimals (very high-priced assets)
- StableCoin: 6 decimals tighter bounds

Protocol normalizes to PRICE_PRECISION (1e6).

## SDK Read Example

```typescript
const oraclePriceData = driftClient.getOraclePriceData(
  perpMarket.amm.oracle,
  perpMarket.amm.oracleSource
);
console.log('Price:', oraclePriceData.price.toString());
console.log('Confidence:', oraclePriceData.confidence.toString());
console.log('Valid:', oraclePriceData.hasSufficientNumberOfDataPoints);
```

## Security Considerations

Manipulation resistance: TWAPs + confidence intervals defeat single-block attacks.
Staleness protection: ops paused on stale data.
Confidence interval validation: wide confidence prevents risky ops.
Multiple oracle support: redundancy across providers.
