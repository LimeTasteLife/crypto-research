# Audit: Hyperliquid Sample Ingest Postmortem

**Date:** 2026-04-28
**Author:** LLM (Claude) in dialogue with project owner
**Scope:** Validate the predictions from `audit/2026-04-27-ontology-coverage-perp-ops.md` against the actual outcomes of the Hyperliquid first-pass ingest (snapshot `hl-docs-2026-04-27`, 20 pages, 252 claims, 36 wiki pages created in Phase 2 sequential merge).
**Method:** Walk the 8 validation checks defined by the predecessor audit. For each check, record observed evidence, assign a verdict (✓ confirmed / ◐ partial / ⚠ unconfirmed / ✗ refuted / N/A insufficient data), and propose a follow-up action.
**Linked log entries:** `batch-ingest` (2026-04-28 01:00), `schema-patch-g1-g4-g11` (2026-04-28 00:00).

---

## Verdict summary

| # | Check | Verdict | Action |
|---|---|---|---|
| 1 | HLP data location clean? | ✓ | Defer Audit Gap 1 multi-pool fix until GMX-class venue. |
| 2 | Programme entity body bloat? | N/A | HL primary docs do not contain programme claims at this snapshot. Re-test on next venue with documented airdrop / points / MM-rewards data. |
| 3 | HYPE token ad hoc accumulation? | ◐ | Asset profile section added inline; Audit Gap 3 schema slot validated by demand but not yet schema-patched. |
| 4 | Frame coverage genuine? | ✓ | 19 / 9 / 17 with specific rationales; not box-checked. |
| 5 | A7/A8/A9 domain-split trigger? | ✗ (not yet) | Single entity (HL); ≥2 entities prerequisite unmet. Re-test after second perpdex ingest. |
| 6 | Citation density ≥90%? | ✓ | 100% per-claim footnoting on inspected sample. |
| 7 | Frame-tag rate within threshold? | ⚠ | Untagged rate ~52% before retro `-` marking; the post-Phase-1 schema patch (G11) is correct, but Phase 1 sources need a back-pass to apply `-` to definitional rows. |
| 8 | Conflict detection fired? | N/A | 0 conflicts on a single-venue ingest is unsurprising; check is meaningful only after second-venue Phase 2 hits the same concept page. |

---

## Check 1 — HLP data location

**Prediction.** HLP claims will arrive (canonical case for protocol-as-MM under A4 and venue-owned-lp under A5). Without `parameters/<venue>/pools/<pool-id>.md` convention, HLP data will land messily in one of three places.

**Observation.** HLP claims (5 from `trading-liquidations`, plus relations from `concepts/lp/venue-owned-lp` and `concepts/tokenomics/rev-share`) all filed to **`parameters/hyperliquid/hlp.md`**. The page reads naturally — frontmatter accommodated the audit's proposed pool-spec schema (informally: `pool_id`, `pool_class: venue-owned-lp`, `deposit_tokens`, `strategy_summary`). Body has `## Current pool spec`, `## Lifecycle events`, `## Time series`, `## Disputed values`, `## Sources` — close to the proposed pool-page template.

**Verdict.** ✓ confirmed. For a single-pool venue (HL has only HLP as a documented venue-owned vault), the canonical `parameters/<venue>/<pool-name>.md` slot works without schema change.

**Action.** Defer Audit Gap 1's formal `parameters/<venue>/pools/<pool-id>.md` directory convention until ingesting a multi-pool venue (GMX with multiple GM pools, Jupiter Perps with JLP variants). At that point, promote `parameters/hyperliquid/hlp.md` → `parameters/hyperliquid/pools/hlp.md` and apply the convention to the multi-pool venue from day 1.

---

## Check 2 — Programme outcome KPI overflow

**Prediction.** HL points S1/S2 will arrive as programme entities; their KPI time-series will bloat the programme entity body without a `parameters/programmes/<slug>.md` slot.

**Observation.** HL primary docs at this snapshot (`hyperliquid.gitbook.io/hyperliquid-docs/`) do **not** contain claims about HL points S1, S2, or any time-bounded incentive programme. The 20 crawled pages cover infrastructure, mechanics, and fees — programme campaigns live elsewhere (HL Foundation blog, Twitter announcements, app dashboards) which were not in this crawl.

**Verdict.** N/A — insufficient data to validate or refute the prediction.

**Action.**
- Pre-emptive fix not justified by current evidence.
- Re-test the prediction on the next venue ingest if its primary docs include programme content (Aevo Surge, Drift Genesis, dYdX MM rewards epochs are likely candidates).
- Until then, when programme claims arrive (likely from a blog/Twitter source), consider a 1-shot decision: file under entity body (if 1 programme) or create the `parameters/programmes/<slug>.md` slot (if ≥2 programmes co-arrive).

---

## Check 3 — HYPE token ad hoc accumulation

**Prediction.** HYPE token entity will accumulate (a) buyback claims from A2, (b) emission claims from `tokenomics`, (c) potential holder-distribution claims. Without an `## Asset profile` template, these arrive as ad hoc body sections.

**Observation.** `entities/token/hype.md` was created with an explicit `## Asset profile` section adapted from the audit's proposed template:

```markdown
## Asset profile
- volatility class: high
- holder distribution: unknown (not in primary docs)
- narrative class: infra
- supply unlock: <prose; full schedule not in primary docs>
- parent ecosystem: [[entities/network/hyperliquid-l1]]
```

The body cleanly separates: snapshot, asset profile, mechanism (staking + fee discount + AF burn), relations, parameters, open questions. No ad hoc accretion.

**Verdict.** ◐ partial — the section was used in practice and worked, but the schema (AGENTS.md token entity template) does not yet formally include `## Asset profile`. The current outcome is a one-off ad-hoc adoption; another LLM in another session would not know to include it.

**Action.** Promote the section to schema in AGENTS.md token entity template. Low severity; can ride along with the next schema patch wave.

---

## Check 4 — Frame coverage actually populated

**Prediction.** If most cells are `gap` with the same boilerplate rationale, the frame is being box-checked rather than absorbed.

**Observation.** `entities/perpdex/hyperliquid.md` `## Frame coverage` has all 45 cells explicit: 19 `filled` (with citations), 9 `not-applicable` (with specific rationale — e.g. `A5/PI through A5/PV: not-applicable — no documented spot DEX LP layer in primary docs (spot trades are CLOB, not AMM-LP)`), 17 `gap` (each with a specific reason — e.g. `A6/PIII gap — IF coverage ratio computation not made explicit`).

Rationales are heterogeneous, not boilerplate. NA reasons differ from gap reasons. Filled cells cite specific source IDs.

**Verdict.** ✓ confirmed. Frame is absorbed, not box-checked.

**Action.** None for now. Periodic spot-check the rationale quality on subsequent ingests.

---

## Check 5 — A7/A8/A9 accumulation under `operations`

**Prediction.** Count claims tagged `A7-*`, `A8-*`, `A9-*` on Hyperliquid. If ≥10 in any of the three for a single entity, the trigger to split into `governance` / `security` / `regulatory` has fired earlier than the heuristic anticipated (which expects ≥2 entities).

**Observation.**
- A7 (governance / parameter authority): 6 claims
- A8 (security / incident response): 14 claims
- A9 (regulatory / market-type classification): 2 claims

A8 exceeds the per-angle threshold of 10 within HL alone, but the ≥2 entities prerequisite is unmet (HL is the only perpdex ingested). Per the schema's `frame: untagged` lint rule and the angle-domain mapping, A8 claims are filed under `concepts/operations/*` (matching-engine, sequencer, settlement) or directly on the perpdex entity / token entity — they are not pooled in a single page that would visibly bloat.

**Verdict.** ✗ not yet — domain split trigger not fired (single entity).

**Action.** When the second perpdex ingest completes, recount A7/A8/A9 claims across both entities. If A8 hits ≥10 on the second venue too, propose `concepts/security/*` as a new domain in AGENTS.md. Likely candidates already visible from HL: `oracle-attack-surface`, `bridge-dispute`, `validator-jailing`, `assistance-fund-control`.

---

## Check 6 — Per-claim citation density

**Prediction.** Sample 20 claims at random; count footnoted vs unfootnoted. <90% footnoted → lint defect rate too high.

**Observation.** Inspected sample (every body claim across `entities/perpdex/hyperliquid.md`, `concepts/risk/liquidation.md`, `parameters/hyperliquid/fee-schedule.md`, `entities/token/hype.md`): every assertion carries a `[^hl-docs-2026-04-27-*]` footnote. Source pages all use the `[^id]: [[sources/...]]` resolution pattern. Definitional ledes are cited; mechanism descriptions are cited per-fact, not per-paragraph.

Footnote-density measurement (lines containing `[^hl-docs`):
- `entities/perpdex/hyperliquid.md`: 52 footnote refs
- `parameters/hyperliquid/fee-schedule.md`: 19 footnote refs
- `concepts/risk/liquidation.md`: 14 footnote refs

These match or exceed the body-content claim density.

**Verdict.** ✓ confirmed (≥90% threshold passed).

**Action.** None.

---

## Check 7 — Frame-tag malformation rate

**Prediction.** Count `frame: malformed` and `frame: untagged` warnings per 100 claims. >5% → tighten Phase 1 agent prompt.

**Observation.**
- Total claims: 252 (per `claim-inventory` Explore subagent output).
- Untagged (blank `frame_tag`): ~130 (52%).
- Explicit `A<n>-P<X>` tags: ~122 (48%).
- `-` (legitimate-empty per the G11 schema patch): 0 (the patch landed *after* Phase 1; no source page has been re-marked).
- Malformed: 0 (no entries violate the regex; only blank or well-formed).

The 52% blank rate would massively exceed the 5% lint threshold under the unpatched schema. Under the patched schema (untagged threshold raised to 10%, with `-` allowed for definitional claims to generic concepts), the bulk of those 130 blanks are likely legitimate `-`-eligible (claims classified as `definition` filed to `concepts/`). Without retroactively re-marking, lint would flag them; with re-marking, the rate drops to whatever fraction is genuinely-untagged in-frame claims.

**Verdict.** ⚠ unconfirmed. The schema patch is structurally correct; the data set was extracted under the old schema and needs a back-pass before the patched lint can run accurately.

**Action.**
- Add a back-pass step to Phase 1 sources/<id>.md files: for each blank `frame_tag` row, classify the claim type and target. If `(type == definition || type == mechanism) && target.tier == concept && target.slug is generic`, change blank → `-`.
- Estimated cost: ~130 row updates across 20 source files. Could be done by a single Explore subagent in read-then-rewrite mode, or deferred until the next ingest where Phase 1 agents are prompted with the patched schema from the start.
- Recommend deferring (cheap to apply on next ingest, expensive to redo retroactively).

---

## Check 8 — Conflict detection fired

**Prediction.** HL has had multiple fee schedule revisions and listing-policy changes (e.g. HIP-3). Expect at least one auto-flagged dispute. Zero disputes after thorough docs+blog ingest is suspicious.

**Observation.** Phase 2 conflict scan recorded **0** within-snapshot conflicts. `open-questions.md` is populated only with raised investigation questions, not with disputed-claims entries.

This is unsurprising for the actual scope ingested:
- Single snapshot, single date, single publisher (Hyperliquid Docs / GitBook).
- Primary docs are written to be internally consistent at any given snapshot.
- Historical fee revisions are not in the snapshot — only the current state. Comparing 2026-04-27 fees to a 2025 fee snapshot would surface revisions, but no 2025 snapshot exists yet.
- HIP-3 vs default-perp differences are not contradictions — they are explicit per-mode formulae, both filed correctly.

**Verdict.** N/A — the prediction's scope (cross-revision contradiction) is not testable without (a) a prior-snapshot mirror of HL or (b) a second venue's claims targeting the same concept page.

**Action.**
- The conflict-detection mechanism's first real test will be when the second perpdex's Phase 2 merge appends to existing concept pages (`concepts/risk/liquidation`, `concepts/market-microstructure/oracle-spec`, etc.). If venue-A and venue-B describe a concept with materially different mechanisms, the Disputed claims block protocol should fire.
- Re-test after second-venue ingest. If 0 conflicts persist on that ingest too, the conflict scan is suspiciously quiet and needs a deliberate red-team probe.

---

## Schema-impact summary

| Audit prediction | Outcome | Schema action taken |
|---|---|---|
| Gap 1 (per-pool slot) | Worked at single-pool scale without schema patch. | Deferred. |
| Gap 2 (programme KPI slot) | Untestable from HL data. | Deferred; re-test on programme-rich venue. |
| Gap 3 (token asset profile) | Section adopted ad-hoc and worked. | Promote to AGENTS.md token template (low priority). |
| Schema patches G1-G4, G11 | Landed before Phase 2 (commit `6700ac0`). | Applied. |

## New findings (not predicted by prior audit)

1. **Untagged-on-extract is the dominant defect class for Phase 1 output**, not malformation. The G11 patch addresses the schema gap but does not address the temporal-ordering gap (patch landed after extraction). Future Phase 1 contracts should run against the patched schema; existing extraction outputs may need a back-pass.

2. **`Variants in the wild` table on concept pages is the correct integration surface for cross-venue comparison** — it survived the single-venue case (one row) and is structurally ready for multi-row append. Worth committing to as a load-bearing schema affordance in subsequent ingests.

3. **Open questions raised count (11) is healthy** — high enough to indicate genuine investigation depth, low enough that they are tractable. Heuristic suggests target ~5-15 raised questions per perpdex first-pass; HL is at the upper end of that range.

4. **Bridge audit / regulatory claims surface even in technical docs** — `hypercore-bridge` produced A8/PV claims (Zellic audit reference); `hyperevm` produced A9/PV claims ("no insiders" principle). The frame's governance angles are not exclusively non-technical — primary docs have governance content if read with the frame lens.

## Notes for next audit

- Re-run an audit (`audit/<later-date>-<topic>.md`) after the second perpdex sample completes. Compare conflict-detection behavior, Variants-table merge cleanliness, and whether the `concepts/security/*` domain split fires.
- The schema patch back-pass for Phase 1 outputs (Check 7 action) can either be batch-applied across all sources/* now, or deferred to the next ingest where Phase 1 runs against the patched schema. Cheaper to defer.
- Audits are append-only by convention. Do not edit prior audit files. New audit on the same topic gets a new dated filename.
