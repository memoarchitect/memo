# IVD Laboratory System

Use this example when the system moves material as well as information.

- Define the analyzer as a physical assembly.
- Model specimen movement through fluidic components.
- Record the measurement result with a coded terminology binding.
- Model the operational activity that runs a panel.

[Open the source model](https://github.com/memoarchitect/memo/tree/main/examples/ivd-laboratory-system).

<!-- memo:reinforce -->

## Where this sits in MEMO

Every tutorial is one slice of the same structure. This example uses these definitions, by the part of the ontology they come from:

| Part of the ontology | Definitions it uses | Reference |
| --- | --- | --- |
| Operational | `OperativeAction` | [Operational](../ontology/operational.md) |
| Logical | `LogicalExchangeItem`, `System` | [Logical](../ontology/logical.md) |
| Implementation | `FluidicComponent`, `OpticalComponent`, `PhysicalAssembly` | [Implementation](../ontology/implementation.md) |
| Realization | `PhysicalPort` | [Realization](../ontology/realization.md) |
| Verification and validation | `ValidationCase` | [Verification and validation](../ontology/verification-validation.md) |
| Views and methodology | `MemoDiagramView`, `ModelMethodBinding` | [Views and methodology](../reference/areas/viewpoints.md) |

**MEMO relationships it uses:** `LogicalTransfer`, `Validates`. See [Relationships](../reference/building-blocks.md#relationships) for what each one claims and which ends are legal.

**Native SysML relationships it uses:** `flow`, `expose`.

**Architecture layers it does not populate:** functional. A MEMO project includes only the layers selected by its methodology. For a device modelled all the way through, see the [GPCA Pump case study](../case-studies/gpca/index.md).

**Narrative treatment:** [Context and Use](../layers/context.md) · [Requirements and Architecture](../layers/requirements-architecture.md).

**Source model:** [`examples/ivd-laboratory-system`](https://github.com/memoarchitect/memo/tree/main/examples/ivd-laboratory-system)
