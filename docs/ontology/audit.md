# Current-Ontology Audit (pre-0.5 baseline)

Audit of `memo/src` as of v0.4.6, performed before the 0.5 ontology rework.
Findings are keyed to the decisions in ADR-0001…ADR-0004 and to the
[migration map](migration-map.md).

## What was sound (kept)

| Area | Finding |
|---|---|
| Modularity | Filesystem mirrors namespaces; one content-bearing leaf package per file; no monoliths. Kept as-is. |
| Relationship style | All semantic relations are native `connection def`s with typed ends off one abstract base (`SemanticLink`). Kept; base renamed `MemoRelationship`. |
| Risk chain | ISO 14971 chain (Hazard → SequenceOfEvents → HazardousSituation → Harm, RiskControl, residual risk) is faithful to the standard. Kept, extended with use-error and cyber entry points. |
| Requirements | EARS/SOPHIST notation slots, obligation kinds, design-control specializations. Kept. |
| Rules | Conformance rules as `constraint def`s with declarative metadata (`predicateExpression`), engine-evaluable. Pattern reused for the new §25 invariants. |
| Viewpoint base | `MemoView :> Views::View` with selection queries; eight-kind `DiagramViewKind` matches the SysML v2 view taxonomy. Kept, catalog extended. |
| Namespace facade | `memo_namespaces.sysml` alias facade avoids qualified package declarations. Kept, regenerated for new packages. |

## Defects and gaps (fixed in 0.5)

1. **Scalar layer classification.** `ArchitectureElementKind.archLayer : String` and
   `LayerElement.layerName : String` encoded architecture layering as strings, and
   `Interface.arcadiaLayer` used a single enum. An element could not be
   *implementation + software realization + safety-related + verification-scoped*
   at once. Replaced by four orthogonal typed dimensions (ADR-0001).
2. **Everything is a `part def`.** `ExchangeItem` (a flowing thing), `Viewpoint`
   (a specification), scenarios, and activities were all part defs. The base
   hierarchy is now construct-specific: `MemoAction`, `MemoPort`, `MemoInterface`,
   `MemoExchangeItem`, `MemoNeed`, `MemoRequirement` (ADR-0002).
3. **No operational world.** No Stakeholder (distinct from Actor), no needs
   hierarchy, no use cases, no clinical procedures, no first-class workflows, no
   user tasks, no product-usage roles. `OperationalActivity` was a bag of strings.
   `Actor` was a flat part def with an enum, conflating users with any actor.
4. **No workflow/scenario/occurrence distinction.** `OperationalScenario` carried a
   `sequenceDescription : String`. No reusable process definition vs. selected
   path vs. execution (ADR-0003).
5. **Functional layer mislabeled.** Technology-independent functions were named
   `LogicalFunction`; Capella-style `FunctionalChain` named steps by
   `allocatedFunction : String`. Renamed `SystemFunction` / `FunctionalFlow` with
   typed references.
6. **String references instead of typed ends.** `ComponentExchange.sourcePort :
   String`, `FunctionalChainStep.allocatedFunction : String`,
   `Transition.sourceState : String`, `InteractionMessage.senderComponent :
   String`. Replaced with typed reference attributes or connection ends wherever
   portable; residuals are listed in the migration map.
7. **No device identity model.** No definition/instance split, no UDI, no
   terminology binding (single ambiguous strings like `partNumber`), no
   single-use/reusable/reprocessable semantics, no technology-domain
   classification. New `medical_products` packages (ADR-0004, §12–§16).
8. **No software runtime/deployment separation.** `SoftwareComponent` mixed module
   view (IEC 62304 items) with runtime properties (period, WCET, scheduling).
   Split into module / runtime / deployment views (ADR-0004).
9. **No UI/interaction ontology.** Usability existed only as `UseError` and a
   viewpoint. New `interaction` package (§18).
10. **Examples inside `src`.** `src/examples/gpca-pump` duplicated
    `examples/gpca-pump` wholesale, producing global-namespace shadowing warnings
    on any whole-repo check. Removed; `memo/examples/gpca-pump` is canonical.
11. **Missing invariants.** No conformance rules for connector-endpoint
    existence, port compatibility, definition/instance identity separation,
    single-use vs. reprocessing, critical-task validation coverage. Added in
    `rules/` (§25).

## Inventory disposition

Concept-by-concept dispositions (kept / renamed / replaced / removed) are in the
[migration map](migration-map.md); external-source grounding for each new
concept is in the [provenance matrix](provenance-matrix.md).
