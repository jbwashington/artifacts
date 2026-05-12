#!/usr/bin/env bash
# Daily cleanup of expired artifacts in this GitHub Pages repo.
#
# Scans this directory for .html files whose <html data-artifact-expires="YYYY-MM-DD">
# attribute is in the past. Expired files are git-rm'd, the index is regenerated,
# a single commit captures all removals, and the result is pushed to main.
#
# The author's local copy at ~/Documents/livedocs/personal/ is NOT touched —
# only the public-facing repo is cleaned. This keeps your private record while
# expiring the shared URL.
#
# Env vars:
#   ARTIFACT_DRY_RUN=1    Log what would happen without modifying anything.

set -euo pipefail
cd "$(dirname "$0")"

DRY_RUN="${ARTIFACT_DRY_RUN:-0}"
TODAY=$(date +%Y-%m-%d)
deleted=()

shopt -s nullglob
for f in *.html; do
  [[ "$f" == "index.html" ]] && continue
  match=$( { grep -oE 'data-artifact-expires="[^"]+"' "$f" || true; } 2>/dev/null | head -1)
  [[ -z "$match" ]] && continue
  exp="${match#data-artifact-expires=\"}"
  exp="${exp%\"}"
  # YYYY-MM-DD strings sort lexicographically the same as dates.
  if [[ "$exp" < "$TODAY" ]]; then
    echo "Expiring: $f (expired $exp)"
    if [[ "$DRY_RUN" != "0" ]]; then
      echo "  [DRY RUN] would: git rm $f"
    else
      git rm -- "$f"
    fi
    deleted+=("$f")
  fi
done

if [[ ${#deleted[@]} -eq 0 ]]; then
  echo "No expired artifacts as of $TODAY"
  exit 0
fi

if [[ "$DRY_RUN" != "0" ]]; then
  echo "[DRY RUN] would: regenerate index, commit, push"
  exit 0
fi

./regen-index.sh
git add index.html

git commit -m "Auto-expire: ${#deleted[@]} artifact(s) [$TODAY]

$(printf -- '- %s\n' "${deleted[@]}")
"
git push origin main

echo "Expired ${#deleted[@]} artifact(s) and pushed to GitHub Pages"
