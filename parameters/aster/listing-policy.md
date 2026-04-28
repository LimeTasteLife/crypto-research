---
type: parameter
entity: [[aster]]
parameter: listing-policy
unit: policy
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: false
---

# Aster listing policy

## Current (as of 2026-04-28)

**Pre-launch contract structure.** Aster lists tokens before they trade on major exchanges, structured as **expiry futures** (sometimes perpetuals) that auto-convert to a regular perp once the underlying token launches[^aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts].

**Conversion triggers (Aster discretion).** Aster claims unilateral authority to initiate the conversion / delivery process under either of two triggers[^aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts]:

1. The underlying token launches on an external exchange.
2. The token's tokenomics are released publicly.

Pre-market mode switches automatically to a perpetual contract upon delivery trigger; Aster retains final authority over the delivery price[^aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts].

**Delisting.** Aster retains the right to delist a pre-launch contract at its discretion[^aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts].

**Pre-market mark price.** While in pre-market mode, the standard external Price Index does not exist, so Aster anchors both Price 1 and Price 2 to the local pre-market order book's `(Bid1 + Ask1)/2`[^aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts]:

- `Pre-launch Price 1 = (Bid1 + Ask1)/2 × (1 + FundingRate × TimeToNextFunding(h)/8)`
- `Pre-launch Price 2 = (Bid1 + Ask1)/2`
- `Pre-launch Mark Price = median(Price1, Price2, ContractPrice)`

After conversion to perpetual, the standard perp index/mark methodology applies — see [[parameters/aster/oracle-config]][^aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts].

**Mark price purpose in pre-market.** Pre-launch USDT-margined futures use Mark Price specifically to avoid unnecessary liquidations during thin local-book conditions and to suppress manipulation of the highly illiquid pre-market order book[^aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts].

**Pre-launch Price 2 logic discretion.** Aster reserves the right to update Pre-launch Price 2 logic based on market conditions[^aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts].

## Time series

| effective | structure | conversion trigger | mark price (pre-market) | mark price (post-conversion) | source |
|---|---|---|---|---|---|
| 2026-04-28 | expiry futures (some perps) | external launch OR tokenomics release (Aster initiates) | median of local-book-anchored Price 1, Price 2, Contract | standard perp methodology | [^aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts] |

## Tiering rules / formulae

- Pre-launch Price 1 = `(Bid1 + Ask1)/2 × (1 + FundingRate × Δt_next/8)`
- Pre-launch Price 2 = `(Bid1 + Ask1)/2`
- Pre-launch Mark = `median(Price1, Price2, ContractPrice)`

## Disputed values
None.

## Sources
[^aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts]: [[sources/aster-docs-2026-04-28-trading-perpetuals-pre-launch-contracts]]
