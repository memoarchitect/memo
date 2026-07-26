# Tutorials

Learning-oriented material: pages you read to acquire skill, not to look
something up. There are two kinds here, and the difference matters.

| | Read it when | What it does |
| --- | --- | --- |
| **Lessons** | You have never built a MEMO model | Takes you by the hand. You type, and something works at the end |
| **Worked examples** | You want to see a real model of a device like yours | Explains a model that already exists, so you can read it and borrow from it |

A lesson guarantees an outcome. A worked example does not ask you to build
anything — it shows you a finished model and explains the choices in it.

## Lessons

Start here if you are new.

1. [Your first model: temperature alarm](../tutorials/first-model.md) — one
   connected slice from clinical need to verification evidence, in about
   twenty minutes. Assumes nothing.
2. [Surgical workflow modelling](surgical-closure-workflow.md) — a
   sleeve-gastrectomy workflow, its scenarios, and scenario-owned activities.

## Worked examples

Each one is a real model in this repository. Read them by the question they
answer, not in order.

**Small and focused**

- [Temperature Alarm](temperature-alarm.md) — one complete safety and evidence thread.
- [Manual Surgical Instrument](manual-surgical-instrument.md) — a deliberately simple mechanical device.
- [Single-Use Device](single-use-device.md) — product identity and lifecycle for a disposable.

**Connecting behavior to structure**

- [Reusable Instrument](reusable-instrument.md) — cleaning, inspection, and reprocessing.
- [Functional, Logical, Physical](functional-logical-physical.md) — realization as a graph, not a pipeline.
- [Software-Only Medical Device](software-only-medical-device.md) — omits physical layers where they do not apply.

**Complete systems**

- [Embedded Infusion Pump](embedded-infusion-pump.md) — module, runtime, and deployment detail.
- [Connected Patient Monitor](connected-patient-monitor.md) — interfaces, trust boundaries, cybersecurity.
- [IVD Laboratory System](ivd-laboratory-system.md) — material, fluid, and coded-measurement flows.
- [Surgical Robot](surgical-robot.md) — channels, independence, and interlocks.

**Modelling technique**

- [Multidimensional Layers](multidimensional-layers.md) — one component as one record, shown in several views.
- [Standard SysML Diagram Samples](sysml-diagram-samples.md) — one view per standard SysML v2 view kind.

## How to read any of them

Where a product has behavior, read its model in this order:

1. Find the `UseCase` — the goal of the work being modelled.
2. Find the workflow or workflows that support it.
3. Select one scenario; this is the operational path being analysed.
4. Follow the scenario's activities into functional flows and functions.
5. Follow functions into requirements, risks and controls, architecture, V&V,
   and evidence.

[Scenario-driven modeling](../what/index.md#scenario-driven-modeling)
explains that order.

## Partial on purpose

Most of these examples populate two or three layers, not all of them. A manual
instrument has no software architecture; a lifecycle example focuses on product
identity. That is a valid model, and `layersOptionalRule` says so.

Each page ends with **Where this sits in MEMO** — the layers it populates, the
layers it deliberately skips, and the types it uses.

For a device modelled all the way through, read the
[GPCA Pump case study](../case-studies/gpca/index.md): every layer populated,
documented as an ISO/IEC/IEEE 42010 architecture description.
