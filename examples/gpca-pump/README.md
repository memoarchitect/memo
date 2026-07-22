# GPCA Pump Reference Example

This is the complete MEMO reference model. It demonstrates scenario-driven
modelling for a generic patient-controlled analgesia infusion pump.

Start with `ucDeliverPcaTherapy` in `model/catalog/gpca_operational.sysml`:

1. The use case states the clinical goal.
2. `wfPrepareAndStartTherapy`, `wfManageActiveTherapy`, and
   `wfRespondToTherapyAlarm` are the workflows that support it.
3. The operational scenarios select normal, alternate, exception, and recovery
   paths through those workflows.
4. The selected path connects to the explicit ISO 14971 chain
   (`HazardCause` → `Hazard` → `SequenceOfEvents` →
   `HazardousSituation` → `Harm`), initial and residual risk,
   `RiskControlMeasure`, architecture, verification, and evidence.

## Layout

- `model/catalog/` — canonical model elements, grouped by concern.
- `model/views/` — diagram and document views; each answers a review question.
- `model/samples/` — renderer samples and saved layouts.
- `methodology/` — GPCA-specific methodology and profile content.
- `dhf/` — document templates and generated-document material.

Read the detailed walkthrough at `docs/examples/gpca-walkthrough.md` before
browsing the full catalog.
