---
type: source
id: drift-docs-2026-04-28-protocol-risk-and-safety-audits
title: Audits
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/protocol/risk-and-safety/audits
mirror_snapshot: drift-docs-2026-04-28
mirror_page: pages/protocol-risk-and-safety-audits.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Audits

## TL;DR
Drift's first-party audits page lists three audits as of this snapshot: Trail of Bits (Nov 7 – Dec 2, 2022 with Jan 23–25, 2023 fixup review; no high-severity findings), Neodyme (May 10, 2024, last updated June 27, 2024; scope: protocol-v2), and OtterSec (Metamask Snap "Connect" by Drift). Trail of Bits is described as a Tier-1 security auditor. The undetermined Trail-of-Bits finding (test code in production) is documented on page 77 of their report. NOTE: The "ClawSecure Feb 2026" audit citation that appears in the secondary-source Credshields post-mortem (2026-04-06) is NOT present on this canonical first-party audits page and is NOT extracted into this source per AGENTS.md hallucination guards.

## Source confidence

This is a primary-source first-party audits page (high authority). The mirror snapshot's preserved disclaimer at end of page note explicitly records that ClawSecure was NOT followed: per the queue file's recon, ClawSecure 2026 appears only in a secondary post-mortem and ClawSecure's public identity is an AI-agent skill scanner, not a Solana smart-contract auditor. NO ClawSecure URL was fetched into this snapshot.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Drift Protocol engaged Trail of Bits to audit the security of its decentralized exchange and smart contract. | [[parameters/drift/audits]] | A8-PV |
| #c2 | Trail of Bits is recognized as a Tier-1 security auditor with notable clients including Google and Microsoft. | [[parameters/drift/audits]] | - |
| #c3 | The Trail of Bits security audit of Drift Protocol was conducted from November 7 to December 2, 2022. | [[parameters/drift/audits]] | A8-PV |
| #c4 | Trail of Bits used a mix of static and dynamic testing of the codebase, with both automated and manual processes, with full knowledge of the target system (source + docs). | [[parameters/drift/audits]] | A8-PV |
| #c5 | The Trail of Bits audit did not uncover any high-severity flaws that could impact system confidentiality, integrity, or availability. | [[parameters/drift/audits]] | A8-PV |
| #c6 | Between January 23 and January 25, 2023, Trail of Bits reviewed Drift Protocol's fixes and mitigations for the original audit findings. | [[parameters/drift/audits]] | A8-PV |
| #c7 | A summary of outstanding Trail-of-Bits findings is on page 73 of the report; the undetermined finding (testing code used in production) is on page 77. | [[parameters/drift/audits]] | A8-PV |
| #c8 | Neodyme audited Drift's protocol-v2 codebase, authored May 10, 2024, last updated June 27, 2024. | [[parameters/drift/audits]] | A8-PV |
| #c9 | OtterSec audited the Metamask Snap "Connect" by Drift. | [[parameters/drift/audits]] | A8-PV |
