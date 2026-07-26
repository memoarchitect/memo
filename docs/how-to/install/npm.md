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

## 2. Point your project at it

A MEMO project declares what it extends in `memo.package.yaml`:

```yaml
name: my-device
version: "0.1.0"
type: device
extends: "@memoarchitect/medical-modeling-profile"
description: "MEMO medical device model project"
```

`@memoarchitect/medical-modeling-profile` is one of four *logical* packages
declared inside the single npm package. Tools resolve logical names through
`memo.manifest.yaml`, never through a directory path, so this reference stays
valid even if the layout changes:

| Logical package | Contains |
| --- | --- |
| `@memoarchitect/ontology` | The core reusable element, relationship, rule, and viewpoint definitions |
| `@memoarchitect/medical-modeling-profile` | The default profile and archetype catalog — the usual `extends:` target |
| `@memoarchitect/methodology-default` | The default methodology |
| `@memoarchitect/methodology-gpca` | The methodology used by the GPCA reference model |

## 3. Or scaffold a new project

If you are starting from nothing, let the CLI do both steps. Install
[Tools](https://github.com/memoarchitect/memo-tools) and run:

```bash
memo init my-device
```

That copies the starter template, writes `memo.package.yaml` with the profile
already set, and produces `memo.lock.yaml` pinning the exact ontology version.
Pass an archetype to start from a device shape rather than a blank model.

## 4. Confirm the import resolves

```sysml
package import_check {
    private import memo_medical_device_library::*;

    part reviewer : User;
}
```

If your editor resolves `User`, you are done. If it does not, the editor
probably does not know to look inside `node_modules` — see
[Use a source checkout](source.md) for how to register a library path
explicitly, or check your tool's library configuration.

## Pinning

`memo.lock.yaml` records the ontology version the project was built against.
Commit it. Until 1.0 the content is experimental and names may change between
releases without migration support, so an unpinned project can break on an
unrelated install.

## Next

- [Temperature Alarm tutorial](../../tutorials/first-model.md) — build a first model
- [Repository and packaging](../../architecture/repository.md) — the manifest contract in full
