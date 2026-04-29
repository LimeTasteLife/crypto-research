# Mirror Snapshots Index

Rollup of all crawled mirror snapshots. Updated by Phase 2 of batch ingest. See [../AGENTS.md](../AGENTS.md) §"Mirror data".

**Refresh is user-initiated only.** No automatic re-crawls. Ask the user before re-fetching any root.

To answer "when was X last refreshed?": find the row with `status: active` for that root in the table below.

## Active

| snapshot_id | root_url | path_prefix | crawled_at | pages | crawler |
|---|---|---|---|---|---|
| hl-docs-2026-04-27 | https://hyperliquid.gitbook.io/hyperliquid-docs | /hyperliquid-docs/ | 2026-04-27T17:20:00Z | 20 | exa |
| lighter-docs-2026-04-28 | https://docs.lighter.xyz/ | / | 2026-04-28T00:58:21Z | 31 | exa |
| drift-docs-2026-04-28 | https://docs.drift.trade/ | / | 2026-04-28T17:00:00Z | 80 | exa |
| drift-developers-2026-04-28 | https://docs.drift.trade/developers | /developers/ | 2026-04-28T17:30:00Z | 45 | exa |
| drift-sdk-2026-04-28 | https://mintlify.com/drift-labs/protocol-v2/ | /drift-labs/protocol-v2/ | 2026-04-28T18:00:00Z | 62 | exa |

## Superseded

| snapshot_id | superseded_by | crawled_at | pages |
|---|---|---|---|

_(none yet)_

## Paused (hit max_pages)

| snapshot_id | root_url | crawled_at | pages | max_pages |
|---|---|---|---|---|
| aster-docs-2026-04-28 | https://docs.asterdex.com/ | 2026-04-28T01:05:00Z | 20 | 20 |
| hl-docs-2026-04-27 | https://hyperliquid.gitbook.io/hyperliquid-docs | 2026-04-27 | 20 | 20 |
| drift-docs-2026-04-28 | https://docs.drift.trade/ | 2026-04-28T02:30:00Z | 20 | 20 |
| drift-developers-docs-2026-04-28 | https://docs.drift.trade/developers | 2026-04-28T02:45:00Z | 20 | 20 |
| drift-sdk-docs-2026-04-28 | https://mintlify.com/drift-labs/protocol-v2/ | 2026-04-28T03:00:00Z | 20 | 20 |
