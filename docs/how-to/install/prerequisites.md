# Prerequisites

MEMO is SysML v2 source. What you need depends on how you use it.

## Use MEMO in a model

| Installation route | Required |
| --- | --- |
| npm package | Node.js 26 or later and npm, pnpm, or Yarn |
| `.kpar` archive | A SysML v2 environment that can load KerML package archives |
| Source checkout | Git and a SysML v2 environment configured to read `src/` |

SysIDE, SysON, and `sysand` are examples of SysML v2 environments. MEMO does
not require one specific modeling environment.

After installation, the environment must resolve this import:

```sysml
private import memo::*;
```

## Build or contribute to MEMO

Building the ontology repository has additional requirements.

| Task | Required |
| --- | --- |
| Install repository dependencies | Node.js 26 or later and pnpm 9.15 |
| Build and validate `.kpar` archives | [`sysand`](https://docs.sysand.org/) available on `PATH` |
| Build this documentation | Python 3, MkDocs, Material for MkDocs, and PyMdown Extensions |

Install the documentation dependencies with:

```bash
python3 -m pip install "mkdocs>=1.6" "mkdocs-material>=9.5" "pymdown-extensions>=10.0"
```

`sysand` is a repository build dependency. It is not required when a project
uses the npm package, a prebuilt `.kpar`, or the source through another
conformant SysML v2 environment.

Continue with the installation route that matches your project:

- [npm package](npm.md)
- [`.kpar` archive](kpar.md)
- [Source checkout](source.md)
