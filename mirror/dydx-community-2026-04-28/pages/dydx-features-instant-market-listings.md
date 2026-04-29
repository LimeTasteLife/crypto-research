# Instant Market Listings

Source: https://docs.dydx.community/dydx/dydx-features/instant-market-listings

Instant Market Listings enable users to list and trade perpetual futures on virtually any asset on dYdX instantly without waiting for governance approvals or third-party permissions. This new product feature eliminates the traditional costs and delays associated with market creation, allowing users to respond swiftly to market trends.

With this feature, users can list established cryptocurrencies or emerging assets as perpetual markets on dYdX by adding 10,000 USDC to the new asset's sub-vault. These funds ensure that new markets launch with sufficient liquidity for efficient trading.

## Launchable Markets on dYdX

Not all markets are currently eligible for instant listing. Skip, a third-party entity elected by the dYdX community as the Market Map Updater, manages the "launchable" markets on-chain.

To ensure compatibility and stability within the dYdX ecosystem, listed markets must meet specific volume and liquidity thresholds. These criteria guarantee seamless integration and provide a stable trading environment from the outset.

Most assets from Base, Ethereum, Solana, and centralized exchanges (CEXs) are supported, covering many of your favorite markets. The dYdX market mapper is actively working to expand this list, aiming to allow virtually any asset to be listed, including perpetual prediction markets.

## How to List a New Market on dYdX

1. Navigate to https://dydx.trade/
2. Select a Market — Type the name of the market into the search bar. If supported, it will appear with a "launchable" label.
3. Begin Market Launch — Click "Preview Launch".
4. Add Funds for Liquidity — Add 10,000 USDC, click "Deposit and Launch." Funds will be locked for an estimated 30 days to support liquidity.
5. Automatic Liquidity Activation — MegaVault supplements your funds.
6. Your Market is Live.
7. Remove Your Funds Anytime after the estimated 30 days.

## FAQ

How long is the lock-up period? An estimated 30 days. The USDC is actually locked for `2,592,000` dYdX protocol blocks. The 30-day estimate assumes an average block time of one second to confirm each block during the lock-up period. The actual block times could be longer, so your USDC could be locked for more than 30 days.

The amount and lock-up period are parameters that the community can adjust at any time via dYdX governance.

Will the funds be treated differently from other funds added to MegaVault? No, besides being locked for an estimated 30 days, the funds added to MegaVault are treated the same as other funds.

What does liquidity look like for a market that I list? When a user launches a market, 10,000 USDC is atomically added into that market's sub-vault. The MegaVault operator can subsequently adjust liquidity as they see fit.

Am I guaranteed to get my 10,000 USDC back in 30 days? No. The 10,000 USDC will be added to MegaVault. MegaVault supports high-risk, illiquid, and volatile markets, and adding funds to MegaVault carries a material risk of loss.

Is it legal to launch a market? You are responsible for assessing the legality of launching a new market. While dYdX is not available in certain jurisdictions, you should not rely on the availability of the instant listing software in a jurisdiction to inform compliance with laws.

Can I launch a market for US investors? No. dYdX may not be used in the United States, Canada, or any other prohibited jurisdiction.
