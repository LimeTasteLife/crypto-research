---
type: parameter
entity: [[entities/dex/uniswap-v4]]
parameter: fee-architecture
unit: percent
last_change: 2025-12-25
last_reviewed: 2026-04-29
disputed: false
---

# Uniswap v4 Fee Architecture

## Current (as of 2025-12-25)

Uniswap v4 has three independent fee layers[^uniswap-v4-contracts-2026-04-29-concepts-architecture][^uniswap-v4-contracts-2026-04-29-guides-custom-accounting]:

1. **LP swap fees** — set at pool creation (static) or managed by hook logic (dynamic)[^uniswap-v4-contracts-2026-04-29-concepts-architecture]
   - Static fees: 0-100% in 0.0001% increments, immutable after pool creation
   - Dynamic fees: hook can update via `beforeSwap` return or `updateDynamicLPFee` at any frequency (per-swap, per-block, or arbitrary schedule)[^uniswap-v4-contracts-2026-04-29-concepts-architecture]
   - v4 fee accounting: accrued fees act as credit — increasing liquidity converts fees to liquidity, decreasing auto-withdraws unclaimed fees[^uniswap-v4-contracts-2026-04-29-concepts-v4-vs-v3]

2. **Protocol fees** — governance-controlled portion of swap fees redirected from LPs to TokenJar[^uniswap-v4-protocol-fee-2026-04-29-concepts-fees]
   - Currently active on v2+v3 (UNIfication, Dec 25 2025); V4FeeAdapter TBD[^uniswap-v4-protocol-fee-2026-04-29-concepts-fees]
   - v2: fixed at 1/6 of swap fee (0.05% of 0.30% total)[^uniswap-v4-protocol-fee-2026-04-29-concepts-fees]

3. **Hook fees** — entirely separate from pool fees and dynamic fees[^uniswap-v4-contracts-2026-04-29-guides-custom-accounting]
   - Implemented via `BeforeSwapDelta` in `beforeSwap` (or `afterSwap` for partial swap fees)[^uniswap-v4-contracts-2026-04-29-guides-custom-accounting]
   - Hook calculates fee, takes via `poolManager.take()`, returns delta to swap router[^uniswap-v4-contracts-2026-04-29-guides-custom-accounting]
   - Use cases: hook monetization, JIT withdrawal penalties, custom LP value distribution[^uniswap-v4-contracts-2026-04-29-guides-custom-accounting]

## Time series

| effective | layer | description | source |
|-----------|-------|-------------|--------|
| 2025-Q1 | LP swap fees | Static (0-100% in 0.0001% increments) or dynamic (hook-managed) per pool | [^uniswap-v4-contracts-2026-04-29-concepts-architecture] |
| 2025-Q1 | Hook fees | Separate fee layer via BeforeSwapDelta / afterSwap | [^uniswap-v4-contracts-2026-04-29-guides-custom-accounting] |
| 2025-12-25 | Protocol fees | UNIfication activated on v2+v3; v4 adapter TBD | [^uniswap-v4-protocol-fee-2026-04-29-concepts-fees] |

## Tiering rules / formulae

LP swap fees are per-pool, not tiered by user volume. Protocol fee split is governance-determined (currently 1/6 on v2). Hook fees are entirely hook-developer-defined with no protocol-level constraints.

## Disputed values
None.

## Sources
[^uniswap-v4-contracts-2026-04-29-concepts-architecture]: [[sources/uniswap-v4-contracts-2026-04-29-concepts-architecture]]
[^uniswap-v4-contracts-2026-04-29-concepts-v4-vs-v3]: [[sources/uniswap-v4-contracts-2026-04-29-concepts-v4-vs-v3]]
[^uniswap-v4-contracts-2026-04-29-guides-custom-accounting]: [[sources/uniswap-v4-contracts-2026-04-29-guides-custom-accounting]]
[^uniswap-v4-protocol-fee-2026-04-29-concepts-fees]: [[sources/uniswap-v4-protocol-fee-2026-04-29-concepts-fees]]
