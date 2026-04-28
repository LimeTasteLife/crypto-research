---
type: parameter
entity: [[aster]]
parameter: audit-registry
unit: count
last_change: 2026-04-28
last_reviewed: 2026-04-28
disputed: false
---

# Aster audits

## Current (as of 2026-04-28)

**Coverage scope.** Aster publishes seven audit reports across six product surfaces — all dated within 2024 (September to December)[^aster-docs-2026-04-28-overview-audit-reports]. Audit firms are **Salus Security**, **PeckShield**, and **HALBORN**[^aster-docs-2026-04-28-overview-audit-reports].

**Audit registry.**

| Product | Firm | Date | Notes |
|---|---|---|---|
| AsterVault | (per audit page) | 2024-09-13 | [^aster-docs-2026-04-28-overview-audit-reports] |
| AsterEarn | (per audit page) | 2024-09-12 | [^aster-docs-2026-04-28-overview-audit-reports] |
| asBNB | Salus Security | 2024-12-11 | twin-audited[^aster-docs-2026-04-28-overview-audit-reports] |
| asBNB | PeckShield | (per page) | report `PeckShield-Audit-Report-asBNBEarn-v1.0`[^aster-docs-2026-04-28-overview-audit-reports] |
| USDF | PeckShield | (per page) | report `PeckShield-Audit-Report-USDFEarn-v1.0`[^aster-docs-2026-04-28-overview-audit-reports] |
| USDF + asUSDF | HALBORN | (per page) | filed under "Astherus / SSC"[^aster-docs-2026-04-28-overview-audit-reports] |
| asCAKE | Salus Security | 2024-12-17 | [^aster-docs-2026-04-28-overview-audit-reports] |

**Notable gap — L1 / matching engine.** The audit page **does not list any audit covering the Aster Chain L1 itself or the perpetuals matching engine** — only Vault, Earn, asBNB / asCAKE / asUSDF, and USDF token+minting contracts have published audits[^aster-docs-2026-04-28-overview-audit-reports].

**Twin-audit anomaly.** asBNB received twin audits from two different firms (Salus Security and PeckShield), unlike other products which received single audits — possibly indicating elevated review priority for the BNB-staking surface[^aster-docs-2026-04-28-overview-audit-reports].

**Date gap.** All publicly listed Aster audit reports are dated within 2024, predating the 2025 product timeline implied by other docs (e.g., TGE, asUSDF emission changes), so the audit page may lag the live deployed surface[^aster-docs-2026-04-28-overview-audit-reports].

## Time series

| effective | audited products | firms | reports count | L1 / matching engine | source |
|---|---|---|---|---|---|
| 2024-09-12 → 2024-12-17 | Vault, Earn, asBNB, USDF, asUSDF (USDF+asUSDF combined), asCAKE | Salus Security, PeckShield, HALBORN | 7 | not audited (gap) | [^aster-docs-2026-04-28-overview-audit-reports] |
| 2026-04-28 (snapshot) | (same as above; no new audits surfaced) | (same) | 7 | still not audited | [^aster-docs-2026-04-28-overview-audit-reports] |

## Tiering rules / formulae

Not applicable — parameter is an audit registry, not formulaic.

## Disputed values
None.

## Sources
[^aster-docs-2026-04-28-overview-audit-reports]: [[sources/aster-docs-2026-04-28-overview-audit-reports]]
