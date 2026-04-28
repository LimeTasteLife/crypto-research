# Event Listening
URL: https://mintlify.com/drift-labs/protocol-v2/examples/event-listening

# Event Listening

Listen to and process Drift Protocol events.

```typescript
import { EventSubscriber, isVariant } from '@drift-labs/sdk';

const eventSubscriber = new EventSubscriber(connection, driftClient.program, {
  eventTypes: [
    'OrderRecord', 'OrderActionRecord', 'DepositRecord',
    'FundingPaymentRecord', 'FundingRateRecord', 'LiquidationRecord',
    'SettlePnlRecord', 'LPRecord', 'InsuranceFundRecord',
    'SpotInterestRecord', 'InsuranceFundStakeRecord',
    'CurveRecord', 'NewUserRecord',
  ],
  maxTx: 4096,
  maxEventsPerType: 4096,
  orderBy: 'blockchain',
  orderDir: 'asc',
  commitment: 'confirmed',
  logProviderConfig: { type: 'websocket' },
});
await eventSubscriber.subscribe();

eventSubscriber.eventEmitter.on('newEvent', (event) => {
  if (event.eventType === 'OrderActionRecord' && isVariant(event.action, 'fill')) {
    console.log('Fill on market', event.marketIndex, event);
  }
  if (event.eventType === 'LiquidationRecord') {
    console.log('Liquidation:', event);
  }
});

// Query stored events
const fills = eventSubscriber.getEventsReceived('OrderActionRecord');
const txEvents = eventSubscriber.getEventsByTx(txSig);
```
