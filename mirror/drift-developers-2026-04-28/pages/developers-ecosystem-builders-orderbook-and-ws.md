# Orderbook + DLOB websocket – Drift Protocol
URL: https://docs.drift.trade/developers/ecosystem-builders/orderbook-and-ws

# Orderbook + DLOB websocket

The DLOB server powers the UI orderbook and trades feed.

## REST endpoints

### L2 orderbook

```
GET https://dlob.drift.trade/l2?marketName=SOL-PERP&depth=10&includeVamm=true&includeIndicative=true
```

Query params: `marketName`, `depth`, `includeVamm`, `includeIndicative`, `grouping`.

Response:
```json
{
  "bids": [{"price":"123.45","size":"100.5"}],
  "asks": [{"price":"123.50","size":"80.2"}],
  "slot": 250000000
}
```

### L3 orderbook

```
GET https://dlob.drift.trade/l3?marketName=SOL-PERP&includeVamm=true
```

Returns every individual order with maker address and order ID.

## WebSocket

Base URL: `wss://dlob.drift.trade/ws`

Channels: `orderbook`, `trades`

```typescript
const ws = new WebSocket("wss://dlob.drift.trade/ws");

ws.onopen = () => {
  ws.send(JSON.stringify({
    type: "subscribe", channel: "orderbook",
    marketType: "perp", market: "SOL-PERP",
    grouping: 10,
    includeVamm: true,
    includeIndicative: true
  }));

  ws.send(JSON.stringify({
    type: "subscribe", channel: "trades",
    marketType: "perp", market: "SOL-PERP"
  }));
};

ws.onmessage = (event) => {
  const message = JSON.parse(event.data);
  // IMPORTANT: data field is often a double-encoded JSON string
  const data = typeof message.data === "string"
    ? JSON.parse(message.data)
    : message.data;

  if (message.channel?.startsWith("orderbook_")) {
    console.log("Bids:", data.bids);
    console.log("Asks:", data.asks);
  }
};
```

### Response channel format

| Subscribed | Response channel |
| --- | --- |
| `orderbook` | `orderbook_perp_{marketIndex}_grouped_{grouping}` |
| `trades` | `trades_perp_{marketIndex}` |

### Double-encoded data field

```typescript
const parsed = JSON.parse(event.data);
const book = typeof parsed.data === "string"
  ? JSON.parse(parsed.data)
  : parsed.data;
```

Last updated on February 27, 2026
