# User Account - Drift Protocol v2

Source: https://mintlify.com/drift-labs/protocol-v2/program/state/user-account

# User Account

> User account structure in Drift Protocol

The User account stores all trading data for a user including positions, orders, and collateral.

## Account Structure

The UserAccount is defined in `programs/drift/src/state/user.rs`.

### Key Fields

Wallet public key that controls this account

Sub-account ID (0-9999)

Array of up to 8 perpetual positions

Array of up to 8 spot positions (collateral)

Array of up to 32 active orders

Settled perpetual PnL

Cumulative funding payments

Next order ID to assign

Custom maximum margin ratio

Whether margin trading is enabled

## TypeScript Types

For TypeScript SDK usage, see:

## UserAccount Type

Full TypeScript interface

## User API

User class methods

## Account Management

Create and manage accounts

## Position Management

Work with positions
