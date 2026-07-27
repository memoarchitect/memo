# Install with npm

The whole MEMO ontology ships as one npm package, `@memoarchitect/ontology`.
The package carries **content only** — SysML v2 source, a manifest, and the
starter template. There is no JavaScript to run.

Use this route when your project already has a Node toolchain, or when you want
a pinned, versioned dependency rather than a checkout.

## 1. Add the dependency

```bash
npm install @memoarchitect/ontology
```

`pnpm add` and `yarn add` work identically. The package installs into
`node_modules/@memoarchitect/ontology/`, with the SysML sources under `src/`
and the packaging contract at `memo.manifest.yaml`.

## 2. Point the modeling environment at it

Configure the modeling environment to load this library directory:

```text
node_modules/@memoarchitect/ontology/src/
```

The npm package also includes `memo.manifest.yaml`. Node-based consumers can
use it to locate the ontology, profile, methodology, templates, and examples:

| Logical package | Contains |
| --- | --- |
| `@memoarchitect/ontology` | The core reusable element, relationship, rule, and viewpoint definitions |
| `@memoarchitect/medical-modeling-profile` | The default profile and archetype catalog — the usual `extends:` target |
| `@memoarchitect/methodology-default` | The default methodology |
| `@memoarchitect/methodology-gpca` | The methodology used by the GPCA reference model |

## 3. Confirm the import resolves

```sysml
package import_check {
    private import memo::*;

    part reviewer : User;
}
```

If the environment resolves `User`, the ontology is available. If it does not,
verify that the library path points to the package's `src/` directory.

## Pinning

Pin the ontology version in `package.json` and commit the package-manager lock
file. Until 1.0, an unpinned dependency can receive namespace or API changes.

## Next

- [Temperature Alarm tutorial](../../tutorials/first-model.md) — build a first model
- [Repository and packaging](../../architecture/repository.md) — the manifest contract in full
- [MEMO Tools](https://github.com/memoarchitect/memo-tools) — optional project scaffolding and validation
