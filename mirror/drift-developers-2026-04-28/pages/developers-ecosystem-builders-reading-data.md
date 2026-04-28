# Reading Data – Drift Protocol
URL: https://docs.drift.trade/developers/ecosystem-builders/reading-data

# Reading Data

## Account data via AuthorityDrift

```typescript
import { UserAccountCache, EnhancedAccountData } from "@drift-labs/common";

const accountKey = UserAccountCache.getUserAccountKey(subAccountId, authority);
const account: EnhancedAccountData = userAccountLookup[accountKey];
```

`EnhancedAccountData` fields: `subAccountId`, `authority`, `name`, `poolId`, `openPerpPositions`, `openOrders`, `spotBalances`, `marginInfo`.

### Positions

```typescript
import { ENUM_UTILS } from "@drift-labs/common";
import { PositionDirection } from "@drift-labs/sdk";

for (const position of account.openPerpPositions) {
  const isLong = ENUM_UTILS.match(position.direction, PositionDirection.LONG);
  position.baseSize.prettyPrint();          // "1.5"
  position.notionalSize.toNotional();       // "$150.00"
  position.entryPrice.toNotional();
  position.liquidationPrice.toNotional();
  position.positionPnl.markBased.positionNotionalPnl;
  position.feesAndFundingPnl;
  position.totalUnsettledPnl;
  position.totalClaimablePnl;
  position.totalSettledPnl;
}
```

### Open orders

```typescript
import { COMMON_UI_UTILS } from "@drift-labs/common";

for (const order of account.openOrders) {
  // order.orderId, marketIndex, direction, price, triggerPrice, baseAssetAmount,
  // baseAssetAmountFilled, oraclePriceOffset, reduceOnly, postOnly, immediateOrCancel
  const label = COMMON_UI_UTILS.getUIOrderTypeFromSdkOrderType(
    order.orderType, order.triggerCondition, order.direction, order.oraclePriceOffset
  ).label;
}
```

### Spot balances and total collateral

```typescript
for (const balance of account.spotBalances) {
  balance.marketIndex; balance.baseBalance;
}
account.marginInfo.netUsdValue.toNotional();
```

## Market data via AuthorityDrift

```typescript
const oraclePrices = drift.oraclePriceCache;
const markPrices = drift.markPriceCache;

drift.onOraclePricesUpdate((lookup) => {});
drift.onMarkPricesUpdate((lookup) => {});
```

### Orderbook

```typescript
const currentBook = drift.orderbookCache;
const subscription = drift.onOrderbookUpdate((newBook) => {});

drift.orderbookManager.updateSubscription({
  marketId: MarketId.createPerpMarket(0),
  grouping: 10,
});
```

### Candle charts

```typescript
import { CandleClient, MarketId, UIEnv, JsonCandle } from "@drift-labs/common";

const candleClient = new CandleClient();
const env = UIEnv.createMainnet();

const candles: JsonCandle[] = await candleClient.fetch({
  env, marketId: MarketId.createPerpMarket(0),
  resolution: "15",
  fromTs: Math.floor(Date.now() / 1000) - 86400,
  toTs: Math.floor(Date.now() / 1000),
});

await candleClient.subscribe({ env, marketId: MarketId.createPerpMarket(0), resolution: "15" }, key);
candleClient.on(key, "candle-update", (candle) => {});
candleClient.unsubscribe(key);
```

## Data API (REST)

Base URL: `https://data.api.drift.trade`

Endpoints:
- `GET /stats/markets` — aggregate market stats (volume, OI, funding, oracle price, status)
- `GET /fundingRates?symbol=SOL-PERP` — funding rate history
- `GET /trades?symbol=SOL-PERP&limit=100` — recent trades

Trade response amounts in protocol precision (base 1e9, quote 1e6).

## Live data via WebSocket

```typescript
const ws = new WebSocket("wss://data.api.drift.trade/ws");
ws.onopen = () => ws.send(JSON.stringify({
  type: "subscribe", symbol: "SOL-PERP", resolution: "1"
}));
```

## DLOB + Swift servers

- DLOB: `https://dlob.drift.trade`
- Swift: `https://swift.drift.trade`

Last updated on February 27, 2026
