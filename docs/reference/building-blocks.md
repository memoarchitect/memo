# Building blocks

## Elements

Elements are SysML definitions used to create model content.

| Source area | Elements | Reference |
| --- | --- | --- |
| Core | Shared base types, dimensions, terminology, and semantic metadata | [Core](areas/core.md#elements) |
| Operational | Actors, stakeholders, use context, use cases, activities, workflows, and scenarios | [Architecture](areas/architecture.md#operational) |
| Functional | Functions, actions, flows, behavior, modes, states, and constraints | [Architecture](areas/architecture.md#functional) |
| Logical | Logical components, interfaces, ports, connectors, exchanges, and decisions | [Architecture](areas/architecture.md#logical) |
| Implementation | Software, hardware, and user-interface definitions | [Architecture](areas/architecture.md#implementation) |
| Realization | Physical nodes, runtime environments, deployment units, and deployed flows | [Architecture](areas/architecture.md#realization) |
| Assurance | Requirements, risk, cybersecurity, human factors, verification, validation, and evidence | [Assurance](areas/assurance.md#elements) |
| Artifacts | Artifact classifications and controlled records | [Artifacts](areas/artifacts.md#elements) |
| Viewpoints | Viewpoint contracts, selection definitions, and views | [Viewpoints](areas/viewpoints.md#elements) |
| Methodology | Scope, profiles, patterns, workflow, gates, usage rules, and project bindings | [Methodology](areas/methodology.md#elements) |

[Browse element declarations by namespace.](../sysml-api/elements.md)

## Relationships

Relationships are SysML `connection def` declarations with typed ends.

| Purpose | Relationships |
| --- | --- |
| Operational context | `ActsAsActor`, `HasConcern`, `AppliesInContext`, `ParticipatesIn`, `OccursDuring` |
| Use cases and workflow | `Motivates`, `Initiates`, `Includes`, `Extends`, `Selects`, `StepPrecedes` |
| Function and architecture | `InvolvesFunction`, `AllocatedTo`, `Realizes`, `BindsToInterface` |
| Implementation and deployment | `ModuleUses`, `BuildsInto`, `DeploysTo`, `ProvidesEnvironment`, `FlowTraversesBinding` |
| Requirements and risk | `DerivesFrom`, `SatisfiedBy`, `IdentifiesHazard`, `Mitigates`, `ControlImplementedBy` |
| Cybersecurity and safety | `ThreatenedBy`, `Exploits`, `CrossesTrustBoundary`, `ImpactsSafety` |
| Verification and evidence | `VerifiedBy`, `Validates`, `ProducesEvidence`, `IncludedIn` |

[Browse relationship declarations by namespace.](../sysml-api/relationships.md)

## Enumerations

Enumerations are SysML `enum def` declarations that define controlled values.

| Used by | Examples |
| --- | --- |
| Core identity and classification | `ElementStatusKind`, `LifecycleStateKind`, `RealizationStageKind`, `CrossCuttingConcernKind` |
| Operational | `UseCaseKind`, `WorkflowStateKind`, `ScenarioPurposeKind`, `ScenarioVariantKind`, `DemandLevelKind` |
| Functional and logical | `ActionKind`, `FunctionalFlowKind`, `TimingConstraintKind`, `InterfaceKind`, `DirectionKind`, `ComponentRoleKind` |
| Implementation and realization | `ModuleKind`, `RuntimeKind`, `SafetyClassKind`, `UIElementFormKind`, `DeploymentKind`, `ProcessingNodeKind` |
| Assurance | `RequirementKind`, `SeverityKind`, `ProbabilityKind`, `RiskControlKind`, `ThreatCategoryKind`, `VerificationMethodKind` |
| Viewpoints and methodology | `AudienceKind`, `PresentationKind`, `ViewOutputKind`, `DiagramViewKind`, `WorkflowStageKind`, `RuleStrengthKind` |

[Browse enumeration declarations by namespace.](../sysml-api/enumerations.md)
