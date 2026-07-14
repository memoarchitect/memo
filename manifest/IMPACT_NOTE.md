# Impact Note

## Release 0.3.0
This release restores clean SysIDE discovery and validation after the ontology
moved into the nested `memo-tools/memo` submodule.

### Expected impact
- VS Code users can open either the parent repository or `memo-tools/memo` and get
  a fully indexed model with zero SysIDE diagnostics.
- Canonical `memo::...` imports remain available through the namespace facade.
- Source files use readable path-derived packages internally; consumers should not
  import those backing packages directly.
- Package consumers should update ontology and methodology constraints to `^0.3.0`.

### Breaking-change assessment
- Reserved identifiers were renamed instead of escaped with quotes. Consumers that
  referenced an old reserved enum literal or feature name must adopt its descriptive
  replacement. Canonical package paths and ontology type names are otherwise retained.

## Release 0.1.0
This release establishes the baseline integrated structure for the package.

### Expected impact
- New adopters: use this release as the baseline.
- Existing draft users: update imports and references to the dedicated `viewpoints/` and `views/` libraries where appropriate.
- Product models without cybersecurity usage: no conceptual migration required.
- Product models with cybersecurity usage: align to the first-class `memo_cybersecurity.sysml` layer and cyber document views.

### Breaking-change assessment
- External release status: baseline release, so no prior public version is assumed.
- Internal draft changes: moderate structural change from earlier working bundles because views/viewpoints and cybersecurity were promoted and reorganized.

### Future change guidance
Future releases should continue using a single package version until there is a strong need for independently versioned sublibraries.
