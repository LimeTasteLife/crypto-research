# Place Market Order
URL: https://mintlify.com/drift-labs/protocol-v2/examples/place-market-order

# Place Market Order

```typescript
import {
  getMarketOrderParams, PositionDirection, PerpMarkets, BASE_PRECISION, BN
} from '@drift-labs/sdk';

const solMarketInfo = PerpMarkets[env].find(m => m.baseAssetSymbol === 'SOL');
const marketIndex = solMarketInfo.marketIndex;

const orderParams = getMarketOrderParams({
  baseAssetAmount: new BN(1).mul(BASE_PRECISION), // 1 SOL
  direction: PositionDirection.LONG,
  marketIndex,
});

const txSig = await driftClient.placePerpOrder(orderParams);
console.log('Tx:', txSig);
```

Market orders go through a brief Dutch JIT auction before falling back to the AMM.
