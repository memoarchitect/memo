# Building blocks

## Elements

Elements are SysML definitions used to create model content.

| Source area | Elements | Reference |
| --- | --- | --- |
| Core | Shared base types, dimensions, terminology, and semantic metadata | [Core](areas/core.md#elements) |
| Operational | Actors, stakeholders, use context, use cases, activities, workflows, and scenarios | [Architecture](../ontology/operational.md) |
| Functional | Functions, actions, flows, behavior, modes, states, and constraints | [Architecture](../ontology/functional.md) |
| Logical | Logical components, interfaces, ports, connectors, exchanges, and decisions | [Architecture](../ontology/logical.md) |
| Implementation | Software, hardware, and user-interface definitions | [Architecture](../ontology/implementation.md) |
| Realization | Physical nodes, runtime environments, deployment units, and deployed flows | [Architecture](../ontology/realization.md) |
| Assurance | Requirements, risk, cybersecurity, human factors, verification, validation, and evidence | [Assurance](../ontology/index.md#the-assurance-disciplines) |
| Artifacts | Artifact classifications and controlled records | [Artifacts](areas/artifacts.md#elements) |
| Viewpoints | Viewpoint contracts, selection definitions, and views | [Viewpoints](areas/viewpoints.md#elements) |
| Methodology | Scope, profiles, patterns, workflow, gates, usage rules, and project bindings | [Methodology](areas/methodology.md#elements) |

[Browse element declarations by namespace.](../sysml-api/elements.md)

## Relationships

MEMO connects elements with native SysML v2 relationships where the language has
one, and with its own typed relationships (`connection def`s, and `allocation
def`s for the deployment chain) where the native form would lose meaning.
[MEMO in a nutshell](../ontology/index.md#how-the-layers-connect) explains the
split, and each layer page lists every relationship that touches the layer.

| Purpose | Native SysML | MEMO relationships |
| --- | --- | --- |
| Operational context | `actor`, `subject` | `AppliesInContext`, `SituatedIn`, `InteractsInContext`, `Governs` |
| Use cases and workflow | `include use case`, `succession` | `Motivates`, `RequiresCapability`, `EnablesUseCase`, `RealizesUseCase` |
| Function and architecture | `allocate`, `perform`, `#refinement dependency`, `flow`, `bind` | `IndependentOf`, `BindsToInterface`, `ConnectionBinding` |
| Implementation and deployment | `dependency` | `BuildsInto`, `DeploysTo`, `HostedBy`, `ProvidesEnvironment`, `MemoryBinding`, `FlowTraversesBinding`, `DependsOnSoup` |
| Requirements and risk | `satisfy` | `DerivesFrom`, `Causes`, `LeadsToHarm`, `IdentifiesHazard`, `Mitigates`, `ControlImplementedBy` |
| Cybersecurity and safety | | `ThreatenedBy`, `Exploits`, `CrossesTrustBoundary`, `ImpactsSafety`, `DerivesCyberRequirement` |
| Verification and evidence | `subject`, `perform` | `Validates`, `ProducesEvidence`, `PerformsStep`, `TestedByUsability`, `EvaluatesTask` |

[Browse relationship declarations by namespace.](../sysml-api/relationships.md)

## Enumerations

Enumerations are SysML `enum def` declarations that define controlled values.

| Used by | Examples |
| --- | --- |
| Core identity and classification | `ElementStatusKind`, `LifecycleStateKind`, `RealizationStageKind`, `CrossCuttingConcernKind` |
| Operational | `UseCaseKind`, `ResourceKind`, `ScenarioKind`, `DemandLevelKind` |
| Functional and logical | `ActionKind`, `FunctionalFlowKind`, `TimingConstraintKind`, `InterfaceKind`, `DirectionKind`, `ComponentRoleKind` |
| Implementation and realization | `ModuleKind`, `RuntimeKind`, `SafetyClassKind`, `UIElementFormKind`, `DeploymentKind`, `ProcessingNodeKind` |
| Assurance | `RequirementTypeKind`, `SeverityKind`, `ProbabilityKind`, `RiskControlKind`, `ThreatCategoryKind`, `MemoVerificationMethodKind` |
| Viewpoints and methodology | `PresentationKind`, `ViewOutputKind`, `DiagramViewKind`, `WorkflowStageKind`, `RuleStrengthKind` |

[Browse enumeration declarations by namespace.](../sysml-api/enumerations.md)
