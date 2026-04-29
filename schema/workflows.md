# Workflows — Ingest, Mirror, Batch, Lint, Query

> Split from `AGENTS.md`. All operational workflows that transform data in the wiki.

## Ingest workflow

Trigger: user says `ingest <path>` or drops a file in `raw/` and asks you to process it.

Steps:

1. Read source. Detect `kind` and `authority` from publisher heuristics.
2. Create `sources/<id>.md` with frontmatter, TL;DR (4–6 lines), and an empty `Claims extracted` table.
3. Extract claims. For each claim:
   - Classify: `definition` | `parameter-value` | `mechanism` | `relation` | `event`.
   - Resolve target page (entity / concept / parameter). Create stub if missing.
   - `parameter-value` → append a row to the time-series table with `[^id]`.
   - `definition` / `mechanism` → add inline-cited sentence to body.
   - `relation` → add wikilink + verb on both endpoints' pages.
   - Record the file-back target in the source page's `Claims extracted` table.
4. Conflict scan: for each new claim, compare against existing claims on the same target. If conflict → apply Disputed claims block protocol (see `schema/confidence.md`).
5. Cross-reference pass: link every newly mentioned entity/concept noun via `[[wikilink]]`.
6. Update `index.md` under correct subtype/domain.
7. Append to `log.md`:
   ```
   ## [YYYY-MM-DD HH:MM] ingest | <source-id> | touched: N pages | claims: N | conflicts: N | new pages: N
   ```
8. Show user a diff summary and any newly raised open questions.

## Mirror data

Web sources are mirrored locally at first ingest and reused for all downstream ontology work. Live URL fetches happen only at (a) initial mirror crawl, (b) explicit `refresh <snapshot-id>`, or (c) one-off user-requested live check (does not auto-mirror).

### Layout

```
mirror/
  <snapshot-id>/
    manifest.yaml
    pages/
      <slug>.md
      ...
```

`<snapshot-id>` = `<root-slug>-<YYYY-MM-DD>`. Examples: `hl-docs-2026-04-27`, `dydx-v4-docs-2026-04-27`, `aevo-blog-clob-2026-05-01`.

### manifest.yaml schema

```yaml
snapshot_id: hl-docs-2026-04-27
root_url: https://hyperliquid.gitbook.io/hyperliquid-docs/trading/fees
host: hyperliquid.gitbook.io
path_prefix: /hyperliquid-docs/trading/
crawled_at: 2026-04-27T14:50:00Z
crawler: exa                           # exa | webfetch  (default: exa, fallback: webfetch)
page_count: 17
status: active                         # active | superseded | paused
supersedes: null                       # snapshot_id of older crawl, if this is a refresh
superseded_by: null                    # snapshot_id of newer crawl, if any
allow: []                              # extra path-prefix regexes (per-URL queue override)
deny: []                               # path-prefix regexes to skip
max_pages: 100                         # soft cap; if exceeded, status=paused
pages:
  - slug: trading-fees
    url: https://hyperliquid.gitbook.io/hyperliquid-docs/trading/fees
    fetched_at: 2026-04-27T14:50:03Z
    status: ok                         # ok | fetch_failed | non_html_skipped
    crawler: exa                       # actual crawler used (may differ from manifest default if fallback fired)
    bytes: 24561
    title: Trading Fees
  - slug: trading-liquidations
    ...
queue_remainder: []                    # optional. URLs known to be in scope but NOT crawled in this run (e.g. status=paused at max_pages, or discovered via llms.txt but truncated). Documentation only; does NOT auto-resume — user must explicitly refresh or queue them.
notes: []                              # optional. Free-form anomaly log for this crawl run. One-liners. Examples: "GitBook nav is JS-rendered; seeded BFS from /llms.txt"; "404 on /old-path → redirect hint to /new-path; followed (no retry charged)"; "exa CRAWL_LIVECRAWL_TIMEOUT on /x; succeeded on second exa attempt".
```

### Crawler selection

**Default: exa MCP** (`mcp__exa-web-search__web_fetch_exa`).
**Fallback: WebFetch** (built-in).

Order, per page fetch:
1. Try `exa.web_fetch_exa(url)`.
2. On exa failure (timeout, tool error, empty/garbage content, blocked) → retry once with `WebFetch(url)`.
3. On WebFetch failure → `status: fetch_failed`, max 2 total retries across both crawlers.
4. Record actual crawler used in `pages[].crawler`.

Per-URL override in queue:
```
https://example.com/x   +crawler=webfetch       # force WebFetch (e.g., exa known-bad for this domain)
https://example.com/y   +crawler=exa            # force exa (skip fallback)
```

For deep-link discovery (BFS through children), use the crawler that succeeded on the seed page — don't mix per page unless one fails.

### Crawl boundary (default)

Same host AND path startswith `path_prefix`. `path_prefix` derived from seed URL by taking the path up to and including the seed's parent directory:

| seed URL path | derived prefix |
|---|---|
| `/hyperliquid-docs/trading/fees` | `/hyperliquid-docs/trading/` |
| `/hyperliquid-docs/` | `/hyperliquid-docs/` |
| `/` | `/` (whole host — soft cap kicks in) |

Soft cap: 100 pages per snapshot. On overflow, save partial manifest with `status: paused` and ask user before continuing.

### Per-URL queue overrides

```
https://hl.gitbook.io/.../trading/fees   +allow=/risk/        # widen prefix
https://hl.gitbook.io/                   +deny=/api/v1/       # exclude subpath
https://docs.dydx.exchange/v4/           +max-pages=200       # raise cap
https://medium.com/@x/post               +nochildren          # single page only
https://hl.gitbook.io/.../fees           +refresh             # force re-crawl even if recent snapshot exists
```

### Page extraction

Each crawled URL → `pages/<slug>.md`.
Slug rule: URL path with `/` replaced by `-`, leading slash stripped, trailing `.html`/`.md` stripped, query strings dropped.
Examples:
- `/hyperliquid-docs/trading/fees` → `trading-fees`
  *(if path-prefix-stripped slug collides, fall back to full-path slug)*
- `/v4/whitepaper.pdf` → `v4-whitepaper` (with `status: non_html_skipped` if not extractable)

Content: cleaned markdown (strip nav/footer/ads). Preserve headings, tables, code blocks, outbound links as `[text](url)`.

### Refresh — user-initiated only

**Refresh is NEVER triggered automatically.** Not by ingest reuse, not by lint, not by any agent action. The user — and only the user — decides when to re-crawl an existing root. Lint may report mirror ages but must not suggest refresh.

Trigger: user says `refresh <snapshot-id>` or `refresh <root-slug>` (most recent active snapshot of that root). Or `+refresh` flag in a queue line for that URL.

Steps:
1. Re-crawl using same `root_url`, `path_prefix`, `allow`, `deny`, `max_pages` from old manifest unless user overrides.
2. Write new snapshot dir `<root-slug>-<today>`.
3. Old manifest: set `status: superseded`, `superseded_by: <new-id>`.
4. New manifest: set `supersedes: <old-id>`.
5. Run claim re-extraction against the new snapshot — produces NEW `sources/<new-id>-<page>.md` files. **Do NOT modify old source pages or wiki pages directly.**
6. Phase 2 merge runs as normal: contradictions between old-snapshot claims and new-snapshot claims surface naturally via the Disputed claims block protocol.
7. Update `mirror/_index.md` with new active row + moved superseded row.

Old snapshots are NEVER deleted. They remain queryable.

### Querying mirror status

When the user asks "when was X last refreshed?", "how old is the X mirror?", "what mirrors do we have?", etc.:

1. Read `mirror/_index.md` first (rollup, fastest).
2. For specifics, read `mirror/<snapshot-id>/manifest.yaml`.
3. Answer with `crawled_at`, `status`, `page_count`, and (if superseded) `superseded_by`.
4. **Do NOT** fetch live URLs to compare. Mirror status is purely a local-file question.

### `mirror/_index.md` — snapshots rollup

Maintained by Phase 2 merge. Three sections (active / superseded / paused), table format:

```
## Active
| snapshot_id | root_url | path_prefix | crawled_at | pages | crawler |
| hl-docs-2026-04-27 | https://hl.gitbook.io/.../trading/ | /hyperliquid-docs/trading/ | 2026-04-27 | 17 | exa |

## Superseded
| snapshot_id | superseded_by | crawled_at | pages |

## Paused
| snapshot_id | root_url | crawled_at | pages | max_pages |
```

### Use rule (load-bearing)

> All claim extraction, lint, and query operations read from `mirror/<snapshot-id>/pages/...`, NOT from live URLs.
> `original_url` in `sources/*.md` is for human reference and refresh, not for runtime fetching.

## Batch ingest workflow (parallel, three-phase)

Trigger: user provides a markdown file containing a flat list of URLs (one per line, blank lines and `#`-comments ignored), e.g. `ingest @raw/queue/queue-001.md` or just hands you the file.

**Hard rule:** parallel agents NEVER touch wiki pages (`entities/`, `concepts/`, `parameters/`, `index.md`, `log.md`, `open-questions.md`). Phase 0.5 agents write only inside `mirror/<snap>/`. Phase 1 agents write only inside `sources/`. Wiki integration happens in a single sequential merge phase.

### Subagent isolation + extended shared-file boundaries [LOAD-BEARING]

This section codifies post-incident lessons from the 2026-04-28 parallel HL/Aster/Lighter/Drift session, where multiple parallel branches independently wrote to shared registry files and produced merge-conflict surfaces.

**Extended forbidden-write list for parallel agents** (in addition to the Hard rule above): `mirror/_index.md`, `AGENTS.md`, `audit/<existing-files>`, `raw/queue/<existing-files>`. These are shared registries / schema documents and may only be modified by:

- The Phase 2 sequential merge controller (for `mirror/_index.md`, `index.md`, `log.md`, `open-questions.md`).
- An explicit user-acknowledged schema-patch session (for `AGENTS.md` and `schema/*.md` schema files).
- An explicit user-acknowledged audit session (for `audit/`).

Parallel platform-ingest agents that need to register a new mirror snapshot, append to `log.md`, or extend `index.md` MUST defer those writes to Phase 2 — never make the writes inside the parallel agent's branch. If a parallel branch contains writes to any extended-forbidden file at merge time, the controller MUST reject the merge and ask the user before proceeding.

**Subagent isolation — controller-managed worktree pattern (REQUIRED).**

Empirically, the Agent tool's `isolation: "worktree"` parameter does NOT reliably create an isolated worktree in this environment — observed failure mode (2026-04-28): subagent committed directly to the parent branch's HEAD with no separate branch created. Do not rely on the parameter alone.

Standard pattern for any subagent that will write to the repository:

1. Controller creates the worktree explicitly BEFORE dispatch:
   `git worktree add .outline/agent-<task-slug> HEAD`
2. Controller dispatches the subagent with the `cwd` (or first-step `cd`) pinned to the worktree path.
3. Subagent commits inside the worktree on its own branch.
4. Controller verifies the worktree branch via `git -C .outline/agent-<task-slug> log` after subagent returns.
5. Controller merges the branch into the target with explicit `git merge --no-ff` (or rebase + push), resolving conflicts as needed.
6. Controller removes the worktree: `git worktree remove .outline/agent-<task-slug>`.

The subagent must NEVER be trusted to self-isolate; isolation is a controller responsibility.

**Subagent prompt verifier clause (REQUIRED preamble).**

Every dispatched subagent prompt that grants write access to the repository MUST include this verification preamble verbatim, BEFORE any task-specific instructions:

```
PRE-WORK SELF-CHECK (run first, return BLOCKED if any check fails):
1. Print `pwd`. Confirm the path is under `.outline/agent-*` or
   `.claude/worktrees/*`. If under the parent repo (no `.outline/` or
   `.claude/worktrees/` segment), STOP and return BLOCKED with the
   message "Not in isolated worktree — controller setup error".
2. Print `git rev-parse --abbrev-ref HEAD`. Confirm the branch is NOT
   `test`, `main`, or any branch matching `worktree-*` already in use.
   If the branch is shared, STOP and return BLOCKED.
3. Confirm the listed forbidden directories from the task prompt are
   present (sanity check that the worktree is a real checkout).
```

A subagent that proceeds with writes without passing the self-check is a critical incident; the controller MUST roll back any commits made and re-dispatch with corrected isolation.

### Phase 0 — reconnaissance (controller, sequential, fast)

1. Parse the queue file into a list of seed URLs with optional flags (`+allow`, `+deny`, `+max-pages`, `+nochildren`, `+refresh`, `+scope`).
2. For each seed: derive `snapshot_id = <root-slug>-<today>` and `path_prefix` (per Mirror crawl boundary rules).
3. Check for existing snapshots of the same `root_url` (consult `mirror/_index.md`):
   - If any **active** snapshot exists AND `+refresh` not set → **reuse** it; skip Phase 0.5 for this seed. **Reuse regardless of age** — refresh is user-initiated only. Ingest never re-crawls automatically.
   - If `+refresh` flag set → schedule re-crawl in Phase 0.5; Phase 2 marks the prior snapshot `status: superseded`.
   - If no snapshot exists → fresh crawl in Phase 0.5.
4. Show user a one-screen dispatch plan: per seed → `snapshot_id | path_prefix | reuse-or-crawl(-or-refresh) | guessed_kind | guessed_target_entity`. Wait for confirmation only if any row is ambiguous (e.g., personal blog, ambiguous publisher).

### Phase 0.5 — mirror crawl (parallel, one agent per seed)

Dispatch all crawl agents in a single tool call. Each agent contract:

```
INPUT: seed_url, snapshot_id, host, path_prefix, allow[], deny[], max_pages, nochildren?
ALLOWED OUTPUT: write mirror/<snapshot_id>/manifest.yaml AND mirror/<snapshot_id>/pages/<slug>.md.
FORBIDDEN: any write outside mirror/<snapshot_id>/. Any read of sources/, entities/, concepts/, parameters/.

STEPS:
  1. mkdir mirror/<snapshot_id>/pages/.
  2. Fetch seed_url using crawler-selection order (exa → webfetch fallback). Extract cleaned markdown → pages/<seed-slug>.md.
  3. If nochildren: skip to step 6.
  4. Find outbound links matching: same host AND path startswith path_prefix AND not in deny[] AND (allow[] empty OR matches allow[]).
  4a. Sparse-link fallback. If step 4 yields fewer than 3 in-scope outbound links AND the host serves a canonical doc index (probe `<host>/llms.txt`, `<path_prefix>/llms.txt`, or `<host>/sitemap.xml`), seed the BFS queue from that index. Common cause: client-side-rendered nav (GitBook, Docusaurus, Mintlify) — the seed page's HTML lacks the sidebar links. Record the fallback in `manifest.notes`.
  5. BFS through matching links until queue exhausted or max_pages reached.
     - Each fetch: use crawler-selection order, extract markdown, save to pages/<slug>.md, record entry in manifest (including pages[].crawler used).
     - Skip non-HTML (PDF/img) but record with status: non_html_skipped.
     - On 404 with explicit redirect hint in response body (e.g. GitBook's "page moved to /new-path"): follow the redirect once. Record in `manifest.notes`. Do not count the 404 against retry budget.
     - On both-crawler failure (no redirect available): status: fetch_failed.
     - At max_pages: stop, manifest.status = paused. Append unprocessed in-scope URLs to `manifest.queue_remainder`.
  6. Write manifest.yaml with full schema (root_url, host, path_prefix, crawled_at, page_count, all pages list, queue_remainder, notes).
  7. Return snapshot_id, page_count, status.
```

### Phase 1 — claim extraction (parallel, one agent per snapshot)

Dispatch one extraction agent per Phase 0.5 snapshot in a single tool call.

```
INPUT: snapshot_id, schema (read schema/schema.md)
ALLOWED OUTPUT: write one sources/<snapshot_id>-<page-slug>.md per page in mirror/<snapshot_id>/pages/.
FORBIDDEN: write outside sources/. Write to mirror/. Write to wiki pages or indices.
ALLOWED READ: own snapshot's pages and manifest. Other sources/*.md (cross-reference). Schema files.
                NOT wiki pages.

STEPS:
  1. Read mirror/<snapshot_id>/manifest.yaml.
  2. For each page entry with status: ok:
     a. Read mirror/<snapshot_id>/pages/<slug>.md.
     b. Detect kind/authority (inherit from snapshot host heuristic if no page-level signal).
     c. Write sources/<snapshot_id>-<slug>.md per Source template (frontmatter references mirror_snapshot + mirror_page).
     d. Write 4-6 line TL;DR.
     e. Extract every concrete claim into the Claims extracted table. For each claim:
          - target tier (entity | concept | parameter)
          - target slug (existing-if-known or proposed-new)
          - claim type (definition | parameter-value | mechanism | relation | event)
          - confidence (high | medium | low)
     f. If a within-snapshot conflict is visible (page A vs page B in same snapshot), record under Conflicts raised.
  3. Skip pages with status: fetch_failed or non_html_skipped (no source page produced).
  4. Return the list of created source ids.
```

### Phase 2 — sequential merge (controller, single-threaded)

After all Phase 1 agents complete:

1. Read every newly created `sources/*.md`. Flat-list all claims with their `filed_to` proposals.
2. Group claims by `filed_to` target page.
3. For each target page (entity / concept / parameter), deterministic order:
   - Create from template if it does not exist.
   - Integrate claims by type:
     - `parameter-value` → append row(s) to time-series, sort by `effective` date.
     - `definition` / `mechanism` → add inline-cited sentence(s) to appropriate section.
     - `relation` → add wikilink + verb to both endpoints.
   - Conflict scan across all claims targeting this page (across ALL sources, including pre-existing). Apply Disputed claims block protocol (see `schema/confidence.md`).
   - Update `last_reviewed` and `sources_count` in frontmatter.
4. Update `index.md` (new pages, modified pages, source counts).
5. Update `mirror/_index.md`: insert new active rows for snapshots created in Phase 0.5; if any `+refresh` was used, move the prior snapshot's row from Active to Superseded with its `superseded_by` set; insert paused-snapshot rows if any.
6. Append `log.md` entry:
   ```
   ## [YYYY-MM-DD HH:MM] batch-ingest | queue=<queue-file> | snapshots: N (new=K, reused=R, refreshed=F) | sources: M | pages touched: P | new pages: J | conflicts: C
   ```
7. Append every conflict to `open-questions.md`.
8. Print structured summary: per-snapshot crawl result (new/reused/refreshed), per-page touch list, all newly raised open questions.

### Phase 2 mandatory completeness rule [LOAD-BEARING]

**Phase 2 is atomic.** A Phase 2 run that creates an entity page WITHOUT (a) integrating that entity's claims into existing concept pages' `## Variants in the wild` tables and (b) creating the parameter pages the entity body references is **incomplete** and breaks the wiki's cross-venue comparison affordance.

Specific obligations every Phase 2 run MUST satisfy before declaring done:

1. **Concept-page Variants integration.** For every claim with type `definition` / `mechanism` filed to a `concepts/<domain>/<slug>` page that **already exists**, append a row to that concept page's `## Variants in the wild` table representing the new venue. Do NOT skip on the basis of "concepts already populated by another venue" — that is precisely the case where the row is needed.
2. **Parameter-page creation.** Every wikilink of the form `[[parameters/<entity>/<slug>]]` written into the new entity page's `## Parameters` section MUST resolve to an existing file by end of Phase 2. Either create the parameter page (preferred) or remove the wikilink (acceptable if the parameter is unsourced from this snapshot).
3. **Index update.** `index.md` lists every page created or modified in this run.
4. **Schema verb discipline.** Every relation written in `**verb**` form MUST appear in `schema/schema.md` §"Relations" canonical verb table. If a needed relation does not fit, add it to `open-questions.md` and use the closest existing verb — DO NOT invent verbs inline.
5. **Schema slot discipline.** Every parameter slot key (the `parameter:` field in parameter-page frontmatter) MUST be either a documented example in `schema/schema.md` §"Parameters" or a justified extension recorded in this Phase 2's log entry. Do NOT silently adopt audit-predicted slots without schema patch.

**Forbidden shortcuts.** No "lightweight Phase 2", no "concepts deferred", no "parameters TBD as forward refs". An entity ingest that defers concept-table integration is a merge-debt generator: future Phase 2 runs across other venues will silently overwrite the gap rather than reconcile it. If time pressure forces deferral, **defer the entity page itself** — file claims on existing concept pages as a one-row-per-claim addition, and create the entity later when there is time to do it correctly.

**Verification before commit.** Before the Phase 2 commit, run:
- Grep every `[[<dir>/<...>]]` wikilink in newly-touched pages; confirm target file exists OR is in this commit.
- Grep every `**<verb>**` pattern; confirm the verb is in the `schema/schema.md` §"Relations" table.
- Diff `concepts/**/*.md` for added Variants rows; confirm at least one row was added per concept page the new entity touches.

### Failure handling

- A single Phase 0.5 or Phase 1 agent failure does NOT abort the batch. Survivors proceed.
- If two agents propose colliding `snapshot_id`s for different `root_url`s: append `-2`, `-3` suffix.
- If a Phase 1 agent wrote outside `sources/`: abort Phase 2, report the violation, ask user.
- If Phase 0.5 hit `max_pages` (status: paused): list affected snapshots in summary; user decides whether to raise cap and resume.

## Lint workflow

Trigger: user says `lint`.

Checks:

- All `disputed: true` pages — has new evidence arrived since `last_reviewed`?
- Disputed pages older than 30 days with no movement — flag for user attention.
- Orphan parameters (no parent entity page exists).
- Orphan concepts (no implementing entity points to it).
- Parameters with `last_change > 90 days` — flag "still current?"
- Unfootnoted claims (any sentence asserting a fact without `[^...]`).
- **Broken wikilinks** — every fully-qualified `[[<dir>/<...>]]` must resolve to an existing file. Group separately by tier (entity / concept / parameter / source / audit).
- **Invented relation verbs** — every `**<verb>**` pattern in body prose must match a verb in `schema/schema.md` §"Relations" canonical table. Flag any non-matching verb as `verb: invented` with the page and verb. Common offenders are listed in the substitutions table; treat each as a Phase 2 schema violation, not a stylistic note.
- **Phase 2 incompleteness markers** — when an entity page exists for a perpdex but its claims are absent from existing concept pages' `## Variants in the wild` tables, flag as `phase2: deferred` with the entity name and the list of concept pages missing a row.
- Sources cited nowhere (file-back failed).
- **Mirror age report**: list active snapshots with their `crawled_at` age in days. **Do NOT suggest refresh** — refresh is user-initiated only. Just report ages so the user can decide.
- **Superseded mirrors not yet reconciled**: snapshots with `status: superseded` whose newer counterpart's claims have not been cross-checked → propose contradictions to verify.
- **Paused crawls** (`status: paused`): list snapshots that hit `max_pages` and never resumed.
- **Frame coverage** (perpdex 1-hop): for each perpdex entity, report `frame coverage: <filled>/<NA>/<gap>` (sums to 45). List ALL `gap` cells per entity (this is the backlog). NA cells reported only on entity creation / first-pass review (rarely revisited). Flag `frame: untagged`, `frame: malformed`, `frame: unrationalized` claims/cells. Surface accumulated A7/A8/A9 claims under `operations` once heuristic threshold reached (≥10 claims in one angle across ≥2 perpdex entities) → propose new concept domain split.
- Suggest 3–5 new questions worth investigating, given current gaps.

Output: a structured report. Do not auto-edit pages during lint — propose, let user approve.

## Query workflow

Trigger: user asks a question.

1. Read `index.md` to identify candidate pages.
2. Read those pages.
3. Synthesize answer with inline citations to wiki pages and (transitively) to sources.
4. **File the answer back** into the wiki when it represents a non-trivial synthesis (a comparison, a new derived insight, a connection). Create a new concept page or augment an existing one. Append to `log.md`.

## File-back rule

Valuable conversational outputs — comparisons, analyses, derivations — are knowledge. Do not let them disappear into chat history. Either:
- Add a new section to an existing page, or
- Create a new concept/entity page.

Mark the file-back in `log.md` as `query | <topic> | filed: <pages>`.
