# Tutorials

Read these tutorials by model complexity. Each is a concrete medical-device
case with a specific review question. Except for a short tutorial that explains
one view, each page is an architecture description: system of interest,
stakeholders and concerns, viewpoints and views, selected elements and
relationships, and evidence or correspondence. SysML excerpts always appear
beside the explanation of what they mean.

## Use every example through the scenario-driven sequence

Where the product needs behavior, read its model in this order:

1. Find the `UseCase`: it is the goal for the work being modelled.
2. Find the workflow or workflows that support it.
3. Select one scenario from a workflow; this is the operational path being analysed.
4. Follow the scenario's activities into functional flows and functions.
5. Follow functions into requirements, risks and controls, architecture, V&amp;V, and evidence.

Some focused examples stop early on purpose. A manual instrument may have no
software architecture; a lifecycle example may focus on product identity. The
GPCA walkthrough is the complete reference: it shows the full sequence and
explains every catalog area and view.

## Small, focused models

- [Temperature Alarm](temperature-alarm.md) — one complete safety and evidence thread.
- [Manual Surgical Instrument](manual-surgical-instrument.md) — a deliberately simple mechanical device.
- [Single-Use Device](single-use-device.md) — product identity and lifecycle for a disposable device.
- [Standard SysML Diagram Samples](sysml-diagram-samples.md) — an openable project with one view per diagram type (BDD, IBD, activity, function flow, context, requirements, state), launched with `memo-architect --example standard-sysml-diagrams`.

## Building the model

- [Surgical Workflow Modelling](surgical-closure-workflow.md) — an illustrative sleeve-gastrectomy workflow, scenarios, and scenario-owned activities.
- [Reusable Instrument](reusable-instrument.md) — adds cleaning, inspection, and reprocessing.
- [Functional, Logical, Physical](functional-logical-physical.md) — connects behavior to architecture.
- [Software-Only Medical Device](software-only-medical-device.md) — omits physical layers where they do not apply.
- [Medical Products and Identity](../layers/medical-products.md) — product, configuration, and realization identity.

## Complete systems

- [Embedded Infusion Pump](embedded-infusion-pump.md) — module, runtime, and deployment detail.
- [Connected Patient Monitor](connected-patient-monitor.md) — interfaces, trust boundaries, and cybersecurity.
- [IVD Laboratory System](ivd-laboratory-system.md) — material, fluid, and coded-measurement flows.
- [Surgical Robot](surgical-robot.md) — channels, independence, and interlocks.

## Additional modelling tutorials

- [Multidimensional Layers](multidimensional-layers.md) — show the same elements in several views without copying them.

## The reference example

[GPCA Pump](../case-studies/gpca/index.md) is the one comprehensive example: a
complete infusion-pump model, documented as an ISO/IEC/IEEE 42010 architecture
description under [Case Studies](../case-studies/index.md). The
[narrative walkthrough](gpca-walkthrough.md) takes the tutorial sequence
across that model and explains what is present in the catalog and each view.
