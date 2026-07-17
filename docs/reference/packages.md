# Packages and Imports

The manifest exposes four logical packages:

| Package | Purpose |
|---|---|
| `@memoarchitect/ontology` | Core reusable element, relationship, rule, and viewpoint definitions |
| `@memoarchitect/medical-modeling-profile` | Medical-device profile, templates, and archetypes |
| `@memoarchitect/methodology-default` | Default workflow and methodology content |
| `@memoarchitect/methodology-gpca` | GPCA example-specific methodology content |

Most device projects should extend `@memoarchitect/medical-modeling-profile` and import
the public library:

```yaml
extends: "@memoarchitect/medical-modeling-profile"
```

```sysml
private import memo_medical_device_library::*;
```

Prefer the public import surface over deep imports into ontology source
packages. Deep imports couple a project to internal organization and make
upgrades harder.

## Source map

| Directory | Contains |
|---|---|
| `src/core` | Common types, enumerations, relationships, dimensions, and semantics |
| `src/architecture` | Context, requirements, functions, behavior, logical, software, hardware, physical, risk, and assurance definitions |
| `src/compliance` | Artifact and lifecycle concepts |
| `src/rules` | Native closure, coverage, cross-layer, lifecycle, and quantitative rules |
| `src/viewpoints` | Reusable viewpoint and view definitions |
| `profile` | Medical modeling profile and project templates |
| `methodologies` | Workflow-specific packages |
| `examples/gpca-pump` | Complete reference model |
