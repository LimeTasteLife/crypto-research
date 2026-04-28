---
type: parameter
entity: [[entities/perpdex/lighter]]
parameter: audit-history
unit: count
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: false
---

# Lighter audit history

## Current (as of 2026-04-28)

Lighter publishes completed smart-contract and circuit audits with downloadable PDFs on a public docs page[^lighter-docs-2026-04-28-security-security-audits]. Two distinct external audit firms (Nethermind and Block) have covered the core matching/bridge stack, alongside internal scope-named audits[^lighter-docs-2026-04-28-security-security-audits].

**Audit registry.**

| Scope | Firm | Published | Notes |
|---|---|---|---|
| LighterCore | Nethermind | 2025-09-22 | Core matching engine[^lighter-docs-2026-04-28-security-security-audits] |
| LighterEvmDepositBridge | Nethermind | 2025-09-22 | Ethereum deposit bridge[^lighter-docs-2026-04-28-security-security-audits] |
| Block audit | Block | 2025-04-08 | Scope not detailed on index page[^lighter-docs-2026-04-28-security-security-audits] |
| Block & delta audit | Block | 2025-08-09 | Scope not detailed on index page[^lighter-docs-2026-04-28-security-security-audits] |
| Wrapper | (scope audit) | 2025-10-10 | Internal/scope-named audit[^lighter-docs-2026-04-28-security-security-audits] |
| Desert exit | (scope audit) | 2025-05-11 | Internal/scope-named audit[^lighter-docs-2026-04-28-security-security-audits] |
| Spot | (scope audit) | 2025-11-24 | Internal/scope-named audit[^lighter-docs-2026-04-28-security-security-audits] |

**Gap.** No audit remediation status or findings appear on the public index page[^lighter-docs-2026-04-28-security-security-audits]. Bug bounty programme is publicly signaled but unpublished — see [[parameters/lighter/bug-bounty]].

## Time series

| effective | firms | audited scopes | total reports | source |
|---|---|---|---|---|
| 2025-04-08 → 2025-11-24 | Nethermind, Block + scope audits | LighterCore, bridge, Block, Block+delta, Wrapper, Desert exit, Spot | 7 | [^lighter-docs-2026-04-28-security-security-audits] |
| 2026-04-28 (snapshot) | (same) | (same) | 7 | [^lighter-docs-2026-04-28-security-security-audits] |

## Tiering rules / formulae
Not applicable — parameter is an audit registry, not formulaic.

## Disputed values
None.

## Sources
[^lighter-docs-2026-04-28-security-security-audits]: [[sources/lighter-docs-2026-04-28-security-security-audits]]
