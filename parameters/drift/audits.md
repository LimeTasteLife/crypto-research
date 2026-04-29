---
type: parameter
entity: [[drift]]
parameter: audits
unit: categorical
last_change: 2024-06-27
last_reviewed: 2026-04-28
disputed: true
---

# Drift audits

## Current (as of 2026-04-28)

**Confirmed first-party audits:**

| auditor | period | scope | severity findings | source |
|---|---|---|---|---|
| Trail of Bits | Nov 7 - Dec 2, 2022 + Jan 23-25, 2023 fixup review | Drift protocol | no high-severity findings; undetermined finding "test code in production" (p.77) | [^drift-docs-2026-04-28-protocol-risk-and-safety-audits] |
| Neodyme | May 10, 2024 (last updated Jun 27, 2024) | protocol-v2 | not surfaced | [^drift-docs-2026-04-28-protocol-risk-and-safety-audits] |
| OtterSec | undated | Metamask Snap "Connect" by Drift | not surfaced | [^drift-docs-2026-04-28-protocol-risk-and-safety-audits] |

Trail of Bits is described as a Tier-1 security auditor[^drift-docs-2026-04-28-protocol-risk-and-safety-audits].

**Bug bounty program (Immunefi classification):**

| severity | payout | source |
|---|---|---|
| Critical (funds drainage / theft without signatures) | up to $500,000 | [^drift-sdk-docs-2026-04-28-program-security] |
| High (funds freezing or incorrect value assignment) | $10,000 - $50,000 | [^drift-sdk-docs-2026-04-28-program-security] |
| Medium / Low (other bugs not threatening funds) | $1,000 - $5,000 | [^drift-sdk-docs-2026-04-28-program-security] |

**Submission.** hello@drift.trade; response within 1 business day; paid in USDC[^drift-sdk-docs-2026-04-28-program-security].

**Out of scope.** Already-exploited attacks, leaked credentials, privileged address access, oracle data issues (except manipulation), liquidity issues, third-party bot errors, social engineering, DoS, Immunefi rules violations[^drift-sdk-docs-2026-04-28-program-security].

**Public disclosure.** Forbidden before reporting[^drift-sdk-docs-2026-04-28-program-security].

**Documented security best-practices.** Oracle guard rails (staleness, confidence interval, mark/oracle divergence, TWAP), size-based margin scaling, per-market position limits, progressive liquidation[^drift-sdk-docs-2026-04-28-program-security].

## Time series

| effective | auditor | scope | source |
|---|---|---|---|
| 2022-11-07 | Trail of Bits | Drift protocol | [^drift-docs-2026-04-28-protocol-risk-and-safety-audits] |
| 2023-01-25 | Trail of Bits (fixup) | Drift protocol | [^drift-docs-2026-04-28-protocol-risk-and-safety-audits] |
| 2024-05-10 | Neodyme | protocol-v2 | [^drift-docs-2026-04-28-protocol-risk-and-safety-audits] |
| undated | OtterSec | Metamask Snap "Connect" | [^drift-docs-2026-04-28-protocol-risk-and-safety-audits] |

## Disputed values

### Disputed claims -- ClawSecure February 2026 audit citation

**Claim A** - confidence: high - recency: 2026-02 - authority: high
  Drift's first-party audits page lists three audits: Trail of Bits, Neodyme, and OtterSec. No ClawSecure citation appears[^drift-docs-2026-04-28-protocol-risk-and-safety-audits].

**Claim B** - confidence: low - recency: 2026 - authority: low
  Secondary post-mortem material (referenced in queue file reconnaissance, not crawled into this snapshot) cites a ClawSecure February 2026 audit of Drift. ClawSecure's public identity is an AI-agent skill scanner, not a Solana smart-contract auditor.
  status: unverified

-> Open question (#dispute-clawsecure-2026): see open-questions.md.

## Sources
[^drift-docs-2026-04-28-protocol-risk-and-safety-audits]: [[sources/drift-docs-2026-04-28-protocol-risk-and-safety-audits]]
[^drift-sdk-docs-2026-04-28-program-security]: [[sources/drift-sdk-docs-2026-04-28-program-security]]
