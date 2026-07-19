# Migration Map (0.4 → 0.5)

Renamed, replaced, moved, and removed concepts. Pre-1.0 policy: no
compatibility aliases; downstream models update names and imports.
The canonical GPCA example has been migrated and is the reference for each
pattern.

## Renames (same semantics, new name)

| 0.4 | 0.5 | Notes |
|---|---|---|
| `SemanticLink` | `MemoRelationship` | relationship foundation (ADR-0002) |
| `EvidenceElement` | `MemoEvidence` | evidence foundation |
| `LogicalFunction` | `SystemFunction` | functions are technology-independent, not "logical layer" |
| `FunctionalChain` | `FunctionalFlow` | + typed `includedFunctions` refs |
| `FunctionalChainStep` | `FunctionalFlowStep` | + typed `function`/`exchange` refs |
| `FunctionalChainKind` | `FunctionalFlowKind` | attribute `chainKind` → `flowCategory` |
| `LogicalFlow` | `FunctionalExchange` | belongs to the functional perspective; + typed function refs |
| `SystemScenario` | `FunctionalScenario` | now `:> MemoScenario`; `precondition/postcondition` → `preCondition/postCondition` |
| `PhysicalConnector` (planned name) | `PhysicalConnectorPart` | avoids clash with connector-relationship vocabulary |

## Replacements (new semantics)

| 0.4 | 0.5 | Notes |
|---|---|---|
| `ArchitectureElementKind.archLayer : String`, `LayerElement`, `ElementKind`/`DimensionKind` family | orthogonal dimensions on `MemoPart` + metadata defs | ADR-0001 |
| `Interface.arcadiaLayer : ArcadiaLayerKind` | inherited `perspective : ArchitecturePerspectiveKind[0..*]` | `ArcadiaLayerKind` removed; system→functional, physical→implementation |
| `Actor` (flat, in `memo_architecture_context`) | `Actor` hierarchy in `memo_context_actors` (abstract root; Human/NonHuman; `User` subtypes) | usages retype to a concrete subtype |
| `StakeholderNeed` (in requirements pkg) | needs hierarchy in `memo_needs` (`Need :> MemoNeed, RequirementDriver`) | `DesignControlNeed` still specializes `StakeholderNeed` |
| `OperationalActivity` (part def, strings) | `OperationalActivity` (action def) in `memo_activities` | usages: `part x :` → `action x :` |
| `OperationalScenario` (`scenarioKind`, `sequenceDescription`) | `OperationalScenario :> MemoScenario` in `memo_scenarios` | `scenarioKind` → `variantKind` + `operationalCondition`; `sequenceDescription` → `pathSummary` |
| `InteractionScenario` (behavior pkg) | `InteractionScenario :> MemoScenario` in `memo_interaction` | |
| `ThreatScenario` (item def) | `ThreatScenario :> MemoScenario` (part def) in cybersecurity | same attributes retained |
| `SoftwareComponent` runtime attributes (period/deadline/WCET/scheduling) | moved to `RuntimeComponent` in `memo_architecture_software_runtime` | module view keeps responsibility/safety class/complexity |
| `ScenarioKind` enum | scenario dimension enums (`ScenarioVariantKind`, `OperationalConditionKind`, `ScenarioPurposeKind`) | `ScenarioKind` removed (no remaining references) |

## Moves (new package, unchanged or extended semantics)

| Concept | 0.4 package | 0.5 package |
|---|---|---|
| `IntendedUse`, `UseContext`, context connections | `memo_architecture_context` (removed) | `memo_context_use_context` |
| `UseError` | `memo_architecture_context` | `memo_assurance_human_factors` |
| `StakeholderNeed` | `memo_architecture_requirements` | `memo_needs` |
| `SBOMEntry` | part-def style | `item def :> MemoExchangeItem` (software_structure) |

## Removals

| Removed | Reason |
|---|---|
| `src/examples/gpca-pump` (whole tree) | §24: examples never live in `src`; `examples/gpca-pump` is canonical |
| example facade packages in `memo_namespaces.sysml` | ontology source must not reference examples |
| `ArcadiaLayerKind`, `DimensionKind`, `ElementKind` family, `LayerElement` | superseded by ADR-0001 dimensions |
| `ScenarioKind` enum | superseded by the scenario dimension enums (ADR-0003) |
| `ExchangeItem` (part def) | superseded by `MemoExchangeItem` (ADR-0002) |

## Completed string-to-typed-reference migrations

| 0.4 form | 0.5 form |
|---|---|
| `ExchangeItem` (part def) + `DataDefinition`/`ControlDefinition` part defs | removed; `DataDefinition`/`ControlDefinition` are `item def :> MemoExchangeItem` — usages retype `part ddX :` → `item ddX :` |
| `ComponentExchange.sourcePort/targetPort : String` | `sourceEndpoint`/`targetEndpoint : MemoPart[0..1]` typed refs (CR-ONT-002); `sourcePortPath`/`targetPortPath` remain as descriptive AADL-path labels only |
| `ComponentExchange.allocatedFunctionalExchanges : String` | `allocatedExchanges : FunctionalExchange[0..*]` typed refs |
| `FunctionalFlow.startFunction/endFunction : String` | `ref startFunction/endFunction : SystemFunction[0..1]` |
| `FunctionalFlowStep.allocatedFunction/exchangeItem : String` | `ref function : SystemFunction`, `ref item exchangedItem : MemoExchangeItem` |
| `SystemCapability.primaryFunction : String` | `ref primaryFunction : SystemFunction[0..1]` |

## Deprecated (still present, do not use in new models)

| Element | Replacement |
|---|---|
| `Requirement`-family specializing part-def bases | new types specialize `MemoNeed`/`MemoRequirement` |

## New packages (0.5)

`memo_core_terminology`, `memo_context_actors`, `memo_context_stakeholders`,
`memo_context_use_context`, `memo_needs`, `memo_use_cases`,
`memo_clinical_procedures`, `memo_activities`, `memo_workflows`,
`memo_scenarios`, `memo_assurance_human_factors`, `memo_interaction`,
`memo_architecture_software_runtime`, `memo_architecture_deployment`,
`memo_medical_products_lifecycle`, `memo_medical_products_definitions`,
`memo_medical_products_usage`, `memo_viewpoints_catalog`,
`memo_rules_ontology`.
