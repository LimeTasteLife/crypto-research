# Drift Builder Codes – Drift Protocol
URL: https://docs.drift.trade/developers/builder-codes

# Drift Builder Codes

## Overview

Drift's Builder Code (DBC) system enables any builder to build on top of Drift while earning fees for routing trades.

DBC establishes the financial infrastructure layer on Solana, allowing anyone to tap into Drift's liquidity and execution without building their own backend. This makes Drift the first on-chain DEX on Solana to offer per-order monetization for third-party frontends.

### Getting started with DBC

Builder Registration: Builders need an existing Drift account and a `RevenueShareAccount`.

User Onboarding: Before placing any orders, users must approve the builder and the maximum allowed builder fee. Approval is stored in the user's `RevenueShareEscrow` account.

### How Builder Codes Work

#### Order Placement

The builder's app constructs a `place_order` transaction including their `builderIdx` and `builderFee` in the signed order params. The `RevenueShareEscrow` account is included so the program can validate and record the order.

#### Fee Accrual (Per Order)

When an order is filled, the fee is credited to the user's `RevenueShareEscrow` as a `RevenueShareOrder`:
- Tracks builder's pubkey, `feesAccrued`, `orderId`, `feeBps`, market type, completion status
- Fees remain in escrow until settlement

#### Settlement

On `settle_pnl`, accrued fees in the escrow are swept to the builder's `RevenueShareAccount`.

### Notes for MMs

RevenueShareEscrow Inclusion: Fillers and market makers must include the user's `RevenueShareEscrow` account in every order fill transaction. PDA derived from user's pubkey (no additional RPC calls needed).

Multi Builder Support: Users can approve multiple builders. MMs may see multiple builder accounts to sweep to during `SettlePnl`. The protocol won't throw if a specific builder is omitted, but all filled rewards must eventually be swept.

Error Handling: If a required escrow account isn't included, the program will throw. Always include it.

### FAQ

Q: Can a user approve multiple builders? A: Yes. Each builder entry in `approvedBuilders` has its own max fee bps.

Q: How are builder fees capped? A: The protocol enforces the user-approved max fee per builder. Going over fails the transaction.

Q: When are builder rewards paid? A: On the user's `settle_pnl` call (sweeps escrowed fees to the builder).

Last updated on February 27, 2026
