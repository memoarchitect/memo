# Installing MEMO

MEMO is content — SysML v2 source — so "installing" it means making that source
resolvable from your model. There are three ways to do that, and they suit
different situations.

[Check the prerequisites](prerequisites.md) before choosing an installation
route. The requirements differ for using MEMO and building the repository.

| Route | Use it when | Guide |
| --- | --- | --- |
| **npm package** | A Node-based project or modeling tool can resolve library source from `node_modules` | [Install with npm](npm.md) |
| **`.kpar` archive** | Your SysML v2 environment loads KerML Project Archives | [Build and install a KerML archive](kpar.md) |
| **Source checkout** | You are contributing to MEMO, or you want to read and modify the library alongside your model | [Use a source checkout](source.md) |

All three end at the same place. Your model imports one library:

```sysml
private import memo::*;
```

## Which should I choose?

- **Using a Node-based project?** Use npm and configure the modeling
  environment to load `node_modules/@memoarchitect/ontology/src/`.
- **Using an environment that accepts `.kpar` libraries?** Build an archive
  with `sysand`, then install it using that environment's library mechanism.
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
releases without migration support. Pin the version you built against—with npm
that is the package version in your package-manager lock file, with `.kpar` it
is the archive you retained, and with a checkout it is the commit. See
[Repository and packaging](../../architecture/repository.md).
