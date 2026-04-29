# Confidence Model & Conflict Detection

> Split from `AGENTS.md`. Rules for claim confidence scoring and dispute handling.

## Confidence model

Each source carries `authority`. Each claim inherits `recency` from `source.date` and `confidence` from a heuristic:

- `high` — official primary docs, on-chain verifiable, audited code, whitepaper.
- `medium` — team blog post, reputable secondhand reporting, well-reasoned independent analysis.
- `low` — tweet/social, anonymous, dated > 1 year with no reconfirmation, rumor.

Promote/demote confidence only with stated reason in the source page.

## Conflict detection (ingest-time)

A new claim *X* conflicts with an existing claim *Y* on the same target page when any of:

1. Same `(entity, parameter)` with overlapping effective windows but different values.
2. Same concept definition phrased non-equivalently.
3. Same mechanism described with different components or ordering.
4. Same relation asserted with reversed polarity (A forks B vs B forks A).

When detected:

1. Set `disputed: true` in the affected page's frontmatter.
2. Append both claims into a `## Disputed claims` block in the canonical layout below.
3. Append one line to `open-questions.md` with a verification suggestion.
4. **Never silently overwrite.** Prior claims stay, with a `status:` flag if appropriate.

### Disputed claims block format

```markdown
## Disputed claims — {topic}

**Claim A** · confidence: high · recency: 2026-03 · authority: high
  {claim text} [^source-a]

**Claim B** · confidence: medium · recency: 2026-01 · authority: medium
  {claim text} [^source-b]
  status: likely_superseded   # one of: active | likely_superseded | refuted | unverified

→ Open question: {what would resolve this?}
  Suggested verification: {on-chain query, secondary source, primary doc lookup}
```
