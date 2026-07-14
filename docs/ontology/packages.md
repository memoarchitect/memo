# Package Structure

The meMO ontology is published through a single `memo::` facade. `memo::medical_device_library` is the aggregate import surface, while focused packages support selective imports. Architecture is decomposed into 18 layers.

## Public facade and source packages

Every SysML document owns a globally unique, path-derived source package. For
example, `src/architecture/assurance/memo_assurance.sysml` declares
`memo_architecture_assurance`. The generated-looking uppercase implementation
prefixes used during migration are gone.

`src/memo_namespaces.sysml` maps those source packages into the stable public
hierarchy:

```sysml
package memo {
    alias architecture for memo_namespace_architecture;
    alias core for memo_namespace_core;
    alias viewpoints for memo_namespace_viewpoints;
}

package memo_namespace_architecture_assurance {
    public import memo_architecture_assurance::*;
}
```

Consumers should use `memo::...` imports. The path-derived packages are an
indexing detail that prevents cross-document package reopening errors in SysIDE.

## How `memo::` Is Organized

`memo::medical_device_library` is the public import surface. Product models import one library, then use focused packages.

<div class="memo-packages" markdown>

<div class="memo-pkg" style="border-left: 4px solid #2dd4a8;">
<div class="memo-pkg-name"><code>memo::core</code></div>
<div class="memo-pkg-desc">
<em style="color: #2dd4a8;">Shared foundation</em><br>
Identity, traceability, documented/evidence elements, controlled values, and typed semantic relationships.
</div>
</div>

<div class="memo-pkg" style="border-left: 4px solid #3b82f6;">
<div class="memo-pkg-name"><code>memo::architecture</code></div>
<div class="memo-pkg-desc">
<em style="color: #3b82f6;">What the device is</em><br>
Arcadia-inspired layers for context, requirements, behavior, interfaces, hardware, software, risk, cyber, assurance, and decisions.
</div>
</div>

<div class="memo-pkg" style="border-left: 4px solid #8b5cf6;">
<div class="memo-pkg-name"><code>memo::methodology</code></div>
<div class="memo-pkg-desc">
<em style="color: #8b5cf6;">How to apply the ontology</em><br>
Profiles, patterns, rules, workflow steps, quality gates, viewpoints, and project bindings.
</div>
</div>

<div class="memo-pkg" style="border-left: 4px solid #f59e0b;">
<div class="memo-pkg-name"><code>memo::viewpoints</code></div>
<div class="memo-pkg-desc">
<em style="color: #f59e0b;">Who needs to see what</em><br>
Stakeholder-oriented concerns such as architecture, safety, cybersecurity, verification, and regulatory review.
</div>
</div>

<div class="memo-pkg" style="border-left: 4px solid #ef4444;">
<div class="memo-pkg-name"><code>memo::artifacts</code> and <code>memo::rules</code></div>
<div class="memo-pkg-desc">
<em style="color: #ef4444;">Evidence and checks</em><br>
Controlled artifact definitions plus closure, coverage, lifecycle, and quantitative rules.
</div>
</div>

<div class="memo-pkg" style="border-left: 4px solid #14b8a6;">
<div class="memo-pkg-name"><code>memo::compliance</code></div>
<div class="memo-pkg-desc">
<em style="color: #14b8a6;">Regulated outputs</em><br>
Controlled artifacts, change, postmarket, and ISO 14971 risk-management-file views.
</div>
</div>

<div class="memo-pkg" style="border-left: 4px solid #22c55e;">
<div class="memo-pkg-name"><code>memo::examples::gpca</code></div>
<div class="memo-pkg-desc">
<em style="color: #22c55e;">Reference product model</em><br>
A worked infusion-pump example used to validate and teach the modeling style.
</div>
</div>

</div>

## Ontology Hierarchy

A stable core, architecture and process around it, then project extensions and reference examples.

<div class="memo-hierarchy" markdown>

<div class="memo-layer">
<div class="memo-layer-header">
<strong>Core</strong>
<span class="memo-badge">stable semantics</span>
</div>
<div class="memo-layer-desc">Traceable elements, documented elements, evidence elements, enums, and typed semantic links.</div>
</div>

<div class="memo-layer">
<div class="memo-layer-header">
<strong>Architecture</strong>
<span class="memo-badge">model the system</span>
</div>
<div class="memo-layer-desc">Arcadia-inspired layers for context, behavior, interfaces, hardware, software, risk, cyber, requirements, and assurance.</div>
</div>

<div class="memo-layer">
<div class="memo-layer-header">
<strong>Methodology</strong>
<span class="memo-badge">apply the method</span>
</div>
<div class="memo-layer-desc">Viewpoints, rules, workflow stages, quality gates, document views, and project bindings.</div>
</div>

<div class="memo-layer">
<div class="memo-layer-header">
<strong>Extensions</strong>
<span class="memo-badge">add domain depth</span>
</div>
<div class="memo-layer-desc">Device-specific modes, interfaces, cybersecurity, usability, AI/ML, and organization-specific profiles.</div>
</div>

<div class="memo-layer">
<div class="memo-layer-header">
<strong>Examples</strong>
<span class="memo-badge">learn by reference</span>
</div>
<div class="memo-layer-desc">GPCA-style worked trace threads that show definitions becoming concrete project instances.</div>
</div>

</div>

!!! warning "Extension rule"
    Extend by packages and profiles; do not keep expanding the core vocabulary.

## Core (`memo::core`)

Abstract bases, enumerations, and semantic link definitions.

| File | Contents |
|------|----------|
| `memo_common.sysml` | `TraceableElement`, `DocumentedElement`, `EvidenceElement`, and other abstract bases |
| `memo_enumerations.sysml` | `SafetyClassKind`, `CriticalityKind`, `HazardTypeKind`, `RiskControlKind`, and other typed enumerations |
| `memo_relationships.sysml` | `SemanticLink` base and all connection definitions |

## Architecture (`memo::architecture`)

18 Arcadia-inspired layers grouped from need to evidence:

| Group | Layers |
|-------|--------|
| **Requirements & context** | `context` · `operational` · `requirements` |
| **Function & behavior** | `functions` · `behavior` |
| **Structure & interfaces** | `logical_structure` · `interfaces` · `software_structure` · `hardware_structure` |
| **System & constraints** | `system` · `physical` · `constraints` |
| **Risk & security** | `risk` · `cybersecurity` |
| **Assurance & rationale** | `assurance` · `analysis_models` · `decisions` |

## Methodology (`memo::methodology`)

How to apply the ontology — profiles, viewpoints, rules, workflow stages, quality gates, and project bindings.

## Viewpoints & Views

- `memo::viewpoints` — reusable selection intent and model-driven view definitions
- `memo::viewpoints::verification_models` — verification viewpoint definitions;
  the descriptive alias avoids the reserved identifier `verification`

## Compliance (`memo::compliance`)

Controlled artifacts and regulated views:

- Document artifact kinds
- Change management
- Post-market traceability
- ISO 14971 risk management file structure

## Importing

References use canonical paths such as `memo::architecture::risk`. Source-package
names such as `memo_architecture_risk_risk` should not appear in consuming models.

```sysml
package MyDevice {
    import memo::medical_device_library::*;
    // or selectively:
    import memo::architecture::risk::*;
    import memo::core::common::*;
}
```

Version 0.3.0 also replaces reserved identifiers with descriptive names rather
than quoted escapes. Examples include `standardArchetype`, `analysis_models`,
`verification_models`, `input`, `output`, and `inputOutput`.
