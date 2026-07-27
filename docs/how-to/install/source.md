# Use a source checkout

Register the MEMO repository's `src/` directory as a library source in your
SysML v2 editor. Use this route when you are contributing to MEMO, or when you
want to read the definitions alongside the model you are writing against them.

## 1. Obtain the library source

Use a local checkout of the [`memo`](https://github.com/memoarchitect/memo)
repository and keep its `src/` directory intact. That directory is the MEMO
source library; `src/memo_namespaces.sysml` declares its public entry point.

```text
memo/
├── src/
│   └── memo_namespaces.sysml
└── syside.toml
```

## 2. Include it in your SysML project

Register `src/` as a library source in your editor or project. In SysIDE, the
repository's own `syside.toml` demonstrates the library-side setting:

```toml
include = ["src"]
```

For a product model, keep your product source separate and configure the
project so it can resolve the MEMO source directory as a library.

!!! warning "Do not copy MEMO definitions into your device model"

    Copying makes upgrades and traceability harder, and it produces exactly the
    duplicate-element problem the ontology is designed to prevent. Reference
    the library; do not vendor its contents into your packages.

## 3. Confirm one import

Create a small scratch file in your model and add the public import:

```sysml
package import_check {
    private import memo::*;

    part reviewer : User;
}
```

If `User` resolves without an error, your model can use MEMO.

## Pinning

A checkout is pinned by its commit. If several people work against the same
model, agree on a commit or tag and record it, because `main` moves and — until
1.0 — names may change between releases without migration support.

For a pinned dependency with a lock file instead, use
[the npm route](npm.md).

## Next

- [Temperature Alarm tutorial](../../tutorials/first-model.md) — build a first model
- [Contributing](../../contributing.md) — if you are changing the library itself
