---
type: parameter
entity: [[drift]]
parameter: referral-program
unit: percent
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: false
---

# Drift referral program

## Current (as of 2026-04-28)

**Referrer reward.** 35% of the trading fees from referred users (no max cap on receivable rewards)[^drift-docs-2026-04-28-protocol-rewards-referral-links].

**Referee discount.** 5% discount[^drift-docs-2026-04-28-protocol-rewards-referral-links].

**Volume basis.** Rewards accrue ONLY from taker volume[^drift-docs-2026-04-28-protocol-rewards-referral-links].

**Tier-3 sunset.** Referred users that reach Tier 3 and above (> $10M monthly volume) generate no referrer rewards or referee discount[^drift-docs-2026-04-28-protocol-rewards-referral-links].

**Attribution.** One-session: user must click, connect a wallet, and deposit within the same session; applies only to new Drift accounts[^drift-docs-2026-04-28-protocol-rewards-referral-links].

**Link rules.** User-customizable up to 32 characters; cannot be changed after first creation[^drift-docs-2026-04-28-protocol-rewards-referral-links].

### Drift Builder Codes (DBC)

**Scope.** Separate integrator revenue-share, layered on top of SWIFT orders ONLY (not standard onchain orders)[^drift-developers-docs-2026-04-28-developers-drift-sdk-builder-codes].

**Workflow.** Builder calls `initializeRevenueShare` (one-time); user creates `RevenueShareEscrow` account (recommend `numOrders >= 8`); user calls `changeApprovedBuilder(builderAuthority, maxFeeTenthBps, true)` to approve builder with max-fee cap[^drift-developers-docs-2026-04-28-developers-drift-sdk-builder-codes].

**Fee unit.** Tenths of a basis point: 100 = 10 bps, 200 = 20 bps[^drift-developers-docs-2026-04-28-developers-drift-sdk-builder-codes].

**Per-order injection.** Per-SWIFT-order, builder app injects `builderIdx` and `builderFeeTenthBps` into the signed message; fees auto-settle to builder's revenue-share account on fill[^drift-developers-docs-2026-04-28-developers-drift-sdk-builder-codes].

## Time series

| effective | referrer share | referee discount | volume basis | tier cap | source |
|---|---|---|---|---|---|
| 2026-04-28 | 35% | 5% | taker only | Tier 3 (>$10M) | [^drift-docs-2026-04-28-protocol-rewards-referral-links] |

## Disputed values
None.

## Sources
[^drift-docs-2026-04-28-protocol-rewards-referral-links]: [[sources/drift-docs-2026-04-28-protocol-rewards-referral-links]]
[^drift-developers-docs-2026-04-28-developers-drift-sdk-builder-codes]: [[sources/drift-developers-docs-2026-04-28-developers-drift-sdk-builder-codes]]
