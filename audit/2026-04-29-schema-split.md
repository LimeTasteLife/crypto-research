---
type: audit
date: 2026-04-29
author: LLM (Claude), in dialogue with project owner
scope: Schema-document refactor — split 870-line AGENTS.md into 5 concern-focused files under schema/, with AGENTS.md retained as a thin entry point. Records the decision rationale, the file structure, the cross-reference convention change, the severity-taxonomy decision deferred for adoption from this audit forward, and the implication for in-flight worktree branches.
---

# Audit: AGENTS.md → schema/*.md Split (Schema-Document Refactor)

**Date:** 2026-04-29
**Author:** LLM (Claude), in dialogue with project owner
**Method:** User-initiated schema-patch session. Two parallel Explore agents surveyed (1) AGENTS.md size and structure, (2) audit-document quality across the four prior audits. Controller drafted three refactor options via duet AskUserQuestion; user selected "concern-based split", then "schema/ root directory" after `.claude/` was discovered to be gitignored.
**State at start:** Repository at HEAD `0b50476` (test branch, post uniswap-v4 merge). Five active worktrees in flight (`agent-ab24f52a` locked, `drift-ingest`, `dydx-ingest`, `lighter-ingest`, `uniswap-ingest`).
**Resulting commit:** `9c54994` — `refactor(schema): split AGENTS.md into schema/*.md by concern`.
**Companion audits:** `audit/2026-04-27-ontology-coverage-perp-ops.md`, `audit/2026-04-28-hyperliquid-sample-postmortem.md`, `audit/2026-04-28-lighter-redteam-postmortem.md`, `audit/2026-04-28-ontology-state-audit.md` (and its 2026-04-29 F3 + F7/F9 errata).

---

## TL;DR

AGENTS.md grew to 870 lines mixing five distinct concerns: schema specification, operational workflows, the 9×5 perpdex investigation frame, citation/style conventions, and the confidence/conflict model. The single-file form was still readable but increasingly read-heavy: any session-start preamble forced a full re-read, and adding the 4 remaining target perpdex platforms (current 3 of 7) was projected to push the file past 1,200 lines. The user's prompt — "전체 온톨로지 구조 너무 방대해져 이제 AGENTS.md? 이렇게 단일파일로 하는 거 너무 비효율적이지 않아?" — surfaced the pressure before it became a measurable defect.

The split adopted was concern-based, not size-based. AGENTS.md was reduced to a 55-line entry point: title preamble, a "schema files" matrix mapping concern → file → when-to-read, an 8-rule "core principles" digest, the first-session checklist, and the out-of-scope list. The five derived files live under `schema/`:

| File | Lines | Concern |
|---|---|---|
| `schema/schema.md` | 288 | Layers, entity model (3 tiers), relations canonical verb set, parameter versioning, page templates (Entity / Concept / Parameter / Source) |
| `schema/workflows.md` | 379 | Ingest, mirror data, batch ingest 3-phase (with subagent isolation + extended forbidden-write list), lint, query, file-back |
| `schema/frame.md` | 112 | 9×5 perpdex investigation matrix (9 angles × 5 patterns × 45 cells per entity), coverage states, tagging rules, lint enforcement |
| `schema/style-guide.md` | 49 | Per-claim citation rule, naming, index/log/open-questions conventions, audit severity taxonomy (new) |
| `schema/confidence.md` | 45 | Confidence model, ingest-time conflict detection, disputed claims block format |

Cross-references between the five files — and from AGENTS.md into them — use the convention `schema/<file>.md §"<section>"`. Two intentional `.claude/<...>` references remain (in `schema/workflows.md` lines 216-217, describing the worktree path used by the subagent self-check preamble) and are not stale.

---

## Decisions recorded

### D1 — Concern-based split, not size-based

The split lines are drawn so each file answers one question:
- "what's a fact's tier?" → `schema/schema.md`
- "how do I ingest / lint / query?" → `schema/workflows.md`
- "what should I look for in a perpdex?" → `schema/frame.md`
- "how do I cite / name / log?" → `schema/style-guide.md`
- "how do I rank claims and surface conflicts?" → `schema/confidence.md`

This shape is robust to growth: adding the remaining 4 perpdex platforms grows wiki content but does NOT grow these schema files. They grow only when the schema itself evolves.

### D2 — `schema/` over `.claude/` over `docs/schema/`

Initial recommendation was `.claude/`, retracted after `.gitignore` was found to exclude that directory ("agent harness scratch directories — never commit"). The retraction is a real lesson: future agent-recommended paths in this repo MUST be checked against `.gitignore` BEFORE the recommendation is offered for selection. The user confirmed `schema/` over `docs/schema/` because (a) schema files are not "docs about the project" — they ARE the project's operational definition, and (b) shorter relative paths from cross-referencing files.

### D3 — Severity taxonomy adopted, applied from this audit forward

Prior audits used divergent severity scales (CRITICAL/HIGH/MEDIUM/LOW in the ontology-state audit; verdict marks ✓/◐/⚠/✗ in the coverage and HL postmortem audits; severity prose without taxonomy in the Lighter red-team). This is recorded in `schema/style-guide.md` §"Audit severity taxonomy" with the following criteria:

| Level | Criteria |
|---|---|
| CRITICAL | Data integrity violation, schema breach, silent data loss |
| HIGH | Cross-venue comparison broken, coverage gap blocking investigation |
| MEDIUM | Style violation, incomplete rationalization, non-blocking gap |
| LOW | Cosmetic, notation inconsistency, non-functional |

**Applies from 2026-04-29 onward.** Prior audits retain their original scales per append-only convention; do NOT retroactively normalize.

### D4 — Forbidden-write list extended

`schema/workflows.md` §"Subagent isolation + extended shared-file boundaries" now lists `schema/*.md` alongside `AGENTS.md` as files that may only be modified in a user-acknowledged schema-patch session. Parallel platform-ingest agents must defer schema edits.

---

## Findings

### F1 (MEDIUM) — In-flight worktree branches contain stale path references

Five active worktrees (`agent-ab24f52a` locked; `drift-ingest`, `dydx-ingest`, `lighter-ingest`, `uniswap-ingest`) were created from snapshots of the test branch at points BEFORE this split. Their local commits or working-tree changes may contain references like `AGENTS.md §"Batch ingest workflow"` or `.claude/<file>.md`. None of these are functional defects — they are stale-path comments — but they will read as drift at merge time.

**Why:** The split changed where canonical text lives, not what it says.
**How to apply:** When merging any of these worktrees, scan their diff for `AGENTS.md §"<section>"` patterns; substitute with `schema/<file>.md §"<section>"` per the matrix in AGENTS.md. Do NOT block a merge over a stale comment; rewrite during review.
**Severity rationale:** MEDIUM (style violation, non-blocking gap) per the new taxonomy.

### F2 (LOW) — Append-only files retain references to old AGENTS.md sections

These files reference `AGENTS.md §"..."` and are NOT to be retroactively edited:
- `audit/2026-04-27-ontology-coverage-perp-ops.md`
- `audit/2026-04-28-*` (3 files)
- `log.md` (multiple entries, including the 2026-04-28 batch-ingest log lines)
- `open-questions.md` resolved entry from 2026-04-28
- `raw/queue/*-2026-04-28.md` (4 user-curated queue files; comment lines)

These are correct historical records. Future entries written after 2026-04-29 should use the new `schema/<file>.md §"..."` form.

**Severity rationale:** LOW (notation inconsistency, non-functional). Convention-violating to fix.

### F3 (LOW) — Two `.claude/` references retained intentionally

`schema/workflows.md` lines 216–217 retain `.claude/worktrees/*` as part of the subagent PRE-WORK SELF-CHECK preamble. These are NOT stale schema-file references — they describe the actual filesystem path Claude Code uses for isolated worktrees, and changing them would break the self-check.

---

## Predictions

**P1 (testable on next batch ingest):** A new perpdex ingest run will reference `schema/<file>.md §"..."` in its log entry and source frontmatter, with zero `AGENTS.md §"..."` references in newly-written content. Falsifies if any new file dated ≥ 2026-04-29 references AGENTS.md by section.

**P2 (testable on next lint pass):** Lint over the 5 active worktree branches at merge time will surface F1's stale-path patterns. Surface count gives a measure of how disruptive the split timing was.

**P3 (testable on the next ontology audit):** The next audit document will use the CRITICAL/HIGH/MEDIUM/LOW severity taxonomy from D3. Falsifies if it reverts to verdict marks or unscaled prose.

**P4 (process):** No subsequent schema-document size growth on the AGENTS.md axis — adding the 4 remaining perpdex platforms grows wiki content but leaves all 5 schema/*.md files untouched. Falsifies if any of the 5 files exceeds 110% of its current line count without an explicit schema-patch commit.

---

## Out of scope (deferred to other sessions)

- **Variants integration debt** (audit/2026-04-28-ontology-state-audit F1) — touches `concepts/`, Phase 2 territory, blocked by parallel worktrees.
- **A7/A8 domain split** (audit/2026-04-28-ontology-state-audit F2) — same.
- **Slot-key normalization** (`schema/schema.md` §"Parameters" deferred-renames list) — same.
- **Drift audit document truncation** (noted in earlier audit-quality survey but not addressed here).
- **Retroactive normalization of F1's stale references in active worktrees** — to be handled at each worktree's merge time, not in this session.
