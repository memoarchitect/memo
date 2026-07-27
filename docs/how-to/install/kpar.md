# Install as a KerML archive (`.kpar`)

A **KerML Project Archive** (`.kpar`) is the interchange format for SysML v2
content. Using MEMO this way needs no Node toolchain and no MEMO tooling — only
a conformant SysML v2 tool.

Use this route when your team works in SysIDE, SysON, `sysand`, or another
conformant tool and wants MEMO as portable library content.

## Why this route exists

MEMO's build gate is an *external* parse. Every build stages the sources into a
`sysand` project and produces a `.kpar`; a clean build with zero errors is what
proves the ontology is portable content rather than configuration for one
engine. The archives you consume here are the same artifacts that gate the
release.

Two archives are produced:

| Archive | Contains |
| --- | --- |
| `memo-ontology` | The ontology: core, architecture, assurance, rules, viewpoints, compliance |
| `memo-methodology-default` | The default methodology, which depends on `memo-ontology` |

## 1. Install sysand

Get it from [docs.sysand.org](https://docs.sysand.org/) and confirm it is on
your `PATH`:

```bash
sysand --version
```

## 2. Obtain the archive

Take `output/memo-ontology.kpar` from a MEMO release, or build it yourself from
a checkout:

```bash
./scripts/build-kpar.sh
```

The script requires `sysand` and writes archives to `output/`. It fails on any
parse error, so a produced archive is by definition one that parsed cleanly.

## 3. Declare it as a dependency

In your own `sysand` project, list the MEMO archive alongside the standard
libraries in `.project.json`:

```json
{
  "name": "my-device",
  "version": "0.1.0",
  "license": "MIT",
  "usage": [
    { "resource": "urn:kpar:memo-ontology" },
    { "resource": "urn:kpar:semantic-library" },
    { "resource": "urn:kpar:systems-library" }
  ]
}
```

MEMO's own methodology project uses exactly this declaration, which is the
worked example to copy.

If you also want the default methodology, add
`{ "resource": "urn:kpar:memo-methodology-default" }`.

## 4. Confirm the import resolves

```sysml
package import_check {
    private import memo::*;

    part reviewer : User;
}
```

Build your project. If `User` resolves, MEMO is available.

## Trade-offs

- **No `memo init`.** Scaffolding, archetypes, and lock files come from
  [Tools](https://github.com/memoarchitect/memo-tools), which is a Node
  package. You can still use MEMO fully; you write the project structure
  yourself.
- **Pinning is manual.** Vendor the `.kpar` you built against and record its
  version, since there is no lock file doing it for you.
- **Maximum portability.** In exchange, nothing about your project depends on
  MEMO's tooling — which is the point of this route.

## Next

- [Temperature Alarm tutorial](../../tutorials/first-model.md) — build a first model
- [SysML source reference](../../reference/index.md) — what the library defines
