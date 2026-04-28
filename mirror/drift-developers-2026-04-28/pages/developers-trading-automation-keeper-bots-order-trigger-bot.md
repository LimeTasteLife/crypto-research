# Tutorial: Order Trigger Bot – Drift Protocol
URL: https://docs.drift.trade/developers/trading-automation/keeper-bots/order-trigger-bot

# Tutorial: Order Trigger Bot

## Introduction

Order Trigger Bots mark orders satisfying the trigger condition:
- Trigger Market Orders - Stop Market and Take Profit
- Trigger Limit Orders - Stop Limit and Take Profit Limit

Trigger Bots receive a small compensation for each marked order. They maintain a local DLOB copy, do not require collateral, and earn small rewards.

## Getting Started

```
yarn run dev:trigger
```

## Technical Explanation

Polls the DLOB for orders whose trigger conditions are met (oracle price crossed a stop-loss level) and submits transactions to mark them triggered.

### Get triggerable nodes

```typescript
const market = this.driftClient.getMarketAccounts()[0];
const oraclePriceData = this.driftClient.getOracleDataForMarket(marketIndex);

const nodesToTrigger = this.dlob.findNodesToTrigger(
    marketIndex,
    this.slotSubscriber.getSlot(),
    oraclePriceData.price
);
```

### Submit trigger

```typescript
const user = this.userMap.get(nodeToTrigger.node.userAccount.toString());
const txSig = await this.driftClient.triggerOrder(
    nodeToTrigger.node.userAccount,
    user.getUserAccount(),
    nodeToTrigger.node.order
);
```

Once triggered on-chain, the order becomes a regular order available for matching bots to fill.

Last updated on February 27, 2026
