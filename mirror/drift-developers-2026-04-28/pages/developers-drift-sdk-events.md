# Events – Drift Protocol
URL: https://docs.drift.trade/developers/drift-sdk/events

# Events

Protocol events are emitted in transaction logs. The SDK provides an `EventSubscriber` that can listen, deserialize, and emit events to your app in real-time.

## Event Types

| Event Type | Description |
| --- | --- |
| `DepositRecord` | A user depositing or withdrawing funds from the protocol |
| `FundingPaymentRecord` | A user paying or receiving funding payments |
| `LiquidationRecord` | A user being liquidated |
| `OrderRecord` | A user placing an order (includes all order parameters) |
| `OrderActionRecord` | A user action on an order: place, cancel, or fill |
| `FundingRateRecord` | The funding rate changing for a market |
| `NewUserRecord` | A new user account being created |
| `SettlePnlRecord` | A user settling their perp PnL |
| `LPRecord` | A user adding or removing passive perp liquidity |
| `InsuranceFundRecord` | The insurance fund balance changing |
| `SpotInterestRecord` | Spot interest accruing |
| `InsuranceFundStakeRecord` | A user staking or unstaking from the insurance fund |
| `CurveRecord` | The AMM curve parameters updating |
| `SwapRecord` | A Jupiter swap being executed through Drift |

## Subscribing to Events

```typescript
import { EventSubscriber } from "@drift-labs/sdk";

const options = {
  eventTypes: [
    "DepositRecord", "FundingPaymentRecord", "LiquidationRecord",
    "OrderRecord", "OrderActionRecord", "FundingRateRecord",
    "NewUserRecord", "SettlePnlRecord", "LPRecord",
    "InsuranceFundRecord", "SpotInterestRecord",
    "InsuranceFundStakeRecord", "CurveRecord",
  ],
  maxTx: 4096,
  maxEventsPerType: 4096,
  orderBy: "blockchain",
  orderDir: "asc",
  commitment: "confirmed",
  logProviderConfig: { type: "websocket" },
};

const eventSubscriber = new EventSubscriber(connection, driftClient.program, options);
await eventSubscriber.subscribe();

eventSubscriber.eventEmitter.on("newEvent", (event) => {
  console.log(event.eventType, event);
});
```

### Filtering Events

```typescript
import { isVariant } from "@drift-labs/sdk";

const marketIndex = 0;
const isPerpFill = (event) => {
  if (event.eventType !== "OrderActionRecord") return false;
  if (event.marketIndex !== marketIndex) return false;
  if (!isVariant(event.marketType, "perp")) return false;
  if (!isVariant(event.action, "fill")) return false;
  return true;
};

eventSubscriber.eventEmitter.on("newEvent", (event) => {
  if (isPerpFill(event)) console.log("Perp fill on market", marketIndex, event);
});
```

## Querying Stored Events

The `EventSubscriber` keeps a rolling buffer of recent events in memory.

```typescript
const events = eventSubscriber.getEventsReceived("OrderActionRecord");

const txSig = "3dq5...";
const eventsForTx = eventSubscriber.getEventsByTx(txSig);
```

Last updated on February 27, 2026
