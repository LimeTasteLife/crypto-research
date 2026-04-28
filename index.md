# Index

Catalog of all wiki pages. Updated on every ingest. See [AGENTS.md](./AGENTS.md) for schema.

Format: `- [[path]] — one-line summary (sources: N, last_reviewed: YYYY-MM-DD)`

## Entities

### perpdex
- [[entities/perpdex/hyperliquid]] — fully on-chain CLOB perp+spot exchange on its own L1 (sources: 20, last_reviewed: 2026-04-28)
- [[entities/perpdex/lighter]] — ZK-rollup verifiable-execution perp DEX, two-track Standard/Premium account model, LIT-staking-gated discounts, LLP-backed liquidations (sources: 31, last_reviewed: 2026-04-28)

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

## Concepts

### market-structure
- [[concepts/market-structure/clob]] — central limit order book; price-time priority on shared per-asset book (sources: 2, last_reviewed: 2026-04-28)

### market-microstructure
- [[concepts/market-microstructure/oracle-spec]] — venue policy for external reference price feed (sources: 2, last_reviewed: 2026-04-28)
- [[concepts/market-microstructure/mark-price-formula]] — robust price for margining, liquidations, TP/SL, PnL (sources: 2, last_reviewed: 2026-04-28)
- [[concepts/market-microstructure/tick-size]] — minimum price increment per market (sources: 1, last_reviewed: 2026-04-28)
- [[concepts/market-microstructure/lot-size]] — minimum size increment per market (sources: 1, last_reviewed: 2026-04-28)
- [[concepts/market-microstructure/contract-size]] — units of underlying per perpetual contract (sources: 1, last_reviewed: 2026-04-28)

### fee-model
- [[concepts/fee-model/funding-rate]] — periodic peer-to-peer payment anchoring mark to spot (sources: 1, last_reviewed: 2026-04-28)

### tokenomics
- [[concepts/tokenomics/buyback]] — programmatic conversion of revenue into native token (sources: 1, last_reviewed: 2026-04-28)
- [[concepts/tokenomics/emission-schedule]] — rule for token mint/unlock over time (sources: 1, last_reviewed: 2026-04-28)
- [[concepts/tokenomics/fee-distribution]] — venue policy for where trading fees flow (sources: 1, last_reviewed: 2026-04-28)
- [[concepts/tokenomics/rev-share]] — recurring transfer of venue revenue to a beneficiary class (sources: 1, last_reviewed: 2026-04-28)

### operations
- [[concepts/operations/matching-engine]] — deterministic order-pairing process (sources: 2, last_reviewed: 2026-04-28)
- [[concepts/operations/sequencer]] — block transaction ordering component (sources: 4, last_reviewed: 2026-04-28)
- [[concepts/operations/settlement]] — finality stage for trades, transfers, bridging (sources: 3, last_reviewed: 2026-04-28)

### risk
- [[concepts/risk/liquidation]] — forced position closure when equity < maintenance margin (sources: 2, last_reviewed: 2026-04-28)
- [[concepts/risk/margin-tier]] — per-asset rule mapping notional to (IM, MM) (sources: 2, last_reviewed: 2026-04-28)
- [[concepts/risk/leverage-cap]] — per-asset upper bound on user-set leverage (sources: 2, last_reviewed: 2026-04-28)
- [[concepts/risk/adl-waterfall]] — final solvency safeguard via opposite-side counterparty closure (sources: 1, last_reviewed: 2026-04-28)

### lp
- [[concepts/lp/venue-owned-lp]] — venue-deployed liquidity vault (sources: 1, last_reviewed: 2026-04-28)

### listing
- [[concepts/listing/listing-playbook]] — venue procedure for getting a new asset live (sources: 3, last_reviewed: 2026-04-28)

### incentives
- [[concepts/incentives/referral-design]] — venue policy for referrer rewards and referred-user discounts (sources: 1, last_reviewed: 2026-04-28)

### mm-agreement
_(none yet)_

### metrics
- [[concepts/metrics/volume]] — notional traded over a window; basis for fee tier eligibility (sources: 3, last_reviewed: 2026-04-28)
- [[concepts/metrics/mm-uptime]] — fraction of time MM meets quote-obligation thresholds (sources: 1, last_reviewed: 2026-04-28)

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

Lighter (planned, Phase 2.2 will populate):
- [[parameters/lighter/fee-schedule]] — Standard zero-fee + Premium 8-tier LIT-staking ladder; LIT Fee Credits paid shortcut; integrator fee caps
- [[parameters/lighter/funding-config]] — hourly funding period; 0.01% IRC; ±0.05% small clamp; ±4% big clamp; per-minute random sampling
- [[parameters/lighter/funding-rate-rebates]] — 6% automatic Premium + 9% LIT-stake-scaled (capped at 50k LIT); 10% annualized cap
- [[parameters/lighter/oracle-config]] — Chainlink + Stork + Pyth index; mark = median(ImpactPrice, price1, price2); 8-min EMA; ±0.5% premium clamp
- [[parameters/lighter/margin-tiers]] — leverage tiers 50x / 25x / 20x / 15x / 10x / 8x / 5x / 3x with MMR ≈ 0.6·IMR, CMR ≈ 0.4·IMR
- [[parameters/lighter/listed-markets-roster]] — crypto + FX + RWA + prelaunch perps roster
- [[parameters/lighter/llp]] — single LLP account, multi-strategy collateral isolation; LIT-staking-gated deposits
- [[parameters/lighter/insurance-fund]] — LLP doubles as insurance fund; ADL fires on strategy depletion
- [[parameters/lighter/multi-asset-collateral]] — ETH-first roll-out; per-asset LTV / LT / LF; UTA-gated
- [[parameters/lighter/liquidation-params]] — partial-liquidation IoC at zero price; 1% max liquidation fee to LLP; prelaunch carve-out
- [[parameters/lighter/audit-history]] — Nethermind / Block / internal audit publication ledger
- [[parameters/lighter/bug-bounty]] — publicly signaled, page "Coming soon" as of 2026-04-28
- [[parameters/lighter/points-rules]] — Season 2: 200k retail/wk + 50k MM/wk; quality-favoring multipliers
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

### lighter-docs-2026-04-28 snapshot (31)
_(see sources/ — 31 lighter-docs-2026-04-28-* files)_
