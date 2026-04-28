# Troubleshooting – Drift Protocol
URL: https://docs.drift.trade/developers/trading-automation/troubleshooting

# Troubleshooting

## Failed to get token account balance

The account in `KEEPER_PRIVATE_KEY` does not have a USDC account.

```
SolanaJSONRPCError: failed to get token account balance: Invalid param: could not find account
```

Solution: create the USDC associated token account for the bot wallet.

## ClearingHouseUser does not exist

The account in `KEEPER_PRIVATE_KEY` has not been initialized on the `ClearingHouse` program yet.

```
error: ClearingHouseUser for bot... does not exist
Error: Run with '--init-user' flag to initialize a ClearingHouseUser
```

Solution: `yarn run dev --init-user`

## Misc Transaction Errors

Running a Keeper is profit-seeking; expect competition while filling orders and liquidating positions. Errors can happen at various commitment levels.

Last updated on February 27, 2026
