# Open Questions

Unresolved disputes and verification queue. Populated by ingest (conflict detection) and lint. See [AGENTS.md](./AGENTS.md) §"Conflict detection" and §"Lint workflow".

Entry format:

```
- [[target-page]] {question}. Suggested verification: {action}. Raised: YYYY-MM-DD.
```

When resolved, move to `## Resolved` with `→ resolved YYYY-MM-DD by [[source-id]]`.

## Active

### From Hyperliquid first-pass ingest (2026-04-27 / 2026-04-28)

- [[entities/perpdex/hyperliquid]] Does Hyperliquid publish a delisting policy and FDV sanity bound for HIP-3 perps? (A1/PII gap). Suggested verification: search HIP-3 spec, governance forum, or HL Foundation blog. Raised: 2026-04-28.
- [[entities/perpdex/hyperliquid]] What is the IF coverage ratio (HLP capital vs max OI × stress slippage)? (A6/PIII gap). Suggested verification: query HL on-chain HLP balance + per-market max OI; compute. Raised: 2026-04-28.
- [[entities/perpdex/hyperliquid]] Protocol-MM (HLP) vs builder-MM cannibalization expectation when builders deploy HIP-3 perps with their own MMs? (A4/PIV gap). Suggested verification: read HIP-3 spec on builder MM; observe live HIP-3 perp PnL split. Raised: 2026-04-28.
- [[entities/network/hyperliquid-l1]] What is the validator set size, and how is it bounded? Suggested verification: validator dashboard / governance forum. Raised: 2026-04-28.
- [[entities/network/hyperliquid-l1]] How is double-sign slashing implemented in code, given "no automatic slashing currently"? Suggested verification: source code / Zellic audit reports. Raised: 2026-04-28.
- [[entities/token/hype]] Total HYPE supply and full unlock/emissions schedule? Suggested verification: tokenomics page or HL Foundation announcements. Raised: 2026-04-28.
- [[entities/token/hype]] HYPE holder distribution (top-N concentration)? Suggested verification: on-chain holder analytics. Raised: 2026-04-28.
- [[entities/token/hype]] Cumulative AF auto-burn to date and cadence? Suggested verification: Assistance Fund system address `0xfefefefefefefefefefefefefefefefefefefefe` event log. Raised: 2026-04-28.
- [[parameters/hyperliquid/hlp]] Live TVL, APY, composition for HLP — not in primary docs. Suggested verification: HL app dashboard / on-chain query. Raised: 2026-04-28.
- [[parameters/hyperliquid/listed-markets-roster]] Per-symbol contract-spec time-series (per-asset tick/lot/leverage/IM/MM history). Suggested verification: HL info API + lifecycle events from blog/changelog. Raised: 2026-04-28.
- [[concepts/incentives/referral-design]] Multi-level depth, attribution window, sybil/clawback policy not surfaced in primary docs. Suggested verification: HL referral program ToS / app dashboard. Raised: 2026-04-28.

### From lighter-docs-2026-04-28 ingest (3 disputed + 8 high-value gap cells)

- [[entities/perpdex/lighter]] / [[entities/token/lit]] Is the LIT buyback wallet the literal zero address `0x0000…0000` (effectively buy-and-burn) or a docs placeholder pending a real custody address? Suggested verification: on-chain analysis of trading-fee-funded LIT buys, contract-repo `BuybackTreasury` lookup, or direct team confirmation. Raised: 2026-04-28.
- [[entities/perpdex/lighter]] Is ETH live as multi-asset collateral on Lighter today, or is it still pre-launch with the supply-limits page accurate and the multi-asset-margin page stale? Suggested verification: app.lighter.xyz collateral-deposit flow inspection, contract-repo ETH global-cap value, in-app changelog cross-reference, mirror refresh after docs reconciled. Raised: 2026-04-28.
- [[entities/perpdex/lighter]] / [[entities/programme/lighter-points-program]] Is the total Points Program weekly cap exactly 250,000 (200k retail + 50k MM), or do the two tracks operate on different cadences such that the 50k MM share is not strictly weekly? Suggested verification: explicit "weekly total = X" figure in the next Lighter team announcement, on-chain LIT-points distribution week-over-week. Raised: 2026-04-28.
- [[entities/perpdex/lighter]] (A1/PIII) How is information-asymmetry controlled during the prelaunch listing window — what is the prelaunch oracle composition before any external CEX listing exists? Suggested verification: live page check of `app.lighter.xyz/markets/<prelaunch-symbol>`, prelaunch fair-price spec doc lookup, or team confirmation. Raised: 2026-04-28.
- [[entities/perpdex/lighter]] (A1/PV) Does Lighter publish a listing playbook (depth gates, governance procedure, listing criteria template) for new market additions? Suggested verification: search for a Lighter Governance proposal repo or governance forum; query the team for a published listing-criteria doc. Raised: 2026-04-28.
- [[entities/perpdex/lighter]] (A6/PIII) What is the IF coverage ratio for each LLP strategy — i.e. allocated-collateral vs max-OI × stress slippage × gap%? Suggested verification: on-chain query of LLP strategy balances + market max-OI; compare to historical max-drawdown events; request published IF ratio. Raised: 2026-04-28.
- [[entities/perpdex/lighter]] (A7/PII) What is the parameter-change lead time / announce window, emergency-pause SLA, and veto-holder set for Lighter Governance? Suggested verification: governance forum search, team interview, or contract-level multisig threshold inspection. Raised: 2026-04-28.
- [[entities/perpdex/lighter]] (A8/PIII / A8/PIV) Has Lighter experienced any documented oracle-attack incidents and is there an outage-refund or downtime-fee-credit policy documented anywhere outside the bug-bounty page? Suggested verification: incident-response history search, status-page archives, on-chain forensic of historical price disruptions. Raised: 2026-04-28.
- [[entities/perpdex/lighter]] (A9/PI / A9/PII) What is the blocked-jurisdictions list, OFAC / sanctions screen coverage, and per-jurisdiction KYC tier for Lighter's canonical frontend? Suggested verification: Terms of Service review, geo-IP-block testing, frontend disclaimer inspection. Raised: 2026-04-28.
- [[entities/perpdex/lighter]] (A9/PV) What is the per-product legal opinion (RWA / equity perp / KRW perp / commodity perp) and MiCA / SFC / MAS classification for Lighter's RWA suite? Suggested verification: published legal-opinion documents on lighter.xyz or assets.lighter.xyz, regulatory filings, partner-region announcements. Raised: 2026-04-28.
- [[entities/network/lighter-core]] What is the priority-queue processing deadline before Escape Hatch fires (the "predefined timeframe"), and has Escape Hatch ever been triggered in production? Suggested verification: read the LighterCore contract source / Nethermind audit report (2025-09-22) for the timeout constant; on-chain log search for Escape Hatch state-mutation events. Raised: 2026-04-28.
- [[entities/perpdex/lighter]] / [[concepts/risk/liquidation]] (Disputed #4) Is the canonical zero-price formula base TAV (per trading-liquidations page) or TALT (per multi-asset-margin page)? The TALT form generalizes TAV for non-USDC collateral; if both pages are simultaneously correct the trading-liquidations page is incomplete. Suggested verification: on-chain query of Lighter Core engine constants; user-initiated refresh of trading-liquidations after Lighter publishes a unified formula. Raised: 2026-04-28.
- [[entities/perpdex/lighter]] / [[parameters/lighter/llp]] / [[concepts/risk/adl-waterfall]] (Disputed #5) Does ADL fire on LLP-wide exhaustion (trading-liquidations page) or per-strategy depletion (LLP-strategies page)? The per-strategy trigger fires earlier than the LLP-wide one, materially affecting operator ADL-probability estimates. Suggested verification: read Lighter Core engine code; on-chain analysis of historical ADL events to identify which boundary actually fires. Raised: 2026-04-28.

### From orderly-docs-2026-04-29 + orderly-listing-2026-04-29 ingest (5 open questions)

- [[entities/perpdex/orderly]] Who approves standard listings at the Orderly protocol level? Docs say "Orderly evaluates and approves" but specific committee, multi-sig composition, or governance process for standard listing approval not documented (A1/PV gap). Suggested verification: Orderly team confirmation or governance forum search. Raised: 2026-04-28.
- [[entities/perpdex/orderly]] Does a trader referral program exist (separate from the listing referral bonus)? Only listing-referral found in primary docs; trader referral may not exist or may be builder-discretionary (A3/PII gap). Suggested verification: Orderly app dashboard inspection; ask Orderly team directly. Raised: 2026-04-28.
- [[entities/perpdex/orderly]] / [[parameters/orderly/omnivault]] What is OmniVault LP exit behavior under stress — if strategy at a loss, vault pause conditions, in-flight withdrawals during adverse PnL? (A4/PII gap). Suggested verification: OmniVault smart contract code review; stressed-state withdrawal simulation. Raised: 2026-04-28.
- [[entities/perpdex/orderly]] Does a bug bounty program exist? Not found in first-party docs; may exist in GitHub SECURITY.md (A8/PV gap). Suggested verification: check OrderlyNetwork GitHub repos for SECURITY.md or Immunefi/HackerOne listings. Raised: 2026-04-28.
- [[entities/perpdex/orderly]] What is the governance formalization timeline? Docs state "being formalized" with $ORDER staking granting future voting rights, but no concrete proposal, timeline, or governance forum link found (A7/PII gap). Suggested verification: Orderly blog, governance forum, or team communication channels. Raised: 2026-04-28.
### From Uniswap v4 ingest (2026-04-29)

- [[entities/dex/uniswap-v4]] (Schema) Should `dex-substrate` be added as a new entity subtype? Current `dex` subtype works but does not distinguish standalone DEX protocols from infrastructure-layer DEX protocols (Uniswap v4, Balancer v2, Curve) that serve as substrates for higher-order DeFi products. Suggested verification: review whether any existing or planned entity ingest requires the distinction. Raised: 2026-04-29.
- [[entities/dex/uniswap-v4]] (A2/PII) V4FeeAdapter activation status and timeline — UNIfication passed Dec 25, 2025 activating fees on v2+v3; V4FeeAdapter listed as TBD in docs as of 2026-04-29. Suggested verification: check github.com/uniswap/protocol-fees repo; check gov.uniswap.org for governance timeline. Raised: 2026-04-29.
- [[entities/dex/uniswap-v4]] (A2/PI) Protocol fee rate for v4 pools — will it be 1/6 of swap fee (like v2) or different? Suggested verification: on-chain query of V4FeeAdapter configuration once deployed; governance proposal text. Raised: 2026-04-29.
- [[entities/dex/uniswap-v4]] (A1/PI) Perpdex hook inventory on v4 mainnet — which perpetual futures hooks are deployed? Determines whether v4 has direct perpdex-frame content. Suggested verification: DeFiLlama hooks tracker, Dune v4 hook registry, or Uniswap hook allowlist. Raised: 2026-04-29.
- [[entities/dex/uniswap-v4]] (A8/PV) Bug bounty scope boundary between v4 core and third-party hooks — $15.5M Cantina bounty covers core+periphery; hooks out of scope. Suggested verification: fetch cantina.xyz/bounties/uniswap-v4 for definitive scope. Raised: 2026-04-29.
- [[entities/dex/uniswap-v4]] (A7/PII) Emergency-pause SLA — core contracts immutable (no pause); governance parameter change lead-time not specified beyond Timelock. Suggested verification: on-chain Timelock delay query; governance forum. Raised: 2026-04-29.
- [[entities/dex/uniswap-v4]] (A9/PI-PV) Regulatory classification — no first-party legal opinion, blocked-jurisdiction list, or OFAC screen coverage documented. Suggested verification: Uniswap Labs ToS; Wyoming DUNA legal opinion. Raised: 2026-04-29.

## Resolved

- [AGENTS.md §"Relations"] Should `backstops` be added to the canonical verb set? In use on entities/perpdex/{hyperliquid,lighter} for the LP-vault → liquidation-flow relation. Suggested verification: schema patch on next user-initiated refresh. Raised: 2026-04-28.
  → resolved 2026-04-28 by [[AGENTS.md §"Relations"]] (test branch schema patch 7488394) — verb rejected; canonical substitution is `seeds_liquidity_for` + body note clarifying backstop role. Lighter Mechanism prose updated.
