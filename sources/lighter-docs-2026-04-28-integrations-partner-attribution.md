---
type: source
id: lighter-docs-2026-04-28-integrations-partner-attribution
title: Partner Attribution
publisher: Lighter Docs
author: Lighter team
date: null
original_url: https://docs.lighter.xyz/integrations/partner-attribution
mirror_snapshot: lighter-docs-2026-04-28
mirror_page: pages/integrations-partner-attribution.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Partner Attribution

## TL;DR
The Partner Attribution Program lets third-party integrators run a Lighter-powered frontend and configure their own user fees within Lighter's global limits. Integrator fee caps: 10 bps for perpetuals, 1% for spot, with 0.01 bps as the minimum increment. Users must sign an approval before any integrator fee can apply; the approval can include an expiry and is user-revocable. If integrator and user share an L1 account, only an L2 confirmation is needed; otherwise an L1 approval plus L2 confirmation is required. Partners onboard via the dedicated API docs and Python SDK.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | The Partner Attribution Program allows third-party integrators to build on Lighter and offer its trading infrastructure through their own frontend. | [[entities/perpdex/lighter]] | A3-PV |
| #c2 | Integrators may configure trading fees for users accessing Lighter through their interface, within global limits set by Lighter. | [[entities/perpdex/lighter]], [[parameters/lighter/fee-schedule]] | A3-PIV, A2-PIV |
| #c3 | Integrators may configure fees for both spot and perpetual markets. | [[entities/perpdex/lighter]] | A3-PIV |
| #c4 | Global integrator fee cap on perpetual markets: up to 10 bps. | [[parameters/lighter/fee-schedule]] | A3-PIV, A2-PIV |
| #c5 | Global integrator fee cap on spot markets: up to 1%. | [[parameters/lighter/fee-schedule]] | A3-PIV, A2-PIV |
| #c6 | Minimum integrator fee increment: 0.01 bps. | [[parameters/lighter/fee-schedule]] | A3-PIV |
| #c7 | Before integrator fees can be applied, the user must sign a message approving the integrator's fee configuration. | [[entities/perpdex/lighter]] | A3-PV |
| #c8 | Integrator fee approval may include an expiry period if the integrator chooses to set one. | [[entities/perpdex/lighter]] | A3-PV |
| #c9 | The user can revoke the integrator fee approval at any time. | [[entities/perpdex/lighter]] | A3-PV |
| #c10 | When integrator and user are different L1 accounts, the approval requires an L1 approval plus an L2 confirmation. | [[entities/perpdex/lighter]] | A3-PV |
| #c11 | When integrator and user share the same L1 account, only an L2 confirmation is required. | [[entities/perpdex/lighter]] | A3-PV |
| #c12 | Partner integration API docs are at https://apidocs.lighter.xyz/docs/partner-integration. | [[entities/perpdex/lighter]] | A3-PV |
| #c13 | A Python SDK (lighter-sdk) is published on PyPI at https://pypi.org/project/lighter-sdk/. | [[entities/perpdex/lighter]] | A3-PV |

## Conflicts raised
