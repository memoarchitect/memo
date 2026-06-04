# Package Version

- Package: Medical Device SysML v2 Package
- Version: **0.2.0**
- Release type: relations remodeled as native SysML connections (breaking)
- Release date: 2026-06-04

This package uses a **single version for the entire release**.

The version of record is declared in each project's `.project.json`
(`memo-ontology`, `memo-methodology-default`) and pinned in `sysand-lock.toml` —
that is the version SysML v2 tools (e.g. `sysand`) query to resolve and include
packages. This file and the changelog are human-readable notes that track it;
they are not consumed by the toolchain.
