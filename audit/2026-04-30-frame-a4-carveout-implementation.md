---
type: audit
date: 2026-04-30
author: LLM (Claude), authorized schema-patch session
scope: Implementation of audit/2026-04-30-frame-a4-carveout-proposal.md Option 1.
parent_proposal: audit/2026-04-30-frame-a4-carveout-proposal.md
---

# Frame A4 Carve-out Implementation — Option 1 (sub-tag) landed

## Scope of this patch
- `schema/frame.md` edited (only file in this commit besides this audit + log/index/open-questions controller updates).
- No entity Frame coverage blocks edited (opt-in migration per proposal Migration cost row).
- No concept page edits.

## Concrete changes
- Expanded the A4 prose paragraph into three blocks: an introductory note announcing the `{ext, pov}` carve-out, the `A4-ext` block (verbatim from the prior wording), and a new `A4-pov` block enumerating which probes apply to protocol-owned vaults.
- Inlined the 5-row pattern-reinterpretation table (PI–PV) from the parent proposal directly under the A4 prose, so ext-vs-pov readings of each cross-cutting pattern are co-located with the angle definition.
- Updated the lint regex in §"How to apply during ingest" item 5 to accept the optional `(-(ext|pov))?` sub-tag on every angle, not just A4 — this preserves regex symmetry without committing to other-angle sub-tags.
- Added a new §"A4 sub-tag rule" subsection between the lint enforcement section and §"Out of frame scope", documenting the default-as-ext semantics, opt-in pov form, opportunistic migration stance, four worked examples, and the unchanged angle ↔ domain mapping row.
- Updated the §"Coverage matrix" example block to show one `A4-ext/PIII` (gap) and one `A4-pov/PIII` (filled) entry side-by-side, illustrating that ext and pov can coexist on the same entity.

## Migration semantics (post-patch)
- Existing tags `A4-P<X>` parse as `A4-ext-P<X>` by default.
- New tags may use either form: `A4-ext-P<X>` (explicit external MM) or `A4-pov-P<X>` (protocol-owned vault).
- Lint regex extended to accept both forms.
- Frame coverage blocks on entity pages remain unchanged until next refresh touches them — this is a deliberate opt-in stance.

## Validation predictions resolved at patch time
- P1 gap-collapse: testable on next entity refresh, not at patch.
- P4 A5 stays NA: validated at patch (no A5 line touched).

## Predictions still pending
- P1, P2, P3, P5 — pending entity-page refreshes.

## Backward compatibility
- Existing source-page `frame_tag` columns continue to validate.
- Existing entity `## Frame coverage` block format unchanged.
- `audit/`, `log.md` retain old `A4-P<X>` references — append-only, do not retroactively edit.

## Schema patch session designation
This implementation was authorized in conversation turn requesting parallel execution after the proposal audit landed at commit 630523c (2026-04-30).
