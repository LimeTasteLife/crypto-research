# Index

Catalog of all wiki pages. Updated on every ingest. See [AGENTS.md](./AGENTS.md) for schema.

Format: `- [[path]] — one-line summary (sources: N, last_reviewed: YYYY-MM-DD)`

## Entities

### perpdex
- [[entities/perpdex/hyperliquid]] — fully on-chain CLOB perp+spot exchange on its own L1 (sources: 20, last_reviewed: 2026-04-28)

### network
- [[entities/network/hyperliquid-l1]] — purpose-built PoS L1 with HyperBFT consensus; hosts HyperCore + HyperEVM (sources: 5, last_reviewed: 2026-04-28)
- [[entities/network/arbitrum]] — referenced as USDC deposit corridor for Hyperliquid (sources: 1, last_reviewed: 2026-04-28)

### token
- [[entities/token/hype]] — Hyperliquid native token; staking, fee discount, AF burn endpoint (sources: 2, last_reviewed: 2026-04-28)

### actor
_(none yet)_

### mm-firm
_(none yet)_

### programme
_(none yet)_

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

### Per-market (`parameters/<entity>/markets/<symbol>.md`)
_(none yet — primary docs provide aggregate spec only; per-symbol detail TBD)_

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
