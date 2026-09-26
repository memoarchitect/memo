# shellcheck shell=bash
# ─── Locate the memo-tools CLI ───────────────────────────────────────────────
#
# SysML checks in this repo go through `memo toolchain check`, never a tool
# spawned directly: memo-tools owns the validator providers, so the engine is
# a setting (`--toolchain.validator`, or MEMO_VALIDATOR here) and the SysIDE
# gaps listed in `validator-exceptions.json` are excepted wherever a check runs.
#
# memo-tools depends on this package, so it cannot be a dependency of it.
# Resolved in order: $MEMO_CLI, the workspace checkout beside this one
# (memo-meta/memo-tools, built), then `memo` on PATH. The checkout comes before
# PATH because a globally installed memo-tools is a release, usually older than
# the tree being built, and a check run by the wrong version is not the check.
#
# Sets MEMO_CMD (an array) and MEMO_VALIDATOR, or returns 1.
# ─────────────────────────────────────────────────────────────────────────────

MEMO_VALIDATOR="${MEMO_VALIDATOR:-syside}"

resolve_memo_cli() {
  local root="$1"
  if [ -n "${MEMO_CLI:-}" ]; then
    read -r -a MEMO_CMD <<<"$MEMO_CLI"
  elif [ -f "$root/../memo-tools/packages/tools/lib/bin/memo.js" ]; then
    MEMO_CMD=(node "$root/../memo-tools/packages/tools/lib/bin/memo.js")
  elif command -v memo >/dev/null 2>&1; then
    MEMO_CMD=(memo)
  else
    echo "✖ memo-tools CLI not found — set MEMO_CLI, put \`memo\` on PATH, or build ../memo-tools (pnpm build)" >&2
    return 1
  fi
}
