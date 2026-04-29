# Oracles

Source: https://mintlify.com/drift-labs/protocol-v2/concepts/oracles

> Oracle integrations and price feed mechanics in Drift Protocol

## Oracle Overview

Drift Protocol relies on decentralized oracle networks to provide accurate, manipulation-resistant price feeds for all markets. Oracles are critical for:

- Marking positions to market for PnL calculations
- Calculating margin requirements and liquidation thresholds
- Determining funding rates for perpetual markets
- Validating order prices and preventing market manipulation

## Supported Oracle Sources

Drift supports multiple oracle providers:

```typescript
export class OracleSource {
  static readonly PYTH = { pyth: {} };
  static readonly PYTH_1K = { pyth1K: {} };
  static readonly PYTH_1M = { pyth1M: {} };
  static readonly PYTH_PULL = { pythPull: {} };
  static readonly PYTH_1K_PULL = { pyth1KPull: {} };
  static readonly PYTH_1M_PULL = { pyth1MPull: {} };
  static readonly SWITCHBOARD = { switchboard: {} };
  static readonly QUOTE_ASSET = { quoteAsset: {} };
  static readonly PYTH_STABLE_COIN = { pythStableCoin: {} };
  static readonly PYTH_STABLE_COIN_PULL = { pythStableCoinPull: {} };
  static readonly Prelaunch = { prelaunch: {} };
  static readonly SWITCHBOARD_ON_DEMAND = { switchboardOnDemand: {} };
  static readonly PYTH_LAZER = { pythLazer: {} };
  static readonly PYTH_LAZER_1K = { pythLazer1K: {} };
  static readonly PYTH_LAZER_1M = { pythLazer1M: {} };
  static readonly PYTH_LAZER_STABLE_COIN = { pythLazerStableCoin: {} };
}
```

### Pyth Network

Pyth is the primary oracle provider for Drift:

- High-frequency updates: Sub-second price updates
- Confidence intervals: Built-in uncertainty quantification
- Pull model: Users submit price updates in transactions
- Push model: Traditional on-chain price updates
- Multiple price feeds: Standard, 1K precision, 1M precision for different asset types

Pyth Pull oracles require the user to submit a price update in the same transaction as their trade. This ensures the latest price is always used.

### Switchboard

Switchboard provides decentralized oracle aggregation:

- On-demand: Users can trigger updates when needed
- Aggregated data: Multiple data sources combined
- Lower latency: Fast price updates

### Prelaunch Oracle

For markets before official price feeds exist:

```typescript
export type PrelaunchOracle = {
  price: BN;
  maxPrice: BN;
  confidence: BN;
  ammLastUpdateSlot: BN;
  lastUpdateSlot: BN;
  perpMarketIndex: number;
};
```

Admins can set and update prices for prelaunch markets.

## Oracle Price Data

```typescript
export type OraclePriceData = {
  price: BN;
  confidence: BN;
  delay: BN;
  hasSufficientNumberOfDataPoints: boolean;
  maxPrice?: BN;
};
```

### MM Oracle Price Data

```typescript
export type MMOraclePriceData = OraclePriceData & {
  slot: BN;
  oracleSource: OracleSource;
};
```

## Oracle Validity Checks

```typescript
export enum OracleValidity {
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

### Validity Guard Rails

```typescript
export type OracleGuardRails = {
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

```typescript
if (confidence > price * tooVolatileRatio) return OracleValidity.TooVolatile;
if (currentSlot - oracleSlot > slotsBeforeStaleForMargin) return OracleValidity.StaleForMargin;
const divergence = abs(markPrice - oraclePrice) / oraclePrice;
if (divergence > markOraclePercentDivergence) { /* reject or adjust */ }
```

## Historical Oracle Data

```typescript
export type HistoricalOracleData = {
  lastOraclePrice: BN;
  lastOracleDelay: BN;
  lastOracleConf: BN;
  lastOraclePriceTwap: BN;      // 1-hour TWAP
  lastOraclePriceTwap5Min: BN;  // 5-minute TWAP
  lastOraclePriceTwapTs: BN;
};
```

### TWAP Calculation

$$TWAP_{new} = TWAP_{old} + \frac{(price_{current} - TWAP_{old}) \times \Delta t}{period}$$

Where `period` = TWAP window (e.g., 3600s for 1-hour TWAP); `Δt` = time since last update. TWAPs are used for funding rate calc, manipulation detection, and divergence guard rails.

## Oracle Price in Margin Calculations

For Long: `marginPrice = oraclePrice - offset`. For Short: `marginPrice = oraclePrice + offset`. Where `offset = min(maxSpread × oraclePrice, confidence + baseSpread × oraclePrice)`.

## Oracle Update Frequency

| Oracle Type | Update Frequency | Latency |
| --- | --- | --- |
| Pyth Push | ~400ms | Low |
| Pyth Pull | Per transaction | Lowest |
| Pyth Lazer | ~100ms | Lowest |
| Switchboard | ~1000ms | Medium |
| Switchboard On-Demand | Per transaction | Low |

### Staleness Thresholds

```typescript
slotsBeforeStaleForAmm: 50,        // ~20 seconds at 400ms/slot
slotsBeforeStaleForMargin: 120,    // ~48 seconds
```

## Oracle Precision

- Standard: 6 decimals
- 1K: 3 decimals (higher-priced assets)
- 1M: 0 decimals (very high-priced assets)
- StableCoin: 6 decimals with tighter bounds

The protocol normalizes all prices to `PRICE_PRECISION` (1e6) internally.

## Oracle Fallbacks

If primary oracle fails: 1) Use last valid price (within staleness threshold); 2) Use TWAP; 3) Use alternative oracle; 4) Pause operations.

## Oracle Security Considerations

- Price Manipulation Resistance: TWAPs and confidence intervals make flash-loan attacks ineffective.
- Staleness Protection: Strict staleness checks prevent use of outdated prices.
- Confidence Interval Validation: Wide intervals during volatility prevent risky operations.
- Multiple Oracle Support: Pyth, Switchboard provide redundancy.

## Oracle Price Examples

Standard (SOL): `price: 100_000_000 ($100), confidence: 100_000 (±$0.10), oracleSource: PYTH_PULL`
High-Priced (BTC): `price: 50_000_000 ($50,000), confidence: 5_000 (±$5), oracleSource: PYTH_1K`
Stablecoin (USDC): `price: 1_000_000 ($1.00), confidence: 1_000 (±$0.001), oracleSource: PYTH_STABLE_COIN`
