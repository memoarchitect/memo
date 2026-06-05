# meMO — Medical Engineering Modelling Ontology

<div style="text-align: center; margin: 2em 0;">
<strong style="font-size: 1.4em;">Author the model. Compile the checks. Assure the safety case.</strong><br>
<em>Typed, computable, and architecture-backed.</em>
</div>

---

**meMO** is a SysML v2-native domain ontology for medical device architecture and safety assurance. It connects design behavior, architecture, risk, cybersecurity, verification, and evidence in one shared, computable model.

`memo:: 0.2.0` · MIT · SysML v2 · ISO 14971 · IEC 62304 · ISO/IEC/IEEE 42010

## The Problem

Medical devices are becoming complex, connected, software-defined cyber-physical systems. Safety depends on how the *whole system* behaves — not on any single requirement.

Today's evidence is spread across documents that are traced but not always meaningful:

- **Requirements** are traced to tests, but the link does not carry the safety claim it is meant to support.
- **Risk controls** are named, but not anchored to the design feature that implements them.
- **Tests** can pass without exercising the behavior that fails under timing, users, hardware, or faults.

The problem isn't too few documents. It's that the links between them can't be checked for meaning or completeness.

## What meMO Provides

SysML v2 provides the language substrate — packages, parts, requirements, actions, interfaces, relationships, and typed model structure. meMO specializes it with:

| Capability | Description |
|-----------|-------------|
| **Typed elements** | Every safety-relevant thing is a typed part with regulator-relevant attributes |
| **Semantic links** | Meaningful connections that express intent, roles, direction, and constraints |
| **Closure rules** | Logical checks that complete the chain and enforce consistency |
| **Architecture layers** | 18 Arcadia-inspired layers with risk and cybersecurity as peers |
| **Methodology** | Viewpoints, rules, workflow stages, and review gates |
| **Reference example** | GPCA infusion pump modeled end-to-end |

## The Stack

meMO is a stack, not a single tool. Adopt what you need.

| Layer | What it does | Status |
|-------|-------------|--------|
| **Ontology** | Typed SysML v2 elements and architecture layers. Defines what each element means. | :material-check-circle: Released |
| **Methodology** | Predefined viewpoints, rules, workflow stages, and review gates. | :material-check-circle: Released |
| **Tools** | Parser, validator, and CLI that check the model and generate documents. | :material-progress-wrench: WIP |
| **Architect** | Web app for diagrams, traceability, DSM, and DHF review. | :material-progress-wrench: WIP |

## Quick Start

```bash
# Requires sysand on PATH — see https://docs.sysand.org/
pnpm run build        # or: ./scripts/build-kpar.sh
```

## Next Steps

<div class="grid cards" markdown>

-   :material-package-variant:{ .lg .middle } **Ontology**

    ---

    Packages, architecture layers, domain types, and semantic links.

    [:octicons-arrow-right-24: Explore packages](ontology/packages.md)

-   :material-book-open-variant:{ .lg .middle } **Methodology**

    ---

    Profiles, viewpoints, workflow gates, and project binding.

    [:octicons-arrow-right-24: Learn the method](methodology/profiles.md)

-   :material-flask:{ .lg .middle } **GPCA Example**

    ---

    A complete safety thread from clinical need to evidence view.

    [:octicons-arrow-right-24: Walk the example](gpca/overview.md)

-   :material-shield-check:{ .lg .middle } **Standards**

    ---

    Coverage of ISO 14971, IEC 62304, ISO 42010, and more.

    [:octicons-arrow-right-24: See coverage](reference/standards.md)

</div>
