---
type: parameter
entity: [[hyperliquid]]
parameter: staking-rewards
unit: percent / time
last_change: 2026-04-27
last_reviewed: 2026-04-28
disputed: false
---

# Hyperliquid staking rewards

## Current (as of 2026-04-27)

| field | value |
|---|---|
| reward formula | rate ∝ 1 / sqrt(total HYPE staked) (Ethereum-inspired)[^hl-docs-2026-04-27-hypercore-staking] |
| benchmark yield | ~2.37%/year at 400M HYPE staked[^hl-docs-2026-04-27-hypercore-staking] |
| accrual cadence | every minute[^hl-docs-2026-04-27-hypercore-staking] |
| distribution cadence | daily[^hl-docs-2026-04-27-hypercore-staking] |
| auto-redelegation | yes (compounds to staked validator)[^hl-docs-2026-04-27-hypercore-staking] |
| reward calculation basis | minimum delegated balance during each staking epoch (100k rounds)[^hl-docs-2026-04-27-hypercore-staking] |
| reward source | future emissions reserve[^hl-docs-2026-04-27-hypercore-staking] |

## Tiering rules / formulae

Reward yield per unit staked decreases as total stake grows — at higher participation, individual yield is lower but total network security is higher. The minimum-balance basis (rather than time-weighted-average) creates a small disincentive to repeatedly briefly under-delegate during an epoch.

## Time series

| effective  | yield benchmark | accrual / payout | basis | source |
|------------|------------------|-------------------|-------|--------|
| 2026-04-27 | ~2.37%/yr @ 400M staked | minute / daily | min epoch balance | [^hl-docs-2026-04-27-hypercore-staking] |

## Disputed values
None.

## Sources
[^hl-docs-2026-04-27-hypercore-staking]: [[sources/hl-docs-2026-04-27-hypercore-staking]]
