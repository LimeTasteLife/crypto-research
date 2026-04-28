---
type: concept
domain: risk
name: ADL waterfall
last_reviewed: 2026-04-28
disputed: false
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

(Other perpdex venues to be added in subsequent ingest passes.)

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
