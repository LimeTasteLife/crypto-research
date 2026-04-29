---
type: parameter
entity: [[entities/dex/uniswap-v4]]
parameter: protocol-fee-config
unit: percent
last_change: 2025-12-25
last_reviewed: 2026-04-29
disputed: false
---

# Uniswap v4 Protocol Fee Configuration

## Current (as of 2025-12-25)

Protocol fees are a governance-configurable portion of swap fees redirected from LPs to protocol-controlled collection contracts[^uniswap-v4-protocol-fee-2026-04-29-concepts-fees]. The system collects fees from all Uniswap protocol versions (v2, v3, v4, UniswapX, Unichain) through version-specific Fee Adapter contracts, routing to a per-chain immutable TokenJar[^uniswap-v4-protocol-fee-2026-04-29-overview].

**Fee flow:** Protocol → Fee Adapter → TokenJar → Releaser[^uniswap-v4-protocol-fee-2026-04-29-overview]

**TokenJar:** Immutable per-chain contract; only the active Releaser can withdraw[^uniswap-v4-protocol-fee-2026-04-29-overview].

**Firepit Releaser:** Burns UNI to address(0xdead) in exchange for collected fee assets[^uniswap-v4-protocol-fee-2026-04-29-guides-getting-started]. Trigger: when top N assets in TokenJar exceed ~100 UNI in value, anyone calls `Firepit.release()`[^uniswap-v4-protocol-fee-2026-04-29-overview]. Nonce mechanism prevents front-running[^uniswap-v4-protocol-fee-2026-04-29-guides-best-practices]. `Firepit.threshold()` is updateable by governance-appointed thresholdSetter[^uniswap-v4-protocol-fee-2026-04-29-guides-best-practices].

**Deployed contracts (Ethereum mainnet):**
- TokenJar/AssetSink: `0xf38521f130fcCF29dB1961597bc5d2B60F995f85`[^uniswap-v4-protocol-fee-2026-04-29-deployments]
- Firepit Releaser: `0x0D5Cd355e2aBEB8fb1552F56c965B867346d6721`[^uniswap-v4-protocol-fee-2026-04-29-deployments]
- V3FeeAdapter: `0x5E74C9f42EEd283bFf3744fBD1889d398d40867d`[^uniswap-v4-protocol-fee-2026-04-29-deployments]

**Unichain:** Uses OptimismBridgedResourceFirepit for cross-chain fee relay[^uniswap-v4-protocol-fee-2026-04-29-deployments].

## Fee split table

| version | fee tier | LP fee | protocol fee | source |
|---------|----------|--------|--------------|--------|
| v2 | all pools | 0.25% | 0.05% | [^uniswap-v4-protocol-fee-2026-04-29-concepts-fees] |
| v3 | 0.01% | 0.0075% | 0.0025% | [^uniswap-v4-protocol-fee-2026-04-29-concepts-fees] |
| v3 | 0.05% | 0.0375% | 0.0125% | [^uniswap-v4-protocol-fee-2026-04-29-concepts-fees] |
| v3 | 0.30% | 0.25% | 0.05% | [^uniswap-v4-protocol-fee-2026-04-29-concepts-fees] |
| v3 | 1.00% | 0.8334% | 0.1666% | [^uniswap-v4-protocol-fee-2026-04-29-concepts-fees] |
| v4 | TBD | TBD | TBD | [^uniswap-v4-protocol-fee-2026-04-29-concepts-fees] |

## Time series

| effective | event | source |
|-----------|-------|--------|
| 2025-12-25 | UNIfication governance vote passed; protocol fees activated on all v2 pools and selected v3 pools | [^uniswap-v4-protocol-fee-2026-04-29-concepts-fees] |
| 2025-12-25 | Firepit + TokenJar + V3FeeAdapter deployed on Ethereum mainnet; ownership to Governance Timelock | [^uniswap-v4-protocol-fee-2026-04-29-deployments] |
| TBD | V4FeeAdapter deployment (work-in-progress as of 2026-04-29) | [^uniswap-v4-protocol-fee-2026-04-29-concepts-fees] |

## Operational notes

- v2 protocol fee enabled/disabled globally via `feeTo` on v2 factory (governance)[^uniswap-v4-protocol-fee-2026-04-29-concepts-fees]
- v3 fees: must be collected to AssetSink before release eligibility via `IV3FeeController.collect()`[^uniswap-v4-protocol-fee-2026-04-29-guides-best-practices]
- v2 fees: automatically pushed as ERC-20 LP tokens to AssetSink; underlying value requires pool-reserve math[^uniswap-v4-protocol-fee-2026-04-29-guides-best-practices]
- Protocol fee system can release native ETH; recipients must be payable[^uniswap-v4-protocol-fee-2026-04-29-guides-best-practices]
- UNI approval risk: max-approving to Firepit may lead to unexpected higher burn if threshold updated; mitigate with exact-amount approvals[^uniswap-v4-protocol-fee-2026-04-29-guides-best-practices]

## Disputed values
None.

## Sources
[^uniswap-v4-protocol-fee-2026-04-29-overview]: [[sources/uniswap-v4-protocol-fee-2026-04-29-overview]]
[^uniswap-v4-protocol-fee-2026-04-29-concepts-fees]: [[sources/uniswap-v4-protocol-fee-2026-04-29-concepts-fees]]
[^uniswap-v4-protocol-fee-2026-04-29-deployments]: [[sources/uniswap-v4-protocol-fee-2026-04-29-deployments]]
[^uniswap-v4-protocol-fee-2026-04-29-guides-getting-started]: [[sources/uniswap-v4-protocol-fee-2026-04-29-guides-getting-started]]
[^uniswap-v4-protocol-fee-2026-04-29-guides-best-practices]: [[sources/uniswap-v4-protocol-fee-2026-04-29-guides-best-practices]]
