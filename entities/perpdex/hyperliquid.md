---
type: entity
subtype: perpdex
name: Hyperliquid
network: [[entities/network/hyperliquid-l1]]
status: live
launched: 2023-Q2
sources_count: 20
last_reviewed: 2026-04-28
disputed: false
---

# Hyperliquid

> A purpose-built layer-one blockchain whose state machine is a fully on-chain CLOB perp + spot exchange, secured by HyperBFT consensus.

## Snapshot
- Market structure: [[concepts/market-structure/clob]] (fully on-chain, no off-chain matching)
- Operator: Hyperliquid Foundation (governs validator set; team-funded)
- Native token: [[entities/token/hype]] (used for staking, fee discount, governance attribution)
- Network: [[entities/network/hyperliquid-l1]] (own L1; HyperBFT consensus; HyperCore + HyperEVM execution split)
- Bridge for USDC deposits: routed via [[entities/network/arbitrum]][^hl-docs-2026-04-27-onboarding-how-to-start-trading]

## Mechanism

Hyperliquid is a layer-one blockchain optimized from first principles for an on-chain financial system[^hl-docs-2026-04-27-hyperliquid-docs]. Execution is split into **HyperCore** — fully on-chain perpetual and spot order books with one-block finality — and **HyperEVM** — a general-purpose EVM execution layer secured by the same HyperBFT consensus[^hl-docs-2026-04-27-hyperliquid-docs][^hl-docs-2026-04-27-hyperevm].

**Consensus.** HyperBFT is a HotStuff-derived proof-of-stake algorithm where validator block production is weighted by staked HYPE[^hl-docs-2026-04-27-hyperliquid-docs][^hl-docs-2026-04-27-hypercore-overview]. HyperCore order/cancel/trade/liquidation events inherit one-block finality from HyperBFT[^hl-docs-2026-04-27-hyperliquid-docs].

**Throughput.** Mainnet capacity is approximately 200k orders/sec; the reported bottleneck is execution, not consensus or networking[^hl-docs-2026-04-27-hyperliquid-docs][^hl-docs-2026-04-27-hypercore-overview]. End-to-end latency from a co-located client is reported at 0.2s median / 0.9s p99[^hl-docs-2026-04-27-hypercore-overview].

**On-chain matching engine.** HyperCore holds margin and matching state on-chain — there is no off-chain order book[^hl-docs-2026-04-27-hypercore-overview]. A single consistent transaction order is produced by HyperBFT consensus[^hl-docs-2026-04-27-hypercore-overview].

**HyperEVM ↔ HyperCore.** HyperEVM contracts read HyperCore state via a read precompile and submit orders via a write system contract[^hl-docs-2026-04-27-hyperevm]. Spot assets deployed via permissionless auction can be linked to ERC-20s on HyperEVM with no bridging risk because both layers share unified state[^hl-docs-2026-04-27-hyperevm]. HyperEVM is currently in alpha; higher throughput and write system contracts are not yet live on mainnet[^hl-docs-2026-04-27-hyperevm].

**Liquidations and HLP.** Most liquidations are sent directly to the order book, allowing all users to compete for liquidation flow and letting the liquidated user keep any remaining margin (no clearance fee)[^hl-docs-2026-04-27-trading-liquidations]. Backstop liquidations (when account equity drops below 2/3 of maintenance margin) are taken over by the liquidator vault, a sub-strategy of [[parameters/hyperliquid/hlp]] — the protocol-as-MM vault[^hl-docs-2026-04-27-trading-liquidations]. Backstop-liquidation PnL flows entirely to the community via HLP[^hl-docs-2026-04-27-trading-liquidations]. See [[concepts/risk/liquidation]] for the full mechanism.

**Fees → community.** All trading fees are directed to the community: HLP, the Assistance Fund, and HIP-3/spot deployers — the team takes nothing[^hl-docs-2026-04-27-trading-fees]. The Assistance Fund (on-chain system address `0xfefefefefefefefefefefefefefefefefefefefe`) automatically converts trading fees into HYPE on-chain and burns it, permanently removing supply[^hl-docs-2026-04-27-trading-fees]. See [[parameters/hyperliquid/fee-schedule]] and [[parameters/hyperliquid/revenue-distribution]].

**Outcome tokens (testnet only).** Outcome tokens charge fees only on close/settle, not on opening positions[^hl-docs-2026-04-27-trading-fees].

**Stated principle: "no insiders".** The team commits that no party gets advance access or paid integration during alpha[^hl-docs-2026-04-27-hyperevm].

## Relations
- [[hyperliquid]] **implements** [[concepts/market-structure/clob]][^hl-docs-2026-04-27-hypercore-order-book]
- [[hyperliquid]] **runs_on** [[entities/network/hyperliquid-l1]][^hl-docs-2026-04-27-hyperliquid-docs]
- [[hyperliquid]] **lists** spot and perp markets via permissionless auction (HIP-1, HIP-3)[^hl-docs-2026-04-27-hyperevm]
- [[hyperliquid]] **distributes_to** [[entities/token/hype]] via Assistance Fund auto-buyback-and-burn[^hl-docs-2026-04-27-trading-fees]
- [[parameters/hyperliquid/hlp]] **seeds_liquidity_for** Hyperliquid markets and **backstops** liquidations[^hl-docs-2026-04-27-trading-liquidations]

## Parameters
- [[parameters/hyperliquid/fee-schedule]] — perps + spot fee tiers, staking discounts, maker rebate ladder
- [[parameters/hyperliquid/mm-rebate-tiers]] — three tiers based on share of 14d maker volume
- [[parameters/hyperliquid/revenue-distribution]] — community-only direction (HLP / Assistance Fund / deployers)
- [[parameters/hyperliquid/listed-markets-roster]] — perp contract specs across listed markets
- [[parameters/hyperliquid/oracle-config]] — validator-median oracle composition
- [[parameters/hyperliquid/funding-config]] — funding period, clamp, premium/interest formula
- [[parameters/hyperliquid/validator-requirements]] — self-delegation, lockup, commission rules
- [[parameters/hyperliquid/staking-rewards]] — sqrt(stake) reward formula, distribution cadence
- [[parameters/hyperliquid/hlp]] — protocol-owned market-making + liquidator vault

## Frame coverage
- A1/PI: filled — listing modality (permissionless auction for spot HIP-1; deployer-configurable HIP-3 perps); oracle composition at launch[^hl-docs-2026-04-27-hyperevm][^hl-docs-2026-04-27-trading-fees]
- A1/PII: gap — explicit pre-launch → live → delisting symmetry not documented at the schema/policy level in primary docs
- A1/PIII: not-applicable — pre-launch information-asymmetry controls are HIP-3-deployer-configurable, no protocol-level mechanism documented
- A1/PIV: filled — HIP-3 deployer share stacks with protocol fee[^hl-docs-2026-04-27-trading-fees]
- A1/PV: gap — listing playbook contract template not surfaced in docs
- A2/PI: filled — full fee schedule (perps tiers 0-6, spot tiers 0-6, staking discount tiers, maker rebate tiers); fees → community[^hl-docs-2026-04-27-trading-fees]
- A2/PII: gap — fee-cliff sunset / fee-change announce window not documented
- A2/PIII: filled — maker rebate tiered by 14d maker volume share[^hl-docs-2026-04-27-trading-fees]
- A2/PIV: filled — staking discount × volume tier × aligned-quote × stable-pair scaling all stack[^hl-docs-2026-04-27-trading-fees]
- A2/PV: not-applicable — no external counterparty SLA at fee layer
- A3/PI: gap — referral retention/quality KPIs not documented
- A3/PII: filled — referral cap ($1B reward / $25M discount per user) and attribution[^hl-docs-2026-04-27-trading-fees]
- A3/PIII: gap — toxic-flow markout segregation in referral attribution not documented
- A3/PIV: gap — multi-program stack accounting (referral × maker rebate × staking) not made explicit
- A3/PV: filled — staking-trading-link permanence + KYC ramp via spot deposit[^hl-docs-2026-04-27-trading-fees][^hl-docs-2026-04-27-for-developers-api-info-endpoint]
- A4/PI: filled — protocol-as-MM via HLP; mainnet ~200k orders/sec; co-located p99 0.9s[^hl-docs-2026-04-27-hypercore-overview][^hl-docs-2026-04-27-trading-liquidations]
- A4/PII: gap — MM orderly offboarding not documented at protocol level
- A4/PIII: filled — maker rebate ladder is markout-style penalty (negative fee scales with volume share)[^hl-docs-2026-04-27-trading-fees]
- A4/PIV: gap — protocol-MM (HLP) vs external-MM cannibalization not analyzed
- A4/PV: not-applicable — no external MM agreements documented (HLP is internal)
- A5/PI through A5/PV: not-applicable — no documented spot DEX LP layer in primary docs (spot trades are CLOB, not AMM-LP)
- A6/PI: filled — mark-price formula; margin tiers; ADL waterfall; funding clamp; insurance handled via HLP backstop[^hl-docs-2026-04-27-trading-liquidations][^hl-docs-2026-04-27-trading-margining][^hl-docs-2026-04-27-trading-funding]
- A6/PII: gap — pre-launch FDV bound check / delisting symmetry policy not surfaced
- A6/PIII: gap — IF coverage ratio computation not made explicit
- A6/PIV: gap — cross-asset correlation stress not surfaced
- A6/PV: not-applicable — no external SLA on risk parameters
- A7/PI: filled — validator epoch is 100k consensus rounds (~90 min); HyperEVM in alpha[^hl-docs-2026-04-27-hypercore-staking][^hl-docs-2026-04-27-hyperevm]
- A7/PII: filled — validator self-delegation drop → undelegate-only mode; 7d unstaking queue[^hl-docs-2026-04-27-hypercore-staking]
- A7/PIII: not-applicable — governance-flow toxicity is not a documented surface here
- A7/PIV: gap — governance vs ops authority separation not documented
- A7/PV: filled — validator commission ≤1% increase rule; 1y self-delegation lock[^hl-docs-2026-04-27-hypercore-staking]
- A8/PI: filled — one-block finality; double-sign slashing reserved; no automatic slashing yet[^hl-docs-2026-04-27-hyperliquid-docs][^hl-docs-2026-04-27-hypercore-staking]
- A8/PII: filled — validator jailing on inadequate latency; staking-trading link permanence creates security surface[^hl-docs-2026-04-27-hypercore-staking][^hl-docs-2026-04-27-trading-fees]
- A8/PIII: gap — adverse selection / oracle attack history not documented
- A8/PIV: gap — outage refund / downtime fee credit policy not documented
- A8/PV: filled — bridge withdrawal authority limited to validator quorum (2/3)[^hl-docs-2026-04-27-hypercore-bridge]
- A9/PI: gap — blocked-jurisdictions policy not documented in primary docs
- A9/PII: gap — onboarding KYC tier vs offboarding withdrawal restrictions not documented
- A9/PIII: not-applicable — adverse-selection accounting in regulatory layer not a documented surface
- A9/PIV: gap — frontend sovereignty (canonical vs builder-forkable) policy implicit but not documented
- A9/PV: filled — "no insiders" principle stated; testnet outcome tokens fee policy[^hl-docs-2026-04-27-hyperevm][^hl-docs-2026-04-27-trading-fees]

Coverage summary: filled 17 / not-applicable 11 / gap 17 = 45.

## Open questions
- Does Hyperliquid publish a delisting policy and FDV sanity bound for HIP-3 perps?
- What is the IF coverage ratio computation (HLP capital vs max OI × stress slippage)?
- What is the protocol-MM (HLP) vs builder-MM cannibalization expectation when builders deploy HIP-3 perps with their own market makers?

## Disputed claims
None at first ingest.

## Related
[[entities/network/hyperliquid-l1]] · [[entities/token/hype]] · [[concepts/market-structure/clob]] · [[concepts/risk/liquidation]] · [[parameters/hyperliquid/fee-schedule]] · [[parameters/hyperliquid/hlp]]

## Sources
[^hl-docs-2026-04-27-hyperliquid-docs]: [[sources/hl-docs-2026-04-27-hyperliquid-docs]]
[^hl-docs-2026-04-27-about-hyperliquid]: [[sources/hl-docs-2026-04-27-about-hyperliquid]]
[^hl-docs-2026-04-27-hypercore-overview]: [[sources/hl-docs-2026-04-27-hypercore-overview]]
[^hl-docs-2026-04-27-hypercore-clearinghouse]: [[sources/hl-docs-2026-04-27-hypercore-clearinghouse]]
[^hl-docs-2026-04-27-hypercore-bridge]: [[sources/hl-docs-2026-04-27-hypercore-bridge]]
[^hl-docs-2026-04-27-hypercore-oracle]: [[sources/hl-docs-2026-04-27-hypercore-oracle]]
[^hl-docs-2026-04-27-hypercore-order-book]: [[sources/hl-docs-2026-04-27-hypercore-order-book]]
[^hl-docs-2026-04-27-hypercore-staking]: [[sources/hl-docs-2026-04-27-hypercore-staking]]
[^hl-docs-2026-04-27-hyperevm]: [[sources/hl-docs-2026-04-27-hyperevm]]
[^hl-docs-2026-04-27-onboarding-how-to-start-trading]: [[sources/hl-docs-2026-04-27-onboarding-how-to-start-trading]]
[^hl-docs-2026-04-27-trading-fees]: [[sources/hl-docs-2026-04-27-trading-fees]]
[^hl-docs-2026-04-27-trading-liquidations]: [[sources/hl-docs-2026-04-27-trading-liquidations]]
[^hl-docs-2026-04-27-trading-margining]: [[sources/hl-docs-2026-04-27-trading-margining]]
[^hl-docs-2026-04-27-trading-funding]: [[sources/hl-docs-2026-04-27-trading-funding]]
[^hl-docs-2026-04-27-trading-order-types]: [[sources/hl-docs-2026-04-27-trading-order-types]]
[^hl-docs-2026-04-27-trading-contract-specifications]: [[sources/hl-docs-2026-04-27-trading-contract-specifications]]
[^hl-docs-2026-04-27-trading-auto-deleveraging]: [[sources/hl-docs-2026-04-27-trading-auto-deleveraging]]
[^hl-docs-2026-04-27-trading-robust-price-indices]: [[sources/hl-docs-2026-04-27-trading-robust-price-indices]]
[^hl-docs-2026-04-27-for-developers-api]: [[sources/hl-docs-2026-04-27-for-developers-api]]
[^hl-docs-2026-04-27-for-developers-api-info-endpoint]: [[sources/hl-docs-2026-04-27-for-developers-api-info-endpoint]]
