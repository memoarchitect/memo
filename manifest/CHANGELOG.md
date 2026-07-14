# Changelog

## 0.4.0 - 2026-07-13
Organized the GPCA example so authored catalog content is separated from views
and view samples.

- Moved all 16 GPCA model source files from `model/` into `model/catalog/`.
- Updated the backing package namespaces, imports, and canonical namespace facade
  to match the new catalog directory.
- Added a conformance gate that prevents `.sysml` files from being placed directly
  in the GPCA `model/` directory.
- Verified the catalog, examples, namespace facade, and full ontology with SysIDE.

## 0.3.0 - 2026-07-13
Fixed SysIDE workspace discovery after the three-repository split and verified all
149 SysML sources, including the GPCA examples and canonical namespace facade,
with SysIDE, compatibility, parser, lint, test, and build gates.

- Updated the parent workspace to index the canonical `memo-tools/memo/src` tree.
- Added submodule-local SysIDE discovery for opening `memo-tools/memo` directly.
- Replaced cross-document reopened packages with readable, path-derived source
  packages such as `memo_architecture_assurance`; `memo_namespaces.sysml` retains
  the canonical `memo::...` consumer hierarchy through aliases.
- Replaced reserved identifiers with descriptive names instead of quoted escapes,
  including `standardArchetype`, `analysis_models`, and `verification_models`.
- Standardized collection values, actions, constraints, relationship references,
  and scalar visibility to syntax accepted by SysIDE 0.10.2.
- Updated MEMO's Langium parser and conformance policy to accept the same standard
  SysML forms as SysIDE.
- Verified zero SysIDE diagnostics and all monorepo tests before the version bump.

## 0.2.0 - 2026-06-04
Relations remodeled as native SysML v2 connections (breaking).

- All relationships are now `connection def`s deriving from the `SemanticLink`
  base (each is a native SysML `Connection`/`Association`), replacing the prior
  reified `part def … specializes SemanticLink` pattern.
- Relationship usages are authored as `connection : Type connect a ::> x to b ::> y;`
  instead of part instances with reference-binding members.
- Noun `*Link` relations renamed to verbs (`SatisfiedBy`, `VerifiedBy`,
  `MitigatesHazard`, `DerivesFrom`, …); ISO 14971 risk-chain `riskRole` override
  split into a first-class `AssessedAgainst` relation.
- Requirement authoring gains EARS/SOPHIST notation; `MethodRigorKind` replaced by
  `safetyClassification` + `lifecycleStage` (risk-proportionate scope).

Migration: re-author relationship instances as `connection` usages; navigate
relationships by the camelCase relation name (e.g. `verifiedBy`, `derivesFrom`).

## 0.1.0 - 2026-04-23
Initial integrated release.

Included in this release:
- standalone `viewpoints/` library
- standalone `views/` library
- first-class cybersecurity ontology layer
- cyber risk, hazard, mitigation, trust-boundary, and trace semantics
- query-backed views with explicit exposed model content
- compatibility re-exports for legacy methodology/compliance entry points
- GPCA examples updated to include cybersecurity and view usage

Notes:
- internal draft bundle labels such as v10, v11, and v12 were development snapshots
- `0.1.0` is the first package-wide release version, declared in each project's `.project.json` (the version SysML tools query for inclusion)
