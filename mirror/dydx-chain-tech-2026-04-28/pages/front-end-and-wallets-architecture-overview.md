# Architecture Overview (Front-end & Wallets)

Source: https://docs.dydx.community/dydx-chain-technical-docs/front-end-and-wallets/architecture-overview

## V4 Architecture (High-Level)

## Front-ends

Web Application: The website has been developed using Javascript and React, facilitating interaction with the Indexer via an API for accessing off-chain orderbook data and enabling direct blockchain trade executions. The front-end codebase, along with the deployment scripts, will be made available as open-source, simplifying the process for anyone to deploy the dYdX front end on their own domain or hosting solution through IPFS/Cloudflare gateway.

Mobile Development: The iOS and Android applications have been created in native Swift and Kotlin, mirroring the web application's interaction with the Indexer and direct trade executions on the blockchain. These mobile applications will also be open-sourced.

## Lifecycle of an Order

1. User places a trade on a decentralized front-end (e.g., website) or via API.
2. The order is routed to a validator. That validator gossips that transaction to other validators and full nodes to update their orderbooks with the new order.
3. The consensus process picks one validator to be the proposer. The selected validator matches the order and adds it to its next proposed block.
4. The proposed block continues through the consensus process. If 2/3 of validator nodes vote to confirm the block, then the block is committed and saved to the on-chain databases of all validators and full nodes. If the proposed block does not successfully hit the 2/3 threshold, then the block is rejected.
5. After the block is committed, the updated on-chain (and off-chain) data is streamed from full nodes to Indexers. The Indexer then makes this data available via API and Websockets back to the front end and/or any other outside services querying for this data.
