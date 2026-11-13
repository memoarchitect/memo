# Surgical Robot

Use this example for a cyber-physical system with safety architecture.

- Define primary and monitor control channels.
- State the basis for their independence.
- Model the interlock and mechanical-force flow.
- Include the haptic user-interface element in the same connected model.

[Open the source model](https://github.com/memoarchitect/memo/tree/main/examples/surgical-robot).

<!-- memo:reinforce -->

## Where this sits in MEMO

Every tutorial is one slice of the same structure. This example uses these definitions, by the part of the ontology they come from:

| Part of the ontology | Definitions it uses | Reference |
| --- | --- | --- |
| Logical | `LogicalComponent`, `System` | [Logical](../ontology/logical.md) |
| Implementation | `Actuator`, `MechanicalPart`, `OperatorInterfaceElement` | [Implementation](../ontology/implementation.md) |
| Realization | `PhysicalPort` | [Realization](../ontology/realization.md) |
| Views and methodology | `MemoDiagramView`, `ModelMethodBinding` | [Views and methodology](../reference/areas/viewpoints.md) |

**MEMO relationships it uses:** `IndependentOf`, `LogicalTransfer`. See [Relationships](../reference/building-blocks.md#relationships) for what each one claims and which ends are legal.

**Native SysML relationships it uses:** `dependency`, `flow`, `expose`.

**Architecture layers it does not populate:** operational, functional. A MEMO project includes only the layers selected by its methodology. For a device modelled all the way through, see the [GPCA Pump case study](../case-studies/gpca/index.md).

**Narrative treatment:** [Requirements and Architecture](../layers/requirements-architecture.md).

**Source model:** [`examples/surgical-robot`](https://github.com/memoarchitect/memo/tree/main/examples/surgical-robot)
