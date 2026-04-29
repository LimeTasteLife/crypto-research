# Index

Catalog of all wiki pages. Updated on every ingest. See [AGENTS.md](./AGENTS.md) for schema.

Format: `- [[path]] — one-line summary (sources: N, last_reviewed: YYYY-MM-DD)`

## Entities

### perpdex
- [[entities/perpdex/hyperliquid]] — fully on-chain CLOB perp+spot exchange on its own L1 (sources: 20, last_reviewed: 2026-04-28)
- [[entities/perpdex/lighter]] — ZK-rollup verifiable-execution perp DEX, two-track Standard/Premium account model, LIT-staking-gated discounts, LLP-backed liquidations (sources: 31, last_reviewed: 2026-04-28)

- [[entities/perpdex/orderly]] — headless omnichain CLOB perp infrastructure with multi-frontend builder model, OmniVault (Kronos Research), permissionless listing, VALOR staking (sources: 20, last_reviewed: 2026-04-28)

### dex
- [[entities/dex/uniswap-v4]] — hooks-extensible singleton AMM protocol (concentrated liquidity from v3); deployed across 16 mainnet chains; three fee layers (LP/protocol/hook); UNI governance + Firepit burn (sources: 16, last_reviewed: 2026-04-29)

### network
- [[entities/network/hyperliquid-l1]] — purpose-built PoS L1 with HyperBFT consensus; hosts HyperCore + HyperEVM (sources: 5, last_reviewed: 2026-04-28)
- [[entities/network/arbitrum]] — referenced as USDC deposit corridor for Hyperliquid (sources: 1, last_reviewed: 2026-04-28)
- [[entities/network/lighter-core]] — Lighter's custom ZK rollup with Ethereum-anchored DA + settlement and on-chain Escape Hatch (sources: 4, last_reviewed: 2026-04-28)

### token
- [[entities/token/hype]] — Hyperliquid native token; staking, fee discount, AF burn endpoint (sources: 2, last_reviewed: 2026-04-28)
- [[entities/token/lit]] — Lighter native token; gates Premium fee discounts, LLP access, funding-rebate scaling; daily 24h TWAP buyback (sources: 4, last_reviewed: 2026-04-28)

### actor
_(none yet)_

### mm-firm
_(none yet)_

### programme
- [[entities/programme/lighter-points-program]] — Two-track (retail + MM) discretionary weekly points; Season 2 active; implied 250k weekly pool (sources: 4, last_reviewed: 2026-04-28)
- [[entities/programme/lighter-liquidity-partner-program]] — Premium-only weekly maker-rebate pool; randomized ~1-min snapshots; per-symbol/bps/size cumulative-grid scoring; tiers/weights/pool published Mondays 17:00 UTC (sources: 1, last_reviewed: 2026-04-28)

## Concepts

### market-structure
- [[concepts/market-structure/clob]] — central limit order book; price-time priority on shared per-asset book (sources: 2, last_reviewed: 2026-04-28)
- [[concepts/market-structure/amm]] — automated market maker; deterministic pricing function replaces order book (sources: 4, last_reviewed: 2026-04-29)

### market-microstructure
- [[concepts/market-microstructure/oracle-spec]] — venue policy for external reference price feed (sources: 2, last_reviewed: 2026-04-28)
- [[concepts/market-microstructure/mark-price-formula]] — robust price for margining, liquidations, TP/SL, PnL (sources: 2, last_reviewed: 2026-04-28)
- [[concepts/market-microstructure/tick-size]] — minimum price increment per market (sources: 1, last_reviewed: 2026-04-28)
- [[concepts/market-microstructure/lot-size]] — minimum size increment per market (sources: 1, last_reviewed: 2026-04-28)
- [[concepts/market-microstructure/contract-size]] — units of underlying per perpetual contract (sources: 1, last_reviewed: 2026-04-28)

### fee-model
- [[concepts/fee-model/funding-rate]] — periodic peer-to-peer payment anchoring mark to spot (sources: 1, last_reviewed: 2026-04-28)

### tokenomics
- [[concepts/tokenomics/buyback]] — programmatic conversion of revenue into native token; HL AF burn, Aster Foundation, Uniswap Firepit UNI burn (sources: 5, last_reviewed: 2026-04-29)
- [[concepts/tokenomics/emission-schedule]] — rule for token mint/unlock over time (sources: 1, last_reviewed: 2026-04-28)
- [[concepts/tokenomics/fee-distribution]] — venue policy for where trading fees flow; HL community-only, Aster ALP+buyback, Uniswap LP+protocol fee+hook fee (sources: 4, last_reviewed: 2026-04-29)
- [[concepts/tokenomics/rev-share]] — recurring transfer of venue revenue to a beneficiary class (sources: 1, last_reviewed: 2026-04-28)

### operations
- [[concepts/operations/matching-engine]] — deterministic order-pairing process (sources: 2, last_reviewed: 2026-04-28)
- [[concepts/operations/sequencer]] — block transaction ordering component (sources: 4, last_reviewed: 2026-04-28)
- [[concepts/operations/settlement]] — finality stage for trades, transfers, bridging (sources: 3, last_reviewed: 2026-04-28)

### risk
- [[concepts/risk/liquidation]] — Forced-closure mechanism on under-margined positions; HL (book → HLP backstop → ADL) + Lighter (Healthy/Pre-Liq/Partial/Full/ADL waterfall, zero-price IoC, 1% overshoot fee, prelaunch carve-out, strategy-isolated ADL) (sources: 6, last_reviewed: 2026-04-28)
- [[concepts/risk/margin-tier]] — per-asset rule mapping notional to (IM, MM) (sources: 2, last_reviewed: 2026-04-28)
- [[concepts/risk/leverage-cap]] — per-asset upper bound on user-set leverage (sources: 2, last_reviewed: 2026-04-28)
- [[concepts/risk/adl-waterfall]] — final solvency safeguard via opposite-side counterparty closure (sources: 1, last_reviewed: 2026-04-28)

### lp
- [[concepts/lp/concentrated-liquidity]] — LPs allocate capital within specific price ranges for capital efficiency; Uniswap v3 origin, v4 inherits + hooks extensibility (sources: 5, last_reviewed: 2026-04-29)
- [[concepts/lp/venue-owned-lp]] — venue-deployed liquidity vault (sources: 1, last_reviewed: 2026-04-28)
- [[concepts/lp/vault]] — Venue-owned/operated capital pools (protocol-MM, insurance, strategy-as-a-service); HL HLP, Lighter LLP (multi-strategy), Lighter XLP (prelaunch), Lighter Public Pools (no-lockup operator-strategy) (sources: 8, last_reviewed: 2026-04-28) — NOTE: semantic overlap with `venue-owned-lp` above; consolidate via filename rename in follow-up commit

### listing
- [[concepts/listing/listing-playbook]] — venue procedure for getting a new asset live (sources: 3, last_reviewed: 2026-04-28)

### incentives
- [[concepts/incentives/referral-design]] — venue policy for referrer rewards and referred-user discounts (sources: 1, last_reviewed: 2026-04-28)
- [[concepts/incentives/points-program]] — Venue-issued credit ledgers tied to future-claim allocation; Lighter retail+MM two-track (200k+50k weekly), with HL/dYdX/Aevo placeholders TBD on next ingest (sources: 3, last_reviewed: 2026-04-28)

### mm-agreement
_(none yet)_

### metrics
- [[concepts/metrics/volume]] — notional traded over a window; basis for fee tier eligibility (sources: 3, last_reviewed: 2026-04-28)
- [[concepts/metrics/mm-uptime]] — fraction of time MM meets quote-obligation thresholds (sources: 1, last_reviewed: 2026-04-28)

### governance
- [[concepts/governance/parameter-mutation-cadence]] — frequency, lead-time, and process for changing risk parameters; live-tuning vs structural-change layering (sources: 0, last_reviewed: 2026-04-29) **[stub]**
- [[concepts/governance/veto-holders]] — actors with authority to block or roll back governance proposals; thresholds and historical use (sources: 0, last_reviewed: 2026-04-29) **[stub]**
- [[concepts/governance/emergency-pause-authority]] — who can halt trading without governance vote; trigger conditions and resumption SLA (sources: 0, last_reviewed: 2026-04-29) **[stub]**
- [[concepts/governance/governance-vs-ops-separation]] — boundary between governance-controlled and ops-controlled parameters; escalation paths (sources: 0, last_reviewed: 2026-04-29) **[stub]**

### security
- [[concepts/security/audit-cadence-and-scope]] — external audit frequency, scope coverage, publication policy, remediation tracking (sources: 0, last_reviewed: 2026-04-29) **[stub]**
- [[concepts/security/oracle-attack-history]] — documented oracle-layer manipulation incidents and remediation (sources: 0, last_reviewed: 2026-04-29) **[stub]**
- [[concepts/security/bug-bounty-program]] — public vulnerability disclosure scope, payout tiers, eligibility, disclosed findings (sources: 0, last_reviewed: 2026-04-29) **[stub]**
- [[concepts/security/incident-response-sla]] — MTTA, MTTR, downtime fee-credit policy, liquidation rollback window (sources: 0, last_reviewed: 2026-04-29) **[stub]**
- [[concepts/security/validator-mev-policy]] — validator/sequencer MEV rules, monitoring, slashing conditions (sources: 0, last_reviewed: 2026-04-29) **[stub]**

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
