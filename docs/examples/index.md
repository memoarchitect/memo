# Learn from the examples

Every focused example in `memo/examples` exists to answer one modeling
question you will eventually face. Read the question first, then the model:
each example is deliberately small enough to read in one sitting, and each
compiles under `syside check --warnings-as-errors`. The
[GPCA pump](gpca-walkthrough.md) is the one *complete* model that ties all of
these threads together.

## Start here: the vertical slice

**"How do I connect a goal to evidence?"** →
[`temperature-alarm`](https://github.com/memoarchitect/memo/tree/main/examples/temperature-alarm)
— *Monitor patient temperature* traced end to end: use case → function →
monitor channel → alarm UI element → use error → hazard → risk control
implemented by the UI → verification, usability validation, and evidence. If
you read one example, read this one; it is the assurance chain in ~140 lines.

## Model the work before the device

**"My product changes a clinical workflow — where do I start?"** →
[`surgical-closure-workflow`](https://github.com/memoarchitect/memo/tree/main/examples/surgical-closure-workflow)
— the operational world with *no* system layers: users, a need, the
close-incision use case, the wound-closure procedure and technique, an
eight-step workflow, the place-interrupted-sutures critical task with its six
task steps, a context-bound difficulty assessment, and two scenarios — the
nominal path and a suture-break recovery that is a *delta*, not a copied
workflow.

## Give a simple product a complete identity

**"It's just a needle holder — what does MEMO add?"** →
[`manual-surgical-instrument`](https://github.com/memoarchitect/memo/tree/main/examples/manual-surgical-instrument)
— definition/instance split with UDI, GMDN coding, a mechanical-only
technology domain, patient-contact declarations on the jaws, and role-typed
usage in a suturing task. Note what is *absent*: no functional, logical, or
software layer, and no rule complains.

## Prove the lifecycle rules work

**"Single-use vs. reusable — property or class?"** →
[`single-use-device`](https://github.com/memoarchitect/memo/tree/main/examples/single-use-device)
and
[`reusable-instrument`](https://github.com/memoarchitect/memo/tree/main/examples/reusable-instrument)
— the same `ReuseLifecycle` cluster expressing opposite answers, plus the
reprocessing workflow ("sterilize a reusable instrument" is itself a use case)
and a `ScenarioOccurrence` recording autoclave cycle 113 of unit SN-007.

## Keep one element in many disciplines

**"Do I copy the component into the safety model?"** →
[`multidimensional-layers`](https://github.com/memoarchitect/memo/tree/main/examples/multidimensional-layers)
— one dose-limit checker participating in the implementation perspective, the
designed and deployed realization stages, and the safety + cybersecurity +
verification disciplines, with zero duplication (ADR-0001 in model form).

## Understand realization as a graph

**"Does every function become software?"** →
[`functional-logical-physical`](https://github.com/memoarchitect/memo/tree/main/examples/functional-logical-physical)
— one pressure-protection responsibility realized by software supervision
*and* a mechanical relief valve, which is precisely why functional, logical,
and implementation must not collapse into each other.

## Scale up by device class

| Question | Example |
|---|---|
| Embedded firmware: module vs. runtime vs. deployment views? | [`embedded-infusion-pump`](https://github.com/memoarchitect/memo/tree/main/examples/embedded-infusion-pump) |
| Distributed system, trust boundaries, coded measurements? | [`connected-patient-monitor`](https://github.com/memoarchitect/memo/tree/main/examples/connected-patient-monitor) |
| SaMD with no hardware layer at all (IMDRF)? | [`software-only-medical-device`](https://github.com/memoarchitect/memo/tree/main/examples/software-only-medical-device) |
| Cyber-physical: channels, independence, interlocks, haptics? | [`surgical-robot`](https://github.com/memoarchitect/memo/tree/main/examples/surgical-robot) |
| Material flows, fluidics, optics, coded lab results? | [`ivd-laboratory-system`](https://github.com/memoarchitect/memo/tree/main/examples/ivd-laboratory-system) |

## Map to other methods

**"We present in C4 / we analyze in AADL."** →
[`c4-mapping`](https://github.com/memoarchitect/memo/tree/main/examples/c4-mapping)
and
[`aadl-mapping`](https://github.com/memoarchitect/memo/tree/main/examples/aadl-mapping)
— both are correspondence data, not foundations: C4 levels map onto MEMO
viewpoints; AADL categories and timing properties map onto MEMO runtime,
deployment, and physical elements. Nothing in `memo/src` depends on either.

## How to read any example

1. Read the header comment — it states the question the example answers.
2. Read the elements top-down; ids are stable and cross-referenced.
3. Follow the `connection :` lines last — they are the argument.
4. Run `syside check --warnings-as-errors examples/<name>` and experiment.
