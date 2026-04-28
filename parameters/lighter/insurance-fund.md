---
type: parameter
entity: [[entities/perpdex/lighter]]
parameter: insurance-fund
unit: USDC
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: false
---

# Lighter insurance fund

## Current (as of 2026-04-28)

**Topology.** Lighter's insurance fund is implemented through the LLP (Lighter Liquidity Provider) account — the LLP is both the protocol's primary liquidity provider and its insurance-fund backstop[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]. LLP funds are held within a single account, which acts as the counterparty to all LLP trading and liquidations[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies].

**Strategy-level isolation.** LLP Strategies allow collateral allocation across distinct strategy buckets — Crypto Perps, FX, and Equities/RWAs — with each market assigned to one strategy[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]. Each strategy behaves as a segregated collateral shard for risk purposes; risk and losses are isolated at the strategy level[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]. If a strategy's allocated collateral is fully depleted, only that strategy enters ADL — other strategies are unaffected[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies].

**Sizing.** Concrete per-strategy collateral allocation sizes are not published in primary docs[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]. LLP access is gated to LIT stakers at 1 LIT staked → up to 10 USDC LLP capacity, determining the aggregate pool size[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies].

**Liquidation fee inflow.** During Partial Liquidation, if an IoC fill executes at a better price than the zero price, up to a 1% liquidation fee accrues to LLP[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]. This is the primary funding mechanism for the insurance pool from liquidation events[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund].

**ADL trigger.** ADL fires when the LLP (insurance fund) is undercapitalized and a full-liquidation position would push LLP below its own Initial Margin Requirement[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]. Under strategy isolation, ADL applies only to the depleted strategy; surviving strategies continue normally[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies].

See [[parameters/lighter/llp]] for LLP deposit structure and [[concepts/risk/insurance-fund-sizing]] for cross-venue comparison.

## Time series

| effective | topology | strategy buckets | ADL trigger | liq fee to IF | source |
|---|---|---|---|---|---|
| 2026-04-28 | single LLP account, strategy-isolated | Crypto Perps / FX / Equities-RWAs | LLP strategy depleted | up to 1% on partial-liq overshoot | [^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund][^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies] |

## Tiering rules / formulae
Not applicable — no published numeric size targets; sizing is LIT-staking-driven.

## Disputed values
None.

## Sources
[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]: [[sources/lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund]]
[^lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]: [[sources/lighter-docs-2026-04-28-trading-liquidations-and-llp-insurance-fund-llp-strategies]]
