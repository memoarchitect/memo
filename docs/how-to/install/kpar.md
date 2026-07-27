# Install as a KerML archive (`.kpar`)

A **KerML Project Archive** (`.kpar`) packages SysML v2 library content. Using
an existing archive needs no Node toolchain or MEMO tooling. Building an
archive from this repository requires `sysand`.

Use this route only when your SysML v2 environment can load `.kpar` libraries.

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

Compiled archives are build output and are not stored under `src/` or committed
to the repository.

## 1. Install `sysand`

Get it from [docs.sysand.org](https://docs.sysand.org/) and confirm it is on
your `PATH`:

```bash
sysand --version
```

## 2. Build the archives

From a source checkout, run:

```bash
./scripts/build-kpar.sh
```

The script writes versioned archives below `output/kpar/memo-ontology/` and
`output/kpar/memo-methodology-default/`. It fails when the external parse
reports an error.

## 3. Install the archive

Use the target modeling environment's library or package installation
mechanism. The procedure is environment-specific.

For a `sysand` project, list the MEMO archive alongside the standard libraries
in `.project.json`:

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

- **Pinning is manual.** Retain the `.kpar` you built against and record its
  version, since there is no lock file doing it for you.
- **Installation differs by environment.** `.kpar` support and library
  registration are provided by the selected SysML v2 environment.

## Next

- [Temperature Alarm tutorial](../../tutorials/first-model.md) — build a first model
- [SysML source reference](../../reference/index.md) — what the library defines
