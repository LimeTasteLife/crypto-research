# Mirror Snapshots Index

Rollup of all crawled mirror snapshots. Updated by Phase 2 of batch ingest. See [../AGENTS.md](../AGENTS.md) §"Mirror data".

**Refresh is user-initiated only.** No automatic re-crawls. Ask the user before re-fetching any root.

To answer "when was X last refreshed?": find the row with `status: active` for that root in the table below.

## Active

| snapshot_id | root_url | path_prefix | crawled_at | pages | crawler |
|---|---|---|---|---|---|

_(none yet)_

## Superseded

| snapshot_id | superseded_by | crawled_at | pages |
|---|---|---|---|

_(none yet)_

## Paused (hit max_pages)

| snapshot_id | root_url | crawled_at | pages | max_pages |
|---|---|---|---|---|

_(none yet)_
