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
| [[entities/perpdex/aster]] | not surfaced (primary docs) — per-pair minimums for the Perpetuals MM program documented separately at [[parameters/aster/listed-markets-roster]] | linear: nominal value = contracts × transaction price, computed against quote (USDT or USD1)[^aster-docs-2026-04-28-trading-perpetuals-fees] | none for standard perps; pre-launch contracts are expiry futures that auto-convert to standard perps on token launch[^aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts] |

(Other perpdex venues to be added in subsequent ingest passes.)

## Related
[[concepts/fee-model/funding-rate]] · [[parameters/hyperliquid/listed-markets-roster]] · [[concepts/risk/leverage-cap]]

## Sources
[^hl-docs-2026-04-27-trading-contract-specifications]: [[sources/hl-docs-2026-04-27-trading-contract-specifications]]
[^aster-docs-2026-04-28-trading-perpetuals-fees]: [[sources/aster-docs-2026-04-28-trading-perpetuals-fees]]
[^aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts]: [[sources/aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts]]
