#!/usr/bin/env bash
# ─── External portability gate for one MEMO project ──────────────────────────
#
# Proves that a project's model is portable SysML v2 and needs no MEMO-specific
# configuration to mean what it means:
#
#   1. no semantic YAML is present in the project,
#   2. SysIDE (`syside check`) reports zero errors over the project plus the
#      reusable source it imports,
#   3. Sensmetry `sysand` builds the same closure into a KPAR with zero errors.
#
# Usage:  ./scripts/check-project-portability.sh <project-dir>
# Requires: syside and sysand on PATH.
# ─────────────────────────────────────────────────────────────────────────────
set -uo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROJECT_DIR="${1:-}"

if [ -z "$PROJECT_DIR" ] || [ ! -d "$PROJECT_DIR" ]; then
  echo "usage: $0 <project-dir>" >&2
  exit 2
fi
PROJECT_DIR="$(cd "$PROJECT_DIR" && pwd)"
PROJECT_NAME="$(basename "$PROJECT_DIR")"

for tool in syside sysand; do
  command -v "$tool" >/dev/null 2>&1 || { echo "✖ $tool not found on PATH" >&2; exit 127; }
done

echo "── portability gate: $PROJECT_NAME ──"
fail=0

# ── 1. No semantic YAML ──────────────────────────────────────────────────────
# The project must carry no file that selects model content. Application
# settings are allowed; a semantic field in one is rejected by the loader, and
# the files below no longer exist as semantic inputs at all.
semantic_yaml="$(find "$PROJECT_DIR" \
  \( -name 'memo.config.yaml' -o -name 'memo.config.yml' \
  -o -name 'memo.rules.yaml' -o -name 'memo.rules.yml' \
  -o -name 'memo.viewpoints.yaml' -o -name 'memo.viewpoints.yml' \
  -o -name 'memo.rendering.yaml' -o -name 'memo.rendering.yml' \) -print)"
if [ -n "$semantic_yaml" ]; then
  echo "  ✖ semantic YAML present:"
  echo "$semantic_yaml" | sed 's/^/      /'
  fail=1
else
  echo "  ✔ no semantic YAML in the project"
fi

if [ ! -f "$PROJECT_DIR/model/catalog/project.sysml" ]; then
  echo "  ✖ no model/catalog/project.sysml — the project has no native entrypoint"
  fail=1
else
  echo "  ✔ native entrypoint present"
fi

# ── 2. SysIDE ────────────────────────────────────────────────────────────────
syside_out="$(syside check "$PROJECT_DIR" "$REPO_ROOT/src" 2>&1)"
if [ -n "$syside_out" ]; then
  echo "  ✖ syside check reported:"
  echo "$syside_out" | sed 's/^/      /'
  fail=1
else
  echo "  ✔ syside check clean"
fi

# ── 3. Sysand ────────────────────────────────────────────────────────────────
# The project and the reusable source it imports are staged as one sysand
# project, so the external build parses the whole closure the project resolves.
staging="$(mktemp -d)"
mkdir -p "$staging/reusable" "$staging/project" "$staging/LICENSES"
cp "$REPO_ROOT/LICENSES/MIT.txt" "$staging/LICENSES/MIT.txt"
( cd "$REPO_ROOT/src" && find . -name '*.sysml' -print0 | while IFS= read -r -d '' f; do
    mkdir -p "$staging/reusable/$(dirname "$f")"; cp "$f" "$staging/reusable/$f"
  done )
( cd "$PROJECT_DIR" && find . -name '*.sysml' -not -path './node_modules/*' -not -path '*/.venv/*' -print0 \
  | while IFS= read -r -d '' f; do
      mkdir -p "$staging/project/$(dirname "$f")"; cp "$f" "$staging/project/$f"
    done )

printf '{\n  "name": "memo-project-%s",\n  "version": "0.0.0",\n  "license": "MIT",\n  "usage": [{"resource":"urn:kpar:semantic-library"},{"resource":"urn:kpar:systems-library"},{"resource":"urn:kpar:metadata-library"}]\n}\n' \
  "$PROJECT_NAME" >"$staging/.project.json"

sysand_ok=0
(
  cd "$staging"
  find . -name '*.sysml' -print0 | xargs -0 sysand include --compute-checksum >/dev/null 2>&1
  out="$(sysand build 2>&1)" || true
  if echo "$out" | grep -qi '^error:\|: error'; then
    echo "  ✖ sysand build reported errors:"
    echo "$out" | grep -i 'error' | head -20 | sed 's/^/      /'
    exit 1
  fi
  if [ -z "$(ls output/*.kpar 2>/dev/null | head -1)" ]; then
    echo "  ✖ sysand produced no .kpar"
    exit 1
  fi
  echo "  ✔ sysand build clean"
) || sysand_ok=1
[ "$sysand_ok" -eq 0 ] || fail=1
rm -rf "$staging"

echo ""
if [ "$fail" -ne 0 ]; then
  echo "✖ portability gate FAILED for $PROJECT_NAME"
  exit 1
fi
echo "✔ portability gate PASSED for $PROJECT_NAME"
