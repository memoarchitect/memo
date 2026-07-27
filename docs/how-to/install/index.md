# Installing MEMO

MEMO is content — SysML v2 source — so "installing" it means making that source
resolvable from your model. There are three ways to do that, and they suit
different situations.

| Route | Use it when | Guide |
| --- | --- | --- |
| **npm package** | Your project already has a Node toolchain, or you want a pinned, versioned dependency | [Install with npm](npm.md) |
| **`.kpar` archive** | You use a conformant SysML v2 tool such as `sysand` and want tool-portable content with no Node at all | [Install as a KerML archive](kpar.md) |
| **Source checkout** | You are contributing to MEMO, or you want to read and modify the library alongside your model | [Use a source checkout](source.md) |

All three end at the same place. Your model imports one library:

```sysml
private import memo::*;
```

## Which should I choose?

- **Starting a new project?** Use npm. `memo init` scaffolds a project from an
  archetype and writes the lock file that pins the ontology version.
- **Using SysIDE, SysON, or another SysML v2 tool without Node?** Use the
  `.kpar` route. It is the reason MEMO is validated against an external
  conformant tool on every build.
- **Evaluating or contributing?** Use a source checkout so you can read the
  definitions while you model against them.

## Confirm it worked

Whichever route you took, the check is the same. Create a scratch file:

```sysml
package import_check {
    private import memo::*;

    part reviewer : User;
}
```

If `User` resolves without an error, your model can use MEMO. Continue to the
[Temperature Alarm tutorial](../../tutorials/first-model.md), which assumes the
library resolves.

## Versioning

Until 1.0 the content is experimental: names and structure may change between
releases without migration support. Pin the version you built against — with
npm that is `memo.lock.yaml`, with `.kpar` it is the archive you vendored, and
with a checkout it is the commit. See
[Repository and packaging](../../architecture/repository.md).
