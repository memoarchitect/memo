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

```
.project.json                sysand project: the core ontology (memo-ontology)
sysand-lock.toml             sysand lockfile
medical_device_library.sysml
architecture/                element kinds, structure, interfaces, risk, requirements
core/                        common types, enumerations, relationships
base/                        dimensions, semantics, methodology base + KerML stdlib wrapper
compliance/                  regulatory document views (ISO 14971 risk management file)
artifacts/                   artifact kinds
rules/                       native constraint defs (closure, coverage, cross-layer, lifecycle, quantitative)
viewpoints/  views/          viewpoint + view definitions
methodology/                 nested sysand project: default + GPCA methodology (memo-methodology-default)
packages/                    thin @memo/* package manifests (consumed as data deps by memo-cli)
examples/gpca-pump/          reference model — pure .sysml
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
