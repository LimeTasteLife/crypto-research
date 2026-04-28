# Security
URL: https://mintlify.com/drift-labs/protocol-v2/program/security

# Security

## Audits

- Trail of Bits (Nov 2022 - Jan 2023): no high-severity flaws found
- Neodyme (May 2024 - Jun 2024)
- Ottersec: scope was MetaMask Snap "Connect by Drift"

## Bug Bounty

Drift Protocol runs a bug bounty program. Critical findings reach significant payouts. Submit responsibly to the team via Discord or designated bounty channels.

## Resilience Mechanisms

- Oracle validity checks (Stale, TooVolatile, TooUncertain, etc.) — block actions when oracle fails
- Price bands — prevent risky orders during extreme oracle/mark divergence
- Circuit breakers — pause specific operations on each market
- Insurance Fund — backstop for liquidation deficits
- Drift Safety Module (DSM) — DRIFT-staked backstop, automated bad debt coverage
- Progressive liquidation — ramp up over slots to avoid wick wipe-outs
- Confidence-interval-aware margin — wider confidence increases margin requirement

## Account Permissions

- Admin: protocol-wide config (rotate via instruction)
- User authority: full control over their own subaccounts
- Delegate: can place/cancel orders only (no withdraws)
- Liquidator (any): permissionless, requires collateral
- Keeper (any): permissionless, no collateral required for filling/triggering

## Reporting Vulnerabilities

For security issues, do NOT file public GitHub issues. Contact the Drift team through official channels.
