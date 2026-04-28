# Tutorial: Order Matching Bot – Drift Protocol
URL: https://docs.drift.trade/developers/trading-automation/keeper-bots/order-matching-bot

# Tutorial: Order Matching Bot

## Introduction

Order Matching Bots match two orders that cross or a taker order against the AMM:
- Market Orders: Market Buy and Market Sell
- Limit Orders: Limit Buy and Limit Sell

Matching Bots receive a small compensation for each order successfully filled. They maintain a local copy of the DLOB, do not require collateral, and earn a small reward for performing their duties.

## Getting Started

```
yarn run dev:filler
```

## Technical Explanation

Continuous loop: fetch fillable orders from the DLOB, filter out non-actionable ones, and submit fill transactions.

### Get fillable nodes

Market orders first go through JIT Auctions; after the auction period, they become available for matching bots. The DLOB exposes `findNodesToFill`:

```typescript
const market = this.clearingHouse.getMarketAccounts()[0];
const oraclePriceData = this.driftClient.getOracleDataForMarket(marketIndex);
const oracleIsValid = isOracleValid(market.amm, oraclePriceData,
    this.driftClient.getStateAccount().oracleGuardRails,
    this.slotSubscriber.getSlot());

const vAsk = calculateAskPrice(market, oraclePriceData);
const vBid = calculateBidPrice(market, oraclePriceData);

const nodesToFill = this.dlob.findNodesToFill(
    marketIndex, vBid, vAsk, this.slotSubscriber.getSlot(),
    oracleIsValid ? oraclePriceData : undefined
);
```

### Filter for fillable nodes

Filter out limit orders too small for the AMM to execute:

```typescript
if (!nodeToFill.makerNode &&
    (isVariant(nodeToFill.node.order.orderType, "limit") ||
     isVariant(nodeToFill.node.order.orderType, "triggerLimit"))) {
    const baseAssetAmountMarketCanExecute = calculateBaseAssetAmountMarketCanExecute(
        market, nodeToFill.node.order, oraclePriceData
    );

    if (baseAssetAmountMarketCanExecute.lt(market.amm.baseAssetAmountStepSize)) continue;
}
```

### Submit fill

```typescript
const user = this.userMap.get(nodeToFill.node.userAccount.toString());
const txSig = await this.driftClient.fillOrder(
    nodeToFill.node.userAccount,
    user.getUserAccount(),
    nodeToFill.node.order,
    undefined
);
```

Last updated on February 27, 2026
