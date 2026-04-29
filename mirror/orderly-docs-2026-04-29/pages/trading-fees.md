# Trading fees

Trading fees are the costs you pay when you buy, sell, or trade on an exchange. On Orderly, fees are measured in basis points (1 bps = 0.01%) of your trade's total value.

Orderly Network uses a two-layer fee structure:

1. Base fees: The cost the Builder (the DEX) pays to Orderly Network.
2. User fees: The fee the Trader pays to the Builder.

### The dual-layer example

- Orderly base taker fee: 3 bps (0.03%)
- Builder custom fee: 5 bps (0.05%)
- Result: The Trader pays 5 bps. Orderly retains 3 bps, and the Builder keeps 2 bps as profit.

### Fee types

Maker fees: Charged when your order adds liquidity to the order book. Currently, the Orderly base maker fee is 0.00 bps across all tiers.

Taker fees: Charged when your order removes liquidity by filling immediately.

Liquidation fees: If your position gets liquidated, a liquidation fee is applied.

Perpetual futures trading fees are charged after every trade in USDC and are factored into the position's average entry price.

## How fees work for Traders

As a Trader, you pay a single fee per trade that's set by the Builder (the DEX you're using).

- Total fee paid: You see one transparent fee per trade. This fee typically includes Orderly's base fee plus the Builder's margin.
- How it's charged: Fees are automatically deducted from your USDC balance when your trade executes.

## How fees work for Builders

Orderly gives Builders full control over their pricing. You set your own trading fees while tapping into Orderly's shared liquidity.

- Set your own fees: You decide what to charge your users. The only rule: your fee must be at least as high as Orderly's base fee.
- Keep the difference: You retain 100% of the margin between what you charge users and what Orderly charges you.

### Builder Staking programme

Builders can get lower base fees and better support by hitting monthly volume targets or staking $ORDER tokens.

## Public

Requirements: No volume or staking requirement.

| Fee type | Rate (bps) |
|---|---|
| Crypto base taker fee | 3.00 |
| RWA base taker fee | 5.00 |
| Orderly base maker fee | 0.00 |

## Silver

Requirements: >= $30M monthly aggregate volume or stake 100K $ORDER

| Fee type | Rate (bps) |
|---|---|
| Crypto base taker fee | 2.75 |
| RWA base taker fee | 4.75 |
| Orderly base maker fee | 0.00 |

## Gold

Requirements: >= $90M monthly aggregate volume or stake 250K $ORDER

| Fee type | Rate (bps) |
|---|---|
| Crypto base taker fee | 2.50 |
| RWA base taker fee | 4.50 |
| Orderly base maker fee | 0.00 |

## Platinum

Requirements: >= $1B monthly aggregate volume or stake 2M $ORDER

| Fee type | Rate (bps) |
|---|---|
| Crypto base taker fee | 2.00 |
| RWA base taker fee | 4.00 |
| Orderly base maker fee | 0.00 |

## Diamond

Requirements: >= $10B monthly aggregate volume or stake 7M $ORDER

| Fee type | Rate (bps) |
|---|---|
| Crypto base taker fee | 1.00 |
| RWA base taker fee | 3.00 |
| Orderly base maker fee | 0.00 |

Monthly (30-day) aggregate trading volume includes all activity from the Builder and their direct Builder referrals. Daily snapshots determine tier eligibility.

## Permissionless Listing Fee Revenue

Builders who permissionlessly list markets earn 50% of trading fees and 100% of liquidation fees from their markets.
