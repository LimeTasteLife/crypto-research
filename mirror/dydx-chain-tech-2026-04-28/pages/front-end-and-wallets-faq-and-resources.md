# FAQ & Resources (Front-end & Wallets)

Source: https://docs.dydx.community/dydx-chain-technical-docs/front-end-and-wallets/faq-and-resources

## Ecosystem Tools FAQ

Officially recognized wallets: Keplr, Leap (popular Cosmos wallets).

Multi-sig and MPCs that support the dYdX chain: Keplr Multisig, Fordefi.

Example transaction to exchange USDC from Noble chain to USDC on Ethereum:
- From Noble: https://www.mintscan.io/noble/tx/51C848560634B18E4D0F69D9D9064E78C1FB4CD1BF6DB75098360FFB7D656DAD?height=4428705
- On Ethereum: https://etherscan.io/tx/0x03d2614f3b3d866ce5d8eef1d7e1b2f525af67c616c7f6531e1c32877b930a8c

## Front End FAQ

Is there a way to get user's BuyingPower from API? You can get equity and freeCollateral from the `/v4/addresses/<address>` endpoint. It won't make sense to get BuyingPower from API since each market has different maximum leverage.

GoodTilBlock param in placeOrder function: see https://github.com/dydxprotocol/v4-clients/blob/main/v4-client-js/examples/short_term_order_composite_example.ts

"FillOrKill order could not be fully filled" error on market order: Market orders need to be short-term order (with GoodTilBlock set).

Hexadecimal -> accAddress: You still need to own the metamask address (have the private key) to run the derivation to determine dydxaddress. Pattern: metamask address → sign a message → dydx address.

Custom UI integration: The user can connect their metamask wallet to your alternative UI. Then you ask the user to sign the message. Frontend code is open-source: https://github.com/dydxprotocol/v4-web

## Websocket FAQ

Heartbeat stream: not needed. V4 orderbook example at https://github.com/chiwalfrm/dydxexamples/tree/main/v4orderbook

Subscribe to new block event via ws: not available on websocket; available via REST: https://docs.dydx.trade/developers/indexer/indexer_api#getheight. If you run a full node that can keep up with the chain, you would always know the block height (recommended to avoid REST rate limits).

Block number of an orderbook snapshot: https://docs.dydx.trade/developers/indexer/indexer_api#getheight

Can we assume one orderbook update will be published per block per pair? No, because the order book is off chain.

Subscribe to trade confirmation events via ws: get fills via ws v4_subaccount channel.

Get orderID without using GET /orders: monitor the v4_subaccounts feed via websocket — it has orders so you can see the orderId and match that up with the clientId.
