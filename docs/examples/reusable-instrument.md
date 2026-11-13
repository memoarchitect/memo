# Reusable instrument workflow

This example models the work used to clean, inspect, sterilize, and release a
reusable instrument. It does not model catalog data, serial numbers, lots, or
asset history.

The model separates three operational concepts:

- A `ClinicalWorkflow` defines the reusable sequence of work.
- An `OperativeScenario` inside it selects the nominal path: it performs the
  three activities and orders them with native `first … then` successions.
- An actual or hypothetical execution of a scenario is a native usage of it, not a separate element.

The code is included from the example's source.

```sysml
--8<-- "examples/reusable-instrument/model/catalog/reusable_instrument.sysml:use-case"
```

```sysml
--8<-- "examples/reusable-instrument/model/catalog/reusable_instrument.sysml:workflow"
```

The workflow realizes the use case:

```sysml
--8<-- "examples/reusable-instrument/model/catalog/reusable_instrument.sysml:realizes"
```

External manufacturing, QMS, or asset-management systems may associate their
records with the occurrence. Those record schemas are outside MEMO.

<!-- memo:reinforce -->

## Where this sits in MEMO

Every tutorial is one slice of the same structure. This example uses these definitions, by the part of the ontology they come from:

| Part of the ontology | Definitions it uses | Reference |
| --- | --- | --- |
| Operational | `ClinicalUseCase`, `ClinicalWorkflow`, `OperativeAction`, `OperativeScenario`, `User` | [Operational](../ontology/operational.md) |
| Logical | `System` | [Logical](../ontology/logical.md) |
| Verification and validation | `ValidationCase` | [Verification and validation](../ontology/verification-validation.md) |
| Views and methodology | `MemoDiagramView`, `ModelMethodBinding` | [Views and methodology](../reference/areas/viewpoints.md) |

**MEMO relationships it uses:** `RealizesUseCase`, `Validates`. See [Relationships](../reference/building-blocks.md#relationships) for what each one claims and which ends are legal.

**Native SysML relationships it uses:** `actor`, `subject`, `perform`, succession (`first … then`), `expose`.

**Architecture layers it does not populate:** functional, implementation, realization. A MEMO project includes only the layers selected by its methodology. For a device modelled all the way through, see the [GPCA Pump case study](../case-studies/gpca/index.md).

**Source model:** [`examples/reusable-instrument`](https://github.com/memoarchitect/memo/tree/main/examples/reusable-instrument)
