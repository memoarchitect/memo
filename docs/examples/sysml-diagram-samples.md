# Standard SysML diagram samples

The [standard SysML diagram sample project](https://github.com/memoarchitect/memo/tree/main/examples/sysml-diagram-samples)
is a small, openable MEMO Architect project whose only job is to render **one
diagram per standard SysML v2 view kind**. Together the views describe no
product or reference architecture — each exists solely to exercise one renderer.

Open it read-only in the Architect UI:

```sh
memo-architect --example standard-sysml-diagrams
```

The command copies the bundled example to a disposable directory and starts the
Architect dev server there, so any edits are discarded when you quit.

Each view is a `MemoDiagramView` under `model/samples/`, grouped in the Architect
explorer under **Model Viewpoint › Samples**.

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

Every tutorial is one slice of the same structure. This example populates these layers:

| Layer | Element types it uses | Reference |
| --- | --- | --- |
| Operational | `OperationalEntity`, `UseCase`, `UseContext`, `User` | [Operational](../reference/elements/operational.md) |
| Functional | `ModeState`, `StateMachine`, `Transition` | [Functional](../reference/elements/functional.md) |
| Logical | `DataPort`, `LogicalComponent` | [Logical](../reference/elements/logical.md) |
| Implementation and realization | `HardwareAssembly` | [Implementation and realization](../reference/elements/implementation.md) |
| Assurance | `Need`, `Requirement` | [Assurance](../reference/elements/assurance.md) |
| Views and methodology | `MemoDiagramView` | [Views and methodology](../reference/elements/views.md) |

**Typed links it uses:** `AppliesInContext`, `Composes`, `DerivesFrom`, `ExchangesWith`, `Extends`, `IncludedIn`, `Includes`, `Initiates`, `InteractsWith`, `MemoLink`, `ParticipatesIn` — see [Relationships](../reference/relationships.md) for what each one claims and which ends are legal.

**Narrative treatment:** [Context and Use](../layers/context.md) · [Functional Analysis](../layers/operations-system.md) · [Requirements and Architecture](../layers/requirements-architecture.md) · [Risk, Cybersecurity, and Assurance](../layers/risk-assurance.md).

**Source model:** [`examples/sysml-diagram-samples`](https://github.com/memoarchitect/memo/tree/main/examples/sysml-diagram-samples)
