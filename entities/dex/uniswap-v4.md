---
type: entity
subtype: dex
name: Uniswap v4
network: [[entities/network/ethereum]], [[entities/network/unichain]], [[entities/network/base]], [[entities/network/arbitrum]], [[entities/network/optimism]], +12 networks
status: live
launched: 2025-Q1
sources_count: 16
last_reviewed: 2026-04-29
disputed: false
---

# Uniswap v4

> Hooks-extensible singleton AMM protocol inheriting concentrated liquidity from v3, deployed across 16 mainnet chains.

## Subtype note

Uniswap v4 is filed under `dex` — not `perpdex`. It is a **DEX substrate**: a permissionless AMM protocol layer on which third-party hooks (including potential perpetual futures hooks) can be deployed. The perpdex investigation frame (A1-A9 x PI-PV) applies only transitively: if a perpetual futures hook is deployed on v4 pools, **that hook** would be the perpdex entity with its own `entities/perpdex/<hook-name>` page. Uniswap v4 itself provides the infrastructure substrate.

A new entity subtype `dex-substrate` has been proposed in [[open-questions]] to better capture protocols like Uniswap v4, Balancer v2, and Curve that serve as AMM/pool primitives on which higher-order DeFi products build.

## Snapshot
- Market structure: [[concepts/market-structure/amm]] (concentrated liquidity, hooks-extensible)[^uniswap-v4-contracts-2026-04-29-concepts-architecture]
- Operator: Uniswap Labs (core development); Uniswap Foundation (security framework, governance coordination)[^uniswap-v4-contracts-2026-04-29-security]
- Native token: [[entities/token/uni]] (governance, protocol fee burn via Firepit)[^uniswap-v4-protocol-fee-2026-04-29-overview]

## Mechanism

### Singleton Architecture
All pool state and operations are managed by a single `PoolManager.sol` contract (Singleton design), replacing v3's factory-per-pool model[^uniswap-v4-contracts-2026-04-29-concepts-architecture]. Pool creation is a state update rather than a contract deployment, significantly reducing gas costs[^uniswap-v4-contracts-2026-04-29-concepts-v4-vs-v3]. Each pool is associated with a unique PoolId; Pool.State contains current price, liquidity, tick bitmap, fee growth, and position information[^uniswap-v4-contracts-2026-04-29-concepts-poolmanager].

Three contract suites are deployed per chain: `@uniswap/v4-core`, `@uniswap/v4-periphery`, `@uniswap/universal-router`[^uniswap-v4-contracts-2026-04-29-deployments].

### Flash Accounting (EIP-1153)
Flash accounting leverages EIP-1153 transient storage to record balance changes as net deltas rather than executing intermediate token transfers[^uniswap-v4-contracts-2026-04-29-concepts-architecture]. Periphery contracts must `unlock` the PoolManager and implement `unlockCallback` to perform actions (swap, modifyLiquidity, donate, take, settle, mint, burn, sync)[^uniswap-v4-contracts-2026-04-29-concepts-flash-accounting]. For multi-hop swaps, any number of hops requires only two token transfers: input and output[^uniswap-v4-contracts-2026-04-29-concepts-flash-accounting]. Pool initialization can happen outside the unlock context[^uniswap-v4-contracts-2026-04-29-concepts-flash-accounting].

### Hooks System
Hooks are external smart contracts attached to pools that execute before and/or after: pool creation, liquidity add/remove, swap, and donation[^uniswap-v4-contracts-2026-04-29-concepts-architecture]. Each pool can have one hook, but a hook can serve infinite pools[^uniswap-v4-contracts-2026-04-29-concepts-hooks]. Hooks are optional and specified at pool creation[^uniswap-v4-contracts-2026-04-29-concepts-hooks]. Permissions are encoded in the hook contract's address[^uniswap-v4-contracts-2026-04-29-concepts-hooks]. Ten hook functions span four lifecycle stages: initialize (before/after), liquidity modification (before/after add, before/after remove), swap (before/after), donate (before/after)[^uniswap-v4-contracts-2026-04-29-concepts-hooks].

Use cases include: limit orders, custom oracles, fee management, automated liquidity management, derivative/synthetic asset platforms, yield farming, lending hooks[^uniswap-v4-contracts-2026-04-29-concepts-hooks]. Hooks can also implement custom curves that eject the concentrated liquidity model[^uniswap-v4-contracts-2026-04-29-guides-custom-accounting].

Hook routing via the Uniswap Interface is available through UniswapX filler integration; broader routing support will ramp up progressively[^uniswap-v4-contracts-2026-04-29-concepts-hook-routing]. Hook existence does not guarantee frontend routing[^uniswap-v4-contracts-2026-04-29-concepts-hooks].

### Three Fee Layers
1. **LP swap fees** — static (set at pool creation in 0.0001% increments, range 0-100%) or dynamic (hook-managed via beforeSwap return or updateDynamicLPFee, at any frequency)[^uniswap-v4-contracts-2026-04-29-concepts-architecture]
2. **Protocol fees** — governance-controlled portion redirected from LPs to TokenJar; currently active on v2+v3; v4 adapter TBD[^uniswap-v4-protocol-fee-2026-04-29-concepts-fees]
3. **Hook fees** — entirely separate from pool and dynamic fees; implemented via BeforeSwapDelta in beforeSwap or afterSwap[^uniswap-v4-contracts-2026-04-29-guides-custom-accounting]

v4 fee accounting: accrued fees act as credit when modifying liquidity — increasing position converts fees to liquidity, decreasing auto-withdraws unclaimed fees[^uniswap-v4-contracts-2026-04-29-concepts-v4-vs-v3]. A `salt` parameter distinguishes positions of the same range on the same pool[^uniswap-v4-contracts-2026-04-29-concepts-v4-vs-v3].

### ERC-6909 Token Claims
v4 uses ERC-6909 (minimal multi-token standard, simplified alternative to ERC-1155) for gas-efficient token claims within the PoolManager[^uniswap-v4-contracts-2026-04-29-concepts-erc-6909]. Users can leave tokens in PoolManager and receive ERC-6909 claim tokens; minting/burning has constant-size gas overhead with no external function calls[^uniswap-v4-contracts-2026-04-29-concepts-erc-6909]. Benefits high-frequency traders and MEV bots[^uniswap-v4-contracts-2026-04-29-concepts-erc-6909].

### Native ETH Support
v4 supports native token assets (Ether) without WETH9 wrapping, reducing gas costs for ETH swappers and liquidity providers[^uniswap-v4-contracts-2026-04-29-concepts-architecture][^uniswap-v4-contracts-2026-04-29-concepts-v4-vs-v3].

### Subscribers (Liquidity Mining)
Position owners can opt-in to subscriber contracts that receive notifications on: subscription, liquidity changes, transfer, unsubscription[^uniswap-v4-contracts-2026-04-29-concepts-subscribers]. This enables staking/liquidity-mining without transferring position ownership, unlike v3 which required ERC-721 transfer[^uniswap-v4-contracts-2026-04-29-concepts-subscribers][^uniswap-v4-contracts-2026-04-29-concepts-v4-vs-v3].

### Custom Accounting
Hooks can alter token amounts for swaps and liquidity modifications via return deltas, enabling: custom curves (ejecting concentrated liquidity), hook swap fees, liquidity withdrawal fees, native pricing bypass[^uniswap-v4-contracts-2026-04-29-concepts-architecture][^uniswap-v4-contracts-2026-04-29-guides-custom-accounting].

### Protocol Fee System (UNIfication)
UNIfication (governance vote passed Dec 25, 2025) activated protocol fees on v2+v3 mainnet[^uniswap-v4-protocol-fee-2026-04-29-concepts-fees]. Fee flow: protocol versions → Fee Adapters → per-chain TokenJar (immutable) → Releaser[^uniswap-v4-protocol-fee-2026-04-29-overview]. Primary releaser: Firepit, which burns UNI to address(0xdead) in exchange for collected fee assets[^uniswap-v4-protocol-fee-2026-04-29-guides-getting-started]. V4FeeAdapter status: TBD / work-in-progress as of 2026-04-29[^uniswap-v4-protocol-fee-2026-04-29-concepts-fees].

Firepit mechanics: when top N assets in TokenJar exceed ~100 UNI in value, anyone can call Firepit.release() to burn UNI and withdraw[^uniswap-v4-protocol-fee-2026-04-29-overview]. Nonce mechanism prevents front-running[^uniswap-v4-protocol-fee-2026-04-29-guides-best-practices]. Firepit.threshold() is updateable by governance-appointed thresholdSetter[^uniswap-v4-protocol-fee-2026-04-29-guides-best-practices].

### Governance
All protocol fee contract ownership transferred to Uniswap Governance Timelock[^uniswap-v4-protocol-fee-2026-04-29-deployments]. Governance can update Releaser selection, Fee Adapter configuration, and protocol fee rates[^uniswap-v4-protocol-fee-2026-04-29-overview]. Core contracts (PoolManager, TokenJar) are immutable[^uniswap-v4-protocol-fee-2026-04-29-overview]. Enabling new fee values requires governance vote (setFeeTo on v2 factory, setMerkleRoot on V3FeeController)[^uniswap-v4-protocol-fee-2026-04-29-deployments]. Hook allowlisting requires an application form[^uniswap-v4-contracts-2026-04-29-concepts-hook-routing].

### Security
Nine independent audits on v4 core and periphery contracts (OpenZeppelin, Certora, Trail of Bits, Spearbit, ABDK — July-September 2024)[^uniswap-v4-contracts-2026-04-29-overview]. $15.5M bug bounty on Cantina (launched November 2024)[^uniswap-v4-contracts-2026-04-29-overview]. Security framework by Uniswap Foundation provides hook risk scoring: 9 dimensions, 3 risk tiers (Low/Medium/High), with escalating audit/monitoring requirements[^uniswap-v4-contracts-2026-04-29-security].

## Parameters
- [[parameters/uniswap-v4/fee-architecture]]
- [[parameters/uniswap-v4/protocol-fee-config]]
- [[parameters/uniswap-v4/pool-creation-params]]
- [[parameters/uniswap-v4/audits]]
- [[parameters/uniswap-v4/governance-params]]
- [[parameters/uniswap-v4/hook-security-framework]]
- [[parameters/uniswap-v4/deployments]]

## Frame coverage

Uniswap v4 is a `dex` entity, not a `perpdex`. The perpdex 9x5 frame applies only from a substrate perspective. Most cells are not-applicable because the protocol does not directly implement perpdex-specific features — those are delegated to third-party hook contracts.

- A1/PI: not-applicable — pool creation is permissionless; no listing quality gate at protocol level
- A1/PII: not-applicable — no wind-down playbook for pools; pools are permissionless and perpetual
- A1/PIII: not-applicable — no information-asymmetry controls at protocol level; delegated to hooks
- A1/PIV: not-applicable — no incentive layers at pool creation level
- A1/PV: not-applicable — no SLA/contracting for pool creation
- A2/PI: filled — three fee layers documented (LP, protocol, hook) with fee split tables
- A2/PII: gap — V4FeeAdapter TBD; protocol fee wind-down/sunset not documented
- A2/PIII: not-applicable — no toxic-flow accounting at protocol level; delegated to hooks
- A2/PIV: not-applicable — no multi-layer incentive stacking at protocol fee level
- A2/PV: not-applicable — no SLA for fee collection
- A3/PI: not-applicable — no first-party referral/incentive program
- A3/PII: not-applicable — no referral program to wind down
- A3/PIII: not-applicable — no referral-related toxic flow
- A3/PIV: not-applicable — no referral incentive layers
- A3/PV: not-applicable — no referral agreement template
- A4/PI: not-applicable — no protocol-as-MM model; no formal MM program
- A4/PII: not-applicable — no MM onboarding/offboarding at protocol level
- A4/PIII: not-applicable — no MM toxic flow accounting at protocol level
- A4/PIV: not-applicable — no MM incentive overlap
- A4/PV: not-applicable — no MM agreement template
- A5/PI: filled — LP mechanics well-documented (concentrated liquidity, dynamic fees, custom accounting)
- A5/PII: not-applicable — no pair retirement playbook at protocol level; pools are permissionless
- A5/PIII: gap — JIT/sandwich defense not documented at protocol level; hook-implementable
- A5/PIV: not-applicable — no AMM-LP x orderbook-MM overlap (pure AMM)
- A5/PV: not-applicable — no LP onboarding terms/SLA
- A6/PI: gap — no insurance fund, ADL, or liquidation engine (perpdex concerns delegated to hooks)
- A6/PII: not-applicable — no risk-param wind-down; pools are immutable after creation
- A6/PIII: not-applicable — no toxic-flow risk at protocol level
- A6/PIV: not-applicable — no risk-incentive overlap
- A6/PV: not-applicable — no risk SLA
- A7/PI: filled — governance controls protocol fee parameters via Timelock; core contracts immutable
- A7/PII: gap — emergency-pause SLA not documented
- A7/PIII: not-applicable — no governance toxic flow
- A7/PIV: not-applicable — no governance-ops authority overlap documented
- A7/PV: not-applicable — no governance SLA template
- A8/PI: filled — 9 audits, $15.5M bug bounty, security framework with risk scoring
- A8/PII: not-applicable — no incident retro process documented at protocol level
- A8/PIII: not-applicable — no security toxic flow
- A8/PIV: not-applicable — no security incentive overlap
- A8/PV: gap — bug bounty scope boundary between core and hooks not fully documented
- A9/PI: gap — no regulatory classification documented
- A9/PII: not-applicable — no regulatory wind-down
- A9/PIII: not-applicable — no regulatory toxic flow
- A9/PIV: not-applicable — no regulatory incentive overlap
- A9/PV: gap — no legal opinion on DEX substrate classification

Summary: filled 4 / not-applicable 34 / gap 7 = 45

## Open questions

- V4FeeAdapter activation status and timeline (when will v4 protocol fees go live?). See [[open-questions]].
- Protocol fee rate for v4 pools (will it be 1/6 like v2, or different?). See [[open-questions]].
- Perpdex hook inventory on v4 mainnet (which perpetual futures hooks are deployed?). See [[open-questions]].

## Disputed claims
None.

## Related
[[concepts/market-structure/amm]] · [[concepts/lp/concentrated-liquidity]] · [[concepts/tokenomics/buyback]] · [[concepts/tokenomics/fee-distribution]] · [[entities/token/uni]]

## Sources
[^uniswap-v4-contracts-2026-04-29-overview]: [[sources/uniswap-v4-contracts-2026-04-29-overview]]
[^uniswap-v4-contracts-2026-04-29-concepts-architecture]: [[sources/uniswap-v4-contracts-2026-04-29-concepts-architecture]]
[^uniswap-v4-contracts-2026-04-29-concepts-hooks]: [[sources/uniswap-v4-contracts-2026-04-29-concepts-hooks]]
[^uniswap-v4-contracts-2026-04-29-concepts-flash-accounting]: [[sources/uniswap-v4-contracts-2026-04-29-concepts-flash-accounting]]
[^uniswap-v4-contracts-2026-04-29-concepts-poolmanager]: [[sources/uniswap-v4-contracts-2026-04-29-concepts-poolmanager]]
[^uniswap-v4-contracts-2026-04-29-concepts-erc-6909]: [[sources/uniswap-v4-contracts-2026-04-29-concepts-erc-6909]]
[^uniswap-v4-contracts-2026-04-29-concepts-subscribers]: [[sources/uniswap-v4-contracts-2026-04-29-concepts-subscribers]]
[^uniswap-v4-contracts-2026-04-29-concepts-v4-vs-v3]: [[sources/uniswap-v4-contracts-2026-04-29-concepts-v4-vs-v3]]
[^uniswap-v4-contracts-2026-04-29-concepts-hook-routing]: [[sources/uniswap-v4-contracts-2026-04-29-concepts-hook-routing]]
[^uniswap-v4-contracts-2026-04-29-deployments]: [[sources/uniswap-v4-contracts-2026-04-29-deployments]]
[^uniswap-v4-contracts-2026-04-29-security]: [[sources/uniswap-v4-contracts-2026-04-29-security]]
[^uniswap-v4-contracts-2026-04-29-guides-custom-accounting]: [[sources/uniswap-v4-contracts-2026-04-29-guides-custom-accounting]]
[^uniswap-v4-protocol-fee-2026-04-29-overview]: [[sources/uniswap-v4-protocol-fee-2026-04-29-overview]]
[^uniswap-v4-protocol-fee-2026-04-29-concepts-fees]: [[sources/uniswap-v4-protocol-fee-2026-04-29-concepts-fees]]
[^uniswap-v4-protocol-fee-2026-04-29-deployments]: [[sources/uniswap-v4-protocol-fee-2026-04-29-deployments]]
[^uniswap-v4-protocol-fee-2026-04-29-guides-getting-started]: [[sources/uniswap-v4-protocol-fee-2026-04-29-guides-getting-started]]
[^uniswap-v4-protocol-fee-2026-04-29-guides-best-practices]: [[sources/uniswap-v4-protocol-fee-2026-04-29-guides-best-practices]]
