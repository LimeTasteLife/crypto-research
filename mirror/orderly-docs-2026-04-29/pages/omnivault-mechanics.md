# OmniVault Mechanics

Orderly OmniVault deploys strategies with vault assets to generate yields. PnL gain/loss proportionally split across all LPs according to share ownership.

## Lifecycle

1. Users deposit USDC into the OmniVault
2. Strategy Providers (SPs) execute strategies with vault assets
3. Users submit withdrawal requests to redeem shares
4. Users claim redeemed USDC once redemption is processed

## Shares

Non-tokenized, non-tradable, non-transferable.

- Share price = Vault Net Asset Value / Total Number of Issued Shares
- Deposit shares = LP Deposits (USDC) / Share Price
- Withdrawal = LP Withdrawal Shares * Share Price

## Vault Period

Each period lasts 3 hours. All deposits & withdrawal requests batched and processed at a common settlement share price.

Vault Period Start times (UTC): 0200H, 0500H, 0800H, 1100H, 1400H, 1700H, 2000H, 2300H

## Omnichain Capability

LP can deposit USDC from any supported network (Arbitrum, Base, Optimism) while interacting with a single unified strategy vault. Can deposit from chain A and withdraw on chain B.

## OmniVault Yields & Strategies

SPs manage vault assets to:
1. Execute market making strategies primarily on Orderly's order book
2. Act as the primary liquidator for selected symbols, taking on liquidated positions

OmniVault does NOT replace the Orderly insurance fund. Not all liquidated positions handled by OmniVault. Risk management mechanisms limit vault exposure.

Orderly allocates a portion of net protocol revenue (up to 40%) and a portion of insurance fund liquidation fees to OmniVault. Percentage periodically adjusted based on market conditions and TVL.

All returns compounded and distributed to LPs proportionally.

## APY Calculation

Calculated using daily time-weighted rate of return (TWRR) across 30-day rolling window, compounded and annualized.
