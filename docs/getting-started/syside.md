# SysIDE and validation

meMO 0.3.0 is structured for reliable document-level indexing in SysIDE. The
repository includes `syside.toml`, so opening the repository root in VS Code
indexes `src/` and excludes package scaffolding, generated output, and dependency
directories.

## Validate from the command line

Install the SysIDE command-line executable and make it available on `PATH`. A
Modeler license is required for semantic validation. Configure the license using
SysIDE's keyring support or the `SYSIDE_LICENSE_KEY` environment variable; never
commit a license key to this repository.

Run the release gate from the repository root:

```bash
syside check --warnings-as-errors --stats src
```

The 0.3.0 release contains 149 SysML documents and completes this command with
zero diagnostics.

## Why source packages are flat

Reopening the same nested package hierarchy in many documents can produce
unresolved references in document-oriented language servers. meMO therefore
uses one unique, path-derived package per source file:

```sysml
package memo_architecture_assurance {
    private import ScalarValues::*;
    // ontology definitions
}
```

The public hierarchy remains canonical. `memo_namespaces.sysml` aliases and
re-exports source packages so product models continue to import:

```sysml
package MyDevice {
    private import memo::architecture::assurance::*;
    part def MyVerificationCase specializes VerificationCase;
}
```

Do not import a path-derived source package from a product model. Treat it as an
implementation detail of the release.

## Reserved identifiers

meMO does not rely on quoted identifiers to escape SysML keywords. Descriptive
names are used instead—for example `analysis_models`, `verification_models`, and
`standardArchetype`. This keeps source readable and consistent across SysIDE,
SysON, sysand, and MEMO's lightweight parser.

## Troubleshooting

- Confirm VS Code opened the repository root containing `syside.toml`.
- Confirm `src/memo_namespaces.sysml` is present.
- Run the CLI command above to separate model errors from editor state.
- Reload the VS Code window after changing workspace configuration.
- Ensure the CLI license is configured if `syside check` reports a license error.
