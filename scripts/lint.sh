#!/usr/bin/env bash
# =============================================================================
# scripts/lint.sh — AGENTS.md §"Lint workflow" automated check runner
# Version: 1.0.0
# Language: Bash (chosen for portability; no Python dep needed)
# Dependencies: rg (ripgrep), fd, awk, sort, uniq, date, git
#               All are available in this repo's environment (per CLAUDE.md).
#
# HARD CONSTRAINT: This script is READ-ONLY against wiki content.
# It NEVER writes to entities/, concepts/, parameters/, sources/, mirror/,
# index.md, log.md, open-questions.md, AGENTS.md, audit/, raw/.
# Per AGENTS.md §"Lint workflow": "Do not auto-edit pages during lint —
# propose, let user approve."
# =============================================================================
set -euo pipefail

SCRIPT_VERSION="1.0.0"
WIKI_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# fd 10+ requires pattern as first positional arg.
# fd_md_dirs emits NUL-separated absolute .md paths across one or more dirs.
# Usage: fd_md_dirs -0 dir1 [dir2 ...]
fd_md_dirs() {
  local null_sep=false
  [[ "${1:-}" == "-0" ]] && null_sep=true && shift
  for _dir in "$@"; do
    [[ -d "$_dir" ]] || continue
    if $null_sep; then
      fd . "$_dir" -e md -0 2>/dev/null || true
    else
      fd . "$_dir" -e md 2>/dev/null || true
    fi
  done
}

# ---------------------------------------------------------------------------
# CLI parsing
# ---------------------------------------------------------------------------
JSON_OUTPUT=false
HELP=false

for arg in "$@"; do
  case "$arg" in
    --json) JSON_OUTPUT=true ;;
    --help|-h) HELP=true ;;
    *) echo "Unknown argument: $arg" >&2; exit 1 ;;
  esac
done

if $HELP; then
  cat <<'EOF'
Usage: lint.sh [--json] [--help]

Runs all AGENTS.md §"Lint workflow" checks against the current wiki state.
Prints a structured report. NEVER auto-edits wiki pages.

Options:
  --json    Emit machine-readable JSON report (default: human-readable text)
  --help    Show this help

Exit codes:
  0  All checks pass or INFO-only findings
  1  At least one IMPORTANT finding
  2  At least one CRITICAL finding

Checks implemented (14 total):
  1.  Disputed pages stale (>30 days without review)
  2.  Orphan parameters (no parent entity page)
  3.  Orphan concepts (not referenced by any perpdex entity)
  4.  Stale parameters (last_change >90 days)
  5.  Unfootnoted claims (heuristic — false positives possible)
  6.  Broken wikilinks
  7.  Invented relation verbs
  8.  Phase 2 incompleteness markers
  9.  Orphan sources (cited nowhere)
  10. Dangling footnotes (no source file)
  11. Mirror age report
  12. Superseded mirrors not yet reconciled
  13. Paused crawls
  14. Frame coverage report
EOF
  exit 0
fi

# ---------------------------------------------------------------------------
# Canonical verb set (from AGENTS.md §"Relations")
# ---------------------------------------------------------------------------
CANONICAL_VERBS=(
  implements
  runs_on
  uses
  competes_with
  forks
  derives_from
  charges
  rebates
  governs
  operates
  lists
  applies_to
  depends_on
  succeeds
  cites
  contradicts
  quotes_on
  partners_with
  distributes_to
  subsidizes
  seeds_liquidity_for
  is_collateral_for
  bridges_to
)

# ---------------------------------------------------------------------------
# Counters
# ---------------------------------------------------------------------------
COUNT_PASS=0
COUNT_INFO=0
COUNT_IMPORTANT=0
COUNT_CRITICAL=0

# Findings accumulator for JSON mode
declare -a JSON_SECTIONS=()

# ---------------------------------------------------------------------------
# Helper: get today's date as Unix epoch seconds (macOS + GNU compat)
# ---------------------------------------------------------------------------
today_epoch() {
  date +%s
}

# Parse YYYY-MM-DD → epoch seconds
date_to_epoch() {
  local d="$1"
  # Try GNU date first, fall back to macOS date
  if date --version >/dev/null 2>&1; then
    date -d "$d" +%s 2>/dev/null || echo 0
  else
    date -j -f "%Y-%m-%d" "$d" +%s 2>/dev/null || echo 0
  fi
}

# Days between a date string and today
days_since() {
  local d="$1"
  local then
  then=$(date_to_epoch "$d")
  local now
  now=$(today_epoch)
  if [[ "$then" -eq 0 ]]; then
    echo 9999
  else
    echo $(( (now - then) / 86400 ))
  fi
}

# Extract a frontmatter field value from a file
# Usage: frontmatter_field <file> <field>
frontmatter_field() {
  local file="$1"
  local field="$2"
  # Between the two --- delimiters, find "field: value"
  awk '/^---$/{f++; next} f==1 && /^'"$field"':/{sub(/^'"$field"': */,""); print; exit}' "$file"
}

# ---------------------------------------------------------------------------
# Output helpers
# ---------------------------------------------------------------------------
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
GIT_SHA=$(git -C "$WIKI_ROOT" rev-parse --short HEAD 2>/dev/null || echo "unknown")

print_header() {
  if ! $JSON_OUTPUT; then
    echo "=== AGENTS.md schema lint — ${TIMESTAMP} — HEAD ${GIT_SHA} ==="
    echo ""
  fi
}

# section_header <num> <name> <issue_count>
section_header() {
  local num="$1" name="$2" count="$3"
  if ! $JSON_OUTPUT; then
    if [[ "$count" -eq 0 ]]; then
      echo "## ${num}. ${name} [PASS]"
    else
      echo "## ${num}. ${name} [${count} issue(s)]"
    fi
  fi
}

finding() {
  local severity="$1"  # CRITICAL | IMPORTANT | INFO
  local msg="$2"
  if ! $JSON_OUTPUT; then
    echo "  [${severity}] ${msg}"
  fi
  case "$severity" in
    CRITICAL)  (( COUNT_CRITICAL++ ))  || true ;;
    IMPORTANT) (( COUNT_IMPORTANT++ )) || true ;;
    INFO)      (( COUNT_INFO++ ))      || true ;;
  esac
}

pass_finding() {
  (( COUNT_PASS++ )) || true
}

section_end() {
  if ! $JSON_OUTPUT; then
    echo ""
  fi
}

# ---------------------------------------------------------------------------
# CHECK 1: Disputed pages stale (>30 days)
# ---------------------------------------------------------------------------
check_1_disputed_stale() {
  local issues=0
  declare -a findings=()

  while IFS= read -r -d '' f; do
    local disputed
    disputed=$(frontmatter_field "$f" "disputed")
    if [[ "$disputed" == "true" ]]; then
      local lr
      lr=$(frontmatter_field "$f" "last_reviewed")
      if [[ -n "$lr" ]]; then
        local age
        age=$(days_since "$lr")
        if [[ "$age" -ge 30 ]]; then
          findings+=("[IMPORTANT] ${f#$WIKI_ROOT/} — disputed=true, last_reviewed=${lr} (${age} days ago)")
          (( issues++ )) || true
        fi
      else
        findings+=("[IMPORTANT] ${f#$WIKI_ROOT/} — disputed=true but no last_reviewed field")
        (( issues++ )) || true
      fi
    fi
  done < <(fd_md_dirs -0 "$WIKI_ROOT/entities" "$WIKI_ROOT/concepts" "$WIKI_ROOT/parameters")

  section_header 1 "Disputed pages stale (>30 days)" "$issues"
  if [[ "${#findings[@]}" -eq 0 ]]; then
    pass_finding
    if ! $JSON_OUTPUT; then echo "  (none)"; fi
  else
    for f in "${findings[@]}"; do
      local sev="${f%%]]*}"
      sev="${sev#[}"
      local msg="${f#*] }"
      finding "$sev" "$msg"
    done
  fi
  section_end
}

# ---------------------------------------------------------------------------
# CHECK 2: Orphan parameters (no parent entity page)
# ---------------------------------------------------------------------------
check_2_orphan_parameters() {
  local issues=0
  declare -a findings=()

  # parameters/<entity>/<file>.md → parent must be entities/<subtype>/<entity>.md
  local param_dir="${WIKI_ROOT}/parameters"
  if [[ ! -d "$param_dir" ]]; then
    section_header 2 "Orphan parameters" 0
    pass_finding
    if ! $JSON_OUTPUT; then echo "  (parameters/ directory missing — skip)"; fi
    section_end
    return
  fi

  while IFS= read -r -d '' pfile; do
    # pfile is an absolute path like /path/to/parameters/aster/alp.md
    local rel="${pfile#${param_dir}/}"       # aster/alp.md
    local entity_slug="${rel%%/*}"            # aster

    # Skip if entity_slug is empty or "." (shouldn't happen with absolute paths)
    [[ -z "$entity_slug" || "$entity_slug" == "." ]] && continue

    # Check if any entities/<subtype>/<entity_slug>.md exists
    local found=false
    local edir="${WIKI_ROOT}/entities"
    local subtypes
    subtypes=$(ls "$edir" 2>/dev/null) || true
    for st in $subtypes; do
      local candidate="${edir}/${st}/${entity_slug}.md"
      if [[ -f "$candidate" ]]; then
        found=true
        break
      fi
    done

    if [[ "$found" == false ]]; then
      findings+=("IMPORTANT|parameters/${rel} — parent entity '${entity_slug}' not found in entities/")
      (( issues++ )) || true
    fi
  done < <(fd_md_dirs -0 "$param_dir")

  section_header 2 "Orphan parameters (no parent entity page)" "$issues"
  if [[ "${#findings[@]}" -eq 0 ]]; then
    pass_finding
    if ! $JSON_OUTPUT; then echo "  (none)"; fi
  else
    for f in "${findings[@]}"; do
      finding "IMPORTANT" "${f#IMPORTANT|}"
    done
  fi
  section_end
}

# ---------------------------------------------------------------------------
# CHECK 3: Orphan concepts (not referenced by any perpdex entity)
# ---------------------------------------------------------------------------
check_3_orphan_concepts() {
  local issues=0
  declare -a findings=()

  local concepts_dir="${WIKI_ROOT}/concepts"
  local perpdex_dir="${WIKI_ROOT}/entities/perpdex"

  if [[ ! -d "$concepts_dir" ]] || [[ ! -d "$perpdex_dir" ]]; then
    section_header 3 "Orphan concepts" 0
    pass_finding
    if ! $JSON_OUTPUT; then echo "  (directories missing — skip)"; fi
    section_end
    return
  fi

  # Build set of all wikilink targets referenced in perpdex entity files
  local tmp_refs
  tmp_refs=$(mktemp)

  while IFS= read -r -d '' efile; do
    rg --no-filename --no-line-number -o '\[\[concepts/[^\]|]+' "$efile" 2>/dev/null \
      | sed 's/^\[\[//' >> "$tmp_refs" || true
  done < <(fd_md_dirs -0 "$perpdex_dir")

  while IFS= read -r -d '' cfile; do
    # cfile is absolute; derive wiki-relative path
    local rel="${cfile#${WIKI_ROOT}/}"    # e.g. concepts/risk/liquidation.md
    local no_ext="${rel%.md}"             # e.g. concepts/risk/liquidation
    if ! rg -qF "$no_ext" "$tmp_refs" 2>/dev/null; then
      findings+=("INFO|${rel} — not referenced by any entities/perpdex/*.md")
      (( issues++ )) || true
    fi
  done < <(fd_md_dirs -0 "$concepts_dir")

  rm -f "$tmp_refs"

  section_header 3 "Orphan concepts (not referenced by any perpdex entity)" "$issues"
  if [[ "${#findings[@]}" -eq 0 ]]; then
    pass_finding
    if ! $JSON_OUTPUT; then echo "  (none)"; fi
  else
    for f in "${findings[@]}"; do
      finding "INFO" "${f#INFO|}"
    done
  fi
  section_end
}

# ---------------------------------------------------------------------------
# CHECK 4: Stale parameters (last_change > 90 days)
# ---------------------------------------------------------------------------
check_4_stale_parameters() {
  local issues=0
  declare -a findings=()

  while IFS= read -r -d '' f; do
    local lc
    lc=$(frontmatter_field "$f" "last_change")
    if [[ -n "$lc" ]]; then
      local age
      age=$(days_since "$lc")
      if [[ "$age" -ge 90 ]]; then
        findings+=("INFO|${f#$WIKI_ROOT/} — last_change=${lc} (${age} days ago) — still current?")
        (( issues++ )) || true
      fi
    fi
  done < <(fd_md_dirs -0 "$WIKI_ROOT/parameters")

  section_header 4 "Stale parameters (last_change >90 days)" "$issues"
  if [[ "${#findings[@]}" -eq 0 ]]; then
    pass_finding
    if ! $JSON_OUTPUT; then echo "  (none)"; fi
  else
    for f in "${findings[@]}"; do
      finding "INFO" "${f#INFO|}"
    done
  fi
  section_end
}

# ---------------------------------------------------------------------------
# CHECK 5: Unfootnoted claims (HEURISTIC — false positives likely)
# ---------------------------------------------------------------------------
# Strategy: scan body lines (outside frontmatter, fenced code blocks, tables)
# for sentences ending with . or : that contain no [^...] citation.
# KNOWN LIMITATIONS / FALSE POSITIVE SOURCES:
#   - List items that are structural (e.g. "- See [[...]].")
#   - Sentences in headings (## Section.)
#   - Multi-line sentences where citation is on the next line
#   - Inline code blocks containing periods
#   - Template placeholder text
# This is explicitly labeled as heuristic in AGENTS.md.
# ---------------------------------------------------------------------------
check_5_unfootnoted_claims() {
  local issues=0
  declare -a findings=()

  local wiki_files=()
  while IFS= read -r -d '' f; do
    wiki_files+=("$f")
  done < <(fd_md_dirs -0 "$WIKI_ROOT/entities" "$WIKI_ROOT/concepts" "$WIKI_ROOT/parameters")

  for f in "${wiki_files[@]+"${wiki_files[@]}"}"; do
    local rel="${f#$WIKI_ROOT/}"
    local in_frontmatter=0
    local fm_count=0
    local in_fence=0
    local lineno=0

    while IFS= read -r line; do
      (( lineno++ )) || true

      # Track frontmatter (first pair of ---)
      if [[ "$line" == "---" ]]; then
        (( fm_count++ )) || true
        if [[ $fm_count -le 2 ]]; then
          continue
        fi
      fi
      # Skip lines inside frontmatter
      if [[ $fm_count -lt 2 ]]; then
        continue
      fi

      # Track fenced code blocks
      if [[ "$line" =~ ^'```' ]]; then
        if [[ $in_fence -eq 0 ]]; then
          in_fence=1
        else
          in_fence=0
        fi
        continue
      fi
      [[ $in_fence -eq 1 ]] && continue

      # Skip table rows (start with |)
      [[ "$line" =~ ^\| ]] && continue

      # Skip headings
      [[ "$line" =~ ^# ]] && continue

      # Skip blank lines
      [[ -z "${line// }" ]] && continue

      # Skip pure wikilink/list-ref lines (e.g. "- [[...]]")
      [[ "$line" =~ ^\-[[:space:]]*\[\[ ]] && continue

      # Skip footnote definition lines: [^id]: ...
      [[ "$line" =~ ^\[\^ ]] && continue

      # Check: line ends with . or : AND has no [^...] citation
      if [[ "$line" =~ [.:]$ ]] && ! [[ "$line" =~ \[\^ ]]; then
        # Additional filter: skip very short lines and pure structural lines
        local stripped="${line//\[/}"
        stripped="${stripped//\]/}"
        # If line is under 40 chars, likely structural
        if [[ "${#line}" -gt 40 ]]; then
          local excerpt="${line:0:80}"
          findings+=("INFO|${rel}:${lineno}: ${excerpt}…")
          (( issues++ )) || true
        fi
      fi
    done < "$f"
  done

  section_header 5 "Unfootnoted claims (heuristic — false positives expected)" "$issues"
  if ! $JSON_OUTPUT; then
    echo "  # NOTE: heuristic scan — verify findings manually before acting"
  fi
  if [[ "${#findings[@]}" -eq 0 ]]; then
    pass_finding
    if ! $JSON_OUTPUT; then echo "  (none detected)"; fi
  else
    # Cap output at 20 to avoid overwhelming the report
    local shown=0
    for f in "${findings[@]}"; do
      if [[ $shown -lt 20 ]]; then
        finding "INFO" "${f#INFO|}"
        (( shown++ )) || true
      fi
    done
    if [[ "${#findings[@]}" -gt 20 ]]; then
      if ! $JSON_OUTPUT; then
        echo "  … and $(( ${#findings[@]} - 20 )) more (suppressed — check 5 is heuristic)"
      fi
    fi
  fi
  section_end
}

# ---------------------------------------------------------------------------
# CHECK 6: Broken wikilinks
# ---------------------------------------------------------------------------
# Format: [[dir/path]] or [[dir/path|alias]]
# Resolves to $WIKI_ROOT/dir/path.md (or dir/path/index.md)
# ---------------------------------------------------------------------------
check_6_broken_wikilinks() {
  local issues=0
  declare -a findings=()

  local valid_dirs=(entities concepts parameters sources audit)

  while IFS= read -r -d '' f; do
    local rel="${f#$WIKI_ROOT/}"
    # Extract all [[...]] wikilinks
    while IFS= read -r link; do
      # Strip leading [[ and trailing ]] or |alias]]
      local target="${link#[[}"
      target="${target%%|*}"
      target="${target%%]]*}"
      target="${target%]}"

      # Strip anchor fragments (#section-name) before resolving
      local target_noanchor="${target%%#*}"

      # Only check links that start with one of our valid dirs
      local valid=false
      local first_segment="${target_noanchor%%/*}"
      for vd in "${valid_dirs[@]}"; do
        if [[ "$first_segment" == "$vd" ]]; then
          valid=true
          break
        fi
      done
      $valid || continue

      # Check if file exists (anchor links are valid if the base file exists)
      local candidate="${WIKI_ROOT}/${target_noanchor}.md"
      if [[ ! -f "$candidate" ]]; then
        findings+=("IMPORTANT|${rel} → [[${target}]] — file not found")
        (( issues++ )) || true
      fi
    done < <(rg --no-filename --no-line-number -o '\[\[[^\]]+\]\]' "$f" 2>/dev/null || true)
  done < <(fd_md_dirs -0 "$WIKI_ROOT/entities" "$WIKI_ROOT/concepts" \
              "$WIKI_ROOT/parameters" "$WIKI_ROOT/sources")

  section_header 6 "Broken wikilinks" "$issues"
  if [[ "${#findings[@]}" -eq 0 ]]; then
    pass_finding
    if ! $JSON_OUTPUT; then echo "  (none)"; fi
  else
    for f in "${findings[@]}"; do
      finding "IMPORTANT" "${f#IMPORTANT|}"
    done
  fi
  section_end
}

# ---------------------------------------------------------------------------
# CHECK 7: Invented relation verbs
# ---------------------------------------------------------------------------
# Scan **verb** patterns in body prose (outside frontmatter, fenced blocks,
# tables, backtick spans). Flag verbs not in canonical set.
# ---------------------------------------------------------------------------
check_7_invented_verbs() {
  local issues=0
  declare -a findings=()

  # Build verb pattern for rg
  # We look for **word** patterns and check them against canonical set
  local verb_re='\*\*([a-z][a-z_/]*)\*\*'

  while IFS= read -r -d '' f; do
    local rel="${f#$WIKI_ROOT/}"
    local in_fm=0
    local fm_count=0
    local in_fence=0
    local lineno=0

    while IFS= read -r line; do
      (( lineno++ )) || true

      # Track frontmatter
      if [[ "$line" == "---" ]]; then
        (( fm_count++ )) || true
        if [[ $fm_count -le 2 ]]; then continue; fi
      fi
      [[ $fm_count -lt 2 ]] && continue

      # Track fenced blocks
      if [[ "$line" =~ ^'```' ]]; then
        (( in_fence = 1 - in_fence )) || true
        continue
      fi
      [[ $in_fence -eq 1 ]] && continue

      # Skip table rows
      [[ "$line" =~ ^\| ]] && continue

      # Only check lines with wikilinks — relations take the form [[X]] **verb** [[Y]]
      # Skipping non-wikilink lines avoids false positives on bold prose words.
      [[ "$line" == *"[["* ]] || continue

      # Extract all **verb** tokens
      local remaining="$line"
      while [[ "$remaining" =~ \*\*([a-z][a-z_/]*)\*\* ]]; do
        local verb="${BASH_REMATCH[1]}"
        # Strip the match from remaining to find next
        remaining="${remaining#*\*\*${verb}\*\*}"

        local canon=false
        for cv in "${CANONICAL_VERBS[@]}"; do
          if [[ "$cv" == "$verb" ]]; then
            canon=true
            break
          fi
        done
        if ! $canon; then
          findings+=("IMPORTANT|${rel}:${lineno}: verb '${verb}' not in canonical set")
          (( issues++ )) || true
        fi
      done
    done < "$f"
  done < <(fd_md_dirs -0 "$WIKI_ROOT/entities" "$WIKI_ROOT/concepts" "$WIKI_ROOT/parameters")

  section_header 7 "Invented relation verbs" "$issues"
  if [[ "${#findings[@]}" -eq 0 ]]; then
    pass_finding
    if ! $JSON_OUTPUT; then echo "  (none)"; fi
  else
    # Deduplicate verbs using a temp file as a seen-set (bash 3 compat)
    local seen_verbs_file
    seen_verbs_file=$(mktemp)
    for f in "${findings[@]+"${findings[@]}"}"; do
      local verb
      verb=$(echo "$f" | rg -o "verb '[^']+'" | head -1)
      if ! rg -qF "$verb" "$seen_verbs_file" 2>/dev/null; then
        finding "IMPORTANT" "${f#IMPORTANT|}"
        echo "$verb" >> "$seen_verbs_file"
      fi
    done
    rm -f "$seen_verbs_file"
  fi
  section_end
}

# ---------------------------------------------------------------------------
# CHECK 8: Phase 2 incompleteness markers
# ---------------------------------------------------------------------------
# For each perpdex entity, check that concept pages referenced from its body
# have a "Variants in the wild" row mentioning the venue name.
# ---------------------------------------------------------------------------
check_8_phase2_incompleteness() {
  local issues=0
  declare -a findings=()

  local perpdex_dir="${WIKI_ROOT}/entities/perpdex"
  if [[ ! -d "$perpdex_dir" ]]; then
    section_header 8 "Phase 2 incompleteness markers" 0
    pass_finding
    if ! $JSON_OUTPUT; then echo "  (entities/perpdex/ missing — skip)"; fi
    section_end
    return
  fi

  # Temp file to track (venue_slug|concept_path) pairs already reported (bash 3 compat)
  local seen_pairs
  seen_pairs=$(mktemp)

  while IFS= read -r -d '' efile; do
    local venue_slug
    venue_slug=$(basename "$efile" .md)
    local venue_name
    venue_name=$(frontmatter_field "$efile" "name")
    [[ -z "$venue_name" ]] && venue_name="$venue_slug"

    # Find all [[concepts/...]] wikilinks in this entity file (deduplicated)
    while IFS= read -r clink; do
      local concept_path="${clink#[[}"
      concept_path="${concept_path%%|*}"
      concept_path="${concept_path%%]]*}"
      concept_path="${concept_path%]}"
      # Strip anchor
      concept_path="${concept_path%%#*}"

      local concept_file="${WIKI_ROOT}/${concept_path}.md"
      [[ -f "$concept_file" ]] || continue

      # Dedup: skip if we already reported this (venue, concept) pair
      local pair_key="${venue_slug}|${concept_path}"
      if rg -qxF "$pair_key" "$seen_pairs" 2>/dev/null; then
        continue
      fi
      echo "$pair_key" >> "$seen_pairs"

      # Does the concept have a "Variants in the wild" section?
      if ! rg -q "Variants in the wild" "$concept_file" 2>/dev/null; then
        continue  # concept has no Variants section — not an incompleteness issue
      fi

      # Does the Variants section mention this venue?
      if ! rg -qi "$venue_slug\|$venue_name" "$concept_file" 2>/dev/null; then
        findings+=("IMPORTANT|entities/perpdex/${venue_slug}.md → ${concept_path}.md missing '${venue_name}' row in Variants in the wild")
        (( issues++ )) || true
      fi
    done < <(rg --no-filename --no-line-number -o '\[\[concepts/[^\]|]+' "$efile" 2>/dev/null | sed 's/^\[\[/[[/' | sort -u || true)
  done < <(fd_md_dirs -0 "$perpdex_dir")

  rm -f "$seen_pairs"

  section_header 8 "Phase 2 incompleteness markers" "$issues"
  if [[ "${#findings[@]}" -eq 0 ]]; then
    pass_finding
    if ! $JSON_OUTPUT; then echo "  (none)"; fi
  else
    for f in "${findings[@]}"; do
      finding "IMPORTANT" "${f#IMPORTANT|}"
    done
  fi
  section_end
}

# ---------------------------------------------------------------------------
# CHECK 9: Orphan sources (cited nowhere)
# ---------------------------------------------------------------------------
check_9_orphan_sources() {
  local issues=0
  declare -a findings=()

  local sources_dir="${WIKI_ROOT}/sources"
  if [[ ! -d "$sources_dir" ]]; then
    section_header 9 "Orphan sources (cited nowhere)" 0
    pass_finding
    if ! $JSON_OUTPUT; then echo "  (sources/ missing — skip)"; fi
    section_end
    return
  fi

  while IFS= read -r -d '' sf; do
    local src_id
    src_id=$(frontmatter_field "$sf" "id")
    [[ -z "$src_id" ]] && continue

    # Search for [^src_id] in all wiki pages
    if ! rg -qF "[^${src_id}]" \
              "${WIKI_ROOT}/entities" \
              "${WIKI_ROOT}/concepts" \
              "${WIKI_ROOT}/parameters" \
              "${WIKI_ROOT}/index.md" \
              "${WIKI_ROOT}/log.md" \
              2>/dev/null; then
      findings+=("INFO|sources/${sf#$sources_dir/} — id '${src_id}' is never cited")
      (( issues++ )) || true
    fi
  done < <(fd_md_dirs -0 "$sources_dir")

  section_header 9 "Orphan sources (cited nowhere)" "$issues"
  if [[ "${#findings[@]}" -eq 0 ]]; then
    pass_finding
    if ! $JSON_OUTPUT; then echo "  (none)"; fi
  else
    for f in "${findings[@]}"; do
      finding "INFO" "${f#INFO|}"
    done
  fi
  section_end
}

# ---------------------------------------------------------------------------
# CHECK 10: Dangling footnote IDs (cited but no source file)
# ---------------------------------------------------------------------------
check_10_dangling_footnotes() {
  local issues=0
  declare -a findings=()

  local sources_dir="${WIKI_ROOT}/sources"

  # Build known-source-ids file (bash 3 compat: use temp file instead of assoc array)
  local known_ids_file
  known_ids_file=$(mktemp)
  if [[ -d "$sources_dir" ]]; then
    while IFS= read -r -d '' sf; do
      local sid
      sid=$(frontmatter_field "$sf" "id")
      [[ -n "$sid" ]] && echo "$sid" >> "$known_ids_file"
    done < <(fd_md_dirs -0 "$sources_dir")
  fi

  while IFS= read -r -d '' f; do
    local rel="${f#$WIKI_ROOT/}"
    # Find all [^id] usages (citations, not definitions)
    while IFS= read -r cid; do
      # cid is like [^hl-docs-2026-04-27-trading-fees]
      local sid="${cid#[^}"
      sid="${sid%]}"
      [[ -z "$sid" ]] && continue

      if ! rg -qxF "$sid" "$known_ids_file" 2>/dev/null; then
        findings+=("IMPORTANT|${rel} — [^${sid}] has no matching sources/<file> with id: ${sid}")
        (( issues++ )) || true
      fi
    done < <(rg --no-filename --no-line-number -o '\[\^[a-zA-Z0-9_-]+\]' "$f" 2>/dev/null | sort -u || true)
  done < <(fd_md_dirs -0 "$WIKI_ROOT/entities" "$WIKI_ROOT/concepts" "$WIKI_ROOT/parameters")

  rm -f "$known_ids_file"

  section_header 10 "Dangling footnotes (no source file)" "$issues"
  if [[ "${#findings[@]}" -eq 0 ]]; then
    pass_finding
    if ! $JSON_OUTPUT; then echo "  (none)"; fi
  else
    for f in "${findings[@]}"; do
      finding "IMPORTANT" "${f#IMPORTANT|}"
    done
  fi
  section_end
}

# ---------------------------------------------------------------------------
# CHECK 11: Mirror age report
# ---------------------------------------------------------------------------
# Per AGENTS.md: "Do NOT suggest refresh — refresh is user-initiated only."
# Just report ages so the user can decide.
# ---------------------------------------------------------------------------
check_11_mirror_age() {
  local mirror_index="${WIKI_ROOT}/mirror/_index.md"
  declare -a findings=()
  local issue_count=0

  if [[ ! -f "$mirror_index" ]]; then
    section_header 11 "Mirror age report" 0
    if ! $JSON_OUTPUT; then echo "  (mirror/_index.md not found — skip)"; fi
    pass_finding
    section_end
    return
  fi

  # Parse Active table rows
  # Format: | snapshot_id | root_url | path_prefix | crawled_at | pages | crawler |
  local in_active=false
  while IFS= read -r line; do
    if [[ "$line" =~ ^##[[:space:]]Active ]]; then
      in_active=true
      continue
    fi
    if [[ "$line" =~ ^##[[:space:]] ]] && $in_active; then
      in_active=false
    fi

    if $in_active && [[ "$line" =~ ^\|[[:space:]]([^|]+)[[:space:]]\|[[:space:]]([^|]+)[[:space:]]\|[[:space:]]([^|]+)[[:space:]]\|[[:space:]]([^|]+)[[:space:]]\| ]]; then
      local sid="${BASH_REMATCH[1]// /}"
      local crawled="${BASH_REMATCH[4]// /}"
      # Skip header and separator rows
      [[ "$sid" == "snapshot_id" ]] && continue
      [[ "$sid" =~ ^---+ ]] && continue
      [[ -z "$sid" ]] && continue

      # Parse date from crawled_at (e.g. 2026-04-27T17:20:00Z → 2026-04-27)
      local date_part="${crawled%%T*}"
      date_part="${date_part%%[[:space:]]*}"
      local age=0
      if [[ "$date_part" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
        age=$(days_since "$date_part")
      fi

      local sev="INFO"
      findings+=("${sev}|Mirror snapshot '${sid}' crawled ${date_part} (${age} day(s) ago)")
      (( issue_count++ )) || true
    fi
  done < "$mirror_index"

  section_header 11 "Mirror age report (INFO only — no refresh suggested)" "$issue_count"
  if [[ "${#findings[@]}" -eq 0 ]]; then
    pass_finding
    if ! $JSON_OUTPUT; then echo "  (no active snapshots)"; fi
  else
    for f in "${findings[@]}"; do
      finding "INFO" "${f#INFO|}"
    done
  fi
  section_end
}

# ---------------------------------------------------------------------------
# CHECK 12: Superseded mirrors not yet reconciled
# ---------------------------------------------------------------------------
check_12_superseded_mirrors() {
  local mirror_index="${WIKI_ROOT}/mirror/_index.md"
  declare -a findings=()
  local issues=0

  if [[ ! -f "$mirror_index" ]]; then
    section_header 12 "Superseded mirrors not yet reconciled" 0
    pass_finding
    if ! $JSON_OUTPUT; then echo "  (mirror/_index.md not found — skip)"; fi
    section_end
    return
  fi

  # Parse Superseded table
  local in_super=false
  while IFS= read -r line; do
    if [[ "$line" =~ ^##[[:space:]]Superseded ]]; then
      in_super=true
      continue
    fi
    if [[ "$line" =~ ^##[[:space:]] ]] && $in_super; then
      in_super=false
    fi

    if $in_super && [[ "$line" =~ ^\|[[:space:]]([^|]+)[[:space:]]\|[[:space:]]([^|]+)[[:space:]]\| ]]; then
      local sid="${BASH_REMATCH[1]// /}"
      [[ "$sid" == "snapshot_id" ]] && continue
      [[ "$sid" =~ ^---+ ]] && continue
      [[ -z "$sid" ]] && continue
      # Skip placeholder "(none yet)"
      [[ "$sid" == *none* ]] && continue
      [[ "$line" == *"(none"* ]] && continue

      findings+=("IMPORTANT|Superseded snapshot '${sid}' — verify claims against newer counterpart for contradictions")
      (( issues++ )) || true
    fi
  done < "$mirror_index"

  section_header 12 "Superseded mirrors not yet reconciled" "$issues"
  if [[ "${#findings[@]}" -eq 0 ]]; then
    pass_finding
    if ! $JSON_OUTPUT; then echo "  (none)"; fi
  else
    for f in "${findings[@]}"; do
      finding "IMPORTANT" "${f#IMPORTANT|}"
    done
  fi
  section_end
}

# ---------------------------------------------------------------------------
# CHECK 13: Paused crawls
# ---------------------------------------------------------------------------
check_13_paused_crawls() {
  local mirror_index="${WIKI_ROOT}/mirror/_index.md"
  declare -a findings=()
  local issues=0

  if [[ ! -f "$mirror_index" ]]; then
    section_header 13 "Paused crawls" 0
    pass_finding
    if ! $JSON_OUTPUT; then echo "  (mirror/_index.md not found — skip)"; fi
    section_end
    return
  fi

  local in_paused=false
  while IFS= read -r line; do
    if [[ "$line" =~ ^##[[:space:]]Paused ]]; then
      in_paused=true
      continue
    fi
    if [[ "$line" =~ ^##[[:space:]] ]] && $in_paused; then
      in_paused=false
    fi

    if $in_paused && [[ "$line" =~ ^\|[[:space:]]([^|]+)[[:space:]]\|[[:space:]]([^|]+)[[:space:]]\| ]]; then
      local sid="${BASH_REMATCH[1]// /}"
      [[ "$sid" == "snapshot_id" ]] && continue
      [[ "$sid" =~ ^---+ ]] && continue
      [[ -z "$sid" ]] && continue
      [[ "$sid" == *none* ]] && continue
      [[ "$line" == *"(none"* ]] && continue

      findings+=("INFO|Paused crawl: '${sid}' — hit max_pages; user must decide whether to resume")
      (( issues++ )) || true
    fi
  done < "$mirror_index"

  section_header 13 "Paused crawls (hit max_pages)" "$issues"
  if [[ "${#findings[@]}" -eq 0 ]]; then
    pass_finding
    if ! $JSON_OUTPUT; then echo "  (none)"; fi
  else
    for f in "${findings[@]}"; do
      finding "INFO" "${f#INFO|}"
    done
  fi
  section_end
}

# ---------------------------------------------------------------------------
# CHECK 14: Frame coverage report (perpdex 1-hop)
# ---------------------------------------------------------------------------
# For each entities/perpdex/<venue>.md:
#   - Read the ## Frame coverage section
#   - Count filled / not-applicable / gap (should sum to 45)
#   - Read sources/  matching the venue prefix for frame_tag column
#   - Validate frame_tag regex
#   - Flag untagged / malformed / unrationalized
# ---------------------------------------------------------------------------
check_14_frame_coverage() {
  local issues=0
  declare -a findings=()
  declare -a venue_summaries=()  # buffered INFO lines per venue

  local frame_tag_re='^(A[1-9]-P(I|II|III|IV|V)(, A[1-9]-P(I|II|III|IV|V))*|-)$'
  local perpdex_dir="${WIKI_ROOT}/entities/perpdex"
  local sources_dir="${WIKI_ROOT}/sources"

  if [[ ! -d "$perpdex_dir" ]]; then
    section_header 14 "Frame coverage report" 0
    pass_finding
    if ! $JSON_OUTPUT; then echo "  (entities/perpdex/ missing — skip)"; fi
    section_end
    return
  fi

  while IFS= read -r -d '' efile; do
    local venue_slug
    venue_slug=$(basename "$efile" .md)
    local venue_name
    venue_name=$(frontmatter_field "$efile" "name")
    [[ -z "$venue_name" ]] && venue_name="$venue_slug"

    # --- Parse ## Frame coverage section from entity file ---
    local filled=0 na=0 gap=0 unrationalized=0
    local in_frame=false

    while IFS= read -r line; do
      if [[ "$line" =~ ^##[[:space:]]Frame[[:space:]]coverage ]]; then
        in_frame=true
        continue
      fi
      if [[ "$line" =~ ^##[[:space:]] ]] && $in_frame; then
        in_frame=false
      fi

      $in_frame || continue
      [[ -z "${line// }" ]] && continue

      # Skip the "Coverage summary:" line — it contains all keywords and would double-count
      [[ "$line" =~ ^Coverage[[:space:]]summary ]] && continue
      # Only count lines that look like coverage entries: start with "- A<n>/"
      [[ "$line" =~ ^-[[:space:]]A[1-9]/ ]] || continue

      # Lines like: - A1/PI: filled
      # or: - A5/PI through A5/PV: not-applicable — ...
      # Count cells by counting A<n>/P<roman> occurrences in the line
      local cell_count=0
      local scan="$line"
      while [[ "$scan" =~ A[1-9]/P(I|II|III|IV|V) ]]; do
        (( cell_count++ )) || true
        scan="${scan#*${BASH_REMATCH[0]}}"
      done
      [[ $cell_count -eq 0 ]] && cell_count=1  # fallback for single-cell entries

      if [[ "$line" =~ filled ]]; then
        (( filled += cell_count )) || true
      elif [[ "$line" =~ not-applicable|not_applicable ]]; then
        (( na += cell_count )) || true
        # Check rationale present
        if ! [[ "$line" =~ not-applicable[[:space:]]—[[:space:]].+ ]] && \
           ! [[ "$line" =~ not-applicable:[[:space:]].+ ]] && \
           ! [[ "$line" =~ not-applicable[[:space:]]*— ]]; then
          findings+=("INFO|entities/perpdex/${venue_slug}.md — '${line:0:80}' missing rationale (frame: unrationalized)")
          (( unrationalized++ )) || true
          (( issues++ )) || true
        fi
      elif [[ "$line" =~ :[[:space:]]gap ]]; then
        (( gap += cell_count )) || true
        # Check rationale
        if ! [[ "$line" =~ gap[[:space:]]—[[:space:]].+ ]] && \
           ! [[ "$line" =~ gap:[[:space:]].+ ]]; then
          findings+=("INFO|entities/perpdex/${venue_slug}.md — '${line:0:80}' gap missing rationale (frame: unrationalized)")
          (( unrationalized++ )) || true
          (( issues++ )) || true
        fi
      fi
    done < "$efile"

    local total=$(( filled + na + gap ))

    # Buffer the per-venue summary (printed after section_header)
    venue_summaries+=("$(printf "  [INFO] %-20s  filled=%d / NA=%d / gap=%d = %d (expected 45)" \
             "${venue_slug}" "$filled" "$na" "$gap" "$total")")

    if [[ $total -ne 45 ]] && [[ $total -gt 0 ]]; then
      findings+=("IMPORTANT|entities/perpdex/${venue_slug}.md — frame coverage total=${total} (expected 45); check for missing or duplicate entries")
      (( issues++ )) || true
    elif [[ $total -eq 0 ]]; then
      findings+=("INFO|entities/perpdex/${venue_slug}.md — no ## Frame coverage section found")
      (( issues++ )) || true
    fi

    # --- Scan source files for this venue's frame_tags ---
    # Source files matching prefix: <venue_slug>-* OR *-<venue_slug>-*
    local in_scope_total=0 untagged_count=0 malformed_count=0 dash_count=0

    while IFS= read -r -d '' sf; do
      local in_claims=false
      while IFS= read -r sline; do
        if [[ "$sline" =~ ^##[[:space:]]Claims[[:space:]]extracted ]]; then
          in_claims=true
          continue
        fi
        if [[ "$sline" =~ ^##[[:space:]] ]] && $in_claims; then
          in_claims=false
        fi

        $in_claims || continue

        # Table data rows (not header/separator): | #cN | claim | filed_to | frame_tag |
        [[ "$sline" =~ ^\|[[:space:]]*\#c ]] || continue

        # Extract frame_tag (4th column)
        local ft
        ft=$(echo "$sline" | awk -F'|' '{gsub(/^[[:space:]]+|[[:space:]]+$/, "", $5); print $5}')

        # Check if filed_to has a perpdex link (in-scope)
        local filed_to
        filed_to=$(echo "$sline" | awk -F'|' '{print $4}')
        if ! echo "$filed_to" | rg -q "entities/perpdex" 2>/dev/null; then
          continue  # out of frame scope
        fi

        (( in_scope_total++ )) || true

        if [[ -z "${ft// }" ]]; then
          (( untagged_count++ )) || true
        elif [[ "$ft" == "-" ]]; then
          (( dash_count++ )) || true
        elif ! echo "$ft" | rg -q "$frame_tag_re" 2>/dev/null; then
          (( malformed_count++ )) || true
          findings+=("IMPORTANT|${sf#$WIKI_ROOT/} — frame_tag '${ft}' is malformed (frame: malformed)")
          (( issues++ )) || true
        fi
      done < "$sf"
    done < <(fd_md_dirs -0 "$sources_dir" \
             | while IFS= read -r -d '' sf; do
               base=$(basename "$sf" .md)
               if [[ "$base" == *"-${venue_slug}-"* ]] || \
                  [[ "$base" == "${venue_slug}-"* ]] || \
                  [[ "$base" == *"-${venue_slug}" ]]; then
                 printf '%s\0' "$sf"
               fi
             done)

    if [[ $in_scope_total -gt 0 ]]; then
      local untagged_pct=$(( untagged_count * 100 / in_scope_total ))
      local dash_pct=$(( dash_count * 100 / in_scope_total ))
      venue_summaries+=("$(printf "  [INFO] %-20s  source in-scope claims=%d  untagged=%d(%d%%)  dash=%d(%d%%)  malformed=%d" \
               "${venue_slug}" "$in_scope_total" \
               "$untagged_count" "$untagged_pct" \
               "$dash_count" "$dash_pct" \
               "$malformed_count")")

      if [[ $untagged_pct -gt 10 ]]; then
        findings+=("IMPORTANT|entities/perpdex/${venue_slug}.md — untagged rate ${untagged_pct}% exceeds 10% threshold; Phase 1 agent prompt may need tightening")
        (( issues++ )) || true
      fi
      if [[ $dash_pct -gt 30 ]]; then
        findings+=("INFO|entities/perpdex/${venue_slug}.md — definition-heavy source set: dash-tagged rate ${dash_pct}% (>30%; expected for primary docs)")
        (( issues++ )) || true
      fi
    fi

  done < <(fd_md_dirs -0 "$perpdex_dir")

  section_header 14 "Frame coverage report (perpdex 1-hop)" "$issues"
  # Print buffered per-venue summaries first
  if ! $JSON_OUTPUT; then
    for vs in "${venue_summaries[@]+"${venue_summaries[@]}"}"; do
      echo "$vs"
      (( COUNT_INFO++ )) || true
    done
  fi
  if [[ "${#findings[@]}" -eq 0 ]]; then
    pass_finding
  else
    for f in "${findings[@]+"${findings[@]}"}"; do
      local sev="${f%%|*}"
      finding "$sev" "${f#${sev}|}"
    done
  fi
  section_end
}

# ---------------------------------------------------------------------------
# JSON output builder
# ---------------------------------------------------------------------------
emit_json_report() {
  local ts="$1" sha="$2"
  echo "{"
  echo "  \"lint_timestamp\": \"${ts}\","
  echo "  \"git_sha\": \"${sha}\","
  echo "  \"summary\": {"
  echo "    \"PASS\": ${COUNT_PASS},"
  echo "    \"INFO\": ${COUNT_INFO},"
  echo "    \"IMPORTANT\": ${COUNT_IMPORTANT},"
  echo "    \"CRITICAL\": ${COUNT_CRITICAL}"
  echo "  }"
  echo "}"
}

# ---------------------------------------------------------------------------
# Summary line + exit code
# ---------------------------------------------------------------------------
print_summary() {
  if ! $JSON_OUTPUT; then
    echo "---"
    echo "Total: PASS=${COUNT_PASS} | INFO=${COUNT_INFO} | IMPORTANT=${COUNT_IMPORTANT} | CRITICAL=${COUNT_CRITICAL}"
  else
    emit_json_report "$TIMESTAMP" "$GIT_SHA"
  fi

  if [[ $COUNT_CRITICAL -gt 0 ]]; then
    exit 2
  elif [[ $COUNT_IMPORTANT -gt 0 ]]; then
    exit 1
  else
    exit 0
  fi
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
main() {
  print_header

  check_1_disputed_stale
  check_2_orphan_parameters
  check_3_orphan_concepts
  check_4_stale_parameters
  check_5_unfootnoted_claims
  check_6_broken_wikilinks
  check_7_invented_verbs
  check_8_phase2_incompleteness
  check_9_orphan_sources
  check_10_dangling_footnotes
  check_11_mirror_age
  check_12_superseded_mirrors
  check_13_paused_crawls
  check_14_frame_coverage

  print_summary
}

main
