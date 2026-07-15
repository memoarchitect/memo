#!/usr/bin/env python3
"""Format SysML files: break long single-line definitions into readable multi-line form."""

import re
import sys
import os
from pathlib import Path


def get_indent(line: str) -> str:
    return line[: len(line) - len(line.lstrip())]


def format_block_contents(contents: str, base_indent: str) -> list[str]:
    """Split a brace-enclosed body into individual statements, each on its own line."""
    inner_indent = base_indent + "    "
    stmts = [s.strip() for s in contents.split(";") if s.strip()]
    lines = []
    for stmt in stmts:
        lines.append(f"{inner_indent}{stmt};")
    return lines


def format_line(line: str) -> list[str]:
    """Format a single line. Returns a list of lines (may be 1 if no change needed)."""
    stripped = line.strip()

    # Skip empty, comment-only, or already-well-formatted lines
    if not stripped or stripped.startswith("//") or stripped.startswith("/*"):
        return [line]

    # Skip lines that don't have a brace-enclosed body with multiple semicolons
    if "{" not in stripped or "}" not in stripped:
        return [line]

    # Count semicolons inside the outermost braces
    brace_start = stripped.index("{")
    brace_end = stripped.rindex("}")
    body = stripped[brace_start + 1 : brace_end]

    semicolons_in_body = body.count(";")
    if semicolons_in_body <= 1:
        return [line]

    # This line needs formatting
    indent = get_indent(line)
    header = stripped[:brace_start].rstrip()
    after_close = stripped[brace_end + 1 :].strip()

    stmts = format_block_contents(body, indent)

    result = [f"{indent}{header} {{"]
    result.extend(stmts)
    close = f"{indent}}}"
    if after_close:
        close += f" {after_close}" if after_close != "}" else ""
    result.append(close)

    return result


def format_file(path: Path) -> bool:
    """Format a single .sysml file. Returns True if changes were made."""
    content = path.read_text()
    lines = content.split("\n")

    new_lines = []
    changed = False

    for line in lines:
        formatted = format_line(line)
        if len(formatted) != 1 or formatted[0] != line:
            changed = True
        new_lines.extend(formatted)

    if changed:
        path.write_text("\n".join(new_lines))

    return changed


def main():
    root = Path(__file__).resolve().parent.parent
    sysml_files = sorted(root.rglob("*.sysml"))

    total = 0
    formatted = 0
    for f in sysml_files:
        total += 1
        if format_file(f):
            formatted += 1
            print(f"  formatted: {f.relative_to(root)}")

    print(f"\n{formatted}/{total} files formatted.")


if __name__ == "__main__":
    main()
