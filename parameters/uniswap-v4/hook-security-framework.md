---
type: parameter
entity: [[entities/dex/uniswap-v4]]
parameter: hook-security-framework
unit: text
last_change: 2024-11-01
last_reviewed: 2026-04-29
disputed: false
---

# Uniswap v4 Hook Security Framework

## Current (as of 2024-11-01)

The Uniswap Foundation publishes a public, self-directed security framework for hook developers[^uniswap-v4-contracts-2026-04-29-security]. The Foundation does not review, audit, or certify any submissions[^uniswap-v4-contracts-2026-04-29-security].

### Risk scoring (9 dimensions, max 33)

| dimension | max score |
|-----------|-----------|
| Complexity | 5 |
| Custom math | 5 |
| External dependencies | 3 |
| External liquidity exposure | 3 |
| TVL potential | 5 |
| Team maturity | 3 |
| Upgradeability | 3 |
| Autonomous parameter updates | 3 |
| Price impacting behavior | 3 |

### Risk tiers

| tier | score range | requirements |
|------|-------------|--------------|
| Low | 0-6 | One full audit + AI static analysis; bug bounty optional[^uniswap-v4-contracts-2026-04-29-security] |
| Medium | 7-17 | One full audit + optional second for complex components; bug bounty recommended[^uniswap-v4-contracts-2026-04-29-security] |
| High | 18-33 | Multiple audits mandatory; monitoring with anomaly detection mandatory; formal verification recommended[^uniswap-v4-contracts-2026-04-29-security] |

### Key risk categories (10)

1. Accounting & Token Handling Failures (incorrect delta handling, ERC20 assumptions, rehypothecation)[^uniswap-v4-contracts-2026-04-29-security]
2. External Calls, Reentrancy, and State Drift[^uniswap-v4-contracts-2026-04-29-security]
3. Mathematical Correctness & Precision Risks[^uniswap-v4-contracts-2026-04-29-security]
4. External Dependency Failures (oracles, lending protocols, bridges)[^uniswap-v4-contracts-2026-04-29-security]
5. Upgradeability Hazards (storage collisions, governance attacks)[^uniswap-v4-contracts-2026-04-29-security]
6. Autonomous Behavior or Parameter Updates[^uniswap-v4-contracts-2026-04-29-security]
7. Price Impacting Behavior and Dynamic Fees[^uniswap-v4-contracts-2026-04-29-security]
8. Flash Accounting and Transient State Risks[^uniswap-v4-contracts-2026-04-29-security]
9. BeforeSwapDelta and NoOp Override Risks[^uniswap-v4-contracts-2026-04-29-security]
10. Permission Encoding & Salt Grinding[^uniswap-v4-contracts-2026-04-29-security]

### Recommended security resources

- **Hook Libraries:** OpenZeppelin Solidity library + contract wizard[^uniswap-v4-contracts-2026-04-29-security]
- **Monitoring:** Hypernative (anomaly detection), Hexagate (threat intelligence)[^uniswap-v4-contracts-2026-04-29-security]
- **Formal Verification:** Certora, Halmos (Nethermind), Solidity SMTChecker[^uniswap-v4-contracts-2026-04-29-security]
- **Auditors:** Areta, Spearbit, Code4rena/Cantina, OpenZeppelin[^uniswap-v4-contracts-2026-04-29-security]
- **Testing:** Foundry, Echidna, Diligence Scribble, Hacken v4 Hook Testing Framework[^uniswap-v4-contracts-2026-04-29-security]

## Disputed values
None.

## Sources
[^uniswap-v4-contracts-2026-04-29-security]: [[sources/uniswap-v4-contracts-2026-04-29-security]]
