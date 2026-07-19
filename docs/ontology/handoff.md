# Downstream Handoff (memo-tools / memo-architect)

Work identified during the 0.5 ontology rework that belongs to downstream
repositories. Nothing here was implemented; ontology-side contracts are final
as described.

## memo-tools

1. **Constraint engine: new rule pack.** `memo_rules_ontology` (CR-ONT-001…044)
   follows the existing `constraint def` + `predicateExpression` pattern. The
   engine needs evaluators for: `acyclic(...)`, ref-cardinality checks over the
   new typed refs (`sourceEndpoint`, `definition`, `baseScenario`), attribute
   presence over `ReuseLifecycle` attribute-def values, and enum-order
   comparisons (`criticality < CriticalityKind::high`).
2. **RelationshipRegistry regeneration.** New connection defs (Motivates,
   Initiates, SupportsUseCase, ImplementsProcedure, SelectsStep, UsesProduct,
   TaskUsesProduct, InstanceOf, BuildsInto, DeploysTo, HostsRuntime,
   RuntimeRealizesModule, IndependentOf, ValidatesCriticalTask,
   ValidatesUseCase, VerifiesFunction, ElementTriggersAction, …) must enter the
   registry; `SemanticLink` was renamed `MemoRelationship`.
3. **Migration tooling.** A codemod for user models per
   [migration-map.md](migration-map.md): renames, `part → action` for
   activity/task usages, scenario attribute rewrites, import-path updates.
4. **kpar packaging.** New source directories (context/, needs/, use_cases/,
   clinical_procedures/, activities/, workflows/, scenarios/, interaction/,
   medical_products/, assurance/, architecture/software_runtime/,
   architecture/deployment/, rules/ontology/, viewpoints/catalog/) are covered
   by the existing `src/**` glob in `package.json` `files`; verify kpar
   manifests pick them up.
5. **Terminology support.** `TerminologyCode`/`UdiCarrier` are attribute defs;
   exporters (FHIR DeviceDefinition/Device, GUDID) can map them 1:1. A FHIR
   export profile is a natural next tool.

## memo-architect

1. **Palette/renderer metadata.** New element kinds need palette entries and
   default glyphs: workflow constructs (OperationalWorkflow, WorkflowStep,
   Decision/Fork/Join/Handoff), scenario family, medical products
   (definition/instance), UI element subtypes, runtime/deployment elements,
   channels with role badges (primary/redundant/monitor/interlock).
2. **Viewpoint catalog binding.** `memo_viewpoints_catalog` maps each
   viewpoint to a standard SysML v2 view kind (`defaultViewKind`); the view
   router should consume `CatalogViewpoint` instances instead of hard-coded
   viewpoint lists, and honor the `DiagramIntentMapping` entries for legacy
   BDD/IBD/activity intents.
3. **Dimension-based filtering.** Views should filter on the multivalued
   dimension attributes (`perspective`, `disciplines`, `crossCuttingConcerns`,
   `realizationStage`) rather than the removed `archLayer` strings.
4. **Typed-reference editing.** The string-reference sunset landed in 0.5:
   `ComponentExchange`, `FunctionalFlow(Step)`, and `SystemCapability` now use
   typed refs (`sourceEndpoint`, `function`, `exchangedItem`,
   `primaryFunction`), with `sourcePortPath`/`targetPortPath` kept as
   descriptive AADL-path labels. Editors must write the typed refs.

## Ontology follow-ups (0.6 candidates)

- STPA profile (control structure, unsafe control actions) over
  LogicalControlElement.
- Native `occurrence def` semantics for ScenarioOccurrence once portable
  across SysIDE/SysON/sysand.
- Revisit requirement-def-specializing-part-def pattern if any conformance
  target rejects it (ADR-0002 consequence).
