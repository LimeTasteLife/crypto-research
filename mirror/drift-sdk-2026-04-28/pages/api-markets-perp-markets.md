# Perpetual Markets API
URL: https://mintlify.com/drift-labs/protocol-v2/api/markets/perp-markets

# Perpetual Markets

Access perpetual market accounts and data.

## DriftClient methods

```typescript
driftClient.getPerpMarketAccount(marketIndex): PerpMarketAccount | undefined;
driftClient.getPerpMarketAccounts(): PerpMarketAccount[];
driftClient.getOracleDataForPerpMarket(marketIndex): OraclePriceData;
driftClient.getMMOracleDataForPerpMarket(marketIndex): MMOraclePriceData;
```

## PerpMarkets config helper

```typescript
import { PerpMarkets } from '@drift-labs/sdk';

const solMarket = PerpMarkets['mainnet-beta'].find(
  m => m.baseAssetSymbol === 'SOL'
);
console.log(solMarket.marketIndex);
```

Each entry includes: `marketIndex`, `baseAssetSymbol`, `category`, `oracle`, `oracleSource`, `launchTs`, `pythFeedId`, `pythLazerId`, status flags.

## PerpMarketAccount fields

See `program/state/market-accounts` for the full type definition. Key fields: `marketIndex`, `amm`, `pnlPool`, `marginRatioInitial`, `marginRatioMaintenance`, `imfFactor`, `contractTier`, `status`.

## Pricing helpers

```typescript
import { calculateBidAskPrice } from '@drift-labs/sdk';

const [bid, ask] = calculateBidAskPrice(perpMarket.amm, oracleData);
```
