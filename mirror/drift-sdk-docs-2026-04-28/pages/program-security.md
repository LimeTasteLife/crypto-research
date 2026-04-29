# Security - Drift Protocol v2

Source: https://mintlify.com/drift-labs/protocol-v2/program/security

# Security

> Security considerations and bug bounty program

Drift Protocol prioritizes security through audits, testing, and a bug bounty program.

## Bug Bounty Program

Drift offers bug bounties for on-chain program code vulnerabilities:

| Severity | Description | Bounty |
| --- | --- | --- |
| Critical | Funds drainage or theft without signatures | Up to $500,000 |
| High | Funds freezing or incorrect value assignment | $10,000 - $50,000 |
| Medium/Low | Other bugs not threatening funds | $1,000 - $5,000 |

### Submission

Email hello@drift.trade with:

- Detailed attack vector description
- Proof of concept (for critical/high severity)
- Steps to reproduce

Response within 1 business day.

### Payment

Bug bounties are paid in USDC. Alternative payment methods case-by-case.

### Out of Scope

- Already exploited attacks
- Leaked credentials
- Privileged address access
- Oracle data issues (except manipulation attacks)
- Liquidity issues
- Third-party bot errors
- Social engineering
- DoS attacks
- Violating Immunefi rules

## Security Best Practices

## Oracle guard rails

The protocol uses oracle guard rails to prevent manipulation:

- Price staleness checks
- Confidence interval limits
- Mark/oracle divergence limits
- TWAP for manipulation resistance

## Margin requirements

Size-based margin scaling prevents excessive leverage on large positions.

## Position limits

Per-market position limits prevent market concentration risk.

## Liquidation safeguards

Progressive liquidation system protects against cascading liquidations.

## Audits

Drift has been audited by multiple security firms. See AUDIT.md in the repository for details.

## Severity Classification

Based on Immunefi's classification system:

- Critical: Contract drainage, fund theft, permanent freezing
- High: Temporary freezing, incorrect value assignment
- Medium/Low: Non-fund-threatening bugs

## Contact

- Security issues: hello@drift.trade
- Discord: Join Drift Discord

Do not publicly disclose vulnerabilities before reporting them to the team.

## Architecture

Program architecture overview

## Bug Bounty Details

Full bug bounty information
