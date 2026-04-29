---
type: concept
domain: risk
name: ADL waterfall
last_reviewed: 2026-04-28
disputed: true
---

# ADL waterfall

## Definition
Auto-deleveraging (ADL) is the final solvency safeguard in a perpetual exchange. When neither book liquidation nor backstop liquidation can absorb a losing position's residual loss, the exchange selects opposite-side traders by a ranked priority and forcibly closes their positions at a recent reference price against the underwater account[^hl-docs-2026-04-27-trading-auto-deleveraging]. ADL converts what would otherwise be socialized loss (or insurance-fund depletion) into deterministic per-counterparty take-overs.

## Mechanism on Hyperliquid

**Trigger.** ADL fires when a user's account value or isolated-position value becomes negative[^hl-docs-2026-04-27-trading-auto-deleveraging].

**Ranking formula.** Opposite-side traders are ranked by:

```
rank_score = (mark_price / entry_price) * (notional_position / account_value)
```

[^hl-docs-2026-04-27-trading-auto-deleveraging]

Higher score → earlier in the ADL queue. The product term penalizes both deeply-profitable winners (high mark/entry) and over-leveraged accounts (high notional/equity), matching them against the underwater account first.

**Closure price.** Affected traders' positions are closed at the **previous mark price** against the underwater user[^hl-docs-2026-04-27-trading-auto-deleveraging] — not at the current mark or any negotiated price. This is by design: ADL is not a market event for the surviving traders, it is a forced book-entry settlement.

**No special treatment for backstop-liquidated positions.** Positions that arrived via backstop liquidation (i.e. positions HLP took over) are queued for ADL on the same priority basis as any other holder of the opposite side[^hl-docs-2026-04-27-trading-auto-deleveraging]. HLP is not given preferential immunity from ADL.

**Strict invariant.** A user with no open positions cannot socialize any platform losses[^hl-docs-2026-04-27-trading-auto-deleveraging]. ADL only touches counterparty positions, never spot balances or staking balances of users uninvolved in the failed instrument.

## Variants in the wild

| venue | rank formula | closure price | spot/staking touched? |
|---|---|---|---|
| [[entities/perpdex/hyperliquid]] | `(mark/entry) × (notional/equity)`[^hl-docs-2026-04-27-trading-auto-deleveraging] | previous mark[^hl-docs-2026-04-27-trading-auto-deleveraging] | no — invariant: zero-position users untouchable[^hl-docs-2026-04-27-trading-auto-deleveraging] |
| [[entities/perpdex/aster]] | Leverage PnL Quantile = PnL% × Margin Ratio; PnL% = max(0, Unrealized profit) / max(1, Wallet balance); reduces most profitable + most leveraged opposing first; no warning before reduction[^aster-docs-2026-04-28-trading-perpetuals-adl] | not surfaced | not surfaced |
| [[entities/perpdex/lighter]] | opposite-side accounts ranked by ascending unrealized PnL with leverage as secondary key; bankrupt-account positions matched against this queue[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund] | not explicitly named in primary docs; ADL is the terminal state of the 5-state waterfall (Healthy → Pre-Liquidation → Partial → Full → ADL)[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund] | LLP-strategy isolated: a depleted strategy isolates ADL to that bucket (Crypto Perps / FX / Equities-RWAs); other strategies continue normally[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies] |
| [[entities/perpdex/dydx]] | IF covers shortfall via wider limit price (max 1.5×MMF spread from oracle); once account value goes negative, immediate deleveraging against random offsetting positions; IF bypassed at that stage[^dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism] | not surfaced (random selection among offsetting positions)[^dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism] | isolated-market positions use segregated per-market IF; cross positions share a single IF[^dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism] |
| [[entities/perpdex/orderly]] | most profit + most leverage (profit-leverage composite)[^orderly-docs-2026-04-29-insurance-fund-and-adl] | previous mark (implied — offsets IF positions)[^orderly-docs-2026-04-29-insurance-fund-and-adl] | per-Builder IF isolation for community markets: ADL scoped to single market only; platform IF for standard markets[^orderly-docs-2026-04-29-insurance-fund-and-adl] |

**Disputed trigger granularity (Lighter).** The ADL trigger condition is contested between LLP-wide exhaustion (per the trading-liquidations page) and per-strategy depletion (per the LLP-strategies page). The per-strategy trigger fires earlier and materially affects ADL-probability estimates — see [[entities/perpdex/lighter#disputed-claims-5]].

## Edge cases
- Because the closure price is the **previous** mark, ADL counterparties are paid out as if they exited at the moment before the mark moved further against the underwater user — a small protective step for the involuntary exit.
- The rank product means a marginally-profitable, lightly-leveraged hedger is ADL-prioritized last; a deeply-profitable, highly-leveraged speculator is ADL-prioritized first.

## Disputed claims
None at first ingest.

## Related
[[concepts/risk/liquidation]] · [[parameters/hyperliquid/hlp]] · [[concepts/market-microstructure/mark-price-formula]]

## Sources
[^hl-docs-2026-04-27-trading-auto-deleveraging]: [[sources/hl-docs-2026-04-27-trading-auto-deleveraging]]
[^aster-docs-2026-04-28-trading-perpetuals-adl]: [[sources/aster-docs-2026-04-28-trading-perpetuals-adl]]
[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]: [[sources/lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]]
[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]: [[sources/lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]]
[^dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism]: [[sources/dydx-docs-2026-04-28-concepts-trading-contract-loss-mechanism]]
[^orderly-docs-2026-04-29-insurance-fund-and-adl]: [[sources/orderly-docs-2026-04-29-insurance-fund-and-adl]]
