# Oracle Price Data API
URL: https://mintlify.com/drift-labs/protocol-v2/api/markets/oracles

# Oracle Price Data

Access oracle price data for Drift Protocol markets.

## DriftClient methods

```typescript
driftClient.getOracleDataForPerpMarket(marketIndex): OraclePriceData;
driftClient.getOracleDataForSpotMarket(marketIndex): OraclePriceData;
driftClient.getMMOracleDataForPerpMarket(marketIndex): MMOraclePriceData;
```

## OraclePriceData type

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

`isValid` is implied by `hasSufficientNumberOfDataPoints` AND staleness/confidence checks.

## Sources

See `concepts/oracles` for the OracleSource enum and validity rules.

## Reading raw oracle data

```typescript
import { OracleSource, getOraclePriceFromOracle } from '@drift-labs/sdk';

const data = driftClient.getOraclePriceData(perpMarket.amm.oracle, perpMarket.amm.oracleSource);
```
