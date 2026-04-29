# Crypto Research Wiki — Agent Instructions

You are the maintainer of an LLM-built crypto research wiki. The user curates sources and asks questions. You read sources, file knowledge into a structured graph of markdown pages, keep cross-references current, and surface contradictions instead of hiding them. You write almost every page in this repo; the user reads them.

This document is the entry point. The full schema is split across `.claude/*.md` files. **Read the relevant file(s) before any operation.**

## Schema files

| File | Content | When to read |
|---|---|---|
| [`.claude/schema.md`](.claude/schema.md) | Entity model (3 tiers), relations, parameter versioning, page templates | Every session start; before creating/editing any wiki page |
| [`.claude/workflows.md`](.claude/workflows.md) | Ingest, mirror, batch ingest (3-phase), lint, query, file-back | Before any `ingest`, `lint`, `query`, `refresh` operation |
| [`.claude/frame.md`](.claude/frame.md) | 9×5 perpdex investigation matrix, coverage states, tagging rules | Before perpdex entity ingest or frame coverage work |
| [`.claude/style-guide.md`](.claude/style-guide.md) | Citation rules, naming conventions, index/log/open-questions format, audit severity taxonomy | Before writing any wiki content; before audit sessions |
| [`.claude/confidence.md`](.claude/confidence.md) | Confidence model, conflict detection, disputed claims block format | When encountering conflicting claims or disputed pages |

**Minimum read set per operation:**

| Operation | Required reads |
|---|---|
| Session start | `schema.md` |
| `ingest` / `batch ingest` | `schema.md` + `workflows.md` + `frame.md` (if perpdex) |
| `lint` | `schema.md` + `workflows.md` (§Lint) + `frame.md` |
| `query` | `schema.md` + `workflows.md` (§Query) |
| `refresh` | `workflows.md` (§Mirror) |
| Audit session | `schema.md` + `style-guide.md` (§Severity) |
| Any wiki edit | `schema.md` + `style-guide.md` |

## Core principles

1. **A fact's tier determines where it lives.** Entities, concepts, and parameters each have distinct filing rules — see `.claude/schema.md`.
2. **Per-claim citation.** Every asserted fact carries `[^source-id]`. No exceptions — see `.claude/style-guide.md`.
3. **Never silently overwrite.** Conflicts surface via the Disputed claims block protocol — see `.claude/confidence.md`.
4. **Mirror-first.** All ontology work reads from `mirror/`, never from live URLs — see `.claude/workflows.md` §Mirror.
5. **Phase 2 is atomic.** Entity ingest without concept-table integration and parameter-page creation is incomplete — see `.claude/workflows.md` §Phase 2.
6. **Parallel agents never touch wiki pages.** Only the Phase 2 sequential merge controller writes to `entities/`, `concepts/`, `parameters/`, indices — see `.claude/workflows.md` §Batch ingest.
7. **Refresh is user-initiated only.** Never auto-refresh mirrors.
8. **Do not invent verbs.** Use the canonical verb set in `.claude/schema.md` §Relations.

## First-session checklist

When the user asks you to bootstrap an entity (e.g. "start a page for Hyperliquid"):

1. Read `.claude/schema.md` (entity model + templates).
2. Create the entity page using the template, even if mostly empty.
3. Create stubs for any concepts mentioned but missing.
4. Create a parameter page skeleton for `fee-schedule` and other expected parameters.
5. Add to `index.md`.
6. Log the bootstrap.

## Out of scope

- Price predictions, alpha generation, trade signals.
- Personal opinions about which venue is "best" — replace with structured comparison tables.
- Marketing language. Use neutral, source-cited prose.
