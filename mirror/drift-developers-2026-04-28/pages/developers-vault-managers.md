# Vault Managers – Drift Protocol
URL: https://docs.drift.trade/developers/vault-managers

# Vault Managers

Vaults are delegated trading pools where depositors provide capital and a manager (delegate) trades with it under strict withdrawal rules.

## How it works

Each vault has its own Drift user account that the manager trades with. The manager has delegate authority: place/cancel orders, manage positions. Depositors' funds are pooled in this single account; PnL affects all share holders proportionally. Vaults use share-based accounting: depositors receive shares when they deposit and redeem them after a cooldown (redeem period).

| Parameter | Notes |
| --- | --- |
| `name` | Unique identity for the vault. |
| `management fee` | Annualized; after init can only be lowered. |
| `performance fee` (profit share) | On realized gains; after init can only be lowered. |
| `redemption period` | Withdrawal cooldown in seconds; after init can only be shortened. |
| `permissioned` | If set, only the manager can initialize new vault depositor accounts. |
| `max_deposits` / `max-tokens` | Capacity limit; can be raised or lowered after init (applies to new deposits only). |
| `min_lp_deposit` / `min-deposit-amount` | Minimum deposit size; can be changed after init. |

Fees: percentage precision (1e6 scale), annualized. Management fees apply only when there are non-manager deposits and compound on actions. Performance fees use watermarks (no double-charging on drawdowns).

## Lifecycle

create -> deposit -> trade -> request withdraw -> wait redeem period -> withdraw

## Init / update vault (CLI)

```
yarn cli init-vault \
  --name "MyVault" \
  --market-index 0 \
  --redeem-period 604800 \
  --max-tokens 0 \
  --management-fee 200 \
  --profit-share 2000

yarn cli manager-update-vault \
  --vault-address <VAULT_ADDRESS> \
  --redeem-period 1000 \
  --max-tokens 200000

yarn cli manager-update-margin-trading-enabled \
  --vault-address <VAULT_ADDRESS> --enabled true

yarn cli view-vault --vault-address <VAULT_ADDRESS>
```

## Permissioned vaults

```
yarn cli init-vault-depositor \
  --vault-address <VAULT_ADDRESS> \
  --deposit-authority <AUTHORITY_TO_ALLOW>
```

## Security

Managers cannot withdraw user funds directly; withdrawals governed by redeem period and share accounting. Managers can decrease (not increase) redeem period, can only lower fees after init.

## Trusted vaults

Trusted vaults extend the base vault with manager borrowing and (when enabled) margin trading. Created like normal vault; admin upgrades vault class to Trusted. Manager can borrow assets and repay or mark-to-market.

```
yarn cli manager-borrow \
  --vault-address <VAULT_ADDRESS> \
  --borrow-spot-market-index 0 \
  --borrow-amount <AMOUNT>

yarn cli manager-repay \
  --vault-address <VAULT_ADDRESS> \
  --repay-spot-market-index <INDEX> \
  --repay-amount <AMOUNT> \
  --repay-value <VALUE>

yarn cli manager-update-borrow \
  --vault-address <VAULT_ADDRESS> \
  --new-borrow-value <VALUE>
```

Trusted vaults must be approved by the Drift team before production use. Depositors place significant trust in the manager.

## Multisig manager

The vault manager owns the vault. Set manager to a multisig (e.g., Squads) and use `--dump-transaction-message` for the base58 transaction blob, then import in Squads. Manager can be changed via `manager-update-vault-manager`.

## Accounting

Share price = `vault_equity / total_shares` in the vault's deposit asset. For Trusted vaults, vault equity includes the manager's borrowed value.

## Risks and monitoring

Liquidations: If a depositor has waited the redeem period and their withdrawal would breach the vault's initial margin requirement, a permissioned liquidator can temporarily assume delegate control and close positions in reduce-only mode (up to 1 hour), then restore the original delegate.

Trust and incentives: NOT trustless between depositors and managers. Without reputation or stake, incentives can be misaligned. Depositors have no on-chain recourse.

Last updated on March 24, 2026
