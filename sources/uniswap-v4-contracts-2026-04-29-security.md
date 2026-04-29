---
type: source
id: uniswap-v4-contracts-2026-04-29-security
title: Uniswap v4 Security Framework
publisher: Uniswap Foundation
author: Uniswap Foundation
date: 2026-04-29
original_url: https://docs.uniswap.org/contracts/v4/security
mirror_snapshot: uniswap-v4-contracts-2026-04-29
mirror_page: pages/security.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-29
---

# Uniswap v4 Security Framework

## TL;DR
The Uniswap Foundation publishes a public, self-directed hook security framework with 12 sections covering hook risk assessment. Nine quantitative scoring dimensions (complexity, custom math, external dependencies, external liquidity exposure, TVL potential, team maturity, upgradeability, autonomous parameter updates, price impacting behavior) with max score 33. Three risk tiers: Low (0-6, one audit + AI analysis), Medium (7-17, one+ audit, bounty recommended), High (18-33, multiple audits mandatory, monitoring mandatory, formal verification recommended). Ten key risk categories include accounting failures, reentrancy, math precision, external dependencies, upgradeability hazards, autonomous behavior, dynamic fees, flash accounting risks, BeforeSwapDelta/NoOp overrides, and permission encoding/salt grinding.

## Claims extracted
| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Security framework is provided by Uniswap Foundation as a public, informational resource; Foundation does not review, audit, or certify submissions | [[parameters/uniswap-v4/hook-security-framework]] | - |
| #c2 | Nine quantitative risk scoring dimensions with total max score 33 | [[parameters/uniswap-v4/hook-security-framework]] | - |
| #c3 | Three risk tiers: Low (0-6), Medium (7-17), High (18-33) with escalating security requirements | [[parameters/uniswap-v4/hook-security-framework]] | - |
| #c4 | Low risk hooks: one full audit + AI static analysis; bug bounty optional | [[parameters/uniswap-v4/hook-security-framework]] | - |
| #c5 | Medium risk hooks: one full audit + optional second; bug bounty recommended | [[parameters/uniswap-v4/hook-security-framework]] | - |
| #c6 | High risk hooks: multiple audits mandatory, monitoring with anomaly detection mandatory, formal verification recommended | [[parameters/uniswap-v4/hook-security-framework]] | - |
| #c7 | Ten key hook risk categories including: accounting/token handling failures, external calls/reentrancy, mathematical correctness, external dependency failures, upgradeability hazards, autonomous behavior, price impacting behavior/dynamic fees, flash accounting/transient state risks, BeforeSwapDelta/NoOp override risks, permission encoding/salt grinding | [[parameters/uniswap-v4/hook-security-framework]] | - |
| #c8 | Security resources include: OpenZeppelin hook libraries + wizard, Hypernative/Hexagate monitoring, Certora/Halmos/SMTChecker formal verification, Foundry/Echidna testing tools | [[parameters/uniswap-v4/hook-security-framework]] | - |

## Conflicts raised
None.
