# Integrated Routing with UniswapX

The Uniswap Interface will be ramping up support for hooks in its standard routing system progressively over time. Hook builders looking to get immediate access to flow from the interface can do so by running a UniswapX filler for their hooked pools.

## How Integrated Routing Works

At a high level, hook builders' filler implementations will need to do the following:
1. (On Mainnet) Subscribe to the UniswapX RFQ system and submit fillable bids from orders they receive
2. Listen to the public feed for orders they won or that are open to be filled publicly
3. Execute those orders against pools that use their hooks

## Hook Allowlisting

If you have built a hook that you would like to have allowlisted, fill out the hook allowlisting form. You can review current allowlisted hooks in Allowlisted Hooks.
