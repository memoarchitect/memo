# @memoarchitect/ontology

**MEMO — Medical Engineering Modelling Ontology** — the pure SysML v2 content layer.

A standalone, tool-portable SysML v2 / KerML ontology for medical-device architecture
per **ISO 14971**, **IEC 62304**, and **ISO/IEC/IEEE 42010**. Consistency rules ship as
native `constraint def` / `requirement def` bodies (no engine plug-ins), so the ontology
is portable *content* consumable by any conformant SysML v2 tool — SysIDE, SysON, or
[`sysand`](https://docs.sysand.org/).

The published package contains **no JavaScript, TypeScript, or engine code**. The MEMO
engine and CLI live in `memo-tools`; the web app lives in `memo-architect`.

## Current package state

`@memoarchitect/ontology` is an independently installable npm package. Consumers
pin an exact release; the package has no repository or runtime dependency on Memo
Tools or Memo Architect.

```bash
pnpm add @memoarchitect/ontology@0.4.6
```

For coordinated development, the private `memo-meta` workspace checks out
Ontology, Tools, and Architect as sibling repositories and links this package
into its dependants with meta-only pnpm overrides.

## Documentation

Start with the [user guide](docs/index.md) to learn MEMO's layer model, choose
elements and relationships, and follow the GPCA pump example. The reference
section describes packages, source layout, and maintenance. Build the site with:

```bash
python3 -m pip install "mkdocs>=1.6" "mkdocs-material>=9.5" "pymdown-extensions>=10.0"
pnpm run docs:build
```

## Layout

The package exposes four logical MEMO packages through `memo.manifest.yaml`.
The manifest maps package identifiers to package subpaths.

```
memo.manifest.yaml           logical package, init, and example map
ontology/                    @memoarchitect/ontology descriptor
profile/                     @memoarchitect/medical-modeling-profile + archetypes/templates
methodologies/default/       @memoarchitect/methodology-default descriptor
methodologies/gpca/          @memoarchitect/methodology-gpca descriptor
template/                    complete starter project copied by memo init
examples/gpca-pump/          reference model (not a scaffold template)
src/                         all reusable .sysml content (namespace = directory)
  medical_device_library.sysml   public import surface
  core/                          common/ enumerations/ relationships/
                                 dimensions/ semantics/ + stdlib/* (KerML wrapper)
  architecture/                  one folder per layer: context/ requirements/ functions/ behavior/
                                 logical_structure/ software_structure/ … risk/ cybersecurity/ assurance/ …
  compliance/                    artifacts/ change/ document_views/ postmarket/ iso14971/
  viewpoints/                    reusable viewpoint and view definitions
  rules/                         closure/ coverage/ crosslayer/ lifecycle/ quantitative/ (native constraint defs)
  artifacts/                     artifact kinds (memo::artifacts)
  methodology/                   default methodology
```

## Build / verify

Requires [`sysand`](https://docs.sysand.org/) on `PATH`.

```bash
pnpm run build        # or: ./scripts/build-kpar.sh
```

Builds transient SysAnd projects for the core ontology and methodology into `.kpar`
archives and fails on any external-parser error. The transient project descriptors and
build products are not included in the npm package.

```bash
pnpm test             # manifest/layout tests + npm pack content gate
npm pack              # produces the single @memoarchitect/ontology content tarball
```

## License

MIT
