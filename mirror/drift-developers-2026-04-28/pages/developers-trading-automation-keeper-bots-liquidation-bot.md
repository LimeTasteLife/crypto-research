# Tutorial: Liquidation Bot – Drift Protocol
URL: https://docs.drift.trade/developers/trading-automation/keeper-bots/liquidation-bot

# Tutorial: Liquidation Bot

## Introduction

Liquidation Bots improve the overall health of the protocol by deleveraging users approaching bankruptcy.

Liquidation = liability transfer from liquidatee (user in liquidation territory) to liquidator. Liquidators inherit the liabilities they liquidate and receive an asset at a discount. To participate, liquidators must have sufficient collateral to satisfy the initial margin requirements for the transferred positions.

## Getting Started

The canonical implementations in `keeper-bots-v2`:
- `src/bots/liquidator.ts`
- `src/bots/liquidatorDerisk.ts` (derisk helper)

Steps:
1. Understand liquidation mechanics (liability transfer, discount asset receipt)
2. Choose a reference implementation
3. Prepare the environment (fund wallet with USDC deposit)
4. Run via `keeper-bots-v2` config and monitor RPC latency, competing liquidators, position risk
5. Iterate and harden (filter markets/subaccounts, derisk strategies, exposure guardrails)

## Advanced

Improvements:
- Sort users in an efficient data structure based on their liquidation price
- Monitor market price to determine when to run liquidation checks / RPC checks

Last updated on February 27, 2026
