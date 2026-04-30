---
type: source
id: dydx-docs-2026-04-28-interaction-integration-builder-codes
title: Builder Codes
publisher: dYdX Docs
author: dYdX team
date: null
original_url: https://docs.dydx.xyz/interaction/integration/integration-builder-codes
mirror_snapshot: dydx-docs-2026-04-28
mirror_page: pages/interaction-integration-builder-codes.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Builder Codes

## TL;DR
Builder codes complement Order Router Rev Share — but distinct in two ways: (1) fee is added on top of the fill (not a split of existing fee revenue) and (2) no governance proposal required. `BuilderCodeParameters` fields: `feePpm` (charged on order matching) and `builderAddress` (recipient). Validation: feePpm in `(0, 10000]`, builder address must be valid. Queryable via `/orders` and `/fills`.

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Builder codes enable external parties to submit orders to dYdX and collect per-order fees for building/routing the order. | [[entities/perpdex/dydx]] | A3-PI |
| #c2 | Builder code fees are added on top of each fill (not a split of existing fee revenue, unlike Order Router Rev Share). | [[entities/perpdex/dydx]] | A3-PI, A2-PIV |
| #c3 | No governance proposal is required to use builder codes. | [[entities/perpdex/dydx]] | A3-PI, A7-PI |
| #c4 | Builder code fees and addresses can be queried via the indexer's `/orders` and `/fills` endpoints. | [[entities/perpdex/dydx]] | A3-PI |
| #c5 | `BuilderCodeParameters` consists of `feePpm` (fee in parts-per-million) and `builderAddress` (where fees are routed). | [[entities/perpdex/dydx]] | A3-PI |
| #c6 | The `feePpm` value must be in the range (0, 10,000]. | [[entities/perpdex/dydx]] | A3-PI |
