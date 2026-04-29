# Security Framework

The aim of this guide, and its accompanying worksheet, is to give hook developers a clear, structured, and self-directed framework for understanding the security risks inherent to their project. It explains how complexity, math, external dependencies, upgradeability, liquidity behavior, and other factors contribute to risk.

This framework is provided as a public, informational resource by the Uniswap Foundation. The Uniswap Foundation does not review, audit, or certify any submissions, scores, or implementations derived from it.

## Guide Overview (12 sections)

1. Understanding Hook Risk in v4: How hooks introduce new security risks
2. Hook Risk Self-Scoring Dimensions: Nine quantitative dimensions for evaluating hook risk
3. Generic Hook Risk Tiers & Recommendations: Maps total scores to low/medium/high tiers
4. Feature-Specific Security Recommendations: Seven high-impact features triggering mandatory security actions
5. How to Evaluate Your Security Needs: Combining risk tiers and feature triggers
6. Operational Security (OPSEC): Protecting processes, information, people, workflows
7. Security Best Practices Checklist: Universal best-practice guidelines
8. Risk Calculator Scoring Sheet: Automated worksheet for scoring
9. How To Use This Framework: Step-by-step workflow
10. Future Extensions Community Driven: Community evolution of the framework
11. Security Resources: External resources for hook builders
12. Conclusion

## Key Hook Risk Categories

- Accounting & Token Handling Failures: incorrect delta handling, ERC20 assumptions, rehypothecation
- External Calls, Reentrancy, and State Drift: nested callbacks, external protocol state changes
- Mathematical Correctness & Precision Risks: rounding drift, domain violations, fixed-point instability
- External Dependency Failures: oracles, lending protocols, bridges
- Upgradeability Hazards: storage collisions, governance attacks
- Autonomous Behavior or Parameter Updates: bounded rate of change, time gating
- Price Impacting Behavior and Dynamic Fees: selective fee raising, MEV vectors
- Flash Accounting and Transient State Risks: delta manipulation mid-execution
- BeforeSwapDelta and NoOp Override Risks: custom curves bypassing CL math
- Permission Encoding & Salt Grinding: CREATE2 address mining for hook permissions

## Risk Self-Scoring Dimensions (9)

1. Complexity (0-5)
2. Custom math (0-5)
3. External dependencies (0-3)
4. External liquidity exposure (0-3)
5. TVL potential (0-5)
6. Team maturity (0-3)
7. Upgradeability (0-3)
8. Autonomous parameter updates (0-3)
9. Price impacting behavior (0-3)

Total max score: 33

## Risk Tiers

- Low Risk (0-6): One full audit + AI static analysis. Bug bounty optional.
- Medium Risk (7-17): One full audit + optional second for complex components. Bug bounty recommended.
- High Risk (18-33): Multiple audits mandatory. Monitoring with anomaly detection mandatory. Formal verification recommended.

## Security Resources

### Hook Libraries
- OpenZeppelin: Solidity library for secure and modular Uniswap hooks
- OpenZeppelin: Uniswap Hooks contract wizard

### Monitoring
- Hypernative: real-time anomaly detection
- Hexagate: smart contract threat intelligence

### Formal Verification
- Certora: rule-based invariant verification
- Halmos (Nethermind): symbolic execution
- Solidity SMTChecker

### Audits & Security Reviews
- Areta, Spearbit, Code4rena/Cantina, OpenZeppelin

### Testing Tools
- Foundry, Echidna, Diligence Scribble, Hacken v4 Hook Testing Framework
