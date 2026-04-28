---
type: parameter
entity: [[hyperliquid]]
parameter: revenue-distribution
unit: percent
last_change: 2026-04-27
last_reviewed: 2026-04-28
disputed: false
---

# Hyperliquid revenue distribution

## Current (as of 2026-04-27)

**Recipient classes:**
- HLP (community-owned vault, market making + liquidator backstop)
- Assistance Fund (auto-burn-via-buyback into HYPE)
- Spot and HIP-3 perp deployers (asset-specific fees)
- Team / insiders: **0%**

[^hl-docs-2026-04-27-trading-fees]

**Deployer take rule.** Spot and HIP-3 perp deployers may keep up to 50% of trading fees on their deployed assets[^hl-docs-2026-04-27-trading-fees].

## Tiering rules / formulae

For HIP-3 perps the deployer's chosen `deployerFeeScale` determines `deployerShare = deployerFeeScale / (1 + deployerFeeScale)` (when scale < 1) else 0.5[^hl-docs-2026-04-27-trading-fees]. See [[concepts/tokenomics/buyback]] for AF mechanics and [[parameters/hyperliquid/fee-schedule]] for full per-asset stack.

## Time series

| effective  | team take | community direction | deployer max | source |
|------------|-----------|----------------------|---------------|--------|
| 2026-04-27 | 0% | HLP + Assistance Fund + deployers[^hl-docs-2026-04-27-trading-fees] | 50%[^hl-docs-2026-04-27-trading-fees] | [^hl-docs-2026-04-27-trading-fees] |

## Disputed values
None.

## Sources
[^hl-docs-2026-04-27-trading-fees]: [[sources/hl-docs-2026-04-27-trading-fees]]
