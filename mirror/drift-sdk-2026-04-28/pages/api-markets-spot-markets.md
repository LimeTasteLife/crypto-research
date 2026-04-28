# Spot Markets API
URL: https://mintlify.com/drift-labs/protocol-v2/api/markets/spot-markets

# Spot Markets

Access spot market accounts and data.

## DriftClient methods

```typescript
driftClient.getSpotMarketAccount(marketIndex): SpotMarketAccount | undefined;
driftClient.getSpotMarketAccounts(): SpotMarketAccount[];
driftClient.getOracleDataForSpotMarket(marketIndex): OraclePriceData;
```

## SpotMarkets config helper

```typescript
import { SpotMarkets } from '@drift-labs/sdk';

const usdc = SpotMarkets['mainnet-beta'].find(m => m.symbol === 'USDC');
console.log(usdc.marketIndex);  // 0
```

Each entry includes: `marketIndex`, `symbol`, `mint`, `oracle`, `oracleSource`, `precision`, `precisionExp`, `serumMarket`, `phoenixMarket`, `openbookMarket`, `pythPullOraclePDA`, etc.

## Interest rate helpers

```typescript
import { calculateBorrowRate, calculateDepositRate, SPOT_MARKET_RATE_PRECISION, convertToNumber } from '@drift-labs/sdk';

const spotMarket = driftClient.getSpotMarketAccount(0);
const borrowRate = calculateBorrowRate(spotMarket);
const depositRate = calculateDepositRate(spotMarket);
console.log(convertToNumber(borrowRate, SPOT_MARKET_RATE_PRECISION));
```

## Token amount helpers

```typescript
import { getTokenAmount, getSignedTokenAmount, SpotBalanceType } from '@drift-labs/sdk';

const tokenAmount = getTokenAmount(
  spotPosition.scaledBalance, spotMarket, spotPosition.balanceType
);
const signed = getSignedTokenAmount(tokenAmount, spotPosition.balanceType);
```
