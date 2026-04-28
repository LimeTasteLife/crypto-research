---
type: parameter
entity: [[hyperliquid]]
parameter: pool-spec
pool_id: HLP
pool_class: venue-owned-lp
status: live
deposit_tokens: [USDC]
strategy_summary: market-making + liquidation backstop
last_change: 2026-04-27
last_reviewed: 2026-04-28
disputed: false
---

# Hyperliquid HLP

## Current pool spec

HLP is Hyperliquid's protocol-owned liquidity vault. It runs at least two component strategies:

1. **Market-making** — provides quotes on listed perps.
2. **Liquidator Vault** — backstops liquidations when book closure fails (account equity < 2/3 of maintenance margin)[^hl-docs-2026-04-27-trading-liquidations].

PnL flows entirely to community depositors[^hl-docs-2026-04-27-trading-liquidations]. Distinct from CEX or privileged-MM internalization, where backstop economics accrue to the operator or to designated MMs.

## Lifecycle events

**Backstop liquidation flow:**

1. Position breaches 2/3 maintenance margin without book closure[^hl-docs-2026-04-27-trading-liquidations].
2. HLP Liquidator Vault takes over the position; for cross positions, all cross positions and cross margin transfer to the liquidator; for isolated, only that position[^hl-docs-2026-04-27-trading-liquidations].
3. Trader's maintenance margin is forfeited (HLP buffer to keep backstops profitable on average)[^hl-docs-2026-04-27-trading-liquidations].
4. Backstop-liquidated positions enter the [[concepts/risk/adl-waterfall|ADL queue]] on equal terms[^hl-docs-2026-04-27-trading-auto-deleveraging].

## Time series

| effective  | tvl_usd | apy | composition | fee_take | source |
|------------|----------|------|--------------|----------|--------|
| 2026-04-27 | n/a (not in primary docs) | n/a | n/a | n/a | [^hl-docs-2026-04-27-trading-liquidations] |

(Live TVL/APY tracking is not in primary docs — should be filled from on-chain analytics or Hyperliquid app dashboards in subsequent ingest.)

## Disputed values
None.

## Sources
[^hl-docs-2026-04-27-trading-liquidations]: [[sources/hl-docs-2026-04-27-trading-liquidations]]
[^hl-docs-2026-04-27-trading-auto-deleveraging]: [[sources/hl-docs-2026-04-27-trading-auto-deleveraging]]
