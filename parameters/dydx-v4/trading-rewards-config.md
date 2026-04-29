---
type: parameter
entity: [[dydx]]
parameter: trading-rewards-config
unit: mixed
last_change: 2026-04-28
last_reviewed: 2026-04-29
disputed: true
---

# dYdX v4 trading-rewards-config

## Current (as of 2026-04-28)
- C-formula in code but C currently set to 0[^dydx-docs-2026-04-28-concepts-trading-rewards-trading-rewards][^dydx-docs-2026-04-28-concepts-trading-rewards]
- Taker formula: `taker_reward = taker_volume * (taker_fee_rate - max_maker_rebate - max_affiliate_taker_fee_share) * C * (1 - protocol_revenue_share_rate)`[^dydx-docs-2026-04-28-concepts-trading-rewards-trading-rewards]
- Maker formula: `maker_reward = maker_volume * positive_maker_fees * C * (1 - protocol_revenue_share_rate)`[^dydx-docs-2026-04-28-concepts-trading-rewards-trading-rewards]
- Global cap: 90% of fill's net trading fees per block[^dydx-docs-2026-04-28-concepts-trading-rewards-trading-rewards]
- Affiliate share: 0 if taker 30d volume > $50M, else 50% x taker_fee_rate[^dydx-docs-2026-04-28-concepts-trading-rewards-trading-rewards]
- Status disputed: community docs assert protocol-level rewards removed and consolidated under Surge Program[^dydx-community-2026-04-28-modules-trading-rewards]

## Time series

| effective | C_value | status | source |
|---|---|---|---|
| 2026-04-28 (docs.dydx.xyz) | 0 | formula present, C=0 | [^dydx-docs-2026-04-28-concepts-trading-rewards-trading-rewards] |
| 2026-04-28 (community docs) | N/A | removed; consolidated under Surge | [^dydx-community-2026-04-28-modules-trading-rewards] |

## Tiering rules / formulae
- Cap: 90% of fill's net trading fees per block[^dydx-docs-2026-04-28-concepts-trading-rewards-trading-rewards]
- Affiliate share netting: if 30d vol > $50M, affiliate_share = 0[^dydx-docs-2026-04-28-concepts-trading-rewards-trading-rewards]

## Disputed values

### #dispute-trading-rewards-status

**Claim A** . confidence: high . recency: 2026-04 . authority: high
  C-formula present in Rewards Module code; C currently = 0; traders get rebates directly[^dydx-docs-2026-04-28-concepts-trading-rewards-trading-rewards].

**Claim B** . confidence: high . recency: 2026-04 . authority: high
  Protocol-level trading rewards removed; consolidated under Surge Program[^dydx-community-2026-04-28-modules-trading-rewards].
  status: active

## Sources
[^dydx-docs-2026-04-28-concepts-trading-rewards-trading-rewards]: [[sources/dydx-docs-2026-04-28-concepts-trading-rewards-trading-rewards]]
[^dydx-docs-2026-04-28-concepts-trading-rewards]: [[sources/dydx-docs-2026-04-28-concepts-trading-rewards]]
[^dydx-community-2026-04-28-modules-trading-rewards]: [[sources/dydx-community-2026-04-28-modules-trading-rewards]]
