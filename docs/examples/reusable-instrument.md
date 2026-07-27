# Reusable instrument workflow

This example models the work used to clean, inspect, sterilize, and release a
reusable instrument. It does not model catalog data, serial numbers, lots, or
asset history.

The model separates three operational concepts:

- `OperationalWorkflow` defines the reusable sequence of work.
- `OperationalScenario` selects the nominal path.
- `ScenarioOccurrence` records one modeled execution of that scenario.

```sysml
use case ucSterilize : UseCase {
    attribute :>> useCaseKind = UseCaseKind::clinical;
    attribute :>> goalStatement =
        "Return a used instrument to sterile, functional condition for the next case.";
}
action wfReprocess : OperationalWorkflow {
    attribute :>> entryCondition = "used instrument received in decontamination";
    attribute :>> completionCondition = "sterile pack released to storage";
}
connection : StepPrecedes connect predecessor ::> wsClean to successor ::> wsInspect;
connection : StepPrecedes connect predecessor ::> wsInspect to successor ::> wsSterilize;
```

External manufacturing, QMS, or asset-management systems may associate their
records with the occurrence. Those record schemas are outside MEMO.

## Where this sits in MEMO

| Layer | Element types it uses | Reference |
| --- | --- | --- |
| Operational | `OperationalActivity`, `OperationalWorkflow`, `OperationalScenario`, `ScenarioOccurrence`, `UseCase`, `User`, `WorkflowStep` | [Operational](../reference/areas/architecture.md#operational) |
| Views and methodology | `MemoDiagramView` | [Views and methodology](../reference/areas/viewpoints.md) |

**Typed links it uses:** `Composes`, `Initiates`, `StepPrecedes`, `Supports`.

[Open the source model](https://github.com/memoarchitect/memo/tree/main/examples/reusable-instrument).
