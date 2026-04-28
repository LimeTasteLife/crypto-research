# Indexer Deep Dive

Source: https://docs.dydx.xyz/concepts/architecture/indexer

A good way to think about the Indexer is as similar to Infura or Alchemy's role in the Ethereum ecosystem. However, unlike Infura/Alchemy, and like everything else in dYdX Chain, the Indexer is completely open source and can be run by anyone.

### What is the Indexer?

The Indexer is a read-only service that serves off chain data to clients over REST APIs and Websockets. Its purpose is to store and serve data that exists on dYdX Chain in an easier to use way. Cosmos SDK Full Nodes offer a number of APIs that can be used to request onchain data; however, these Full Nodes are optimized for committing and executing blocks, not for serving high frequency, low-latency requests.

### Onchain vs. Offchain data

The Indexer runs two separate ingestion/storage processes with data from a v4 Full Node: one for onchain data and one for offchain data. Currently, throughput of onchain data state changes is expected to be from 10-50 events/second. On the other hand, the expected throughput of offchain data state changes is between 500-1,000 events/second. This represents a 10-100x difference in throughput requirements.

### Onchain Data

Onchain data is all data that can be reproduced by reading committed transactions on a dYdX Chain deployment. All onchain data has been validated through consensus. This includes:

- Order Fills (Partially and completely filled orders)
- Deleveraging
- Liquidations
- Trades

### Offchain Data

Offchain data is data that is kept in-memory on each v4 node. It is not written to the blockchain or stored in the application state. This includes:

1. Indexed order updates before they hit the chain
2. Order book of each perpetual exchange pair
3. Short-term order placement and cancellations
4. Conditional order placement and cancellation

## Indexer Architecture

The Indexer is made up of a series of services that ingest information from v4 Full Nodes and serve that information to various clients. Kafka topics are used to pass events/data around to the services.

### Ender (Onchain ingestion)

Ender is the Indexer's onchain data ingestion service. It consumes data from the "to-ender" Kafka topic which queues all onchain events by block. Ender takes all state changes from that block and applies them to a Postgres database. Ender will also create and send websocket events for any websocket events that need to be emitted.

### Vulcan (Offchain ingestion)

Vulcan is the Indexer's offchain data ingestion service. It consumes data from the "to-vulcan" Kafka topic, which carries payloads that include active order book updates, place order updates, cancel order updates, and optimistic fills. This data is stored in a Redis cache.

### Comlink (API Server)

Comlink is an API server that exposes REST API endpoints to read both onchain and offchain data.

### Roundtable

Roundtable is a periodic job service that provides required exchange aggregation computations: 24h volume per market, open interest, PnL by account, candles, etc.

### Socks (Websocket service)

Socks is the Indexer's websockets service that allows for real-time communication between clients and the Indexer.

## Hosting & Deploying the Indexer

In service of creating an end-to-end decentralized product, the Indexer is open source. Operators host the Indexer on AWS infrastructure (Secret Manager, Cloudwatch, EC2 ELB, ElastiCache Redis, Lambda, EC2, RDS Postgres, ECS Fargate). dYdX believes that, at minimum, a DevOps engineer is required to perform deployment and maintenance.
