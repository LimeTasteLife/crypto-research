# Index

Catalog of all wiki pages. Updated on every ingest. See [AGENTS.md](./AGENTS.md) for schema.

Format: `- [[path]] — one-line summary (sources: N, last_reviewed: YYYY-MM-DD)`

## Entities

### perpdex
- [[entities/perpdex/hyperliquid]] — fully on-chain CLOB perp+spot exchange on its own L1 (sources: 20, last_reviewed: 2026-04-28)
- [[entities/perpdex/lighter]] — ZK-rollup verifiable-execution perp DEX, two-track Standard/Premium account model, LIT-staking-gated discounts, LLP-backed liquidations (sources: 31, last_reviewed: 2026-04-28)

- [[entities/perpdex/orderly]] — headless omnichain CLOB perp infrastructure with multi-frontend builder model, OmniVault (Kronos Research), permissionless listing, VALOR staking (sources: 20, last_reviewed: 2026-04-28)
- [[entities/perpdex/aster]] — privacy-focused perp DEX on its own L1 with encrypted order flow; multi-product surface (Perps / Shield Mode / 1001x / Spot) and venue-owned ALP counterparty (sources: 20, last_reviewed: 2026-04-28, disputed: true)
- [[entities/perpdex/drift]] — Solana perp DEX with three-layer matching engine (JIT auctions → DLOB → backstop vAMM), cross-margined risk engine, multi-asset Insurance Fund hierarchy, three MM entry points (sources: 39, last_reviewed: 2026-04-28, disputed: true)
- [[entities/perpdex/dydx]] — fully decentralized perp DEX on sovereign Cosmos-SDK + CometBFT app-chain; 60-validator off-chain in-memory CLOB, MegaVault protocol-as-MM, permissionless listings via 10k USDC sub-vault (sources: 67, last_reviewed: 2026-04-28, disputed: true)

### dex
- [[entities/dex/uniswap-v4]] — hooks-extensible singleton AMM protocol (concentrated liquidity from v3); deployed across 16 mainnet chains; three fee layers (LP/protocol/hook); UNI governance + Firepit burn (sources: 16, last_reviewed: 2026-04-29)

### network
- [[entities/network/hyperliquid-l1]] — purpose-built PoS L1 with HyperBFT consensus; hosts HyperCore + HyperEVM (sources: 5, last_reviewed: 2026-04-28)
- [[entities/network/arbitrum]] — referenced as USDC deposit corridor for Hyperliquid (sources: 1, last_reviewed: 2026-04-28)
- [[entities/network/lighter-core]] — Lighter's custom ZK rollup with Ethereum-anchored DA + settlement and on-chain Escape Hatch (sources: 4, last_reviewed: 2026-04-28)
- [[entities/network/aster-chain]] — purpose-built L1 for privacy-focused perpetuals trading; advertises 100k+ TPS, 50ms block latency, and an encrypted-order pipeline that hides order content until execution (sources: 4, last_reviewed: 2026-04-28)
- [[entities/network/bnb-chain]] — EVM-compatible L1 (formerly BSC); referenced as Aster's primary execution venue for Earn products, USDF token + minting contracts, and one of two ALP mint chains (sources: 1, last_reviewed: 2026-04-28)
- [[entities/network/solana]] — high-throughput L1 (~400ms slot times, Tower BFT + PoH); hosts Drift Protocol as a native Solana program (sources: 2, last_reviewed: 2026-04-28)
- [[entities/network/dydx-chain]] — sovereign Cosmos-SDK + CometBFT PoS L1 purpose-built to run a perpetual DEX; 60-validator active set; genesis Oct 26, 2023 (sources: 3, last_reviewed: 2026-04-29)

### token
- [[entities/token/hype]] — Hyperliquid native token; staking, fee discount, AF burn endpoint (sources: 2, last_reviewed: 2026-04-28)
- [[entities/token/lit]] — Lighter native token; gates Premium fee discounts, LLP access, funding-rebate scaling; daily 24h TWAP buyback (sources: 4, last_reviewed: 2026-04-28)
- [[entities/token/aster]] — Aster's native governance + utility token (8B supply); drives 5% perp-fee discount, validator-PoS Base APY + veToken Loyalty Rewards, receives buybacks via Aster Foundation (sources: 4, last_reviewed: 2026-04-28)
- [[entities/token/usdf]] — Aster's yield-bearing stablecoin pegged 1:1 to USDT; used as 99.99%-ratio perp collateral in Multi-Asset Mode and as Trade & Earn reward asset (sources: 5, last_reviewed: 2026-04-28)
- [[entities/token/drift]] — Drift Protocol's governance + backstop token on Solana; fee-discount staking, Drift Safety Module backstop, governance (sources: 4, last_reviewed: 2026-04-28)
- [[entities/token/dydx]] — dYdX Chain's L1 native token for governance, staking, and 5-tier fee discount (25-50% off net positive trading fees); 75% of net protocol revenue routed to buyback (sources: 5, last_reviewed: 2026-04-29)

### actor
- [[entities/actor/cryptolearningclub]] — operates the VIP affiliate tier for dYdX via dYdX Grants; submits on-chain proposals to whitelist/remove VIPs (sources: 1, last_reviewed: 2026-04-29)
- [[entities/actor/dydx-foundation]] — independent foundation supporting the dYdX ecosystem; party to investor transfer-restriction agreements (sources: 1, last_reviewed: 2026-04-29)
- [[entities/actor/dydx-grants]] — dYdX's grants program; onboarded CryptoLearningClub to manage the VIP affiliate tier (sources: 1, last_reviewed: 2026-04-29)
- [[entities/actor/dydx-trading-inc]] — open-sourced the dYdX v4 software; does NOT run any of the protocol/Indexer/front-end components (sources: 2, last_reviewed: 2026-04-29)
- [[entities/actor/greave]] — elected MegaVault operator (Nov 21, 2024); authority to tune sub-vault parameters and reallocate capital (sources: 1, last_reviewed: 2026-04-29)
- [[entities/actor/informal-systems]] — audited the dYdX v4 Chain protocol; finalized reports in v4_chain audits folder (sources: 2, last_reviewed: 2026-04-29)
- [[entities/actor/skip-protocol]] — community-elected Market Map Updater for dYdX; co-built MEV-discrepancy dashboard with dYdX Trading (sources: 2, last_reviewed: 2026-04-29)

### mm-firm
_(none yet)_

### programme
- [[entities/programme/lighter-points-program]] — Two-track (retail + MM) discretionary weekly points; Season 2 active; implied 250k weekly pool (sources: 4, last_reviewed: 2026-04-28)
- [[entities/programme/lighter-liquidity-partner-program]] — Premium-only weekly maker-rebate pool; randomized ~1-min snapshots; per-symbol/bps/size cumulative-grid scoring; tiers/weights/pool published Mondays 17:00 UTC (sources: 1, last_reviewed: 2026-04-28)
- [[entities/programme/aster-referral]] — permissionless referral programme: 10% default commission on referee fees, splittable, plus 20% VIP1 / 10% VIP2+ affiliate tier by application; 365-day validity (sources: 1, last_reviewed: 2026-04-28)
- [[entities/programme/aster-trade-and-earn]] — yield-bearing-collateral incentive: USDF/asBNB Multi-Asset-Mode collateral retains underlying yield, plus weekly USDF Deposit + Trading reward streams (cap 100k USDF/account) (sources: 1, last_reviewed: 2026-04-28)
- [[entities/programme/dydx-affiliate-program]] — lifetime-commission affiliate model with VIP (≤50% taker, $10k/30d cap) and Standard (≤15% taker, $3k/30d cap) tiers; on-chain USDC payouts (sources: 1, last_reviewed: 2026-04-29)
- [[entities/programme/dydx-order-router-rev-share]] — governance-whitelisted revenue-share for third-party order routers; per-router share_ppm set via MsgSetOrderRouterRevShare (sources: 2, last_reviewed: 2026-04-29)
- [[entities/programme/dydx-surge]] — consolidated rewards program replacing protocol-level trading rewards; protocol-level Rewards Module C constant set to 0 (sources: 1, last_reviewed: 2026-04-29)

## Concepts

### market-structure
- [[concepts/market-structure/clob]] — central limit order book; price-time priority on shared per-asset book (sources: 2, last_reviewed: 2026-04-28)
- [[concepts/market-structure/amm]] — automated market maker; deterministic pricing function replaces order book (sources: 4, last_reviewed: 2026-04-29)
- [[concepts/market-structure/hybrid]] — combines two or more matching paradigms (e.g. CLOB + AMM, auction + orderbook) within a single venue, routing flow through a priority waterfall (sources: 1, last_reviewed: 2026-04-28)
- [[concepts/market-structure/vamm]] — virtual AMM using a bonding-curve formula (typically constant-product) for synthetic perp liquidity without physical token reserves; tracks virtual reserves + oracle peg (sources: 1, last_reviewed: 2026-04-28)

### market-microstructure
- [[concepts/market-microstructure/oracle-spec]] — venue policy for external reference price feed (sources: 2, last_reviewed: 2026-04-28)
- [[concepts/market-microstructure/mark-price-formula]] — robust price for margining, liquidations, TP/SL, PnL (sources: 2, last_reviewed: 2026-04-28)
- [[concepts/market-microstructure/tick-size]] — minimum price increment per market (sources: 1, last_reviewed: 2026-04-28)
- [[concepts/market-microstructure/lot-size]] — minimum size increment per market (sources: 1, last_reviewed: 2026-04-28)
- [[concepts/market-microstructure/contract-size]] — units of underlying per perpetual contract (sources: 1, last_reviewed: 2026-04-28)
- [[concepts/market-microstructure/jit-auction]] — Just-In-Time reverse Dutch auction triggered by an incoming taker order; gives MMs a brief window to compete on price before the order reaches the resting book (sources: 2, last_reviewed: 2026-04-28)

### fee-model
- [[concepts/fee-model/funding-rate]] — periodic peer-to-peer payment anchoring mark to spot (sources: 1, last_reviewed: 2026-04-28)
- [[concepts/fee-model/maker-rebate]] — negative maker fee paid by venue to passive liquidity (vs maker-fee, MM-agreement-rebate, volume-tier-discount); funding source, tier mechanics, markout-PIII gap, anti-abuse (sources: 17, last_reviewed: 2026-04-30)

### tokenomics
- [[concepts/tokenomics/buyback]] — programmatic conversion of revenue into native token; HL AF burn, Aster Foundation, Uniswap Firepit UNI burn (sources: 5, last_reviewed: 2026-04-29)
- [[concepts/tokenomics/emission-schedule]] — rule for token mint/unlock over time (sources: 1, last_reviewed: 2026-04-28)
- [[concepts/tokenomics/fee-distribution]] — venue policy for where trading fees flow; HL community-only, Aster ALP+buyback, Uniswap LP+protocol fee+hook fee (sources: 4, last_reviewed: 2026-04-29)
- [[concepts/tokenomics/rev-share]] — recurring transfer of venue revenue to a beneficiary class (sources: 1, last_reviewed: 2026-04-28)

### operations
- [[concepts/operations/insurance-fund]] — venue's capital reserve that absorbs losses when a liquidated position cannot be closed at or above the bankruptcy price; sits between book liquidation and ADL in the contract-loss waterfall (sources: 4, last_reviewed: 2026-04-29)
- [[concepts/operations/matching-engine]] — deterministic order-pairing process (sources: 2, last_reviewed: 2026-04-28)
- [[concepts/operations/oracle]] — component that brings off-chain reference prices into the on-chain trading engine; feeds mark-price, funding-rate, and liquidation triggers (sources: 3, last_reviewed: 2026-04-29)
- [[concepts/operations/sequencer]] — block transaction ordering component (sources: 4, last_reviewed: 2026-04-28)
- [[concepts/operations/settlement]] — finality stage for trades, transfers, bridging (sources: 3, last_reviewed: 2026-04-28)

### risk
- [[concepts/risk/liquidation]] — Forced-closure mechanism on under-margined positions; HL (book → HLP backstop → ADL) + Lighter (Healthy/Pre-Liq/Partial/Full/ADL waterfall, zero-price IoC, 1% overshoot fee, prelaunch carve-out, strategy-isolated ADL) (sources: 6, last_reviewed: 2026-04-28)
- [[concepts/risk/margin-tier]] — per-asset rule mapping notional to (IM, MM) (sources: 2, last_reviewed: 2026-04-28)
- [[concepts/risk/leverage-cap]] — per-asset upper bound on user-set leverage (sources: 2, last_reviewed: 2026-04-28)
- [[concepts/risk/adl-waterfall]] — final solvency safeguard via opposite-side counterparty closure (sources: 1, last_reviewed: 2026-04-28)
- [[concepts/risk/insurance-fund-sizing]] — mechanism by which a venue determines backstop-pool capital stock; topology, inflow source, outflow trigger, and sizing constraint dimensions (sources: 5, last_reviewed: 2026-04-29)
- [[concepts/risk/collateral]] — assets posted to secure positions; single vs multi-asset margin, haircut (LTV/LT/LF or assetWeight or flat ratio), isolated/cross/strict-isolated, per-asset capacity caps, LP-token-as-collateral, rehypothecation (sources: 17, last_reviewed: 2026-04-30)

### lp
- [[concepts/lp/concentrated-liquidity]] — LPs allocate capital within specific price ranges for capital efficiency; Uniswap v3 origin, v4 inherits + hooks extensibility (sources: 5, last_reviewed: 2026-04-29)
- [[concepts/lp/venue-owned-lp]] — venue-deployed liquidity vault (sources: 1, last_reviewed: 2026-04-28)
- [[concepts/lp/vault]] — Venue-owned/operated capital pools (protocol-MM, insurance, strategy-as-a-service); HL HLP, Lighter LLP (multi-strategy), Lighter XLP (prelaunch), Lighter Public Pools (no-lockup operator-strategy) (sources: 8, last_reviewed: 2026-04-28)
- [[concepts/lp/protocol-owned-liquidity]] — counterparty-role lens on protocol-owned vaults (vs external MM, vs open AMM LP); HLP, ALP, OmniVault, Drift IF/DSM/BAL, LLP, MegaVault — three role variants (protocol-MM, IF, hybrid), funding sources, eligibility, lockup, strategy isolation (sources: 17, last_reviewed: 2026-04-30)

### listing
- [[concepts/listing/listing-playbook]] — venue procedure for getting a new asset live (sources: 3, last_reviewed: 2026-04-28)
- [[concepts/listing/listing-criteria]] — venue's published prerequisites for adding a new perpetual market: oracle-source availability, liquidity depth, data history, and governance-approval requirements (sources: 4, last_reviewed: 2026-04-29)
- [[concepts/listing/delisting-policy]] — criteria, procedure, and settlement mechanics for removing a perp/spot market from a venue's active roster (sources: 1, last_reviewed: 2026-04-28)
- [[concepts/listing/pre-launch-perp]] — derivative on a token before official listing; mark price derived from pre-launch book or experimental pricing rather than spot oracle; elevated info-asymmetry + oracle-manipulation risk (sources: 2, last_reviewed: 2026-04-28)

### incentives
- [[concepts/incentives/referral-design]] — venue policy for referrer rewards and referred-user discounts (sources: 1, last_reviewed: 2026-04-28)
- [[concepts/incentives/points-program]] — Venue-issued credit ledgers tied to future-claim allocation; Lighter retail+MM two-track (200k+50k weekly), with HL/dYdX/Aevo placeholders TBD on next ingest (sources: 3, last_reviewed: 2026-04-28)
- [[concepts/incentives/anti-abuse]] — rules, detection, and enforcement actions a venue applies to prevent manipulation of incentive programs (wash trading, self-trading, fee farming, sybil splitting) (sources: 3, last_reviewed: 2026-04-28)
- [[concepts/incentives/sybil-resistance]] — mechanisms a venue uses to limit the advantage of operating multiple accounts: structural caps, declared multi-account thresholds, behavioral detection (sources: 2, last_reviewed: 2026-04-28)

### mm-agreement
- [[concepts/mm-agreement/quote-obligation]] — set of requirements (spread, depth, uptime, size) a market maker must meet to qualify for venue rebates, rewards, or formal partnership status (sources: 4, last_reviewed: 2026-04-28)

### metrics
- [[concepts/metrics/volume]] — notional traded over a window; basis for fee tier eligibility (sources: 3, last_reviewed: 2026-04-28)
- [[concepts/metrics/mm-uptime]] — fraction of time MM meets quote-obligation thresholds (sources: 1, last_reviewed: 2026-04-28)

### governance
- [[concepts/governance/parameter-mutation-cadence]] — frequency, lead-time, and process for changing risk parameters; live-tuning vs structural-change layering (sources: 13, last_reviewed: 2026-04-29)
- [[concepts/governance/veto-holders]] — actors with authority to block or roll back governance proposals; thresholds and historical use (sources: 2, last_reviewed: 2026-04-29)
- [[concepts/governance/emergency-pause-authority]] — who can halt trading without governance vote; trigger conditions and resumption SLA (sources: 9, last_reviewed: 2026-04-29)
- [[concepts/governance/governance-vs-ops-separation]] — boundary between governance-controlled and ops-controlled parameters; escalation paths (sources: 7, last_reviewed: 2026-04-29)

### security
- [[concepts/security/audit-cadence-and-scope]] — external audit frequency, scope coverage, publication policy, remediation tracking (sources: 7, last_reviewed: 2026-04-30)
- [[concepts/security/oracle-attack-history]] — documented oracle-layer manipulation incidents and remediation (sources: 4, last_reviewed: 2026-04-30)
- [[concepts/security/bug-bounty-program]] — public vulnerability disclosure scope, payout tiers, eligibility, disclosed findings (sources: 5, last_reviewed: 2026-04-30)
- [[concepts/security/incident-response-sla]] — MTTA, MTTR, downtime fee-credit policy, liquidation rollback window (sources: 4, last_reviewed: 2026-04-30)
- [[concepts/security/validator-mev-policy]] — validator/sequencer MEV rules, monitoring, slashing conditions (sources: 10, last_reviewed: 2026-04-30)

### regulatory
- [[concepts/regulatory/blocked-jurisdictions]] — jurisdictional bar list, sanctions/OFAC posture, and enforcement mechanism (protocol vs indexer vs integrator-frontend) (sources: 1, last_reviewed: 2026-04-30)
- [[concepts/regulatory/frontend-sovereignty]] — frontend-plurality topology and regulatory-liability allocation across canonical UI vs builder/partner UIs (sources: 7, last_reviewed: 2026-04-30)

## Parameters

### Venue-wide
- [[parameters/hyperliquid/fee-schedule]] — perp+spot tiers, staking discounts, maker rebate ladder (sources: 3, last_reviewed: 2026-04-28)
- [[parameters/hyperliquid/mm-rebate-tiers]] — three share-based rebate tiers (sources: 1, last_reviewed: 2026-04-28)
- [[parameters/hyperliquid/revenue-distribution]] — community-only direction; 0% team take (sources: 1, last_reviewed: 2026-04-28)
- [[parameters/hyperliquid/oracle-config]] — CEX source weights + validator stake-weighted median (sources: 1, last_reviewed: 2026-04-28)
- [[parameters/hyperliquid/funding-config]] — formulae, caps, sampling cadence (sources: 2, last_reviewed: 2026-04-28)
- [[parameters/hyperliquid/listed-markets-roster]] — aggregate spec; max-order-by-leverage tiers (sources: 2, last_reviewed: 2026-04-28)
- [[parameters/hyperliquid/validator-requirements]] — self-delegation, lockup, jailing, slashing (sources: 1, last_reviewed: 2026-04-28)
- [[parameters/hyperliquid/staking-rewards]] — sqrt-stake formula, daily distribution (sources: 1, last_reviewed: 2026-04-28)
- [[parameters/hyperliquid/hlp]] — pool-spec slot for the protocol vault (sources: 2, last_reviewed: 2026-04-28)

Lighter:
- [[parameters/lighter/fee-schedule]] — Standard zero-fee (300/200/200ms) + Premium 8-tier LIT-staking ladder (0→500k LIT, 0.0040%→0.0028% maker / 0.0280%→0.0196% taker / 200→140ms); LIT Fee Credits paid tier-elevator; integrator fee caps (10 bps perp / 1% spot); RWA Premium fees resumed 2026-04-15 14:30 UTC (sources: 7, last_reviewed: 2026-04-28)
- [[parameters/lighter/llp]] — single LLP account; multi-strategy collateral shards (Crypto Perps / FX / Equities-RWAs); RWAs migrated from XLP to LLP; LIT-staking-gated deposits (1 LIT → 10 USDC); LLP-as-MM points redistributed to external MMs (sources: 8, last_reviewed: 2026-04-28)
- [[parameters/lighter/points-rules]] — Season 2: 200k retail/wk + implied 50k MM/wk (250k total Disputed); MM volume formula `score = volume + max(0, (volume−2.5B)·0.25)`; ~6–10 bps×size liquidity metrics per market; daily 8.33% floor + 50% extreme-vol cap (sources: 4, last_reviewed: 2026-04-28)
- [[parameters/lighter/funding-rate-rebates]] — 6% automatic Premium + up to 9% LIT-stake-scaled (linear, capped at 50k LIT); 15% combined cap; 10% annualized cap; daily 00:00 UTC L2 transfers from `0xc4535…2772`; $1 minimum (sources: 1, last_reviewed: 2026-04-28)

Orderly:
- [[parameters/orderly/fee-schedule]] — two-layer base+custom fee; Builder Staking Programme 5 tiers; 0 bps maker all tiers (sources: 2, last_reviewed: 2026-04-28)
- [[parameters/orderly/funding-config]] — piecewise linear 3-slope funding; per-market cap/floor/interval; 15s premium sampling (sources: 1, last_reviewed: 2026-04-28)
- [[parameters/orderly/margin-tiers]] — IMR 4/5-power formula; Cross + Isolated; 100x/20x/10x/5x per-market (sources: 2, last_reviewed: 2026-04-28)
- [[parameters/orderly/liquidation-params]] — decentralized liquidator model; Low/High tiers; 0.60%/1.20% fee (sources: 1, last_reviewed: 2026-04-28)
- [[parameters/orderly/insurance-fund]] — platform IF + per-Builder isolated IFs ($50k/symbol minimum) (sources: 2, last_reviewed: 2026-04-28)
- [[parameters/orderly/listing-policy]] — standard + permissionless dual-path; Diamond Tier gate; POST_ONLY→ACTIVE launch (sources: 3, last_reviewed: 2026-04-28)
- [[parameters/orderly/oracle-config]] — CEX feeds + Pyth + Stork; all-unavailable → reduce-only (sources: 2, last_reviewed: 2026-04-28)
- [[parameters/orderly/omnivault]] — Kronos Research SP; 3h vault periods; up to 40% net revenue allocation (sources: 3, last_reviewed: 2026-04-28)
- [[parameters/orderly/tokenomics]] — 1B max supply; 55/15/20/10 allocation; VALOR staking; 30% daily buyback (sources: 4, last_reviewed: 2026-04-28)
- [[parameters/orderly/audits]] — Halborn, Zellic, Guardian Audits; 2 OmniVault audits (sources: 2, last_reviewed: 2026-04-28)
- [[parameters/orderly/contract-addresses]] — unified Vault; Orderly L2 contracts; 17 EVM + Solana; $ORDER token addresses (sources: 3, last_reviewed: 2026-04-28)
- [[parameters/orderly/multi-asset-collateral]] — Ethereum mainnet: USDC, USDT, YUSD, WBTC, USD1 (sources: 2, last_reviewed: 2026-04-28)
Uniswap v4:
- [[parameters/uniswap-v4/fee-architecture]] — three fee layers: LP swap fees (static/dynamic), protocol fees (governance), hook fees (BeforeSwapDelta) (sources: 4, last_reviewed: 2026-04-29)
- [[parameters/uniswap-v4/protocol-fee-config]] — UNIfication fee system: Fee Adapters → TokenJar → Firepit UNI burn; fee splits by version (sources: 5, last_reviewed: 2026-04-29)
- [[parameters/uniswap-v4/pool-creation-params]] — permissionless pool creation: token pair, fee tier, tick spacing, optional hook (sources: 5, last_reviewed: 2026-04-29)
- [[parameters/uniswap-v4/audits]] — 9 independent audits (Jul-Sep 2024), $15.5M Cantina bug bounty, $2.35M security competition (sources: 1, last_reviewed: 2026-04-29)
- [[parameters/uniswap-v4/governance-params]] — UNI governance via Timelock; immutable core contracts; hook allowlisting (sources: 6, last_reviewed: 2026-04-29)
- [[parameters/uniswap-v4/hook-security-framework]] — Uniswap Foundation public framework: 9 scoring dimensions (max 33), 3 risk tiers, 10 risk categories (sources: 1, last_reviewed: 2026-04-29)
- [[parameters/uniswap-v4/deployments]] — 16 mainnet + 6 testnet chain deployments (sources: 1, last_reviewed: 2026-04-29)

Aster:
- [[parameters/aster/alp]] — venue-owned LP token; protocol-as-MM counterparty across all perp pairs; multi-source NAV accrual; same architectural pattern as HLP/GLP (last_reviewed: 2026-04-28, disputed: true)
- [[parameters/aster/audits]] — 7 audit reports across 6 product surfaces (Vault, Earn, asBNB/asCAKE/asUSDF, USDF token+minting); firms: Salus Security, PeckShield, HALBORN; all dated 2024 Sep-Dec; Aster Chain L1 + perp matching engine NOT in scope (last_reviewed: 2026-04-28)
- [[parameters/aster/contract-addresses]] — multi-chain Treasury (BNB Chain, Ethereum, Solana, Arbitrum); USDF token + minting contracts on BNB Chain; ALP mintable on BNB Chain + Arbitrum (last_reviewed: 2026-04-28)
- [[parameters/aster/fee-schedule]] — two quote-asset rate cards: USDT-perps 0% maker / 0.04% taker; USD1-perps 0% maker / 0.005% taker; flat 5% $ASTER discount; fees on nominal value (last_reviewed: 2026-04-28, disputed: true)
- [[parameters/aster/funding-config]] — Binance-style funding `F = [P + clamp(IR−P, ±0.05%)] / (8/N)`; default 8h interval (ASTERUSDT 4h); IR=0.01% (BNBUSDT 0%); 5s premium sampling; impact-margin notional (last_reviewed: 2026-04-28)
- [[parameters/aster/listed-markets-roster]] — 250+ pairs spanning crypto, equity (AAPL/TSLA/NVDA/AMZN/META/GOOG/MSFT), and commodity perps; pre-launch contracts auto-convert to perps on token launch (last_reviewed: 2026-04-28)
- [[parameters/aster/listing-policy]] — pre-launch contract structure as expiry futures (sometimes perps); auto-conversion triggers on external listing OR tokenomics release at Aster's discretion (last_reviewed: 2026-04-28)
- [[parameters/aster/mm-rebate-tiers]] — three preferential MM tiers (rolling 14-day volume or maker-share); negative maker fees (rebates) and discounted taker fees scaling with tier (last_reviewed: 2026-04-28)
- [[parameters/aster/oracle-config]] — mark = median(Price1, Price2, ContractPrice); Price1 = funding-adjusted forward index; Price2 = index + 5min-MA local-book mid deviation (last_reviewed: 2026-04-28)
- [[parameters/aster/revenue-distribution]] — perp-fee revenue routes to $ASTER buybacks via Aster Foundation + governance-rewards distribution; funding is peer-to-peer (no protocol take) (last_reviewed: 2026-04-28)
- [[parameters/aster/staking-rewards]] — 450k $ASTER per weekly Epoch at launch (150k Base + 300k Loyalty); Base APY by validator tx-share; Loyalty weighted by veASTER × Trading Volume Boost (last_reviewed: 2026-04-28)
- [[parameters/aster/tokenomics]] — 8B total supply: Airdrop 53.5% / Ecosystem & Community 30% / Treasury 7% (locked) / Team 5% / Liquidity & Listings 4.5% (last_reviewed: 2026-04-28)
- [[parameters/aster/usdf-peg]] — three-mechanism peg defense: rigid 1:1 USDT redemption, third-party arbitrage on liquidity-pool deviations, delta-neutral hedging (last_reviewed: 2026-04-28)

Aster programmes:
- [[parameters/programmes/aster-referral]] — outcomes/KPIs: 10% default commission splittable; 20% VIP1 / 10% VIP2+ affiliate tier; 365-day validity; daily payout in fee asset; 1-2h display delay (last_reviewed: 2026-04-28)
- [[parameters/programmes/aster-trade-and-earn]] — outcomes/KPIs: USDF 99.99% / asBNB 95% collateral ratios; weekly USDF rewards capped 100k/account; ≥50k USD volume + ≥2 days/week activity gate (last_reviewed: 2026-04-28)

Drift:
- [[parameters/drift/audits]] — confirmed first-party audits: Trail of Bits (Nov-Dec 2022 + Jan 2023), Neodyme (May 2024, protocol-v2), OtterSec (Metamask Snap); ClawSecure 2026 citation NOT corroborated (last_reviewed: 2026-04-28, disputed: true)
- [[parameters/drift/fee-schedule]] — 6 tiers based on rolling on-chain 30-day volume from Tier 1 Rookie through VIP (last_reviewed: 2026-04-28)
- [[parameters/drift/funding-config]] — `funding_per_hour = 1/24 × (mark_twap − oracle_twap) / oracle_twap` (last_reviewed: 2026-04-28)
- [[parameters/drift/insurance-fund]] — multi-asset structure: separate USDC/BTC/ETH/SOL pools each covering same-denomination liabilities only (last_reviewed: 2026-04-28)
- [[parameters/drift/liquidation-params]] — partial liquidation with slot-based pacing (default 25 slots); accelerates against user, decelerates with price improvement (last_reviewed: 2026-04-28)
- [[parameters/drift/listed-markets-roster]] — 6 Contract Tier labels (A, B, C, Speculative, Highly Speculative, Isolated; docs say "five unique tiers" while listing six) (last_reviewed: 2026-04-28)
- [[parameters/drift/lp-shares]] — vAMM LP via lpShares: users LP into the vAMM as additional collateral; effective position transferred to AMM (last_reviewed: 2026-04-28)
- [[parameters/drift/mm-rebate-tiers]] — flat -0.25 bps maker rebate on non-BTC/ETH perps (AMM and User counterparty); `post only` flag required (last_reviewed: 2026-04-28)
- [[parameters/drift/oracle-config]] — Pyth default; Switchboard supported per market; custom internal Prelaunch oracle (mark-TWAP) for markets without external spot reference (last_reviewed: 2026-04-28)
- [[parameters/drift/referral-program]] — 35% of trading fees from referred users to referrer (no max cap on receivable rewards) (last_reviewed: 2026-04-28)
- [[parameters/drift/risk-parameters]] — 10% oracle-mark price band (relative to oracle's 5-minute TWAP) blocks orders on breach (last_reviewed: 2026-04-28)

dYdX v4:
- [[parameters/dydx-v4/account-limits]] — per-address subaccount cap 128,000 (raised from 127 in v5.0.0 to accommodate one-subaccount-per-isolated-market) (last_reviewed: 2026-04-29)
- [[parameters/dydx-v4/affiliate-program]] — lifetime-commission with VIP (≤50% taker, $10k/30d cap) + Standard (≤15%/$3k) tiers; on-chain USDC payouts (last_reviewed: 2026-04-29)
- [[parameters/dydx-v4/audits]] — dYdX Chain protocol audited by Informal Systems; finalized reports in v4_chain audits folder (last_reviewed: 2026-04-29)
- [[parameters/dydx-v4/compliance]] — blocked jurisdictions (USA, Canada, Iran, Cuba, North Korea, Syria, Myanmar, Crimea/Donetsk/Luhansk); OFAC-sanctioned parties prohibited (last_reviewed: 2026-04-29)
- [[parameters/dydx-v4/fee-schedule]] — 7 volume tiers by 30-day trailing volume (subaccounts + all markets combined); Tier 1 (<$1M): 5.0 bps taker / 1.0 bps maker (last_reviewed: 2026-04-29)
- [[parameters/dydx-v4/funding-config]] — funding-sample epoch 60s (min_num_votes_per_sample=15); funding-tick epoch 3,600s (averages 60 samples) (last_reviewed: 2026-04-29)
- [[parameters/dydx-v4/governance-params]] — CosmosSDK x/gov with 5 proposal types; vote weight = actively-staked DYDX (1:1); non-voting staker inherits validator vote (last_reviewed: 2026-04-29, disputed: true)
- [[parameters/dydx-v4/insurance-fund]] — single cross-margin IF + per-isolated-market segregated IF; receives 100% of liquidation penalty (default 1.5%) (last_reviewed: 2026-04-29)
- [[parameters/dydx-v4/liquidation-params]] — Maximum Liquidation Penalty 1.5% (default, governance-adjustable); 100% of fee to Insurance Fund; Fillable-price config matched against book (last_reviewed: 2026-04-29)
- [[parameters/dydx-v4/listed-markets-roster]] — both cross-margin and isolated-margin perps; PerpetualParams.market_type switch (CROSS default pre-v5.0.0 / ISOLATED) (last_reviewed: 2026-04-29)
- [[parameters/dydx-v4/listing-policy]] — Instant Market Listings (permissionless): 10k USDC deposit into MegaVault sub-vault; no governance vote; ~30-day fund lock (last_reviewed: 2026-04-29)
- [[parameters/dydx-v4/margin-tiers]] — 8 Liquidity Tiers (Large-Cap 0, Small-Cap 1, Long-Tail 2, Safety 3, Isolated 4, Mid-Cap 5, FX 6, IML 5x 7); per-tier IMF (may scale with OI) + fixed MMF (last_reviewed: 2026-04-29, disputed: true)
- [[parameters/dydx-v4/megavault]] — protocol-as-MM construct: USDC depositors fund automated AMM strategies across per-market sub-vaults; deposits = fractional ownership of vault net equity (last_reviewed: 2026-04-29)
- [[parameters/dydx-v4/oracle-config]] — Slinky validator-sidecar vote extensions; each validator pulls from external exchanges; proposer aggregates; in-consensus (last_reviewed: 2026-04-29)
- [[parameters/dydx-v4/order-router-rev-share]] — third-party routers earn maker + taker fee share via order_router_address; per-router share_ppm by governance (example: 500,000 ppm = 50%) (last_reviewed: 2026-04-29)
- [[parameters/dydx-v4/rate-limits]] — equity-tier-based open-order limits + per-block placement rate limits; governance-adjustable (last_reviewed: 2026-04-29)
- [[parameters/dydx-v4/revenue-distribution]] — Protocol Revenue Sharing introduced via dYdX Unlimited (Aug 12, 2024); net-revenue allocation adjustable via MsgUpdateUnconditionalRevShareConfig (last_reviewed: 2026-04-29)
- [[parameters/dydx-v4/staking-rewards]] — source: trading fees (USDC) + gas fees (USDC + DYDX); per-block accrual → distribution module → minus community_tax + validator_commission → stake-weighted distribution (last_reviewed: 2026-04-29)
- [[parameters/dydx-v4/tokenomics]] — 1B DYDX minted Aug 3, 2021; 5y vesting; 50% community / 27.7% past investors / 15.3% founders+employees / 7.0% future employees (last_reviewed: 2026-04-29)
- [[parameters/dydx-v4/trading-rewards-config]] — C-formula in code with C currently set to 0 (formula dormant; rewards consolidated under Surge Program) (last_reviewed: 2026-04-29, disputed: true)
- [[parameters/dydx-v4/upgrade-history]] — v5.0.0: Isolated Markets, subaccount cap 127→128k; v9: Designated Proposers + OEGS + TWAP order type (OrderFlags=128) (last_reviewed: 2026-04-29)
- [[parameters/dydx-v4/validator-requirements]] — max_validators 60; min_commission_rate 5% (last_reviewed: 2026-04-29, disputed: true)

Lighter (planned, future passes will populate):
- [[parameters/lighter/funding-config]] — hourly funding period; 0.01% IRC; ±0.05% small clamp; ±4% big clamp; per-minute random sampling
- [[parameters/lighter/oracle-config]] — Chainlink + Stork + Pyth index; mark = median(ImpactPrice, price1, price2); 8-min EMA; ±0.5% premium clamp
- [[parameters/lighter/margin-tiers]] — leverage tiers 50x / 25x / 20x / 15x / 10x / 8x / 5x / 3x with MMR ≈ 0.6·IMR, CMR ≈ 0.4·IMR
- [[parameters/lighter/listed-markets-roster]] — crypto + FX + RWA + prelaunch perps roster
- [[parameters/lighter/insurance-fund]] — LLP doubles as insurance fund; ADL fires on strategy depletion
- [[parameters/lighter/multi-asset-collateral]] — ETH-first roll-out; per-asset LTV / LT / LF; UTA-gated
- [[parameters/lighter/liquidation-params]] — partial-liquidation IoC at zero price; 1% max liquidation fee to LLP; prelaunch carve-out
- [[parameters/lighter/audit-history]] — Nethermind / Block / internal audit publication ledger
- [[parameters/lighter/bug-bounty]] — publicly signaled, page "Coming soon" as of 2026-04-28
- [[parameters/lighter/lp-program-tiers]] — weekly Google-sheet-published tiers; Premium-only eligibility; 50/50 bid/ask split

### Per-market (`parameters/<entity>/markets/<symbol>.md`)

Hyperliquid: _(none yet — primary docs provide aggregate spec only; per-symbol detail TBD)_

Lighter (planned, Phase 2.2 will populate):
- [[parameters/lighter/markets/BTC]] · [[parameters/lighter/markets/ETH]] · [[parameters/lighter/markets/SOL]] — flagship 50x / 25x crypto perps
- [[parameters/lighter/markets/XAU]] · [[parameters/lighter/markets/XAG]] — precious-metal RWA perps (15x / 10x)
- [[parameters/lighter/markets/WTI]] · [[parameters/lighter/markets/NATGAS]] · [[parameters/lighter/markets/BRENTOIL]] — energy RWA perps (5-day futures roll)

## Sources

### hl-docs-2026-04-27 snapshot (20)
- [[sources/hl-docs-2026-04-27-hyperliquid-docs]]
- [[sources/hl-docs-2026-04-27-about-hyperliquid]]
- [[sources/hl-docs-2026-04-27-onboarding-how-to-start-trading]]
- [[sources/hl-docs-2026-04-27-hypercore-overview]]
- [[sources/hl-docs-2026-04-27-hypercore-bridge]]
- [[sources/hl-docs-2026-04-27-hypercore-clearinghouse]]
- [[sources/hl-docs-2026-04-27-hypercore-oracle]]
- [[sources/hl-docs-2026-04-27-hypercore-order-book]]
- [[sources/hl-docs-2026-04-27-hypercore-staking]]
- [[sources/hl-docs-2026-04-27-hyperevm]]
- [[sources/hl-docs-2026-04-27-trading-fees]]
- [[sources/hl-docs-2026-04-27-trading-contract-specifications]]
- [[sources/hl-docs-2026-04-27-trading-margining]]
- [[sources/hl-docs-2026-04-27-trading-liquidations]]
- [[sources/hl-docs-2026-04-27-trading-funding]]
- [[sources/hl-docs-2026-04-27-trading-auto-deleveraging]]
- [[sources/hl-docs-2026-04-27-trading-robust-price-indices]]
- [[sources/hl-docs-2026-04-27-trading-order-types]]
- [[sources/hl-docs-2026-04-27-for-developers-api]]
- [[sources/hl-docs-2026-04-27-for-developers-api-info-endpoint]]

### orderly-docs-2026-04-29 snapshot (19)
_(see sources/ — 19 orderly-docs-2026-04-29-* files)_

### orderly-listing-2026-04-29 snapshot (1)
- [[sources/orderly-listing-2026-04-29-listing]]

### lighter-docs-2026-04-28 snapshot (31)
_(see sources/ — 31 lighter-docs-2026-04-28-* files)_

### aster-docs-2026-04-28 snapshot (20)
_(see sources/ — 20 aster-docs-2026-04-28-* files)_

### drift-docs-2026-04-28 snapshot (20)
_(see sources/ — 20 drift-docs-2026-04-28-* files)_

### drift-developers-2026-04-28 snapshot (45)
_(see sources/ — 45 drift-developers-2026-04-28-* files)_

### drift-sdk-2026-04-28 snapshot (62)
_(see sources/ — 62 drift-sdk-2026-04-28-* files)_

### drift-developers-docs-2026-04-28 snapshot (20, superseded by drift-developers-2026-04-28)
_(see sources/ — 20 drift-developers-docs-2026-04-28-* files)_

### drift-sdk-docs-2026-04-28 snapshot (20, superseded by drift-sdk-2026-04-28)
_(see sources/ — 20 drift-sdk-docs-2026-04-28-* files)_

### dydx-docs-2026-04-28 snapshot (26)
_(see sources/ — 26 dydx-docs-2026-04-28-* files)_

### dydx-community-2026-04-28 snapshot (21)
_(see sources/ — 21 dydx-community-2026-04-28-* files)_

### dydx-chain-tech-2026-04-28 snapshot (20)
_(see sources/ — 20 dydx-chain-tech-2026-04-28-* files)_

### uniswap-v4-contracts-2026-04-29 snapshot (11) + uniswap-v4-protocol-fee-2026-04-29 snapshot (5)
- [[sources/uniswap-v4-contracts-2026-04-29-overview]]
- [[sources/uniswap-v4-contracts-2026-04-29-concepts-architecture]]
- [[sources/uniswap-v4-contracts-2026-04-29-concepts-hooks]]
- [[sources/uniswap-v4-contracts-2026-04-29-concepts-flash-accounting]]
- [[sources/uniswap-v4-contracts-2026-04-29-concepts-poolmanager]]
- [[sources/uniswap-v4-contracts-2026-04-29-concepts-erc-6909]]
- [[sources/uniswap-v4-contracts-2026-04-29-concepts-subscribers]]
- [[sources/uniswap-v4-contracts-2026-04-29-concepts-v4-vs-v3]]
- [[sources/uniswap-v4-contracts-2026-04-29-concepts-hook-routing]]
- [[sources/uniswap-v4-contracts-2026-04-29-deployments]]
- [[sources/uniswap-v4-contracts-2026-04-29-security]]
- [[sources/uniswap-v4-contracts-2026-04-29-guides-custom-accounting]]
- [[sources/uniswap-v4-protocol-fee-2026-04-29-overview]]
- [[sources/uniswap-v4-protocol-fee-2026-04-29-concepts-fees]]
- [[sources/uniswap-v4-protocol-fee-2026-04-29-deployments]]
- [[sources/uniswap-v4-protocol-fee-2026-04-29-guides-getting-started]]
- [[sources/uniswap-v4-protocol-fee-2026-04-29-guides-best-practices]]
