# MegaVault (Community Docs)

Source: https://docs.dydx.community/dydx/dydx-features/megavault

MegaVault is a user-facing feature that enables dYdX users to add USDC to provide liquidity to various markets, and earn yield in return. By aggregating liquidity from users, MegaVault ensures that every market maintains the necessary liquidity for smooth and efficient trading.

## Vault Mechanics

At a technical level, MegaVault operates multiple "sub-vaults." A sub-vault uses users' USDC to run an automated market-making strategy for a given market. Users' USDC is allocated to these sub-vaults, and the yield they generate is aggregated and distributed to users who added USDC to MegaVault.

## Adding and Removing Funds

Users can add funds into MegaVault at any time and start earning yield immediately. At a high level, users can think of adding funds as owning a percentage of the vault's net equity (i.e., the vault's USDC and position values).

Except in the case of Instant Market Listings, users will be able to remove funds from MegaVault at any time after adding them, though they may experience slippage.

## Operator

For MegaVault to work effectively, it requires a dedicated operator to configure and optimize settings across all sub-vaults continuously. This includes spread parameters, skew factors, and liquidity allocation weights.

On November 21, 2024, dYdX community elected Greave as MegaVault's operator, granting it the ability to update parameters.

## How to Add USDC into MegaVault

1. Visit dydx.trade/vault.
2. Connect Your Wallet (MetaMask, Coinbase Wallet, OKX Wallet, Keplr, etc).
3. Select USDC Amount.
4. Approve and Confirm the Transaction.
5. USDC is added into MegaVault.
6. Generate Passive Income — earn a share of the profits from MegaVault's operations and a portion of protocol revenue.
7. Remove USDC Anytime — MegaVault has no lock-up periods (except instant market listings).

## FAQ

Where does MegaVault yield come from? Currently, MegaVault yield comes from profit & loss on vault positions, funding rate payments, and 50% trading fee revenue share (as approved by the dYdX community on November 15, 2024). This trading fee revenue share can be adjusted by dYdX community anytime via dYdX Chain governance.

Will I receive the MegaVault APR shown in the front-end? The APR is an estimated representation of annualized returns based on past performance which fluctuates significantly. Increases in MegaVault TVL will likely lead to reductions in APR as more users share the protocol revenue received by MegaVault.

How is MegaVault APR calculated? `(30 day PnL/current TVL) * (365/30)` or for less than 30 days, `(total PnL/current TVL) * (365/number of days for which data was available)`.

Can you lose money by adding funds to MegaVault? Yes. MegaVault is designed to support the protocol and not maximize returns. MegaVault's positions may have negative trading PnL, and those losses could outweigh returns from protocol fee sharing or other sources of return.

When I add funds to MegaVault, where is it taken from? MegaVault will use cross-margined funds. Thus, when you add funds to MegaVault position while having any cross-positions open, your cross margin usage will increase.

Who will custody my MegaVault position? You. When you add funds to MegaVault, you maintain control over your funds via the private keys associated with your wallet address.

Can anyone add funds to MegaVault? No. If you reside in, are located in, or have a registered office in the United States, Canada, or any other prohibited jurisdiction, you may not add funds to MegaVault.

Can my position be diluted? Yes, the number of users who may participate and the amount of funds they add to MegaVault is unlimited and each addition of funds will dilute the proportion of fee revenue and PnL attributed.

Why would withdrawals incur slippage? When withdrawing from MegaVault, "slippage" can occur due to increased leverage from collateral outflows or the need to close positions to cover withdrawal outflows. Removing funds reduces the amount of collateral MegaVault holds for each sub-vault position traded and increases MegaVault's leverage.

Slippage scenarios:
1. Low leverage (no positions, all idle): 0% slippage on removal.
2. Medium leverage (one isolated margin sub-vault, 1x leverage, IMF=10%, MMF=50%, half-spread=30bps, skew=2): 4.9% — 35.5% slippage depending on TVL impact.
3. High leverage (8x leverage, IMF=20%, MMF=10%): 100% slippage, $0 received.

Will users be able to directly interact with sub-vaults? Currently, users cannot directly deposit into or withdraw from specific sub-vaults.
