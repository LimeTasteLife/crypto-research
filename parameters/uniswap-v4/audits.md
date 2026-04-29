---
type: parameter
entity: [[entities/dex/uniswap-v4]]
parameter: audits
unit: text
last_change: 2024-11-01
last_reviewed: 2026-04-29
disputed: false
---

# Uniswap v4 Audits

## Current (as of 2024-11-01)

### Core audits (9 independent audits, July-September 2024)

Uniswap v4 core and periphery contracts underwent nine independent security audits[^uniswap-v4-contracts-2026-04-29-overview]:

- **OpenZeppelin** — v4-core (July 2024) + v4-periphery (September 2024)
- **Certora** — v4-core (July 2024)
- **Trail of Bits** — v4-core (September 2024)
- **Spearbit** — v4-core (September 2024) + v4-periphery (September 2024)
- **ABDK** — v4-core (September 2024) + v4-periphery (September 2024)

### Bug bounty

$15.5M bug bounty program on Cantina, launched November 2024 — largest in DeFi history at launch[^uniswap-v4-contracts-2026-04-29-overview]. Covers v4-core and v4-periphery contracts. Third-party hook contracts are explicitly out of scope (hook developers must run their own bounties).

### Security competition

$2.35M security competition with 500+ researchers; no critical vulnerabilities found (pre-launch, 2024).

## Time series

| effective | event | source |
|-----------|-------|--------|
| 2024-07 | OpenZeppelin + Certora v4-core audits | [^uniswap-v4-contracts-2026-04-29-overview] |
| 2024-09 | Trail of Bits, Spearbit, ABDK core audits + OpenZeppelin, Spearbit, ABDK periphery audits | [^uniswap-v4-contracts-2026-04-29-overview] |
| 2024-09 | $2.35M security competition (500+ researchers, no critical findings) | [^uniswap-v4-contracts-2026-04-29-overview] |
| 2024-11 | $15.5M Cantina bug bounty launched | [^uniswap-v4-contracts-2026-04-29-overview] |

## Disputed values
None.

## Sources
[^uniswap-v4-contracts-2026-04-29-overview]: [[sources/uniswap-v4-contracts-2026-04-29-overview]]
