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

## Resolved

_(none yet)_
