# Architecture layers and connections

The ontology organizes a medical-device model from the clinical situation to
its realization. Each layer has a focused question, a small vocabulary of
elements, and typed relationships that make its internal structure explicit.
The important connections are also vertical: an operational scenario leads to
functions; functions are allocated to architecture; requirements, risks, and
verification remain connected to the functions they concern.

## How layers are represented in the ontology

The layer view is **derived from the model’s semantic types and their owning
packages**. It is not a generic diagram grouping added after the model is
written. For example, `OperationalActivity` is defined in the operational
package, `LogicalFunction` in the functions package, `LogicalComponent` in the
logical-structure package, and `SoftwareItem` / `HardwareAssembly` in their
respective realization packages.

Typed relationships then connect those kinds across the layer boundary:
`InvolvesFunction`, `SatisfiedBy`, `AllocatedTo`, `DeploysOnto`, and
`VerifiedBy` are model facts. A tool or view can therefore group elements by
their concrete kind and package, then follow those relationships to render a
layer map or traceability view.

There are also explicit layer fields where they add value:

| Ontology construct | How it records a layer |
|---|---|
| `Interface` | `arcadiaLayer : ArcadiaLayerKind` records `operational`, `system`, `logical`, or `physical` because the same interface taxonomy can occur at several layers. |
| `LayerElement` | Provides a general `layerName` field for elements that need an explicit layer label. |
| `MethodologyScope` | Records included architecture-layer names for a project’s method scope. |

Most architecture elements do not need an additional `layerName`: their type
already establishes their semantic home. This avoids maintaining two conflicting
classifications for the same model element.

<div class="memo-architecture-map" aria-label="MEMO architecture layers and relationships">
  <section class="memo-architecture-layer layer-operation">
    <header><span>01</span><div><strong>Operational analysis</strong><small>What people need to accomplish in context</small></div></header>
    <div class="memo-architecture-elements"><b>Actor</b><b>OperationalActivity</b><b>OperationalScenario</b></div>
  </section>
  <div class="memo-architecture-bridge"><span>scenario realized as</span><i>↓</i></div>
  <section class="memo-architecture-layer layer-function">
    <header><span>02</span><div><strong>Functional behavior</strong><small>What the system does for the scenario</small></div></header>
    <div class="memo-architecture-elements"><b>SystemScenario</b><b>LogicalFunction</b></div>
  </section>
  <div class="memo-architecture-bridge"><span>allocated to</span><i>↓</i></div>
  <section class="memo-architecture-layer layer-logical">
    <header><span>03</span><div><strong>Logical architecture</strong><small>Responsibilities and exchanges independent of implementation</small></div></header>
    <div class="memo-architecture-elements"><b>LogicalComponent</b></div>
  </section>
  <div class="memo-architecture-bridge"><span>realized by</span><i>↓</i></div>
  <section class="memo-architecture-layer layer-realization">
    <header><span>04</span><div><strong>Software, hardware, and physical architecture</strong><small>How the device is implemented, hosted, and connected</small></div></header>
    <div class="memo-architecture-elements"><b>SoftwareItem</b><b>HardwareAssembly</b><b>ProcessingNode</b><b>PhysicalPort</b></div>
  </section>
</div>

## Relationships across the layers

| Relationship | Source | Target | Review question |
|---|---|---|---|
| `Performs` | `Actor` | `OperationalActivity` | Who carries out this work? |
| `SequencesStep` | `OperationalActivity` | `OperationalActivity` | What happens next in the workflow? |
| `DerivesSystemNeed` | `OperationalActivity` | system need | What system concern follows from the work? |
| `InvolvesFunction` | `SystemScenario` | `LogicalFunction` | Which function realizes the scenario? |
| `SatisfiedBy` | `SystemRequirement` | `LogicalFunction` | Which function fulfils the claim? |
| `AllocatedTo` | `LogicalFunction` | `LogicalComponent`, `SoftwareItem`, or `HardwareAssembly` | Which part is responsible? |
| `DeploysOnto` | `SoftwareComponent` | `ProcessingNode` or host assembly | Where does the software run? |
| `RealizesInterface` | logical `Interface` | `PhysicalPort` or physical interface | How is the logical exchange made concrete? |
| `VerifiedBy` | `LogicalFunction` or requirement | `VerificationCase` | How will the behavior be checked? |
| `MitigatesHazard` | `RiskControl` | `Hazard` | Which control reduces the hazard? |

## Why software, hardware, and physical architecture are separate

They are separate because a device can change one without necessarily changing
the others. The distinction keeps implementation decisions reviewable.

| Concern | What it captures | Temperature-alarm example |
|---|---|---|
| **Software architecture** | Executable responsibilities and their structure | The software item that evaluates a temperature and decides whether to raise an alarm |
| **Hardware architecture** | The boards, sensors, actuators, and assemblies that realize the device | The temperature sensor assembly and audible alarm hardware |
| **Physical architecture** | Where software runs and how physical endpoints are deployed and connected | The processing node hosting the software and the physical port carrying the sensor signal |

`AllocatedTo` connects a function to the element responsible for it.
`DeploysOnto` then records where a software component runs. `PhysicalPort` and
the interface vocabulary describe the concrete boundary through which the
realized parts exchange signals, power, material, or data.

## Connection chain

The model connects the three realization concerns through typed links:

| From | Relationship | To | Meaning |
|---|---|---|---|
| `LogicalFunction` | `AllocatedTo` | `SoftwareItem` | The software item is responsible for that function. |
| `LogicalFunction` | `AllocatedTo` | `HardwareAssembly` | The hardware assembly contributes the sensing, actuation, or other physical capability. |
| `SoftwareComponent` | `DeploysOnto` | `ProcessingNode` | The software component runs on that physical computing node. |
| `Interface` | `RealizesInterface` | `PhysicalPort` | The logical exchange is realized through a concrete physical endpoint. |

For the temperature alarm, `EvaluateTemperature` can be allocated to the
evaluation software and the temperature-sensor assembly. The evaluation
software then deploys onto its processing node, while the sensor’s signal
arrives through a physical port. These links retain one continuous path from
the function to executable software, sensor hardware, and the device boundary.

## Interfaces, when the parts are clear

Interfaces describe the exchanges between established parts. Model them after
the functional responsibilities and parts are understandable.

| Element | Use it for | Relationship |
|---|---|---|
| `Interface` | A named logical exchange boundary | `RealizesInterface` |
| `HardwareInterface` | A physical signal, connector, or bus boundary | `RealizesInterface` |
| `SoftwareInterface` | An API, message, or software boundary | `RealizesInterface` |
