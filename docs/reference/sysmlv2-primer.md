# SysML v2 Concepts Used by meMO

This appendix explains only the SysML v2 concepts that meMO uses directly. It is intentionally not a full SysML v2 tutorial.

## Definition versus Usage

meMO mostly defines reusable concepts. Product models then use or specialize those concepts.

A **definition** defines a kind of thing. A **usage** is a use of that kind in a specific model context.

```sysml
// Definition (in the ontology)
part def SoftwareComponent specializes ArchitectureElement {
    attribute safetyClass : SafetyClassKind;
    attribute responsibility : String;
}

// Usage (in a product model)
part bolusController : SoftwareComponent {
    :>> safetyClass = SafetyClassKind::C;
}
```

meMO uses definitions because the ontology is meant to be reused across products.

## `package`

A package groups related model elements. meMO uses packages such as `memo::core`, `memo::architecture`, `memo::methodology`, and `memo::rules`.

Packages make the ontology navigable, versionable, and adoptable in layers.

## `import`

Imports allow one package to use definitions from another. The public `medical_device_library` imports core, architecture, viewpoints, views, compliance, and methodology packages. Common definitions are defined once and reused.

## `part def`

`part def` defines a reusable structural or conceptual kind. meMO uses it for many ontology concepts:

- `TraceableElement`, `DocumentedElement`
- `ArchitectureElement`, `InterfaceElement`, `EvidenceElement`
- `SoftwareComponent`, `HardwareAssembly`
- `Hazard`, `RiskControl`
- `VerificationCase`, `Viewpoint`, `ConsistencyRule`

## `requirement def`

`requirement def` defines reusable requirement kinds. meMO uses it when the element is truly an obligation:

- `SystemRequirement`, `SoftwareRequirement`
- `SafetyRequirement`, `CybersecurityRequirement`

Requirements express obligations that must be satisfied and verified.

## `item def`

`item def` defines things that are exchanged, carried, or treated as items. meMO uses it for interface content:

- `Command`, `Measurement`, `AlarmSignal`
- `ConfigurationItem`, `EvidenceFile`

Interfaces need explicit exchanged items — otherwise they become ambiguous lines.

## `connection def`

`connection def` defines a typed relationship. meMO uses this heavily because relationships are engineering claims:

```sysml
connection def SatisfiedBy :> SemanticLink {
    end requirement : VerifiableElement;
    end satisfyingElement : ArchitectureElement;
}
```

A generic trace link is weak. A typed connection says what kind of claim is being made.

## Connection Ends

Connection ends define the roles at each end of a relationship. In `SatisfiedBy`, one end is the requirement and the other is the satisfying architecture element. Typed ends make validation possible — a checker can detect whether the wrong kinds of elements are connected.

## `attribute`

Attributes capture properties of model elements:

```sysml
attribute id : String;
attribute lifecycleState : LifecycleStateKind;
attribute safetyRelevant : Boolean;
attribute severity : CriticalityKind;
```

Attributes support review, filtering, generated views, and rule checks.

## `enum`

Enums define controlled value sets. meMO uses enums for many controlled values:

- `LifecycleStateKind`, `SafetyClassKind`, `CriticalityKind`
- `VerificationMethodKind`, `InterfaceKind`, `RiskLevelKind`

Controlled values reduce ambiguity and make rules possible. If safety class is free text, a rule cannot reliably detect Class C components.

## `constraint def`

`constraint def` defines reusable rules or conditions:

- Each safety requirement should have verification
- Each hazard should have at least one risk control
- Each risk control should have implementation evidence

The purpose is not to prove safety automatically — it is to support disciplined model review.

## Specialization

Specialization allows one definition to refine another:

```sysml
part def SoftwareComponent specializes ArchitectureElement
```

This means `SoftwareComponent` inherits the common meaning of `ArchitectureElement` but can add software-specific properties. Specialization lets meMO build a layered ontology without duplicating common attributes.

## `viewpoint` and `view`

A **viewpoint** defines a stakeholder-oriented concern (architecture, safety, cybersecurity, verification, regulatory). A **view** is a concrete projection of model content for that concern.

Different stakeholders need different views, but they should consume the same source model.

## Textual Syntax

meMO uses textual SysML because the ontology should live in source control. Textual modeling supports Git review, diffs, versioning, package builds, CI validation, and architecture-as-code workflows.
