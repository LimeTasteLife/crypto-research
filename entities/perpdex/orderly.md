---
type: entity
subtype: perpdex
name: Orderly Network
network: null
status: live
launched: 2022
sources_count: 20
last_reviewed: 2026-04-28
disputed: false
---

# Orderly Network

> A headless omnichain CLOB perpetual futures infrastructure with shared liquidity, multi-frontend builder model, OmniVault (Kronos Research strategy vault), and permissionless market listing for Diamond Tier builders.

## Snapshot
- Market structure: shared [[concepts/market-structure/clob]] orderbook across all builder frontends[^orderly-docs-2026-04-29-what-is-orderly]
- Operator: Orderly team; multi-sig governance with signers having "deepest interest in success of Orderly"; incubated by WOO Network[^orderly-docs-2026-04-29-security]
- Native token: $ORDER (1B max supply; governance, VALOR staking, trading/MM reward boosts)[^orderly-docs-2026-04-29-overview-of-order]
- Settlement chain: Orderly L2 (chainID 291)[^orderly-docs-2026-04-29-addresses]
- Deposit chains: 16 EVM chains (Arbitrum, Optimism, Base, Mantle, Ethereum, SEI, Avalanche, Morph, Sonic, Story, Mode, Plume, Abstract, BNB Smart Chain, Monad) + Solana[^orderly-docs-2026-04-29-supported-chains]
- 90+ perpetual markets across crypto and RWA categories (equities, commodities, indices)[^orderly-docs-2026-04-29-margin-leverage-pnl]
- Multi-frontend builder model: builders integrate via APIs/SDKs or Orderly One; own frontend + user relationship; Orderly provides backend[^orderly-docs-2026-04-29-what-is-orderly]

## Mechanism

**Builder model.** Orderly is a headless omnichain trading infrastructure — builders launch branded trading experiences on top of shared liquidity via APIs, SDKs, UI components, or Orderly One (lower-code path)[^orderly-docs-2026-04-29-what-is-orderly][^orderly-docs-2026-04-29-builder-onboarding]. Builder setup takes ~3-5 business days after contacting Orderly[^orderly-docs-2026-04-29-builder-onboarding]. All builders connect to the same shared orderbook, so day-one liquidity is available without bootstrapping[^orderly-docs-2026-04-29-what-is-orderly].

**Two-layer fee structure.** Orderly charges a base fee to builders; builders set user-facing fees with the constraint that user fee >= base fee; builder keeps the margin[^orderly-docs-2026-04-29-trading-fees]. Base maker fee is 0.00 bps across all tiers[^orderly-docs-2026-04-29-trading-fees]. Base taker fees for crypto range from 3.00 bps (Public) to 1.00 bps (Diamond), and RWA from 5.00 bps to 3.00 bps, determined by the Builder Staking Programme — monthly volume or $ORDER staked[^orderly-docs-2026-04-29-trading-fees]. Builders can set custom per-user fee rates and receive daily rebates in their fee wallet after deducting referral rebates[^orderly-docs-2026-04-29-custom-fees]. Fees are charged in USDC after every trade and factored into the position's average entry price[^orderly-docs-2026-04-29-trading-fees].

**Margin and leverage.** IMR uses a position-size-dependent 4/5-power formula with per-market IMR Factors, and MMR scales proportionally[^orderly-docs-2026-04-29-margin-leverage-pnl]. Max leverage = 1 / Base IMR: BTC/ETH/SOL at 100x, SUI/HYPE and RWA perps at 20x, ARB/ORDER at 10x, IP at 5x[^orderly-docs-2026-04-29-margin-leverage-pnl]. Max notional: $5M for BTC/ETH, $2M for alts[^orderly-docs-2026-04-29-margin-leverage-pnl]. Two margin modes operate simultaneously: Cross (default, shared balance) and Isolated (per-position dedicated margin); mode specified per order, with independent leverage per symbol per mode[^orderly-docs-2026-04-29-isolated-margin].

**Liquidations.** Triggered when Account Margin Ratio falls below Maintenance Margin Ratio, evaluated against Mark Price[^orderly-docs-2026-04-29-liquidations]. Decentralized model: positions transferred to liquidators at a discount rather than dumped on orderbook; anyone with sufficient margin can liquidate[^orderly-docs-2026-04-29-liquidations]. Two liquidation tiers: Low (BTC/ETH, must claim proportional share) and High (others, can claim single symbol)[^orderly-docs-2026-04-29-liquidations]. Liquidation fees: BTC/ETH/SOL 0.60% total (0.30% to liquidator), others 1.20% total (0.60% to liquidator); fee split varies by remaining margin with IF as final absorber[^orderly-docs-2026-04-29-liquidations].

**Funding rate.** Uses a piecewise linear function with three slope regions (1x / 2x / 4x) applied to the average premium before clamping to per-market Cap/Floor values[^orderly-docs-2026-04-29-funding-rate]. Premium sampled every 15 seconds[^orderly-docs-2026-04-29-funding-rate]. Interest rate fixed at 0.01% for most markets[^orderly-docs-2026-04-29-funding-rate]. Per-market intervals: 1h, 4h, or 8h; BTC/ETH cap ±0.30%, SOL ±0.375%, most alts ±2.00%, RWA ±0.30%[^orderly-docs-2026-04-29-funding-rate]. In extreme conditions, Orderly may adjust these parameters[^orderly-docs-2026-04-29-funding-rate].

**Insurance Fund and ADL.** The IF absorbs bad debt, funded by liquidation fees[^orderly-docs-2026-04-29-insurance-fund-and-adl]. Key parameters: min_insurance_fund_margin_ratio and min_margin_ratio_solvency[^orderly-docs-2026-04-29-insurance-fund-and-adl]. ADL is the last resort: triggered when (1) liquidators don't take positions, (2) no IF claims for some time, (3) IF Margin Ratio falls below threshold; selects traders with most profit + highest leverage, market by market[^orderly-docs-2026-04-29-insurance-fund-and-adl]. Per-Builder IF isolation for permissionlessly listed markets with $50k minimum per active symbol; ADL scoped to that specific market only[^orderly-docs-2026-04-29-insurance-fund-and-adl].

**Permissionless listing.** Diamond Tier Builders ($10B monthly volume or 7M $ORDER staked) can self-list up to 5 perpetual markets[^orderly-docs-2026-04-29-permissionless-listing]. Each builder has a dedicated IF ($50k/symbol minimum), separate from platform IF[^orderly-docs-2026-04-29-permissionless-listing]. All community-listed markets are Isolated Margin only[^orderly-docs-2026-04-29-permissionless-listing]. Controlled launch: POST_ONLY → ACTIVE once ±2% depth reaches $100k for 10 minutes; circuit breakers (depth, IF, funding anomalies) → REDUCE_ONLY or delisting[^orderly-docs-2026-04-29-permissionless-listing]. Oracles: Pyth + Stork + CEX feeds[^orderly-docs-2026-04-29-permissionless-listing]. Multiple builders can list same underlying independently[^orderly-docs-2026-04-29-permissionless-listing]. Listing builders earn 50% of trading fees + 100% of liquidation fees[^orderly-docs-2026-04-29-trading-fees].

**Standard listing criteria.** Requires 3+ price oracles from supported CEX sources, $20M+ market cap, and own LP with ±2% depth ≥$20K, ≥15 levels, spread ≤50 bps, uptime ≥90%[^orderly-listing-2026-04-29-listing].

**OmniVault (protocol-as-MM).** Orderly's flagship strategy vault managed by Kronos Research as Strategy Provider[^orderly-docs-2026-04-29-omnivault-overview]. SPs execute market-making strategies on Orderly's orderbook and act as primary liquidator for selected symbols[^orderly-docs-2026-04-29-omnivault-mechanics]. Users deposit USDC from supported chains (Arbitrum, Base, Optimism, Sei) and earn proportional PnL share[^orderly-docs-2026-04-29-omnivault-overview]. Shares are non-tokenized, non-tradable; 3-hour vault periods (8/day)[^orderly-docs-2026-04-29-omnivault-mechanics]. Orderly allocates up to 40% of net protocol revenue and a portion of IF liquidation fees to OmniVault[^orderly-docs-2026-04-29-omnivault-mechanics]. OmniVault does NOT replace the insurance fund[^orderly-docs-2026-04-29-omnivault-mechanics]. Two independent audits completed on vault contracts[^orderly-docs-2026-04-29-omnivault-overview].

**Tokenomics.** $ORDER max supply 1B, ERC-20 on Ethereum and OFT via LayerZero[^orderly-docs-2026-04-29-distribution-and-emission-schedule]. Allocation: Community 55% (Airdrop 13.3%, Ecosystem Incentives 25%, Builder Rewards 8.35%, Future Launches 8.35%), Strategic Investors 15%, Team & Advisors 20%, Foundation 10%[^orderly-docs-2026-04-29-distribution-and-emission-schedule]. Emission over 200 epochs (~7 years); investor 6-month lock + 3.5-year vesting; team 1-year cliff + 3-year vesting[^orderly-docs-2026-04-29-distribution-and-emission-schedule]. Foundation goal: transfer full control to DAO[^orderly-docs-2026-04-29-distribution-and-emission-schedule].

**VALOR staking.** Staking $ORDER earns VALOR (non-transferable, deflationary, hard cap 1B); VALOR represents share of protocol treasury[^orderly-docs-2026-04-29-staking-information]. Treasury receives 30% of net fees daily, settled via $ORDER buyback at end of each epoch[^orderly-docs-2026-04-29-staking-information]. VALOR redeemable for esORDER (7-day wait, auto-staked)[^orderly-docs-2026-04-29-staking-information]. 7-day unstaking period with no VALOR accrual[^orderly-docs-2026-04-29-staking-information]. New system effective 4 November 2025[^orderly-docs-2026-04-29-staking-information].

**Listing referral bonus.** $2,000 fixed per successful project referral + 30% of project marketing budget (capped $10,000 total)[^orderly-listing-2026-04-29-listing]. This is a project-listing referral, not a trader referral program[^orderly-listing-2026-04-29-listing].

**Security.** Audited by Halborn, Zellic, Guardian Audits, and independent consultants; reports on GitHub[^orderly-docs-2026-04-29-security]. Two OmniVault audits completed[^orderly-docs-2026-04-29-omnivault-overview]. Incubated by WOO Network[^orderly-docs-2026-04-29-security].

**Multi-collateral.** Ethereum mainnet supports USDC, USDT, YUSD, WBTC, USD1 as deposit collateral[^orderly-docs-2026-04-29-addresses].

**Roadmap (2026 H1).** Planned features: Multi-Level Referral, Monthly Trading Competition, Expanded RWA Markets, Point Module, Permissionless Vault, Non-USDC Vault (ETH/BTC/LST), Performance Upgrade, Mobile SDK[^orderly-docs-2026-04-29-roadmap].

## Relations
- [[entities/perpdex/orderly]] **implements** [[concepts/market-structure/clob]] — shared CLOB orderbook across all builder frontends[^orderly-docs-2026-04-29-what-is-orderly]
- [[entities/perpdex/orderly]] **uses** Orderly L2 (chainID 291) as settlement chain[^orderly-docs-2026-04-29-addresses]
- [[entities/perpdex/orderly]] **distributes_to** $ORDER via 30% daily net-fee treasury buyback at end of each epoch[^orderly-docs-2026-04-29-staking-information]
- [[parameters/orderly/omnivault]] **seeds_liquidity_for** Orderly perp markets via Kronos Research market-making strategies[^orderly-docs-2026-04-29-omnivault-overview][^orderly-docs-2026-04-29-omnivault-mechanics]
- [[entities/perpdex/orderly]] **lists** 90+ perpetual markets across crypto, equity, commodity, and index categories[^orderly-docs-2026-04-29-margin-leverage-pnl]

## Parameters
- [[parameters/orderly/fee-schedule]] — two-layer base+custom fee; Builder Staking Programme 5 tiers (Public→Diamond); 0 bps maker across all tiers
- [[parameters/orderly/funding-config]] — piecewise linear 3-slope function; per-market cap/floor/interval; 15-second premium sampling
- [[parameters/orderly/margin-tiers]] — IMR 4/5-power formula; Cross + Isolated modes; 100x/20x/10x/5x per-market leverage
- [[parameters/orderly/liquidation-params]] — decentralized liquidator model; Low/High tiers; 0.60%/1.20% fee schedule; IF absorption
- [[parameters/orderly/insurance-fund]] — platform-shared IF + per-Builder isolated IFs ($50k/symbol minimum); ADL last resort
- [[parameters/orderly/listing-policy]] — standard (Orderly-approved, $20M mcap, 3+ oracles) + permissionless (Diamond Tier, POST_ONLY→ACTIVE launch)
- [[parameters/orderly/oracle-config]] — CEX feeds + Pyth + Stork; all-source-unavailable → reduce-only
- [[parameters/orderly/omnivault]] — Kronos Research SP; 3h vault periods; non-tokenized shares; up to 40% net revenue allocation
- [[parameters/orderly/tokenomics]] — 1B max supply; 55/15/20/10 allocation; VALOR staking; 30% net-fee daily buyback
- [[parameters/orderly/audits]] — Halborn, Zellic, Guardian Audits + independents; 2 OmniVault audits
- [[parameters/orderly/contract-addresses]] — unified Vault 0x816f…e9; Orderly L2 contracts; 17 EVM + Solana chains
- [[parameters/orderly/multi-asset-collateral]] — Ethereum mainnet: USDC, USDT, YUSD, WBTC, USD1

## Frame coverage
- A1/PI: filled — headless builder model; 90+ perp markets (crypto + RWA); permissionless listing (Diamond Tier $10B vol / 7M $ORDER); standard listing ($20M mcap, 3+ oracles, LP depth); supported chains 16 EVM + Solana
- A1/PII: filled — controlled launch POST_ONLY → ACTIVE (±2% depth $100k × 10min); circuit breakers → REDUCE_ONLY/delisting; low IF triggers delisting
- A1/PIII: gap — no documented info-asymmetry control during permissionless listing window; oracle composition for new listings relies on CEX feeds + Pyth/Stork but pre-listing price discovery mechanics not specified
- A1/PIV: filled — multiple builders can list same underlying independently (separate books, IFs, risk params); Builder Staking Programme volume includes Builder referrals
- A1/PV: gap — no formal listing playbook template or governance procedure for standard listings; Orderly "evaluates and approves" but approval authority (committee, multi-sig, criteria beyond $20M mcap) not documented
- A2/PI: filled — two-layer fee (base + custom); 5-tier Builder Staking Programme; 0 bps maker all tiers; crypto taker 3.00→1.00 bps; RWA taker 5.00→3.00 bps; daily builder rebates
- A2/PII: filled — 7-day unstaking period with no VALOR accrual; cancel-unstake restakes full amount; staking not allowed for locked team/investor tokens
- A2/PIII: gap — no markout-adjusted rebate or toxic-flow scoring documented; builder keeps fee margin but no adverse-selection accounting
- A2/PIV: filled — $ORDER staking gates both Builder Staking fee tiers and trading/MM reward boosts; VALOR treasury share + permissionless listing 50% fee / 100% liquidation fee revenue share
- A2/PV: not-applicable — fee schedule is a published rate card with discretionary modification; no external counterparty SLA on fee layer
- A3/PI: filled — listing referral bonus ($2,000 fixed + 30% marketing budget capped $10,000); planned Multi-Level Referral and Point Module (roadmap)
- A3/PII: gap — no documented trader referral program; listing referral termination/expiry conditions not specified
- A3/PIII: gap — no anti-abuse / sybil / wash-trade detection documented for referral or incentive programs
- A3/PIV: gap — interaction between listing referral bonus and builder fee revenue share not analyzed; planned Multi-Level Referral stacking not documented
- A3/PV: gap — no referral agreement terms, clawback, or dispute escalation documented
- A4/PI: filled — OmniVault as protocol-as-MM (Kronos Research SP); market-making + liquidator role; non-tokenized shares; 3h vault periods; Arbitrum/Base/Optimism/Sei deposit chains
- A4/PII: filled — planned Permissionless Vault (open to any strategist); roadmap also includes Non-USDC Vault (ETH/BTC/LST)
- A4/PIII: gap — no markout-adjusted rebate or toxic-flow accounting for OmniVault LP returns; no disclosure of MM concentration or strategy-level PnL attribution
- A4/PIV: filled — OmniVault receives up to 40% of net protocol revenue + portion of IF liquidation fees; does NOT replace IF; per-Builder MM accounts for community markets
- A4/PV: gap — no formal MM agreement or quote-obligation SLA; OmniVault terms are protocol parameters not counterparty contracts; per-Builder MM accounts have no documented SLA
- A5/PI: not-applicable — Orderly is perp-only at the protocol level; OmniVault is a strategy vault LP filed under A4, not a spot-AMM LP
- A5/PII: not-applicable — no spot DEX LP lifecycle; OmniVault deposit/withdrawal lifecycle covered under A4
- A5/PIII: not-applicable — no AMM LP; no IL/LVR surface; OmniVault adverse selection is strategy-vault risk filed under A4
- A5/PIV: not-applicable — no AMM-LP × orderbook-MM overlap; single orderbook-MM surface via OmniVault
- A5/PV: not-applicable — no spot LP SLA surface
- A6/PI: filled — IMR 4/5-power formula; MMR proportional scaling; max notional $5M BTC/ETH, $2M alts; decentralized liquidation; IF absorbs bad debt; ADL last resort; per-Builder IF isolation; piecewise linear funding
- A6/PII: filled — permissionless listing circuit breakers (depth/IF/funding → REDUCE_ONLY/delisting); all-oracle-unavailable → reduce-only mode
- A6/PIII: gap — IF coverage ratio (IF balance / max-OI × stress slippage) not published; live IF balance on-chain only
- A6/PIV: filled — multi-collateral on Ethereum (USDC/USDT/YUSD/WBTC/USD1); Cross + Isolated margin modes; per-Builder IF isolation prevents cascade
- A6/PV: not-applicable — risk parameters are unilateral protocol settings; no external SLA on risk layer
- A7/PI: filled — multi-sig governance; $ORDER staking grants future voting rights; Foundation goal: transfer to DAO; governance "being formalized"
- A7/PII: gap — no parameter-change lead time, announce window, or veto-holder set documented; governance formalization timeline absent
- A7/PIII: not-applicable — no governance-flow toxicity surface; governance authority is Foundation/multi-sig, not tokenholder vote-trading
- A7/PIV: gap — separation of governance vs operational authority not specified; who decides funding-cap changes, listing approval, OmniVault SP selection unclear
- A7/PV: filled — Orderly reserves discretion to adjust funding parameters in extreme conditions; unilateral parameter authority implied by multi-sig governance
- A8/PI: filled — auditors: Halborn, Zellic, Guardian Audits + independents; 2 OmniVault audits; reports on GitHub
- A8/PII: gap — no documented incident response history, outage remediation, or slashing policy
- A8/PIII: gap — no oracle-attack incident history; oracle fallback (all-unavailable → reduce-only) documented but stress-test results not published
- A8/PIV: gap — no outage refund / downtime fee-credit / position-stuck remediation policy documented
- A8/PV: gap — no bug bounty program found in primary docs; may exist in GitHub SECURITY.md (out of mirror scope)
- A9/PI: gap — no blocked-jurisdictions list, OFAC/sanctions screen, or KYC tier documentation in primary docs
- A9/PII: gap — frontend sovereignty: Orderly is permissionless infrastructure; regulatory exposure partly delegated to builder frontends; no formal framework for builder-vs-protocol regulatory boundary
- A9/PIII: not-applicable — regulatory adverse-selection (regulator-induced delisting) is not a documented surface
- A9/PIV: gap — stack-accounting across multiple builder frontends (which frontend bears regulatory liability?) not documented
- A9/PV: gap — no legal opinion, per-product classification (RWA perps, equity perps), or MiCA/SFC/MAS status documented

Coverage summary: filled 21 / not-applicable 8 / gap 16 = 45.

## Open questions
- Who approves standard listings at the Orderly protocol level? Docs show "Orderly evaluates and approves" but specific committee/multi-sig/governance process not documented.
- Does a trader referral program exist (separate from the listing referral bonus)? May not exist or may be builder-discretionary.
- What is OmniVault LP exit behavior under stress (if strategy at a loss, vault pause conditions, in-flight withdrawals during adverse PnL)?
- Does a bug bounty program exist? Not found in first-party docs; may be in GitHub SECURITY.md.
- What is the governance formalization timeline? Docs state "being formalized" with $ORDER staking granting future voting rights but no concrete proposal.

## Disputed claims
None.

## Related
[[concepts/market-structure/clob]] . [[concepts/fee-model/funding-rate]] . [[concepts/risk/liquidation]] . [[concepts/risk/adl-waterfall]] . [[concepts/risk/margin-tier]] . [[concepts/risk/leverage-cap]] . [[concepts/lp/vault]] . [[concepts/tokenomics/buyback]] . [[concepts/tokenomics/emission-schedule]] . [[concepts/tokenomics/fee-distribution]] . [[concepts/operations/settlement]] . [[concepts/listing/listing-playbook]] . [[concepts/incentives/referral-design]] . [[concepts/metrics/volume]]

## Sources
[^orderly-docs-2026-04-29-what-is-orderly]: [[sources/orderly-docs-2026-04-29-what-is-orderly]]
[^orderly-docs-2026-04-29-builder-onboarding]: [[sources/orderly-docs-2026-04-29-builder-onboarding]]
[^orderly-docs-2026-04-29-trading-fees]: [[sources/orderly-docs-2026-04-29-trading-fees]]
[^orderly-docs-2026-04-29-margin-leverage-pnl]: [[sources/orderly-docs-2026-04-29-margin-leverage-pnl]]
[^orderly-docs-2026-04-29-liquidations]: [[sources/orderly-docs-2026-04-29-liquidations]]
[^orderly-docs-2026-04-29-funding-rate]: [[sources/orderly-docs-2026-04-29-funding-rate]]
[^orderly-docs-2026-04-29-insurance-fund-and-adl]: [[sources/orderly-docs-2026-04-29-insurance-fund-and-adl]]
[^orderly-docs-2026-04-29-isolated-margin]: [[sources/orderly-docs-2026-04-29-isolated-margin]]
[^orderly-docs-2026-04-29-permissionless-listing]: [[sources/orderly-docs-2026-04-29-permissionless-listing]]
[^orderly-docs-2026-04-29-omnivault-overview]: [[sources/orderly-docs-2026-04-29-omnivault-overview]]
[^orderly-docs-2026-04-29-omnivault-mechanics]: [[sources/orderly-docs-2026-04-29-omnivault-mechanics]]
[^orderly-docs-2026-04-29-overview-of-order]: [[sources/orderly-docs-2026-04-29-overview-of-order]]
[^orderly-docs-2026-04-29-distribution-and-emission-schedule]: [[sources/orderly-docs-2026-04-29-distribution-and-emission-schedule]]
[^orderly-docs-2026-04-29-staking-information]: [[sources/orderly-docs-2026-04-29-staking-information]]
[^orderly-docs-2026-04-29-security]: [[sources/orderly-docs-2026-04-29-security]]
[^orderly-docs-2026-04-29-supported-chains]: [[sources/orderly-docs-2026-04-29-supported-chains]]
[^orderly-docs-2026-04-29-custom-fees]: [[sources/orderly-docs-2026-04-29-custom-fees]]
[^orderly-docs-2026-04-29-addresses]: [[sources/orderly-docs-2026-04-29-addresses]]
[^orderly-docs-2026-04-29-roadmap]: [[sources/orderly-docs-2026-04-29-roadmap]]
[^orderly-listing-2026-04-29-listing]: [[sources/orderly-listing-2026-04-29-listing]]
