# Permissionless Listing

Permissionless Listing removes the bottleneck of platform-managed listing. Qualified Builders can list new perpetual markets themselves, on their own timeline, without waiting for Orderly to evaluate and approve each one. The Builder takes direct responsibility for the market — funding the Insurance Fund, supporting liquidity, and managing risk independently.

## Standard Listing vs. Permissionless Listing

| Feature | Standard Listing | Permissionless Listing |
|---|---|---|
| Who manages it | Orderly | Individual Builder |
| Insurance Fund | Shared across the platform | Dedicated per Builder |
| Listing Process | Evaluated & approved by Orderly | Instant & self-managed |
| Risk Parameters | Standardized & conservative | Customizable by Builder |

## How Permissionless Listing Works

Key design principle: a Builder's market should only affect that Builder's own risk exposure.

### Per-Builder risk isolation

Each Builder must set up:
- Insurance Fund (IF) account — dedicated sub-account covering liquidation losses. Minimum $50,000 per active symbol (e.g., 3 markets = $150,000 minimum). If IF drops too low, system restricts trading or triggers delisting.
- Market Maker (MM) accounts — optional sub-accounts for market-making.

The IF is completely separate from Orderly's platform IF and from any other Builder's IF. If IF fully depleted, ADL scoped to that specific market only.

All permissionlessly listed markets are Isolated Margin only. This prevents cascade from long-tail token crash into BTC/ETH positions.

### Per-Builder symbols

Multiple Builders can list the same underlying asset independently — separate order books, separate liquidity, separate Insurance Funds, separate risk parameters.

### Controlled launch sequence

1. POST_ONLY — Only limit orders accepted. MMs build liquidity.
2. ACTIVE — Once ±2% order book depth reaches $100,000 on both sides and holds for 10 minutes, market opens for full trading.

Circuit breakers: insufficient depth, low IF, or funding rate anomalies can force REDUCE_ONLY mode or delisting. Per-market, not platform-wide.

### Price sources

Index prices aggregated from CEX feeds and on-chain oracles. Supported: Pyth and Stork. If all sources unavailable, market placed into reduce-only mode.

## Who Can List

Available to Diamond Tier Builders ($10B monthly volume or 7M $ORDER staked). Up to 5 active markets per Builder (adjustable by Orderly).

## Community Listed Markets for Traders

| | Standard markets | Community Listed |
|---|---|---|
| Operator | Orderly | Individual Builder |
| Insurance Fund | Shared platform IF | Per-Builder IF |
| Margin mode | Cross + Isolated | Isolated only |
| IF depleted | Platform backstop | ADL only in that market |
| Liquidity | Platform-coordinated | Builder's market-making |

## Fee Revenue for Listing Builders

Builders who permissionlessly list markets earn 50% of trading fees and 100% of liquidation fees from their listed markets.
