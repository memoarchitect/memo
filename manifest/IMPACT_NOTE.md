# Impact Note

## Release 0.4.6
This patch aligns all content-owned release metadata with the npm package and
adds an automated consistency gate.

### Expected impact
- New projects lock Ontology and the medical modeling profile to `0.4.6`.
- Existing `0.4.x` models remain compatible.

### Breaking-change assessment
- No breaking changes are expected.

## Release 0.4.3
This patch removes unused repository-only formatting code and aligns release
metadata. Ontology content and public semantics are unchanged.

### Expected impact
- All `0.4.x` Memo products remain compatible.
- Package consumers may update compatible patch constraints to `^0.4.3`.

### Breaking-change assessment
- No breaking changes are expected.

## Release 0.4.2
This patch updates repository metadata only.

### Expected impact
- All `0.4.x` Memo products remain compatible.
- Package consumers may update compatible patch constraints to `^0.4.2`.

### Breaking-change assessment
- No breaking changes are expected.

## Release 0.4.1
This patch adds reusable DHF document templates and the GPCA risk-management
plan document without changing ontology kinds or public SysML names.

### Expected impact
- Memo Tools and Memo Architect can resolve DHF templates from the ontology release.
- Existing product models remain compatible with `0.4.1`.
- Package consumers should update compatible patch constraints to `^0.4.1`.

### Breaking-change assessment
- No breaking changes are expected.

## Release 0.4.0
This release organizes the GPCA example's authored model content under
`model/catalog/`, alongside the existing `model/samples/` and `model/views/`
collections.

### Expected impact
- GPCA model browsing now has a clear catalog, samples, and views structure.
- Package consumers should update ontology and methodology constraints to `^0.4.0`.
- Tools that discover `model/**/*.sysml` continue to load the same model content.

### Breaking-change assessment
- File paths and internal path-derived GPCA backing package names changed. Scripts
  or tests that directly reference the old paths or backing packages must use the
  new `model/catalog/` paths and `memo_examples_gpca_pump_model_catalog_*` names.
- Canonical ontology packages and public type names are unchanged.

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
