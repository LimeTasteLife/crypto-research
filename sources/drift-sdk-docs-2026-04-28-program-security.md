---
type: source
id: drift-sdk-docs-2026-04-28-program-security
title: Security
publisher: Drift Protocol v2 SDK Docs (Mintlify)
author: Drift Labs
date: null
original_url: https://mintlify.com/drift-labs/protocol-v2/program/security
mirror_snapshot: drift-sdk-docs-2026-04-28
mirror_page: pages/program-security.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Security

## TL;DR
Drift bug bounty (severity-classified per Immunefi rules): Critical (funds drainage / theft without signatures) up to $500,000; High (funds freezing or incorrect value assignment) $10,000–$50,000; Medium/Low (other bugs not threatening funds) $1,000–$5,000. Submission email: hello@drift.trade. Required: detailed attack vector, proof-of-concept (for critical/high), reproduction steps. Response within 1 business day. Paid in USDC. Out of scope: already-exploited attacks, leaked credentials, privileged address access, oracle data issues (except manipulation), liquidity issues, third-party bot errors, social engineering, DoS, Immunefi rules violations. Security best-practices listed: oracle guard rails, size-based margin scaling, per-market position limits, progressive liquidation. Audits documented in AUDIT.md (the page does not enumerate audits inline). Severity classification follows Immunefi's system. Public disclosure before reporting is forbidden.

## Source confidence

The bug bounty payout figures (Critical $500k, High $10k–$50k, Medium/Low $1k–$5k) on this Mintlify SDK-docs Security page MATCH the figures cited in the queue file's Phase 0 recon (which were stated to come from `github.com/drift-labs/protocol-v2/SECURITY.md` fetched at recon time only and out of mirror scope). Per AGENTS.md guidance to flag potentially-out-of-snapshot claims at low-confidence, but here the figures are present in this snapshot's mirror page directly — so they are extracted here as in-snapshot. The queue file's own caveat about SECURITY.md being out-of-scope does NOT affect these claims since they are visible in this page.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Drift bug bounty Critical payout (funds drainage or theft without signatures): up to $500,000. | [[parameters/drift/audits]] | A8-PV |
| #c2 | Drift bug bounty High payout (funds freezing or incorrect value assignment): $10,000 – $50,000. | [[parameters/drift/audits]] | A8-PV |
| #c3 | Drift bug bounty Medium/Low payout (other bugs not threatening funds): $1,000 – $5,000. | [[parameters/drift/audits]] | A8-PV |
| #c4 | Bug bounty submission email: hello@drift.trade. | [[parameters/drift/audits]] | A8-PV |
| #c5 | Bug bounty submission requires a detailed attack vector description, proof-of-concept (for critical/high severity), and reproduction steps. | [[parameters/drift/audits]] | A8-PV |
| #c6 | Bug bounty response within 1 business day. | [[parameters/drift/audits]] | A8-PV |
| #c7 | Bug bounty payouts are paid in USDC (alternative payment methods case-by-case). | [[parameters/drift/audits]] | A8-PV |
| #c8 | Bug bounty out-of-scope items: already-exploited attacks, leaked credentials, privileged address access, oracle data issues (except manipulation attacks), liquidity issues, third-party bot errors, social engineering, DoS attacks, Immunefi rules violations. | [[parameters/drift/audits]] | A8-PV |
| #c9 | Drift severity classification follows Immunefi's classification system. | [[parameters/drift/audits]] | A8-PV |
| #c10 | Public disclosure of vulnerabilities before reporting them to Drift is forbidden. | [[parameters/drift/audits]] | A8-PV |
| #c11 | Drift's documented security best practices: oracle guard rails (staleness checks, confidence interval limits, mark/oracle divergence limits, TWAP for manipulation resistance), size-based margin scaling, per-market position limits, progressive liquidation. | [[parameters/drift/risk-parameters]] | A6-PI, A8-PI |
