# Liquidation Bot
URL: https://mintlify.com/drift-labs/protocol-v2/examples/liquidation-bot

# Liquidation Bot

Build a liquidation bot to earn liquidation fees.

## Overview

Liquidations transfer underwater positions/borrows to liquidators at a discount. Liquidators must hold sufficient collateral to take on the inherited liability.

## Pattern

```typescript
import { UserMap, calculateMaxPctToLiquidate } from '@drift-labs/sdk';

const userMap = new UserMap({
  driftClient, connection,
  subscriptionConfig: { type: 'websocket' },
});
await userMap.subscribe();

// Continuously scan for liquidatable users
for (const [_, user] of userMap.entries()) {
  if (user.canBeLiquidated()) {
    const statuses = user.getLiquidationStatuses();
    // Choose liquidation type and call appropriate instruction:
    //   driftClient.liquidatePerp(...)
    //   driftClient.liquidateSpot(...)
    //   driftClient.liquidateBorrowForPerpPnl(...)
    //   driftClient.liquidatePerpPnlForDeposit(...)
  }
}
```

## Reference Implementation

`drift-labs/keeper-bots-v2/src/bots/liquidator.ts` — production liquidator with derisk logic, RPC management, market filtering.

See also: `drift-labs/keeper-bots-v2/src/bots/liquidatorDerisk.ts`.

## Best Practices

- Sort users by `liquidationPrice` for efficient scanning
- Monitor competing liquidators
- Track exposure and apply position limits
- Use `liquidatorDerisk` strategy to immediately exit liquidated positions
