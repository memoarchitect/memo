# memo-sysmlv2

**MEMO — Medical Engineering Modelling Ontology** — the pure SysML v2 content layer.

A standalone, tool-portable SysML v2 / KerML ontology for medical-device architecture
per **ISO 14971**, **IEC 62304**, and **ISO/IEC/IEEE 42010**. Consistency rules ship as
native `constraint def` / `requirement def` bodies (no engine plug-ins), so the ontology
is portable *content* consumable by any conformant SysML v2 tool — SysIDE, SysON, or
[`sysand`](https://docs.sysand.org/).

This repository contains **no TypeScript and no engine code**. The MEMO engine and CLI
live in `memo-cli`; the web app lives in `memo-architect`. This is the first of the
three phased-release repos (see ADR-1-17).

## Layout

All SysML v2 content lives under `src/`, where the **directory tree mirrors the
`memo::` namespace hierarchy** (e.g. `memo::architecture::context` →
`src/architecture/context/`). Infra (sysand manifests, build output, scripts)
stays at the repo root.

```
.project.json                sysand project: the core ontology (memo-ontology)
sysand-lock.toml             sysand lockfile
packages/                    thin @memo/* package manifests (consumed as data deps by memo-cli)
scripts/  manifest/          build scripts + version metadata
src/                         ── all .sysml content (namespace = directory) ──
  medical_device_library.sysml   public import surface
  core/                          common/ enumerations/ relationships/
  base/                          dimensions/ methodology/ rules/ semantics/ + stdlib/* (KerML wrapper)
  architecture/                  one folder per layer: context/ requirements/ functions/ behavior/
                                 logical_structure/ software_structure/ … risk/ cybersecurity/ assurance/ …
  compliance/                    artifacts/ change/ document_views/ postmarket/ iso14971/
  viewpoints/  views/            core/ + default_viewpoints/ ; core/ + document_views/
  rules/                         closure/ coverage/ crosslayer/ lifecycle/ quantitative/ (native constraint defs)
  artifacts/                     artifact kinds (memo::artifacts)
  methodology/                   nested sysand project: memo/ (default) + gpca/ (memo-methodology-default)
  examples/gpca-pump/            reference model — pure .sysml
```

## Build / verify

Requires [`sysand`](https://docs.sysand.org/) on `PATH`.

```bash
pnpm run build        # or: ./scripts/build-kpar.sh
```

Builds both sysand projects (core ontology + methodology) into `.kpar` archives and
fails on any external-parser error. This is the portability gate: a clean build proves
the constraints are portable SysML v2.

## License

MIT
