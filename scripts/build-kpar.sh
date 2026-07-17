#!/usr/bin/env bash
# ─── memo-sysmlv2 build + portability gate ───────────────────────────────────
#
# Builds the MEMO ontology — carrying native `constraint def` / `requirement def`
# bodies (Epic EE) — into KerML Project Archives (.kpar) using the EXTERNAL,
# conformant SysML v2 tool Sensmetry `sysand`. A clean build with zero `error:`
# lines proves the ontology is portable content, not engine config.
#
# Two independent sysand projects are round-tripped from temporary staging
# directories. The npm content package does not ship SysAnd-specific
# `.project.json` descriptors; the build generates those transiently.
#
# Reproduce:  ./scripts/build-kpar.sh   (or: pnpm run build)
# Requires:   sysand on PATH (https://docs.sysand.org/)
# ─────────────────────────────────────────────────────────────────────────────
set -uo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

PROJECTS=("." "src/methodology")
PROJECT_NAMES=("memo-ontology" "memo-methodology-default")
PROJECT_USAGE=(
  '[{"resource":"urn:kpar:semantic-library"},{"resource":"urn:kpar:systems-library"},{"resource":"urn:kpar:metadata-library"}]'
  '[{"resource":"urn:kpar:memo-ontology"},{"resource":"urn:kpar:semantic-library"},{"resource":"urn:kpar:systems-library"}]'
)

if ! command -v sysand >/dev/null 2>&1; then
  echo "✖ sysand not found on PATH — install from https://docs.sysand.org/" >&2
  exit 127
fi

echo "── memo-sysmlv2 build: external SysML v2 parse via $(sysand --version) ──"

fail=0
for i in "${!PROJECTS[@]}"; do
  proj="${PROJECTS[$i]}"
  project_name="${PROJECT_NAMES[$i]}"
  project_usage="${PROJECT_USAGE[$i]}"
  dir="$REPO_ROOT/$proj"
  echo ""
  echo "▶ $proj"

  # Collect this project's own .sysml files. The ontology build excludes the
  # methodology sources, which are independently round-tripped below.
  files_file="$(mktemp)"
  python3 - "$dir" "$proj" >"$files_file" <<'PY'
import os, sys
root = sys.argv[1]
project = sys.argv[2]
for r, ds, fs in os.walk(root):
    ar = os.path.abspath(r)
    rel_dir = os.path.relpath(ar, root)
    excluded = ('src/methodology', 'src/examples')
    if project == '.' and any(rel_dir == path or rel_dir.startswith(path + os.sep) for path in excluded):
        continue
    ds[:] = [d for d in ds if d not in {'.git', 'node_modules', 'output', '.turbo'}]
    for f in fs:
        if f.endswith('.sysml'):
            print(os.path.relpath(os.path.join(r, f), root))
PY

  count="$(grep -c . "$files_file" || true)"
  echo "  sources: $count .sysml files"

  staging="$(mktemp -d)"
  while IFS= read -r source; do
    mkdir -p "$staging/$(dirname "$source")"
    cp "$dir/$source" "$staging/$source"
  done <"$files_file"

  # SysAnd resolves the project license from LICENSES/<SPDX-ID>.txt relative
  # to .project.json, so stage the repository's MIT license with the sources.
  mkdir -p "$staging/LICENSES"
  cp "$dir/LICENSES/MIT.txt" "$staging/LICENSES/MIT.txt"

  version="$(node -p "require('$REPO_ROOT/package.json').version")"
  printf '{\n  "name": "%s",\n  "version": "%s",\n  "license": "MIT",\n  "usage": %s\n}\n' \
    "$project_name" "$version" "$project_usage" >"$staging/.project.json"

  (
    cd "$staging"
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
    mkdir -p "$dir/output"
    cp "$kpar" "$dir/output/"
  ) || fail=1

  rm -f "$files_file"
  rm -rf "$staging"
done

echo ""
if [ "$fail" -ne 0 ]; then
  echo "✖ build FAILED — ontology does not parse cleanly in external tool."
  exit 1
fi
echo "✔ build PASSED — memo-sysmlv2 is portable SysML v2."
