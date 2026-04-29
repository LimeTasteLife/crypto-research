---
type: parameter
entity: [[entities/dex/uniswap-v4]]
parameter: governance-params
unit: text
last_change: 2025-12-25
last_reviewed: 2026-04-29
disputed: false
---

# Uniswap v4 Governance Parameters

## Current (as of 2025-12-25)

### Governance authority

**UNI token governance** controls protocol fee parameters through the Uniswap Governance Timelock[^uniswap-v4-protocol-fee-2026-04-29-deployments]. Governance can[^uniswap-v4-protocol-fee-2026-04-29-overview]:
- Update which Releaser a TokenJar uses
- Adjust Fee Adapter configuration
- Set protocol fee rates (via `setFeeTo` on v2 factory, `setMerkleRoot` on V3FeeController)[^uniswap-v4-protocol-fee-2026-04-29-deployments]
- Appoint thresholdSetter for Firepit.threshold()[^uniswap-v4-protocol-fee-2026-04-29-guides-best-practices]

### Immutability

Core contracts are immutable[^uniswap-v4-protocol-fee-2026-04-29-overview]:
- **PoolManager** — cannot be upgraded or paused
- **TokenJar** — immutable; only active Releaser can withdraw[^uniswap-v4-protocol-fee-2026-04-29-overview]
- **Pool parameters** — token pair, fee tier, tick spacing, hook address are immutable after pool creation[^uniswap-v4-contracts-2026-04-29-concepts-poolmanager]

### Hook allowlisting

Hook allowlisting for Uniswap Interface routing requires an application form[^uniswap-v4-contracts-2026-04-29-concepts-hook-routing]. Current allowlisted hooks are publicly listed[^uniswap-v4-contracts-2026-04-29-concepts-hook-routing].

### Governance process (UNIfication)

UNIfication governance vote passed December 25, 2025 (125M+ votes vs 742 dissenting)[^uniswap-v4-protocol-fee-2026-04-29-concepts-fees]. Process: Snapshot (off-chain) → on-chain vote → 2-day Timelock → execution.

## Time series

| effective | change | source |
|-----------|--------|--------|
| 2025-12-25 | UNIfication passed; protocol fee contracts deployed; ownership to Governance Timelock | [^uniswap-v4-protocol-fee-2026-04-29-deployments] |

## Disputed values
None.

## Sources
[^uniswap-v4-contracts-2026-04-29-concepts-poolmanager]: [[sources/uniswap-v4-contracts-2026-04-29-concepts-poolmanager]]
[^uniswap-v4-contracts-2026-04-29-concepts-hook-routing]: [[sources/uniswap-v4-contracts-2026-04-29-concepts-hook-routing]]
[^uniswap-v4-protocol-fee-2026-04-29-overview]: [[sources/uniswap-v4-protocol-fee-2026-04-29-overview]]
[^uniswap-v4-protocol-fee-2026-04-29-deployments]: [[sources/uniswap-v4-protocol-fee-2026-04-29-deployments]]
[^uniswap-v4-protocol-fee-2026-04-29-guides-best-practices]: [[sources/uniswap-v4-protocol-fee-2026-04-29-guides-best-practices]]
[^uniswap-v4-protocol-fee-2026-04-29-concepts-fees]: [[sources/uniswap-v4-protocol-fee-2026-04-29-concepts-fees]]
