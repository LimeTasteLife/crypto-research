# Withdraw and Close Account – Drift Protocol
URL: https://docs.drift.trade/protocol/getting-started/withdraw-and-close-account

# Withdraw and Close Account

### Withdraw collateral

To withdraw collateral, ensure you meet the following requirements:

- No open positions.
- No open borrows (check your 'Balances' page).
- No unsettled PnL (settle any PnL before proceeding).

You can partially withdraw collateral if you have enough initial free collateral. To check your collateral, refer to your account health breakdown via any portfolio screen.

Do not delete your account or subaccounts if you're staking at Insurance Vaults. This may cause difficulty unstaking.

Referred accounts cannot be deleted.

### Dynamic rent reclaiming

Every account incurs a base account rent of ~0.035 SOL. During periods of high sign-ups (sybil activity), Drift's program adds an excess fee on top of this base rent. For example, a user might pay 0.035 SOL (base rent) + 0.1901 SOL (excess fee) = 0.2251 SOL to create an account.

### Idle Account Deletion

The Drift Security Council periodically triggers the cleanup of idle accounts in the Drift program. This is done to clear unused space and optimize infrastructure and keeper networks. Authorities of these accounts receive their SOL rent back to their wallets. Accounts eligible for deletion must be inactive for ~3 months and hold under ~$0.05 in notional value. Account history will still available through the UI and the account may be re-created by the user at any time.

### Recovering Funds

Excess Fee

Users can reclaim the excess fee after a 7-day waiting period. Visit the Accounts Page in your portfolio. Look for the "Reclaimable Rent" section and click "Claim" to retrieve any excess fees paid during account creation.

Base Rent

To reclaim the base rent (0.035 SOL in the example above), you'll need to delete your Drift account via the Accounts Page

Click the trash button next to your main account. This will permanently delete your account history and instantly redeem your base account rent. No further steps are required.

Ensure you have no open borrows, unsettled PnL, open positions, or any remaining balances before deleting your account. Withdraw any balances from Drift before proceeding.

Last updated on February 27, 2026
