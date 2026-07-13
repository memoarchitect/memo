<p align="center">
  <strong>meMO</strong><br>
  <em>Medical Engineering Modelling Ontology</em>
</p>

<p align="center">
  A SysML v2-native ontology for medical device architecture and safety assurance.<br>
  Typed, computable, and architecture-backed.
</p>

<p align="center">
  <code>memo:: 0.2.0</code> &middot; MIT &middot; SysML v2 &middot; ISO 14971 &middot; IEC 62304 &middot; ISO/IEC/IEEE 42010
</p>

---

## What is meMO?

Medical devices are becoming complex, connected, software-defined cyber-physical systems. Safety depends on how the *whole system* behaves — not on any single requirement.

Today's evidence is spread across documents that are traced but not always meaningful. Requirements link to tests, but the links don't carry the safety claim. Risk controls are named but not anchored to the design. Tests pass without exercising the behavior that fails under load.

**meMO** is a domain ontology that fills this gap: a typed medical vocabulary built on SysML v2 that connects design behavior, architecture, risk, cybersecurity, verification, and evidence in one shared, computable model.

SysML v2 provides the language substrate. meMO specializes it with medical-device domain types, required attributes, semantic relationships, closure constraints, and generated assurance views.

## The Stack

meMO is a stack, not a single tool. Adopt what you need.

| Layer | What it does |
|-------|-------------|
| **Ontology** | Typed SysML v2 elements and Arcadia-inspired architecture layers for safety, interfaces, behavior, hardware/software, and evidence. Defines what each element means. |
| **Methodology** | Predefined viewpoints, rules, workflow stages, and review gates. A working structure to start from. |
| **Tools**\* | Parser, validator, and CLI that check the model and generate documents. |
| **Architect**\* | Web app for diagrams, traceability, DSM, and DHF review. |

\* *Tools and Architect are in initial stages of development and are work in progress.*

## Ontology at a Glance

A minimal, medically grounded SysML v2 vocabulary published as an open spec in one `memo::` namespace.

**Typed elements** — every safety-relevant thing is a typed part with regulator-relevant attributes:
`IntendedUse` · `Hazard` · `Harm` · `RiskControl` · `Requirement` · `Architecture` · `Behavior` · `VerificationCase` · `Evidence`

**Typed links** — semantic links carry roles, not free-form arrows. Every relation is a native SysML v2 `connection def` specializing `SemanticLink` — its name is the verb, its typed ends carry the roles, and navigation is bidirectional.

**Closure rules** — checked by walking required semantic links and flagging missing paths. 18 architecture layers, Arcadia-inspired, with risk and cybersecurity as peers.

### Connection Kinds

| Domain | Links |
|--------|-------|
| Requirement | `DerivesFrom` · `SatisfiedBy` · `DerivesInto` |
| Function | `AllocatedTo` |
| Interface | `RealizesInterface` · `CrossesTrustBoundary` · `BindsToInterface` |
| Verification | `VerifiedBy` · `ProducesEvidence` · `Validates` · `IncludedIn` |
| Risk | `MitigatesHazard` · `TracesRisk` · `AssessedAgainst` |
| Cybersecurity | `ThreatenedBy` · `Exploits` · `MitigatesVulnerability` · `ImpactsSafety` |

## Package Structure

```
memo::
├── core                    # abstract bases, enumerations, semantic links
├── architecture            # 18 ontology layers — what the device is
│   ├── context · operational · system · requirements
│   ├── functions · behavior
│   ├── logical_structure · logical_interfaces
│   ├── software_structure · hardware_structure · physical_interfaces
│   ├── constraints · risk · cybersecurity
│   └── assurance · physical · analysis · decisions
├── methodology             # how to apply the ontology
│   └── core · viewpoints · rules · patterns · workflow · gates · profiles
├── viewpoints              # reusable selection intent
├── views                   # model-driven presentation
├── compliance              # controlled artifacts + regulated views
└── examples::gpca          # worked example — GPCA infusion pump
```

## GPCA Reference Example

The `examples/gpca-pump/` directory contains a complete worked example using the Generic Patient-Controlled Analgesia (GPCA) infusion pump — a public-domain University of Minnesota CriSys benchmark, treated as IEC 62304 Class C software.

The example models a closed safety thread end-to-end:

```
Need → Requirement → Architecture → Behavior → Risk Control → Verification → Evidence → Document View
```

Every node is typed. Every edge is a `SemanticLink` with status. Change impact is computed from typed relationships, not reconstructed from meeting memory.

## Repository Layout

All SysML v2 content lives under `src/`, where the directory tree mirrors the
`memo::` namespace hierarchy (e.g. `memo::architecture::context` → `src/architecture/context/`).
Infra (sysand manifests, build output, scripts) stays at the repo root.

```
.project.json                     # sysand project: the core ontology
sysand-lock.toml                  # sysand lockfile
packages/                         # thin @memo/* package manifests
scripts/  manifest/               # build scripts + version metadata
src/                              # ── all .sysml content (namespace = directory) ──
  medical_device_library.sysml    # public import surface
  core/                           # common types, enumerations, relationships, semantics
  architecture/                   # one folder per layer: context, requirements, functions,
                                  # behavior, logical/software/hardware structure, risk,
                                  # cybersecurity, assurance, …
  compliance/                     # regulatory document views (ISO 14971 risk management file)
  artifacts/                      # artifact kinds
  rules/                          # native constraint defs (closure, coverage, cross-layer, lifecycle)
  viewpoints/                     # viewpoint + view definitions
  methodology/                    # nested sysand project: methodology profiles (default + gpca)
  examples/gpca-pump/             # reference model — pure .sysml
```

## Build / Verify

Requires [`sysand`](https://docs.sysand.org/) on `PATH`.

```bash
pnpm run build        # or: ./scripts/build-kpar.sh
```

Builds both sysand projects (core ontology + methodology) into `.kpar` archives and fails on any external-parser error. This is the portability gate: a clean build proves the constraints are portable SysML v2.

## Standards Coverage

| Standard | Coverage |
|----------|----------|
| **ISO 14971** | Hazards, harms, risk controls, risk matrices, residual risk, risk management file views |
| **IEC 62304** | Software lifecycle, safety classification (A/B/C), architecture layers, verification obligations |
| **ISO/IEC/IEEE 42010** | Architecture viewpoints, views, and stakeholder concerns |
| **IEC 81001-5-1** | Cybersecurity threat modeling, trust boundaries, vulnerability/mitigation links |
| **ISO 13485** | Controlled document artifacts, change management, post-market traceability |

## Adoption

Teams do not need to adopt every layer at once. The practical starting point is a typed safety thread that can be reviewed, queried, and extended.

1. **One product slice** — select one safety thread, import the core ontology, model the requirement, architecture element, risk control, verification case, and evidence placeholder.
2. **Keep core stable** — extend in your own package. Add device-specific states, modes, interfaces, and conventions without changing the released ontology.
3. **Methodology before tooling** — write the review gates and closure expectations first; automation should run checks the team already agrees matter.
4. **Add tools gradually** — prove value before integration. Run validation and generate lightweight views first.

## License

[MIT](LICENSE)
