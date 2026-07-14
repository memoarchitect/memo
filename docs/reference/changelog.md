# Changelog

## 0.3.0 — 2026-07-13

SysIDE compatibility and reserved-identifier cleanup.

- Replaced reopened cross-document packages with readable, path-derived source
  packages and a canonical `memo::` alias facade.
- Removed temporary uppercase implementation prefixes.
- Replaced reserved identifiers with descriptive names instead of quoted escapes.
- Standardized collection values, actions, constraints, relationship references,
  and scalar visibility to portable SysML v2 syntax.
- Verified all 149 SysML documents with `syside check --warnings-as-errors`:
  zero diagnostics.

**Migration:** continue importing canonical `memo::...` packages. If a product
model referenced a formerly reserved literal or feature, adopt its descriptive
0.3.0 replacement.

## 0.2.0 — 2026-06-04

Relations remodeled as native SysML v2 connections (breaking).

- All relationships are now `connection def`s deriving from the `SemanticLink` base (each is a native SysML `Connection`/`Association`), replacing the prior reified `part def … specializes SemanticLink` pattern.
- Relationship usages are authored as `connection : Type connect a ::> x to b ::> y;` instead of part instances with reference-binding members.
- Noun `*Link` relations renamed to verbs (`SatisfiedBy`, `VerifiedBy`, `MitigatesHazard`, `DerivesFrom`, ...); ISO 14971 risk-chain `riskRole` override split into a first-class `AssessedAgainst` relation.
- Requirement authoring gains EARS/SOPHIST notation; `MethodRigorKind` replaced by `safetyClassification` + `lifecycleStage` (risk-proportionate scope).

**Migration:** re-author relationship instances as `connection` usages; navigate relationships by the camelCase relation name (e.g. `verifiedBy`, `derivesFrom`).

## 0.1.0 — 2026-04-23

Initial integrated release.

- Standalone `viewpoints/` library
- Standalone `views/` library
- First-class cybersecurity ontology layer
- Cyber risk, hazard, mitigation, trust-boundary, and trace semantics
- Query-backed views with explicit exposed model content
- GPCA examples updated to include cybersecurity and view usage
