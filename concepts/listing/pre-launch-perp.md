---
type: concept
domain: listing
name: Pre-launch perp
last_reviewed: 2026-04-28
disputed: false
---

# Pre-launch perp

## Definition

A pre-launch perpetual (or pre-launch contract) is a derivative instrument that allows users to trade price exposure to a token before that token is officially listed on major exchanges or before its tokenomics are released[^lighter-docs-2026-04-28-trading-prelaunch-markets][^aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts]. The key structural difference from a standard perpetual is that no external price reference (spot index) exists: the mark price must be derived from the pre-launch order book itself or from an experimental pricing mechanism rather than from a reliable spot oracle[^lighter-docs-2026-04-28-trading-prelaunch-markets][^aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts]. Pre-launch contracts expose venues to elevated information asymmetry, oracle manipulation risk, and uncertain settlement conditions — requiring design trade-offs in margin mode, liquidity provision, and liquidation flow that differ from standard perps[^lighter-docs-2026-04-28-trading-prelaunch-markets].

## Mechanism

**Oracle.** No external spot index exists for the underlying token. Two approaches:
- **Experimental pool oracle (Lighter):** XLP provides one-sided liquidity; impact prices are computed from the pre-launch order book; LLP is explicitly excluded[^lighter-docs-2026-04-28-trading-prelaunch-markets].
- **Order-book-anchored mark (Aster):** Mark = Median(Price1, Price2, Contract Price) where Price1 = (Bid1+Ask1)/2 × (1 + FR × t/8) and Price2 = (Bid1+Ask1)/2 — both anchored to the pre-market book rather than an external index[^aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts].

**Margin mode.** Pre-launch markets typically restrict cross-margin or operate in isolated mode only, because volatility and oracle uncertainty make cross-margin exposure too correlated with the pre-launch book's liquidity gaps[^lighter-docs-2026-04-28-trading-prelaunch-markets][^aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts].

**Liquidation flow.** The absence of a reliable backstop oracle means the standard liquidation waterfall must be modified:
- Lighter: no liquidation fee on pre-launch; between MMR and CMR an exchange-issued IoC at zero fee closes the position; below CMR the user is directly ADL'd — bypassing LLP-takeover — because ADL fires before bankruptcy, giving counterparties a more favorable execution price[^lighter-docs-2026-04-28-trading-prelaunch-markets].
- Aster: standard perp liquidation flow applies after conversion; during pre-market the expiry-futures structure bounds downside[^aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts].

**Conversion / settlement.** When the underlying token lists on external venues or tokenomics are released, the pre-launch contract either:
- Converts to a standard perpetual (Lighter, Aster)[^lighter-docs-2026-04-28-trading-prelaunch-markets][^aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts].
- Aster reserves the right to initiate delivery automatically and retains final authority over the delivery price[^aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts].

## Variants in the wild

| venue | structure | margin mode | liquidity provider | mark price source | liquidation flow | liq fee | conversion trigger |
|---|---|---|---|---|---|---|---|
| [[entities/perpdex/lighter]] | perpetual | isolated only — cross restricted due to volatility[^lighter-docs-2026-04-28-trading-prelaunch-markets] | XLP (Experimental Liquidity Provider); LLP excluded[^lighter-docs-2026-04-28-trading-prelaunch-markets] | pre-launch order book impact prices; standard mark formula applies post-conversion[^lighter-docs-2026-04-28-trading-prelaunch-markets] | no LLP-takeover; between MMR–CMR: exchange IoC at zero fee; below CMR: direct ADL (pre-bankruptcy)[^lighter-docs-2026-04-28-trading-prelaunch-markets] | none[^lighter-docs-2026-04-28-trading-prelaunch-markets] | token launches externally or Lighter Governance initiates[^lighter-docs-2026-04-28-trading-prelaunch-markets] |
| [[entities/perpdex/aster]] | expiry futures (sometimes perpetual) | not stated separately; standard perp margin applies after conversion[^aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts] | standard LP / Insurance Fund[^aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts] | Median(Price1, Price2, Contract Price) — both Price1 and Price2 anchored to local pre-market book, no external index[^aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts] | standard 5-step perp waterfall after conversion[^aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts] | standard (post-conversion)[^aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts] | Aster-initiated on external token launch or tokenomics release; delivery price at Aster's discretion[^aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts] |

(Hyperliquid row: HL pre-launch perp details not yet surfaced in primary docs at this snapshot.)

## Edge cases
- **ADL-before-bankruptcy on Lighter pre-launch.** Lighter's pre-launch ADL fires when account falls below CMR — not waiting for insolvency. This gives the ADL counterparty a more favorable price than a standard bankruptcy-triggered ADL but means counterparties can be forced to deleverage while neither party is insolvent[^lighter-docs-2026-04-28-trading-prelaunch-markets].
- **Aster delivery-price discretion.** Aster retains final authority over the delivery price at conversion[^aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts]. This creates a legal and economic dependency on Aster's judgment at the settlement moment — a counterparty risk distinct from standard perpetual settlement (which has no settlement event).
- **Oracle self-reference loop.** When both Price1 and Price2 are derived from the same pre-market book (Aster), mark price is fully endogenous. This provides no manipulation resistance from external reference prices — a sufficiently large participant controls mark price by controlling the book[^aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts].
A pre-launch perpetual is a derivatives contract listed before a reliable external oracle exists for the underlying asset, using a venue-internal price reference (e.g. mark TWAP) until an external oracle becomes available[^drift-docs-2026-04-28-protocol-trading-prelaunch-markets].

## Variants in the wild

| venue | model | current value | notes |
|---|---|---|---|
| [[entities/perpdex/drift]] | custom Prelaunch oracle (mark-TWAP, window = funding period) with initial price and max price bounds | default tier: Highly Speculative (no external IF)[^drift-docs-2026-04-28-protocol-trading-prelaunch-markets][^drift-docs-2026-04-28-protocol-trading-market-specs] | configured with conservative OI limits to resist manipulation; oracle source switched once external oracle available; insurance limited to per-market fee pool only[^drift-docs-2026-04-28-protocol-trading-prelaunch-markets] |

## Edge cases
- Without an external oracle, the mark-TWAP oracle is vulnerable to feedback loops (price is derived from its own market's trading activity).
- Max price bound on the Prelaunch oracle prevents unbounded runaway but may create a ceiling effect on legitimate price discovery.

## Disputed claims
None.

## Related
[[parameters/lighter/listed-markets-roster]] · [[parameters/aster/listing-policy]] · [[concepts/risk/liquidation]] · [[concepts/risk/adl-waterfall]]

## Sources
[^lighter-docs-2026-04-28-trading-prelaunch-markets]: [[sources/lighter-docs-2026-04-28-trading-prelaunch-markets]]
[^aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts]: [[sources/aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts]]
[[concepts/listing/listing-playbook]] · [[concepts/market-microstructure/oracle-spec]] · [[concepts/risk/insurance-fund-sizing]]

## Sources
[^drift-docs-2026-04-28-protocol-trading-prelaunch-markets]: [[sources/drift-docs-2026-04-28-protocol-trading-prelaunch-markets]]
[^drift-docs-2026-04-28-protocol-trading-market-specs]: [[sources/drift-docs-2026-04-28-protocol-trading-market-specs]]
