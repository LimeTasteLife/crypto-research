# Onboarding FAQs

Source: https://docs.dydx.xyz/concepts/onboarding-faqs

## Background

How does the network work? dYdX Chain (or "v4") is composed of full nodes and each maintains an in-memory order book. Anyone can use the open source software to run a full node. Traders can submit order placements and cancellations to full nodes, which gossip the transactions amongst themselves. Full nodes with enough delegated layer 1 governance tokens participate in block building as validators. Validators on dYdX Chain take turns proposing blocks of trades every ~1 second. The validator whose turn it is to propose a block at a given height is called the proposer. The proposer uses its mempool orderbook to propose a block of matches, which validators either accept or reject according to CometBFT (Tendermint) consensus.

What is the difference between a full node and a validator? A full node does not participate in consensus. It receives data from other full nodes and validators in the network via the gossip protocol. A validator participates in consensus by broadcasting votes signed by each validator's private keys.

What are the benefits of running a full node as a market maker? Running a full node will eliminate the latency between placing an order and when the actual order is gossiped throughout the network. Without your own node, your order will need to first be relayed to the nearest geographic node, which will then propagate it throughout the network for you. With your own node, your order will directly be gossiped. Additionally, running a full node allows you to use full node streaming.

What is the current block time? The current block time is ~1 second on average.

## Trading

Order types: Two order types — Short-Term orders and stateful orders. Short-Term orders are meant for programmatic, low-latency traders that want to place orders with shorter expirations. Stateful orders are meant for retail that wants to place orders with longer expirations. These orders exist on chain.

Why should market makers only use short-term orders? Short-Term orders are placed and can be immediately matched after they're added to the mempool, while stateful orders can only be placed and matched after they're added to a block. Short-Term orders should always have superior time priority to stateful orders.

How do subaccounts work on dYdX Chain? To begin trading, you need to make sure your funds are in your subaccount.

Do I need gas when I transfer funds to create a new subaccount? Yes. Both USDC and cosmos native dYdX can be used to pay for gas fees. This USDC must be in the main wallet and not another subaccount to pay for fees.

Rate limits: Rate limits are per account, and not per subaccount.

## Full Nodes & Validators

Throughput: Up to 1500 orders/second from load-testing. Latency depends on which validator is the proposer. Having multiple full-nodes in different regions improves latency.

Order-to-trade latency: Order match -> trade probably at least 1 block (~0.8s), could be more.

## Indexer

How does the indexer reconstruct the orderbook? A full node is run alongside the Indexer and sends messages to the indexer when it receives orders. On a cold-start, a full-node would still have all the stateful orders. For short-term orders only valid for 20 blocks, within 20 blocks the indexer would have an accurate view.

## MEV

How will dYdX Chain handle MEV? Cosmos infrastructure enables unique MEV solutions to be built that align validator's incentives with user's incentives. dYdX Chain has a framework where MEV is measured via a dashboard. The first step would be to punish validators with slashing.

Finality: When your order fills, a block proposer proposes a block containing the fill, and then the block undergoes consensus. If valid, it finalizes shortly thereafter. In Cosmos, every block is final (no reorgs or forks).

## Pricing

How is the oracle price computed? Five parts:
- Slinky: sidecar that pulls price data from external sources and caches them for the validator to use.
- Vote Extensions: Every block during the Precommit stage, all validators will submit vote extensions for what they believe the oracle price of all tracked assets should be.
- Consensus: The block after VE are submitted, Slinky deterministically aggregates all VE from the previous block and proposes a new updated price which is voted into consensus.
- `x/prices` Module: updates the state based on the new price.
- Params: determines the external sources and sensitivity, configured per network.

How often are prices updated on-chain? Prices will not update on any given block if the market is disabled within `x/marketmap` or less than 2/3s of validators (by stake weight) contributed to a price update.

Does Slinky store historical prices? No. Prices are stored in `x/oracle` module, and only stores the most recently posted price.
