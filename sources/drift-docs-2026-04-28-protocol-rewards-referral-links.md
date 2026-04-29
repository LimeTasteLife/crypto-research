---
type: source
id: drift-docs-2026-04-28-protocol-rewards-referral-links
title: Referral Links
publisher: Drift Docs
author: Drift Labs
date: 2026-02-27
original_url: https://docs.drift.trade/protocol/rewards/referral-links
mirror_snapshot: drift-docs-2026-04-28
mirror_page: pages/protocol-rewards-referral-links.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Referral Links

## TL;DR
Drift's referral mechanism: referrer earns 35% of referred-user trading fees; referee gets a 5% discount. No max cap on receivable referrer rewards. Rewards accrue ONLY from taker volume. Important sunset / termination condition: referred users that reach Tier 3 and above (>$10M monthly volume) generate no referrer rewards or referee discount — i.e., a built-in cap on the referral economics for high-volume traders. Attribution window: a referral applies only to new Drift accounts created through the link; the user must click, connect a wallet, and deposit within the same session (one-session attribution). Permissionless self-serve link creation via the UI (max 32 chars; not changeable after first set).

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Referrers earn 35% of the trading fees from users they refer. | [[parameters/drift/referral-program]] | A3-PI |
| #c2 | Referred users receive a 5% discount on their trading fees. | [[parameters/drift/referral-program]] | A3-PI |
| #c3 | There is no max cap on the amount of receivable referrer rewards. | [[parameters/drift/referral-program]] | A3-PI |
| #c4 | Referrer rewards accrue only from taker volume. | [[parameters/drift/referral-program]] | A3-PIII |
| #c5 | Referred users that reach Tier 3 and above (>$10M monthly volume) generate no referrer rewards or referee discount. | [[parameters/drift/referral-program]] | A3-PII, A3-PIV |
| #c6 | The referral link applies solely to new Drift accounts created through that link. | [[parameters/drift/referral-program]] | A3-PI |
| #c7 | For a referral to apply, users must have clicked the link, connected their wallet, and made a deposit within the same session (1-session attribution). | [[parameters/drift/referral-program]] | A3-PI |
| #c8 | Referral links are user-customizable up to 32 characters and cannot be changed after first creation. | [[parameters/drift/referral-program]] | - |
| #c9 | Referral link creation is permissionless and self-serve via the Drift UI (Overview tab → Referrals). | [[parameters/drift/referral-program]] | A3-PI |
