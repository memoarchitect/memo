#!/usr/bin/env bash
# ─── memo-sysmlv2 build + portability gate ───────────────────────────────────
#
# Builds the MEMO ontology — carrying native `constraint def` / `requirement def`
# bodies (Epic EE) — into KerML Project Archives (.kpar) using the EXTERNAL,
# conformant SysML v2 tool Sensmetry `sysand`. A clean build with zero `error:`
# lines proves the ontology is portable content, not engine config.
#
# Two independent sysand projects are round-tripped:
#   .                — the core ontology         (root .project.json,   memo-ontology)
#   src/methodology/ — default + GPCA methodology (nested .project.json, memo-methodology-default)
#
# Reproduce:  ./scripts/build-kpar.sh   (or: pnpm run build)
# Requires:   sysand on PATH (https://docs.sysand.org/)
# ─────────────────────────────────────────────────────────────────────────────
set -uo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

PROJECTS=(
  "."
  "src/methodology"
)

if ! command -v sysand >/dev/null 2>&1; then
  echo "✖ sysand not found on PATH — install from https://docs.sysand.org/" >&2
  exit 127
fi

echo "── memo-sysmlv2 build: external SysML v2 parse via $(sysand --version) ──"

fail=0
for proj in "${PROJECTS[@]}"; do
  dir="$REPO_ROOT/$proj"
  echo ""
  echo "▶ $proj"

  # Collect this project's own .sysml files, excluding nested sub-projects
  # (directories that carry their own .project.json).
  files_file="$(mktemp)"
  python3 - "$dir" >"$files_file" <<'PY'
import os, sys
root = sys.argv[1]
subprojects = set()
for r, ds, fs in os.walk(root):
    if r != root and '.project.json' in fs:
        subprojects.add(os.path.abspath(r))
for r, ds, fs in os.walk(root):
    ar = os.path.abspath(r)
    if any(ar == s or ar.startswith(s + os.sep) for s in subprojects):
        continue
    for f in fs:
        if f.endswith('.sysml'):
            print(os.path.relpath(os.path.join(r, f), root))
PY

  count="$(grep -c . "$files_file" || true)"
  echo "  sources: $count .sysml files"

  (
    cd "$dir"
    rm -f .meta.json
    rm -rf output
    # Index sources (regenerates .meta.json deterministically; not committed).
    tr '\n' '\0' <"$files_file" | xargs -0 sysand include --compute-checksum >/dev/null
    # Build the KPAR — the actual external parse.
    out="$(sysand build 2>&1)" || true
    echo "$out" | grep -v 'Including file' | sed 's/^/  /'
    if echo "$out" | grep -qi '^error:\|: error'; then
      echo "  ✖ external parse reported errors"
      exit 1
    fi
    kpar="$(ls output/*.kpar 2>/dev/null | head -1 || true)"
    if [ -z "$kpar" ]; then
      echo "  ✖ no .kpar produced"
      exit 1
    fi
    nsysml="$(unzip -l "$kpar" | grep -c '\.sysml' || true)"
    echo "  ✔ $(basename "$kpar") built — $nsysml source files, zero errors"
  ) || fail=1

  rm -f "$files_file"
done

echo ""
if [ "$fail" -ne 0 ]; then
  echo "✖ build FAILED — ontology does not parse cleanly in external tool."
  exit 1
fi
echo "✔ build PASSED — memo-sysmlv2 is portable SysML v2."
