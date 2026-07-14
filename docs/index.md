# meMO — Medical Engineering Modelling Ontology

<div style="text-align: center; margin: 2em 0;">
<strong style="font-size: 1.4em;">Author the model. Compile the checks. Assure the safety case.</strong><br>
<em>A Companion Book for Architecture-as-Code in Medical Devices</em>
</div>

---

**meMO** is a SysML v2-native ontology for medical device architecture and safety assurance. It connects design behavior, architecture, risk, cybersecurity, verification, and evidence in one shared, computable model.

`memo:: 0.3.0` · MIT · SysML v2 · ISO 14971 · IEC 62304 · ISO/IEC/IEEE 42010

## Why meMO Exists

Medical devices are becoming complex, connected, software-defined cyber-physical systems. Safety depends on how the *whole system* behaves — not on any single requirement.

Today's evidence is spread across documents that are traced but not always meaningful. A requirement may still link to a test while the behavior that test exercises has moved to another component. A risk control may still appear in the risk file while the implementation has been split across software, hardware, and user workflow. An architecture document may still show a block diagram while the actual interfaces have changed.

**The artifacts remain. The meaning drifts.**

The problem isn't too few documents. It's that the links between them can't be checked for meaning or completeness. meMO addresses this by moving the source of meaning from disconnected documents into a connected architecture model.

## What meMO Provides

SysML v2 provides the language substrate — packages, parts, requirements, actions, interfaces, relationships, and typed model structure. meMO specializes it with medical-device domain semantics:

| Capability | Description |
|-----------|-------------|
| **Typed elements** | Every safety-relevant thing is a typed part with regulator-relevant attributes |
| **Semantic links** | Meaningful connections that express intent, roles, direction, and constraints |
| **Closure rules** | Logical checks that enforce completeness of the safety argument |
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

These layers can be adopted independently. A small team may begin with only the ontology and one example model. A larger organization may later add methodology packages, rules, generated views, CI checks, and a visual workbench.

## The Assurance Thread

meMO's core mental model is the **assurance thread** — the connected path from concern to evidence:

```
Need / Risk / Concern
        ↓
    Requirement
        ↓
  Architecture Element
        ↓
  Interface / Behavior
        ↓
    Risk Control
        ↓
  Verification Case
        ↓
      Evidence
        ↓
   Document View
```

A concern creates a requirement. A requirement is satisfied by architecture. Architecture exposes interfaces and behavior. Behavior implements or supports risk controls. Verification cases check claims. Evidence records what was shown. Document views communicate the result.

meMO's ontology exists to make that thread typed and checkable.

## Quick Start

```bash
# Requires sysand on PATH — see https://docs.sysand.org/
pnpm run build        # or: ./scripts/build-kpar.sh
```

For direct SysIDE validation, open the repository folder in VS Code or run:

```bash
syside check --warnings-as-errors --stats src
```

Version 0.3.0 is verified across all 149 SysML documents with zero diagnostics.

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
