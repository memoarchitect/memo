# Standard SysML diagram samples

The [standard SysML diagram sample project](https://github.com/memoarchitect/memo/tree/main/examples/sysml-diagram-samples)
ships with the ontology package. It declares **one `MemoDiagramView` per
standard SysML v2 view kind** under `model/samples/`, and nothing else — the
views describe no product and no reference architecture.

Read it when you want to see how a `MemoDiagramView` is declared for each
`DiagramViewKind` value, and what `diagramType` pairs with each.

!!! info "Rendering these views"

    This page covers what the sample model *declares*. Opening the views in a
    graphical workbench is [MEMO Architect](https://github.com/memoarchitect/memo-architect)'s
    job, and is documented there.

| View | Diagram type | View kind | Demonstrates |
| --- | --- | --- | --- |
| `tree_view.sysml` | `bdd` | general | Block Definition Diagram — a decomposition hierarchy. |
| `interconnection_view.sysml` | `ibd` | interconnection | Internal Block Diagram — nested parts, boundary ports, typed connectors. |
| `action_flow_view.sysml` | `afd` | actionflow | Activity / action flow — actions, item flows, successions. |
| `functional_flow_view.sysml` | `ffd` | actionflow | Functional flow — swimlanes per realising component, typed data/energy flows. |
| `context_view.sysml` | `context` | general | System context — the system as one block among the external actors, systems, and use context it interacts with. |
| `requirements_view.sysml` | `req` | general | Requirements — stakeholder needs deriving into system requirements. |
| `state_transition_view.sysml` | `stm` | statetransition | State machine — pump operating modes and their triggered transitions. |

## Read an IBD as a connected structure

An internal block diagram has an unambiguous direction of flow: an upstream port
produces an item and a downstream port consumes it. The connectors should point
from producer to consumer; a renderer must not reverse them to fit a preferred
layout.

## What these samples are not

They are not a device reference model and they do not teach the MEMO ontology.
For a connected medical-device argument — context through evidence — use the
[GPCA pump walkthrough](gpca-walkthrough.md), whose own `model/samples/` folder
backs the same Samples experience.

<!-- memo:reinforce -->

## Where this sits in MEMO

Every tutorial is one slice of the same structure. This example uses these definitions, by the part of the ontology they come from:

| Part of the ontology | Definitions it uses | Reference |
| --- | --- | --- |
| Operational | `OperationalEntity`, `OperativeAction`, `SystemUseCase`, `UseContext`, `User` | [Operational](../ontology/operational.md) |
| Functional | `FunctionalFlow`, `StateMachine`, `SystemFunction` | [Functional](../ontology/functional.md) |
| Logical | `DataPort`, `InterfaceItem`, `LogicalComponent`, `System` | [Logical](../ontology/logical.md) |
| Implementation | `HardwareAssembly` | [Implementation](../ontology/implementation.md) |
| Requirements | `Need`, `Requirement` | [Requirements](../ontology/requirements.md) |
| Safety and risk | `FailureMode` | [Safety and risk](../ontology/safety-risk.md) |
| Core | `MemoItem`, `MemoPort`, `MemoState` | [Core](../reference/areas/core.md) |
| Views and methodology | `MemoDiagramView`, `ModelMethodBinding` | [Views and methodology](../reference/areas/viewpoints.md) |

**MEMO relationships it uses:** `AppliesInContext`, `DerivesFrom`, `LogicalConnector`, `MemoRelationship`. See [Relationships](../reference/building-blocks.md#relationships) for what each one claims and which ends are legal.

**Native SysML relationships it uses:** `actor`, `subject`, `allocate`, `satisfy`, `dependency`, `flow`, `bind`, succession (`first … then`), `include`, `transition`, `expose`.

**Architecture layers it does not populate:** realization. A MEMO project includes only the layers selected by its methodology. For a device modelled all the way through, see the [GPCA Pump case study](../case-studies/gpca/index.md).

**Narrative treatment:** [Context and Use](../layers/context.md) · [Functional Analysis](../layers/operations-system.md) · [Requirements and Architecture](../layers/requirements-architecture.md) · [Risk, Cybersecurity, and Assurance](../layers/risk-assurance.md).

**Source model:** [`examples/sysml-diagram-samples`](https://github.com/memoarchitect/memo/tree/main/examples/sysml-diagram-samples)
