---
type: concept
domain: market-microstructure
name: Contract size
last_reviewed: 2026-04-28
disputed: false
---

# Contract size

## Definition
Contract size is the unit of underlying that one perpetual contract represents. Combined with leverage and mark price, it determines initial margin and the dollar value of one contract.

## Mechanism on Hyperliquid

Each contract represents 1 unit of the underlying spot asset[^hl-docs-2026-04-27-trading-contract-specifications]. Hyperliquid perps are linear contracts with no expiration date; convergence to spot is enforced by funding payments rather than settlement[^hl-docs-2026-04-27-trading-contract-specifications].

## Variants in the wild

| venue | unit | linearity | expiry |
|---|---|---|---|
| [[entities/perpdex/hyperliquid]] | 1 unit underlying[^hl-docs-2026-04-27-trading-contract-specifications] | linear (USDC-collateralized; technically quanto for USDT-denominated)[^hl-docs-2026-04-27-trading-contract-specifications] | none (perpetual)[^hl-docs-2026-04-27-trading-contract-specifications] |

(Other perpdex venues to be added in subsequent ingest passes.)

## Related
[[concepts/fee-model/funding-rate]] · [[parameters/hyperliquid/listed-markets-roster]] · [[concepts/risk/leverage-cap]]

## Sources
[^hl-docs-2026-04-27-trading-contract-specifications]: [[sources/hl-docs-2026-04-27-trading-contract-specifications]]
