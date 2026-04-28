---
type: entity
subtype: perpdex
name: Lighter
network: [[entities/network/lighter-core]]
status: live
launched: unknown
sources_count: 30
last_reviewed: 2026-04-28
disputed: true
---

# Lighter

> A ZK-rollup verifiable-execution perp DEX with a two-track Standard/Premium account model, LIT-staking-gated discounts, and an LLP-backed liquidation waterfall.

## Snapshot
- Market structure: [[concepts/market-structure/clob]] (verifiable order matching with SNARK-proven price-time priority)[^lighter-docs-2026-04-28-trading-order-types-and-matching]
- Operator: Lighter team / Lighter Governance (parameter-mutation discretion across markets, points program, LP program)[^lighter-docs-2026-04-28-trading-contract-specifications][^lighter-docs-2026-04-28-points-program][^lighter-docs-2026-04-28-liquidity-partner-program]
- Native token: [[entities/token/lit]] (gates fee discounts, latency improvements, LLP access, funding-rate rebates)[^lighter-docs-2026-04-28-about-lighter-lit-utility][^lighter-docs-2026-04-28-trading-trading-fees][^lighter-docs-2026-04-28-trading-funding-funding-rate-rebates]
- Network: [[entities/network/lighter-core]] (custom ZK-rollup; Ethereum as DA + settlement; SNARK-aggregated proofs)[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]
- Settlement bridge: Ethereum L1 contracts hold deposits and the canonical state root; Escape Hatch fallback enables permissionless withdrawal[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]
- App entry points: app.lighter.xyz and lighter.exchange[^lighter-docs-2026-04-28-lighter-docs-index]

## Risks

**High regulatory surface, no published per-product legal opinion.** Lighter simultaneously lists crypto perps, FX (USDCHF, USDCAD, USDJPY, EURUSD, GBPUSD), commodities (WTI, NATGAS, BRENTOIL, XAU, XAG), Korean equities (USDC-settled, KRW-priced), and prelaunch markets[^lighter-docs-2026-04-28-trading-contract-specifications][^lighter-docs-2026-04-28-trading-real-world-assets-rwas-rwa-pricing-mechanism][^lighter-docs-2026-04-28-trading-prelaunch-markets]. Primary docs do not publish: blocked-jurisdictions list, OFAC / sanctions screen coverage, per-jurisdiction KYC tiers, or per-product legal opinion (commodity / equity / RWA / KRW-perp). MiCA / SFC / MAS classification is not surfaced. Frame cells A9/PI, A9/PII, A9/PV remain `gap`; this section flags the cluster as operationally material for institutional onboarding decisions.

**ZK-rollup operational scaffolding partially documented.** Sequencer-failure recovery, prover-stall fallback, batch-proof cadence under stress, and DA-fallback failure modes are not described in primary docs[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]. Escape Hatch is referenced as a self-withdrawal mechanism but its trigger deadline (how long the sequencer can be uncooperative before priority-queue activation) is not documented.

**Five cells re-rated to `gap` after red-team review.** Initial coverage 26 / 8 / 11 was tightened to 21 / 8 / 16 after challenging the `filled` rationale on A1/PIV, A2/PII, A3/PV, A4/PIII, and A8/PV. See `## Frame coverage` for revised verdicts and rationales.

## Mechanism

**Lighter Core (verifiable execution).** Lighter operates as a ZK-rollup-style exchange anchored to Ethereum, with a custom proving engine purpose-built for orderbook, position, and pool workloads[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]. Every operation is a deterministic execution of a user-signed transaction; a batch produces a new state plus a succinct cryptographic proof verified on Ethereum[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]. The Sequencer provides FIFO ordering and soft finality; Witness Generators feed a Prover that aggregates hundreds of thousands of execution proofs into a single batch proof[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]. Highly compressed data blobs posted to Ethereum let any user reconstruct their state directly from on-chain data[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]. See [[entities/network/lighter-core]] for the full architecture.

**Account model — Standard vs Premium.** Lighter exposes two account types[^lighter-docs-2026-04-28-trading-trading-fees]. Standard Accounts are zero-fee on both perpetuals and spot but trade through a deliberately throttled latency stack (300 ms taker / 200 ms maker / 200 ms cancel)[^lighter-docs-2026-04-28-trading-trading-fees]. Premium Accounts pay fees (base 0.0040% maker / 0.0280% taker, 200 ms taker latency) and have no added latency on cancels or post-only placements — the latency edge MMs care about[^lighter-docs-2026-04-28-trading-trading-fees]. Orthogonally, Unified Trading Accounts (UTA) provide unified margin across spot and perpetual USDC balances and are the precursor to multi-asset margin; Simple Trading Accounts keep spot and perp balances strictly separated[^lighter-docs-2026-04-28-trading-unified-trading-accounts].

**Fees and LIT staking discount.** Premium fees scale on a flat 8-tier ladder: 0 / 1k / 3k / 10k / 30k / 100k / 300k / 500k LIT staked, capping at 30% fee discount and 140 ms taker latency[^lighter-docs-2026-04-28-trading-trading-fees]. Discount applies at the L1-address level; the master and all sub-accounts share one tier based on combined stake[^lighter-docs-2026-04-28-trading-trading-fees]. An address-list registration channel exists today and an in-app wallet linker is planned[^lighter-docs-2026-04-28-trading-trading-fees]. **LIT Fee Credits** are a paid shortcut: users buy time-bounded credit that counts toward a higher tier (e.g. 100k staked + 200k-equivalent credits qualifies the next tier); 100% of credit proceeds are streamed daily to LIT stakers as yield[^lighter-docs-2026-04-28-trading-trading-fees-lit-fee-credits]. See [[parameters/lighter/fee-schedule]].

**Order matching, STP, and post-trade risk.** The matching engine enforces price-time priority, executes at the maker's price, and inserts unfilled taker remainders into the book[^lighter-docs-2026-04-28-trading-order-types-and-matching]. Lighter asserts SNARK-backed verifiable matching: it is mathematically impossible for the matcher to act maliciously[^lighter-docs-2026-04-28-trading-order-types-and-matching]. Self-trade prevention cancels the resting (maker) order when same-account taker would cross — a "cancel-resting" STP variant[^lighter-docs-2026-04-28-trading-self-trade-prevention]. Risk is enforced post-trade: every fill is validated against account health, and an Order Margin reservation gates limit-order placement to prevent orders that would auto-cancel at fill[^lighter-docs-2026-04-28-trading-order-types-and-matching]. Fat-finger limits gate ask price to ≥ max(MarkPrice, bestBid) × 0.95 and bid price to ≤ min(MarkPrice, bestAsk) × 1.05[^lighter-docs-2026-04-28-trading-order-types-and-matching]. Order types include market, limit, SL/TP (with optional limit variants), and TWAP, with Reduce-Only / Post-Only / GTT / IOC modifiers[^lighter-docs-2026-04-28-trading-order-types-and-matching]. TWAPs slice across running time, posting a market child every 30 s with size = total / (running_time/30s + 1)[^lighter-docs-2026-04-28-trading-order-types-and-matching].

**Mark / fair price.** Mark price is the median of three components: Impact Price, price1 = index + EMA_8min(clamp(ImpactPrice − index, ±index/200)), and price2 = median of CEX mark prices[^lighter-docs-2026-04-28-trading-fair-price-marking]. The 0.5% premium clamp ensures mark cannot deviate from external references by more than 0.5%; the 8-minute EMA forces sustained manipulation to move mark[^lighter-docs-2026-04-28-trading-fair-price-marking]. Impact Notional = 500 USDC / Initial Margin Fraction[^lighter-docs-2026-04-28-trading-fair-price-marking]. Index price aggregates Chainlink, Stork, and Pyth oracles[^lighter-docs-2026-04-28-trading-fair-price-marking]. See [[parameters/lighter/oracle-config]].

**Funding (and rebates).** Funding pays hourly, peer-to-peer with zero exchange fee[^lighter-docs-2026-04-28-trading-funding]. The premium per minute is sampled at random within the minute; the 1-hour premium is the time-weighted average of 60 samples; the funding rate combines a 0.01% interest-rate component, a ±0.05% small clamp, a ±4% big clamp, and divides by 8 to spread the 1h figure over an 8h equivalent (CEX convention)[^lighter-docs-2026-04-28-trading-funding]. Default funding period is 1 h per market[^lighter-docs-2026-04-28-trading-contract-specifications]. **Funding Rate Rebates** rebate up to 15% to the funding-paying side: 6% automatic for Premium accounts plus up to 9% scaling linearly with LIT staked, capped at 9% when 50k LIT is staked[^lighter-docs-2026-04-28-trading-funding-funding-rate-rebates]. Eligible funding = min(FundingRate, InterestRateComponent) × PositionValue; rebates pay daily at 00:00 UTC from the Lighter Rebates Fund (`0xc4535ceeA637b3B1bcdf5932603A4DbC00Ad2772`) with a $1 minimum[^lighter-docs-2026-04-28-trading-funding-funding-rate-rebates]. A 10% annualized cap applies across consolidated accounts[^lighter-docs-2026-04-28-trading-funding-funding-rate-rebates]. See [[parameters/lighter/funding-config]] and [[parameters/lighter/funding-rate-rebates]].

**Liquidations and LLP insurance fund.** Each market specifies three margin levels — IMR > MMR > CMR (initial > maintenance > close-out) — with the strict ordering C_i < M_i < I_i[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]. The 5-state waterfall: Healthy (TAV ≥ all reqs), Pre-Liquidation (TAV < IMR, ≥ MMR — only health-improving operations allowed), Partial Liquidation (TAV < MMR, ≥ CMR — orders cancelled, IoC limit orders sent at zero price; up to 1% liquidation fee accrues to LLP if filled at a better price), Full Liquidation (TAV < CMR — LLP takes over positions in ascending unrealized PnL order, only if LLP stays above its own IMR), and ADL (LLP undercapitalized — bankrupt-account positions matched against opposite-side accounts ranked by leverage and unrealized PnL)[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]. Zero price (long) = markPrice·(1 − M_i·TAV/MMR); (short) = markPrice·(1 + M_i·TAV/MMR)[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]. **LLP Strategies** allow collateral allocation across distinct buckets (Crypto Perps / FX / Equities-RWAs); each market maps to one strategy, and a depleted strategy isolates ADL to that bucket while others continue normally[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]. LLP is the counterparty to all LLP trading and liquidations, and ADL events are fully backstopped by LLP — LPs absorb residual risk[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]. LLP access is exclusive to LIT stakers: 1 LIT staked → up to 10 USDC LLP capacity[^lighter-docs-2026-04-28-about-lighter-lit-utility]. See [[parameters/lighter/llp]] and [[concepts/risk/liquidation]].

**RWAs (rolling futures + index pricing).** Lighter lists 24/7 RWA perpetual markets across commodities, equities, and fixed income[^lighter-docs-2026-04-28-trading-real-world-assets-rwas]. LLP now manages liquidity and liquidations for RWAs, replacing the prior Experimental Liquidity Provider (XLP) for that scope; RWA perps are subject to standard liquidation fees[^lighter-docs-2026-04-28-trading-real-world-assets-rwas][^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]. RWA pricing blends external oracle feeds (Chainlink, Pyth, Stork, other exchanges) with an internal price derived from order-book impact prices smoothed by a time-weighted EMA; on stale-oracle ticks the oracle weight decays exponentially with a per-source τ and the residual weight shifts to internal pricing, while convergence back to external is instant[^lighter-docs-2026-04-28-trading-real-world-assets-rwas-rwa-pricing-mechanism]. Index uses τ = 1 h (capped at ±(1/L·0.75 − 0.5%) around the last oracle); mark uses τ = 8 min (capped at ±(1/L·0.75) around the last oracle)[^lighter-docs-2026-04-28-trading-real-world-assets-rwas-rwa-pricing-mechanism]. Korean equity perps are USDC-settled but priced in KRW[^lighter-docs-2026-04-28-trading-real-world-assets-rwas-rwa-pricing-mechanism]. WTI, NATGAS, and BRENTOIL use front-month futures as their underlying with a 5-day linear roll (20% per business day, 5th–10th business day; daily roll fires at 5:30 PM ET for WTI/NATGAS, 7:00 PM ET for BRENTOIL)[^lighter-docs-2026-04-28-trading-real-world-assets-rwas-futures-contract-price-rolling-mechanism]. RWAs support Isolated and Cross Margin, but Cross Margin opens are currently restricted due to volatility[^lighter-docs-2026-04-28-trading-real-world-assets-rwas].

**Multi-asset margin.** Multi-Asset Margin (MAM) lets users post non-USDC assets as margin; the asset's value × LTV haircut adds to TAV[^lighter-docs-2026-04-28-trading-multi-asset-margin]. ETH is the first non-USDC asset; MAM is gated to UTA accounts and at launch covers perps only (USDC spot trading with non-USDC collateral is "coming soon")[^lighter-docs-2026-04-28-trading-multi-asset-margin]. Per-asset config: LTV ≤ LT (Liquidation Threshold) ≤ LF (Liquidation Factor), plus per-asset Liquidation Fee, User Supply Cap, and Global Supply Cap[^lighter-docs-2026-04-28-trading-multi-asset-margin]. TAV uses LTV; TALT (Total Account Liquidation Threshold) uses LT — by construction TALT ≥ TAV[^lighter-docs-2026-04-28-trading-multi-asset-margin]. Health states reuse IMR/MMR/CMR but evaluate TALT for liquidation triggers; the modified perp zero price uses TALT instead of TAV[^lighter-docs-2026-04-28-trading-multi-asset-margin]. Spot zero price = IndexPrice · LF; spot liquidation guarantees the user receives at least LF-discounted value per unit of collateral[^lighter-docs-2026-04-28-trading-multi-asset-margin]. The collateral-supply-limits page shows ETH global cap as "coming soon" — see Disputed claims below[^lighter-docs-2026-04-28-trading-multi-asset-margin-collateral-supply-limits]. See [[parameters/lighter/multi-asset-collateral]].

**Pre-launch markets.** Prelaunch markets operate in isolated mode only; LLP has no exposure and XLP (Experimental Liquidity Provider) supplies liquidity[^lighter-docs-2026-04-28-trading-prelaunch-markets]. Prelaunch carries no liquidation fee[^lighter-docs-2026-04-28-trading-prelaunch-markets]. The liquidation flow is custom: between MMR and CMR an exchange-issued IoC at zero fee closes the position; below CMR the user is directly Auto-Deleveraged, bypassing LLP-takeover, with the counterparty receiving a more favorable execution price because ADL fires before bankruptcy[^lighter-docs-2026-04-28-trading-prelaunch-markets].

**Public Pools.** Public Pools let whitelisted operators run trading strategies on pooled depositor capital via an operator sub-account[^lighter-docs-2026-04-28-trading-public-pools]. Each pool exposes an Operator Fee (% of profits at participant withdrawal) and a Minimum Operator Share (e.g. 10% min share with a 10k USDC operator deposit caps participant deposits at 90k USDC)[^lighter-docs-2026-04-28-trading-public-pools]. Public Pools do not support isolated positions; depositors receive pool shares redeemed at withdrawal; no lockup — funds are withdrawable any time[^lighter-docs-2026-04-28-trading-public-pools].

**Audits and verifiability.** Lighter publishes a public audit history: Nethermind audited LighterCore and LighterEvmDepositBridge (both 2025-09-22); Block audits 2025-04-08 and 2025-08-09 (Block & delta); plus internal/scope audits — Wrapper (2025-10-10), Desert exit (2025-05-11), and Spot (2025-11-24)[^lighter-docs-2026-04-28-security-security-audits]. Two distinct external firms (Nethermind, Block) cover the core matching/bridge stack alongside scope audits[^lighter-docs-2026-04-28-security-security-audits]. The bug bounty programme is publicly signaled but the page is "Coming soon" — no scope, payouts, or terms published yet as of 2026-04-28[^lighter-docs-2026-04-28-security-bug-bounty-program]. See [[parameters/lighter/audit-history]] and [[parameters/lighter/bug-bounty]].

**Account model and API surface.** Account creation is gated by an Ethereum-wallet signature that registers the main account; assets deposit via Lighter's Ethereum smart contracts[^lighter-docs-2026-04-28-trading-api]. Each main account or sub-account may register up to 256 API keys used to sign and verify requests[^lighter-docs-2026-04-28-trading-api]. Multiple sub-accounts can be created under the same Ethereum wallet[^lighter-docs-2026-04-28-trading-api]. Full API docs live at apidocs.lighter.xyz; an api-updates Telegram channel is operated[^lighter-docs-2026-04-28-trading-api]. PnL accounting: Unrealized PnL = Σ(markPrice_i − avgEntryPrice_i)·position_i; funding payments apply immediately to realized PnL rather than accruing as a separate balance[^lighter-docs-2026-04-28-trading-pnl-and-total-account-value]. TAV = Collateral + Unrealized PnL[^lighter-docs-2026-04-28-trading-pnl-and-total-account-value]. Isolated positions use an Allocated Margin balance that functions as collateral but is scoped to one position[^lighter-docs-2026-04-28-trading-pnl-and-total-account-value].

**Partner attribution.** The Partner Attribution Program lets third-party integrators run a Lighter-powered frontend and configure user fees within global limits — perp cap 10 bps, spot cap 1%, minimum increment 0.01 bps[^lighter-docs-2026-04-28-integrations-partner-attribution]. Users must sign an approval before integrator fees apply; approvals can be expiring and are user-revocable[^lighter-docs-2026-04-28-integrations-partner-attribution]. When integrator and user share an L1 account only an L2 confirmation is needed; otherwise an L1 approval plus L2 confirmation is required[^lighter-docs-2026-04-28-integrations-partner-attribution]. A Python SDK (lighter-sdk on PyPI) and partner-integration API docs at apidocs.lighter.xyz/docs/partner-integration round out the integrator surface[^lighter-docs-2026-04-28-integrations-partner-attribution].

**Stated principle: zero-fee for retail, community-aligned tokenomics.** Standard Account is fee-free for everyone; LIT buybacks are funded by trading fee revenue and executed as daily 24h TWAPs (with shorter timeframes possible)[^lighter-docs-2026-04-28-trading-trading-fees][^lighter-docs-2026-04-28-about-lighter-lit-utility]. The treasury account performing buybacks is listed as the Ethereum zero address — see Disputed claims[^lighter-docs-2026-04-28-about-lighter-lit-utility].

## Relations
- [[entities/perpdex/lighter]] **implements** [[concepts/market-structure/clob]] (verifiable, SNARK-backed price-time priority)[^lighter-docs-2026-04-28-trading-order-types-and-matching]
- [[entities/perpdex/lighter]] **runs_on** [[entities/network/lighter-core]] (own ZK rollup, Ethereum-anchored)[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]
- [[entities/perpdex/lighter]] **uses** [[concepts/operations/sequencer]] (FIFO ordering, soft finality)[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]
- [[entities/perpdex/lighter]] **lists** crypto perps, FX pairs, RWA perps (commodities, equities, fixed income), and prelaunch perps[^lighter-docs-2026-04-28-trading-contract-specifications][^lighter-docs-2026-04-28-trading-real-world-assets-rwas][^lighter-docs-2026-04-28-trading-prelaunch-markets]
- [[entities/perpdex/lighter]] **distributes_to** [[entities/token/lit]] via daily 24h TWAP buyback funded by trading-fee revenue[^lighter-docs-2026-04-28-about-lighter-lit-utility]
- [[entities/perpdex/lighter]] **subsidizes** [[entities/programme/lighter-points-program]] (organic-trading rewards distributed weekly)[^lighter-docs-2026-04-28-points-program][^lighter-docs-2026-04-28-points-program-retail][^lighter-docs-2026-04-28-points-program-market-makers]
- [[entities/perpdex/lighter]] **subsidizes** [[entities/programme/lighter-liquidity-partner-program]] (weekly maker-rebate pool by tier)[^lighter-docs-2026-04-28-liquidity-partner-program]
- [[parameters/lighter/llp]] **seeds_liquidity_for** Lighter crypto, FX, and RWA markets and **backstops** liquidations[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies][^lighter-docs-2026-04-28-trading-real-world-assets-rwas]
- [[entities/perpdex/lighter]] **partners_with** third-party integrators via Partner Attribution Program (perp cap 10 bps, spot cap 1%)[^lighter-docs-2026-04-28-integrations-partner-attribution]
- [[entities/perpdex/lighter]] **depends_on** Chainlink, Stork, and Pyth oracles for index price aggregation[^lighter-docs-2026-04-28-trading-fair-price-marking]

## Parameters
- [[parameters/lighter/fee-schedule]] — Standard zero-fee + Premium 8-tier LIT-staking ladder (0 → 500k LIT, max 30% discount); LIT Fee Credits paid shortcut; integrator fee caps (Phase 2.2 will populate time series)
- [[parameters/lighter/funding-config]] — hourly funding period; 0.01% IRC; ±0.05% small clamp; ±4% big clamp; per-minute random sampling; /8 spread to 8h CEX convention
- [[parameters/lighter/funding-rate-rebates]] — 6% automatic Premium + 9% LIT-stake-scaled (capped at 50k LIT); 10% annualized cap; daily 00:00 UTC L2 transfer; $1 minimum
- [[parameters/lighter/oracle-config]] — Chainlink + Stork + Pyth index; mark = median(ImpactPrice, price1, price2); 8-min EMA; ±0.5% premium clamp; Impact Notional 500 USDC / IMF
- [[parameters/lighter/margin-tiers]] — leverage tiers 50x / 25x / 20x / 15x / 10x / 8x / 5x / 3x with MMR ≈ 0.6·IMR, CMR ≈ 0.4·IMR[^lighter-docs-2026-04-28-trading-contract-specifications]
- [[parameters/lighter/listed-markets-roster]] — crypto perps + FX pairs (USDCHF, USDCAD, USDJPY, EURUSD, GBPUSD) + RWA perps (XAU, XAG, WTI, NATGAS, BRENTOIL, equities) + prelaunch perps
- [[parameters/lighter/llp]] — single LLP account, multi-strategy collateral isolation (Crypto Perps / FX / Equities-RWAs), LIT-staking-gated deposits (1 LIT → 10 USDC capacity)
- [[parameters/lighter/insurance-fund]] — LLP doubles as insurance fund; ADL fires only when an LLP strategy is depleted
- [[parameters/lighter/multi-asset-collateral]] — ETH-first roll-out; per-asset LTV / LT / LF / Liquidation Fee / User Cap / Global Cap; UTA-gated
- [[parameters/lighter/liquidation-params]] — partial-liquidation IoC at zero price; 1% max liquidation fee to LLP on partial fills; prelaunch carve-out (zero fee)
- [[parameters/lighter/audit-history]] — Nethermind LighterCore + bridge (2025-09-22); Block (2025-04-08, 2025-08-09); Wrapper (2025-10-10); Desert exit (2025-05-11); Spot (2025-11-24)
- [[parameters/lighter/bug-bounty]] — publicly signaled, page "Coming soon" as of 2026-04-28; no scope/payouts/terms published yet
- [[parameters/lighter/points-rules]] — Season 2: 200k retail/wk + 50k MM/wk; quality-favoring multipliers, non-linear scaling, market weights, sybil-resistance heuristics
- [[parameters/lighter/lp-program-tiers]] — weekly Google-sheet-published tiers, weights, total pool; Premium-only eligibility; spread/size cumulative levels per tier; 50/50 bid/ask split
- [[parameters/lighter/markets/BTC]] · [[parameters/lighter/markets/ETH]] · [[parameters/lighter/markets/SOL]] · [[parameters/lighter/markets/XAU]] · [[parameters/lighter/markets/XAG]] · [[parameters/lighter/markets/WTI]] · [[parameters/lighter/markets/NATGAS]] · [[parameters/lighter/markets/BRENTOIL]] — selected per-market spec/lifecycle pages (Phase 2.2 will populate full roster)

## Frame coverage
- A1/PI: filled — verifiable matching, on-chain settlement, account-creation flow, market-listing surface (crypto + FX + RWA + prelaunch)[^lighter-docs-2026-04-28-trading-order-types-and-matching][^lighter-docs-2026-04-28-trading-contract-specifications][^lighter-docs-2026-04-28-trading-real-world-assets-rwas][^lighter-docs-2026-04-28-trading-prelaunch-markets][^lighter-docs-2026-04-28-trading-api]
- A1/PII: filled — prelaunch isolated-only carve-out + custom liquidation flow committed alongside listing concept[^lighter-docs-2026-04-28-trading-prelaunch-markets]
- A1/PIII: gap — pre-launch information-asymmetry controls (insider-trading guard, pre-launch oracle source documentation) not surfaced
- A1/PIV: gap — portfolio-cannibalization / new-listing × existing-listing stack accounting at launch not surfaced; integrator-fee stacking belongs at A2/PIV not A1/PIV
- A1/PV: gap — listing playbook contract template (governance procedure, depth gates, listing criteria document) not surfaced
- A2/PI: filled — full Standard zero-fee + Premium 8-tier ladder; LIT Fee Credits; LIT buyback funded by trading-fee revenue, daily 24h TWAP[^lighter-docs-2026-04-28-trading-trading-fees][^lighter-docs-2026-04-28-trading-trading-fees-lit-fee-credits][^lighter-docs-2026-04-28-about-lighter-lit-utility]
- A2/PII: gap — fee-change announce-window protocol and sunset taper rules not documented; only an ad-hoc 2026-04-15 RWA Premium-fee resume timestamp observed
- A2/PIII: filled — Premium has zero added latency on cancels and Post-Only placements; Standard latency 300 / 200 / 200 ms[^lighter-docs-2026-04-28-trading-trading-fees][^lighter-docs-2026-04-28-trading-order-types-and-matching]
- A2/PIV: filled — staking discount × LIT Fee Credits × funding-rate rebate stack with explicit aggregation rule (L1 address + sub-accounts share tier)[^lighter-docs-2026-04-28-trading-trading-fees][^lighter-docs-2026-04-28-trading-funding-funding-rate-rebates][^lighter-docs-2026-04-28-trading-trading-fees-lit-fee-credits]
- A2/PV: filled — partner attribution agreement structure (user signature, expiry, revocation, L1 vs L2 confirmation rules)[^lighter-docs-2026-04-28-integrations-partner-attribution]
- A3/PI: filled — points-program seasons, weekly cadence, multi-category metrics (volume / OI / fundings / liquidations / PnL); discretionary adjustment[^lighter-docs-2026-04-28-points-program][^lighter-docs-2026-04-28-points-program-retail]
- A3/PII: filled — Season 1 ended 2025-09-30 (final Private Beta distribution); Season 2 cadence is documented onboarding/offboarding boundary[^lighter-docs-2026-04-28-points-program]
- A3/PIII: filled — sybil-detection (mixed automated + semi-automated), 10-account limit, self-trading enforcement, intentional-loss exclusion[^lighter-docs-2026-04-28-points-program-retail]
- A3/PIV: filled — points × premium-account stack accounting (PnL weight bonus for Premium; LLP-MM-share redistribution to other participants)[^lighter-docs-2026-04-28-points-program-retail][^lighter-docs-2026-04-28-points-program-market-makers]
- A3/PV: gap — no documented affiliate/referrer SLA template (clawback, attribution window, dispute-escalation); existing partner-attribution evidence is a per-user signed-fee-approval mechanic, not an integrator agreement template
- A4/PI: filled — LLP protocol-as-MM model; LP program snapshot-based scoring; per-symbol/bps/size liquidity grid; 250k weekly points pool with 20% MM share[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies][^lighter-docs-2026-04-28-liquidity-partner-program][^lighter-docs-2026-04-28-points-program-market-makers]
- A4/PII: filled — XLP → LLP scope migration for RWAs (orderly takeover); Public Pools allow operator entry/exit without lockup[^lighter-docs-2026-04-28-trading-real-world-assets-rwas][^lighter-docs-2026-04-28-trading-public-pools]
- A4/PIII: gap — no markout-window or toxicity-class segregation in maker rebates; STP cancel-resting and weekly LP snapshot tiebreak address different concerns; quality-favoring scaling is qualitative only
- A4/PIV: filled — LLP-as-MM is excluded from points payout (redistributed); daily 8.33% liquidity-points floor; 50% daily cap on extreme-vol days; protocol-MM vs external-MM separation made explicit[^lighter-docs-2026-04-28-points-program-market-makers]
- A4/PV: filled — Premium-only eligibility and whitelist gating for Public Pool operators is the codified counterparty model[^lighter-docs-2026-04-28-liquidity-partner-program][^lighter-docs-2026-04-28-trading-public-pools]
- A5/PI through A5/PV: not-applicable — Lighter is perp-first; spot exists but the docs surface no AMM-LP / pair-fee-tier / IL / JIT-defense layer; Public Pools and LLP are vault/insurance constructs filed under A4
- A6/PI: filled — full mark/funding/liquidation/multi-asset-margin/RWA-pricing mechanism documented end-to-end[^lighter-docs-2026-04-28-trading-fair-price-marking][^lighter-docs-2026-04-28-trading-funding][^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund][^lighter-docs-2026-04-28-trading-multi-asset-margin][^lighter-docs-2026-04-28-trading-real-world-assets-rwas-rwa-pricing-mechanism]
- A6/PII: filled — RWA cross-margin restricted "due to volatility"; Multi-Asset-Margin conservative caps roll-out plan; ETH "coming soon" caveat[^lighter-docs-2026-04-28-trading-real-world-assets-rwas][^lighter-docs-2026-04-28-trading-multi-asset-margin][^lighter-docs-2026-04-28-trading-multi-asset-margin-collateral-supply-limits]
- A6/PIII: gap — IF coverage ratio (LLP capital vs max OI × stress slippage × gap%) not computed in primary docs; per-strategy collateral sizes not published
- A6/PIV: filled — TAV / Allocated Margin / unrealized vs realized PnL accounting fully formalized; UTA vs Simple account collateral boundary[^lighter-docs-2026-04-28-trading-pnl-and-total-account-value][^lighter-docs-2026-04-28-trading-unified-trading-accounts]
- A6/PV: not-applicable — no external SLA on risk parameters (no formal MM-rebate or insurance contract published)
- A7/PI: filled — Lighter Governance adds markets; LP-program tiers/weights/pool published Mondays 17:00 UTC; points-program parameters at team discretion[^lighter-docs-2026-04-28-trading-contract-specifications][^lighter-docs-2026-04-28-liquidity-partner-program][^lighter-docs-2026-04-28-points-program][^lighter-docs-2026-04-28-points-program-market-makers]
- A7/PII: gap — emergency-pause SLA, parameter-change announce-window, veto holders not documented
- A7/PIII: not-applicable — governance flow toxicity not a documented surface here
- A7/PIV: gap — governance vs ops authority separation (Lighter Governance vs Lighter team) is not explicitly delineated
- A7/PV: gap — formal commission / rate-of-change rules on governance parameters not documented
- A8/PI: filled — verifiable matching via SNARK; verifiable liquidations claim; published audit history (Nethermind, Block) covering core/bridge/wrapper/desert-exit/spot[^lighter-docs-2026-04-28-trading-order-types-and-matching][^lighter-docs-2026-04-28-security-security-audits]
- A8/PII: filled — Escape Hatch on-chain priority queue and self-withdrawal via state-blob proofs; user-always-can-exit stated principle[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]
- A8/PIII: gap — oracle-attack history, adverse-selection-from-bad-oracle history not documented
- A8/PIV: gap — outage refund / downtime fee credit policy not documented
- A8/PV: gap — bug-bounty terms unpublished (page is "Coming soon" stub); audit reports exist (counted under A8/PI) but no externally signed disclosure-policy / safe-harbor template surfaced
- A9/PI: gap — blocked-jurisdictions policy / OFAC / sanctions screen coverage not documented in primary docs
- A9/PII: gap — KYC tier policy, withdrawal restrictions per jurisdiction not documented
- A9/PIII: not-applicable — adverse-selection accounting in regulatory layer not a documented surface
- A9/PIV: filled — frontend sovereignty: canonical app (app.lighter.xyz) coexists with builder-forkable Partner Attribution frontends within explicit fee-cap envelope[^lighter-docs-2026-04-28-lighter-docs-index][^lighter-docs-2026-04-28-integrations-partner-attribution]
- A9/PV: gap — per-product legal opinion (RWA / equity perp / KRW perp / commodity perp) and MiCA/SFC/MAS classification not surfaced

Coverage summary: filled 21 / not-applicable 8 / gap 16 = 45.

## Open questions
- A1/PIII: How is information-asymmetry controlled during the prelaunch listing window — is the prelaunch oracle composition documented anywhere besides the main fair-price page?
- A1/PV: Does Lighter publish a listing playbook (depth gates, governance procedure, listing criteria template) for new market additions?
- A6/PIII: What is the IF coverage ratio for each LLP strategy — i.e. allocated-collateral vs max-OI × stress slippage × gap%?
- A7/PII: What is the parameter-change lead time / announce window, emergency-pause SLA, and veto-holder set for Lighter Governance?
- A7/PIV: How are Lighter team and Lighter Governance authorities separated for parameter mutation?
- A7/PV: Are there formal rate-of-change rules on governance parameters comparable to validator-commission caps elsewhere?
- A8/PIII: Has Lighter experienced any documented oracle-attack incidents and how were they remediated?
- A8/PIV: Is there an outage-refund or downtime-fee-credit policy documented anywhere outside the bug-bounty page?
- A9/PI / A9/PII: What is the blocked-jurisdictions list, OFAC / sanctions screen coverage, and per-jurisdiction KYC tier?
- A9/PV: Per-product legal opinion (RWA / equity perp / KRW perp / commodity perp) and MiCA / SFC / MAS classification?

## Disputed claims

### Disputed claims — LIT buyback target address (zero address vs custody wallet)

**Claim A** · confidence: high · recency: 2026-04 · authority: high
  The treasury account that conducts LIT buybacks is `0x0000000000000000000000000000000000000000`[^lighter-docs-2026-04-28-about-lighter-lit-utility].

**Claim B** · confidence: medium · recency: 2026-04 · authority: medium
  By Ethereum convention, sending tokens to `0x0000…0000` is a burn — not a custody operation. A "treasury account that conducts buybacks" usually refers to a custody address that holds the bought tokens; if Lighter's docs literally mean the zero address, then either (i) buybacks are buy-and-burn (not custody), or (ii) the docs page is incorrect / placeholder. The Lighter docs do not explicitly call this a burn; they call it "the treasury account that conducts LIT buybacks", which is internally inconsistent with the address[^lighter-docs-2026-04-28-about-lighter-lit-utility].
  status: unverified

→ Open question: Is the LIT buyback wallet the literal zero address (i.e. effectively buy-and-burn) or is the docs page using a placeholder pending publication of the real custody address?
  Suggested verification: (1) on-chain analysis — query trading-fee-funded LIT buys and check destination address; (2) check Lighter's app/contract repo for a `BuybackTreasury` address constant; (3) ask the Lighter team to confirm the docs page or update it with the real address.

### Disputed claims — ETH multi-asset margin live status

**Claim A** · confidence: medium · recency: 2026-04 · authority: high
  ETH is the first non-USDC asset added to Multi-Asset Margin; additional assets will be rolled out with conservative user and global supply limits[^lighter-docs-2026-04-28-trading-multi-asset-margin]. The wording implies ETH is live as collateral.

**Claim B** · confidence: medium · recency: 2026-04 · authority: high
  As of the 2026-04-28 mirror snapshot, the Global Cap value for ETH (the only currently-listed non-USDC margin asset) is shown as "ETH as collateral is coming soon" — no concrete numeric cap is published[^lighter-docs-2026-04-28-trading-multi-asset-margin-collateral-supply-limits].
  status: likely_superseded

→ Open question: Is ETH live as multi-asset collateral on Lighter today, or is it still in pre-launch with the supply-limits page reflecting the truth and the multi-asset-margin page being stale?
  Suggested verification: (1) check app.lighter.xyz collateral-deposit flow for ETH availability; (2) check Lighter's contract repo for a populated ETH global cap value; (3) cross-reference an in-app announcement or changelog for a launch date; (4) request the next mirror refresh once docs are reconciled.

### Disputed claims — Points program weekly cap arithmetic

**Claim A** · confidence: high · recency: 2026-04 · authority: high
  For Season 2, 200,000 retail points per week are distributed every Friday[^lighter-docs-2026-04-28-points-program-retail]. Market-making activity receives 20% of total allocated points, equal to 50,000 points[^lighter-docs-2026-04-28-points-program-market-makers]. Implied total points pool referenced for the program = 250,000 (20% = 50,000)[^lighter-docs-2026-04-28-points-program-market-makers].

**Claim B** · confidence: medium · recency: 2026-04 · authority: high
  The MM page does not explicitly state weekly cadence; the "250,000 total" is implied by inverting the 20% / 50,000 split. The retail page explicitly says 200k/week. Whether the MM 50k figure is also weekly (so total = 250k/week) or some other cadence is not literally written; the consistent interpretation is 200k retail + 50k MM = 250k weekly total, but the MM page leaves this implicit[^lighter-docs-2026-04-28-points-program-market-makers].
  status: unverified

→ Open question: Is the total Points Program weekly cap exactly 250,000 (200k retail + 50k MM), or do the two tracks operate on different cadences such that the 50k MM share is not strictly weekly?
  Suggested verification: (1) check the next weekly Lighter team announcement for an explicit "this week's total pool = X" figure; (2) request the Lighter team to publish an unambiguous Points Program rules page with explicit weekly totals; (3) cross-reference week-over-week on-chain LIT-points distribution events.

**Disputed claim #4 — zero-price formula base (TAV vs TALT)**

**Claim A** · confidence: high · recency: 2026-04 · authority: high
  `zeroPrice(short) = mark · (1 + M · TAV / MMR)`; base is Total Account Value [^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund].

**Claim B** · confidence: high · recency: 2026-04 · authority: high
  `zeroPrice(short) = mark · (1 + M · TALT / MMR)`; base is Total Account Liquidation Threshold (TALT) [^lighter-docs-2026-04-28-trading-multi-asset-margin].
  status: likely_superseded   # multi-asset-margin page asserts the TALT formula collapses to TAV when collateral is USDC-only

→ Open question: Which formula is the canonical engine implementation? The TALT formulation generalizes the TAV one for non-USDC collateral; if both pages are correct simultaneously, the trading-liquidations page is incomplete (does not name the TALT generalization).
  Suggested verification: on-chain query of Lighter Core engine constants; or user-initiated refresh of trading-liquidations after Lighter publishes the unified formula.

**Disputed claim #5 — ADL trigger granularity (LLP-wide exhaustion vs per-strategy depletion)**

**Claim A** · confidence: high · recency: 2026-04 · authority: high
  ADL fires when an account has negative value AND the LLP as a whole lacks capital to cover the losses (LLP-wide exhaustion) [^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund].

**Claim B** · confidence: high · recency: 2026-04 · authority: high
  ADL fires when a single strategy's allocated collateral is fully depleted, isolating ADL to that strategy alone (per-strategy depletion) [^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies].
  status: active

→ Open question: Which trigger is canonical post-2026-04-28? The per-strategy trigger fires earlier than the LLP-wide one, materially affecting ADL-probability estimates for operators forecasting risk.
  Suggested verification: read Lighter Core engine code; on-chain analysis of historical ADL events to identify which boundary actually fires.

## Related
[[entities/network/lighter-core]] · [[entities/token/lit]] · [[entities/programme/lighter-points-program]] · [[entities/programme/lighter-liquidity-partner-program]] · [[concepts/market-structure/clob]] · [[concepts/risk/liquidation]] · [[concepts/risk/adl-waterfall]] · [[concepts/risk/margin-tier]] · [[concepts/market-microstructure/mark-price-formula]] · [[concepts/market-microstructure/oracle-spec]] · [[concepts/listing/pre-launch-perp]] · [[concepts/lp/vault]] · [[concepts/operations/sequencer]] · [[concepts/incentives/sybil-resistance]] · [[concepts/tokenomics/buyback]] · [[concepts/tokenomics/fee-distribution]] · [[concepts/fee-model/funding-rate]] · [[parameters/lighter/fee-schedule]] · [[parameters/lighter/llp]] · [[parameters/lighter/multi-asset-collateral]]

## Sources
[^lighter-docs-2026-04-28-lighter-docs-index]: [[sources/lighter-docs-2026-04-28-lighter-docs-index]]
[^lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]: [[sources/lighter-docs-2026-04-28-about-lighter-technical-architecture-lighter-core]]
[^lighter-docs-2026-04-28-about-lighter-lit-utility]: [[sources/lighter-docs-2026-04-28-about-lighter-lit-utility]]
[^lighter-docs-2026-04-28-trading-trading-fees]: [[sources/lighter-docs-2026-04-28-trading-trading-fees]]
[^lighter-docs-2026-04-28-trading-trading-fees-lit-fee-credits]: [[sources/lighter-docs-2026-04-28-trading-trading-fees-lit-fee-credits]]
[^lighter-docs-2026-04-28-trading-unified-trading-accounts]: [[sources/lighter-docs-2026-04-28-trading-unified-trading-accounts]]
[^lighter-docs-2026-04-28-trading-order-types-and-matching]: [[sources/lighter-docs-2026-04-28-trading-order-types-and-matching]]
[^lighter-docs-2026-04-28-trading-real-world-assets-rwas]: [[sources/lighter-docs-2026-04-28-trading-real-world-assets-rwas]]
[^lighter-docs-2026-04-28-trading-real-world-assets-rwas-rwa-pricing-mechanism]: [[sources/lighter-docs-2026-04-28-trading-real-world-assets-rwas-rwa-pricing-mechanism]]
[^lighter-docs-2026-04-28-trading-real-world-assets-rwas-futures-contract-price-rolling-mechanism]: [[sources/lighter-docs-2026-04-28-trading-real-world-assets-rwas-futures-contract-price-rolling-mechanism]]
[^lighter-docs-2026-04-28-trading-public-pools]: [[sources/lighter-docs-2026-04-28-trading-public-pools]]
[^lighter-docs-2026-04-28-trading-contract-specifications]: [[sources/lighter-docs-2026-04-28-trading-contract-specifications]]
[^lighter-docs-2026-04-28-trading-prelaunch-markets]: [[sources/lighter-docs-2026-04-28-trading-prelaunch-markets]]
[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]: [[sources/lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]]
[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]: [[sources/lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]]
[^lighter-docs-2026-04-28-trading-multi-asset-margin]: [[sources/lighter-docs-2026-04-28-trading-multi-asset-margin]]
[^lighter-docs-2026-04-28-trading-multi-asset-margin-collateral-supply-limits]: [[sources/lighter-docs-2026-04-28-trading-multi-asset-margin-collateral-supply-limits]]
[^lighter-docs-2026-04-28-trading-funding]: [[sources/lighter-docs-2026-04-28-trading-funding]]
[^lighter-docs-2026-04-28-trading-funding-funding-rate-rebates]: [[sources/lighter-docs-2026-04-28-trading-funding-funding-rate-rebates]]
[^lighter-docs-2026-04-28-trading-pnl-and-total-account-value]: [[sources/lighter-docs-2026-04-28-trading-pnl-and-total-account-value]]
[^lighter-docs-2026-04-28-trading-fair-price-marking]: [[sources/lighter-docs-2026-04-28-trading-fair-price-marking]]
[^lighter-docs-2026-04-28-trading-self-trade-prevention]: [[sources/lighter-docs-2026-04-28-trading-self-trade-prevention]]
[^lighter-docs-2026-04-28-trading-api]: [[sources/lighter-docs-2026-04-28-trading-api]]
[^lighter-docs-2026-04-28-liquidity-partner-program]: [[sources/lighter-docs-2026-04-28-liquidity-partner-program]]
[^lighter-docs-2026-04-28-points-program]: [[sources/lighter-docs-2026-04-28-points-program]]
[^lighter-docs-2026-04-28-points-program-market-makers]: [[sources/lighter-docs-2026-04-28-points-program-market-makers]]
[^lighter-docs-2026-04-28-points-program-retail]: [[sources/lighter-docs-2026-04-28-points-program-retail]]
[^lighter-docs-2026-04-28-integrations-partner-attribution]: [[sources/lighter-docs-2026-04-28-integrations-partner-attribution]]
[^lighter-docs-2026-04-28-security-bug-bounty-program]: [[sources/lighter-docs-2026-04-28-security-bug-bounty-program]]
[^lighter-docs-2026-04-28-security-security-audits]: [[sources/lighter-docs-2026-04-28-security-security-audits]]
