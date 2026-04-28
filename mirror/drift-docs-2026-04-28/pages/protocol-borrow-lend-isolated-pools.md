# Isolated Pools – Drift Protocol
URL: https://docs.drift.trade/protocol/borrow-lend/isolated-pools

# Isolated Pools

Drift's isolated pools allow users to trade or provide liquidity with specific risks confined to a particular pool. Each isolated pool is segregated, meaning that the risks associated with one pool do not impact other pools on Drift.

### What's the difference between Isolated and Cross-collateral pools?

Cross collateral (default accounts for Drift) shares a single collateral pool across multiple positions, allowing all assets in the account to back each other. This method spreads risk and increases margin efficiency but exposes the entire account to liquidation if risks are not managed. Isolated pools, however, keep collateral and risk confined to a single pool or position. Losses or liquidation in one pool do not impact the rest of the platform or the user's other positions.

| Feature | Cross Collateral | Isolated Pools |
| --- | --- | --- |
| Risk Sharing | Shared across all positions | Confined to a single pool |
| Account Health | Determined by total account collateral | Customized per pool |
| Liquidation Impact | All positions at risk if account health fails | Only the affected pool is liquidated |
| Margin Efficiency | High (collateral supports all positions) | Low (collateral is pool-specific) |
| Use Case | Suitable for traders/stakers managing multiple positions and want to optimise capital efficiency | Ideal for stakers/traders who are only focused on one position and containing risk to a limited set of tokens |

### Example - Cross Collateral Pool

Risk Management:

- Both positions rely on the same JLP collateral.
- If JLP's value drops significantly, both the SOL and USDC positions may face liquidation.

### Example - Isolated Pool

Risk Management:

- If JLP's price drops, only this pool's position is at risk of liquidation.
- Other pools or positions you hold remain unaffected. At the same time, you'll not be able to use the token deposited in isolated pool for other positions.
- Isolated pools can potentially offer higher LTV as the risk exposure is contained

### Supported Pools

| Pool | Assets |
| --- | --- |
| JLP Isolated Pool | JLP, USDC |

Last updated on February 27, 2026
