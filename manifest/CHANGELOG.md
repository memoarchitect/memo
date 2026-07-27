# Changelog

## Unreleased

## 0.6.1 - 2026-07-27

- Moved complete project templates under `templates/` and declared them in
  `memo.manifest.yaml`.
- Made the default template extend `@memoarchitect/methodology-default` and
  create architecture, assurance, and artifact source areas.
- Removed the device-archetype startup catalog used by the CLI.

## 0.6.0 - 2026-07-26

- Moved clinical-procedure and medical-product vocabulary from `src/` to
  `examples/extensions/`. They are optional methodology modules selected with
  `includedModule`; no extension metaclass was added.
- Reorganized ontology sources to mirror the nested `memo::` namespace:
  `architecture/operational`, `functional`, `logical`, `implementation`, and
  `realization`; assurance now follows the five V-model disciplines:
  `requirements`, `safety_risk`, `cybersecurity`, `human_factors`, and
  `verification_validation`.
- Removed flat root namespace aliases for operational packages and flat
  architecture-package aliases. The canonical navigation paths are now nested
  below `memo::architecture`.
- Replaced the separate public facade with `memo::*`; the root package now
  provides both the public import and the nested namespace.

## 0.5.0 - 2026-07-18
Ontology rework: orthogonal dimensions, construct-specific Memo base
hierarchy, and the full operational-to-implementation medical-device ontology.

- Added orthogonal classification dimensions (perspective, realization stage,
  discipline, cross-cutting concern) replacing scalar layer strings (ADR-0001).
- Added construct-specific foundations (MemoPart, MemoAction, MemoPort,
  MemoInterface, MemoExchangeItem, MemoNeed, MemoRequirement,
  MemoRelationship, MemoEvidence) and a terminology kernel
  (TerminologyCode, UdiCarrier) (ADR-0002).
- Added stakeholders/actors/users, needs, medical use cases, clinical
  procedures, first-class workflows, scenario dimensions and occurrences,
  activities/tasks/task difficulty (ADR-0003).
- Renamed the functional layer (SystemFunction, FunctionalFlow,
  FunctionalExchange, FunctionalScenario); expanded logical, software
  (module/runtime/deployment), hardware/physical, and interface packages;
  added medical product definitions/instances, technology domains, and reuse
  lifecycles (ADR-0004).
- Added interaction/UI ontology, human-factors assurance, viewpoint catalog,
  and ontology conformance invariants (CR-ONT-*).
- Removed src/examples; examples/gpca-pump is canonical. Added 13 focused
  examples across the device-complexity spectrum.
- Completed the string-to-typed-reference migration: ComponentExchange
  endpoints and exchange allocations, FunctionalFlow start/end functions,
  FunctionalFlowStep function/item references, and SystemCapability primary
  functions are typed refs; the legacy ExchangeItem part-def family became
  MemoExchangeItem item defs. The GPCA example is fully migrated (46 typed
  component exchanges).
- Repaired the project/profile starter templates (dangling `System` type
  replaced by base `PhysicalAssembly` or `SoftwareSystem`; explicit import visibility) — they now pass
  `syside check --warnings-as-errors`.
- Breaking renames and moves are listed in docs/ontology/migration-map.md.

## 0.4.6 - 2026-07-16
Aligned every logical ontology and methodology descriptor with the published npm
package version and added a package test that prevents future version drift.

- Aligned ontology, profile, methodology, example, and SysAnd lock metadata.
- No ontology kinds, public SysML names, or model behavior changed.

## 0.4.3 - 2026-07-14
Removed an unused ad-hoc SysML formatter and aligned every package manifest with
the canonical release version.

- Removed a formatter that was not part of the build and could not safely parse
  nested SysML blocks.
- Aligned the ontology, methodology, modeling-profile, and SysAnd metadata at
  `0.4.3`.
- No ontology kinds, public SysML names, or model behavior changed.

## 0.4.2 - 2026-07-14
Aligned public project metadata with the shared GitHub/GitLab repository model.

- Updated package website metadata to the public GitHub repository.
- No ontology kinds, public SysML names, or model behavior changed.

## 0.4.1 - 2026-07-14
Added the canonical DHF document template library and a GPCA risk-management
plan document instance used by Memo Tools and Memo Architect.

- Added standards-based DHF templates for 21 CFR 820, FDA cybersecurity,
  IEC 62304, IEC 62366, and ISO 14971.
- Added shared document-control, approval, reference, and revision snippets.
- Added the GPCA `DOC-RMP-001` risk-management plan example.

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
