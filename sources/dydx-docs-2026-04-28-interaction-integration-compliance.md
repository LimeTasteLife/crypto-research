---
type: source
id: dydx-docs-2026-04-28-interaction-integration-compliance
title: Compliance
publisher: dYdX Docs
author: dYdX team
date: null
original_url: https://docs.dydx.xyz/interaction/integration/integration-compliance
mirror_snapshot: dydx-docs-2026-04-28
mirror_page: pages/interaction-integration-compliance.md
raw_path: null
kind: docs
authority: high
ingested: 2026-04-28
---

# Compliance

## TL;DR
A9 surface — explicit blocked-jurisdiction list. Prohibited: USA, Canada, Iran, Cuba, North Korea, Syria, Myanmar/Burma, Crimea/Donetsk/Luhansk; OFAC-sanctioned parties; any other persons whose use is contrary to applicable law. Third parties integrating with the open-source software are expected to enforce these terms client-side. dYdX provides two indexer endpoints to support: `/v4/geo` (returns IP-derived geo + blocked boolean) and `/v4/screen/<address>` (returns per-address compliance status).

## Claims extracted

| id | claim | filed_to | frame_tag |
|----|-------|----------|-----------|
| #c1 | Per the dYdX terms of service, persons or entities residing/located/incorporated/operated in the United States or Canada are prohibited from using dYdX Software. | [[parameters/dydx-v4/compliance]], [[entities/perpdex/dydx]] | A9-PI |
| #c2 | Persons or entities tied to Iran, Cuba, North Korea, Syria, Myanmar (Burma), or Crimea/Donetsk/Luhansk regions are prohibited from using dYdX Software. | [[parameters/dydx-v4/compliance]] | A9-PI |
| #c3 | Persons or entities subject to OFAC sanctions or designated on any prohibited/restricted-parties list are prohibited from using dYdX Software. | [[parameters/dydx-v4/compliance]] | A9-PI |
| #c4 | Third parties integrating with the dYdX open-source software are expected to comply with the dYdX terms and must implement client-side geo-blocking. | [[parameters/dydx-v4/compliance]] | A9-PV |
| #c5 | The indexer's `/v4/geo` endpoint returns the user's location info (country, region, city, timezone, lat/lng) and a `blocked` boolean based on requesting IP. | [[parameters/dydx-v4/compliance]] | A9-PI |
| #c6 | The indexer's `/v4/screen/<address>` endpoint returns a per-address compliance status (e.g. COMPLIANT) with a reason and updatedAt timestamp. | [[parameters/dydx-v4/compliance]] | A9-PI |
