# Native project format

A MEMO project's meaning is in its SysML. Nothing else is read.

This is the contract as of the native semantic flip (2026-08-01). It replaces
ADR-1-8, which specified `memo.config.yaml` as the project format.

## The one rule

> Delete every YAML file in a project and the model still means exactly what it
> meant before.

Application settings may say *where* a package's source lives and *how* a
command runs. They may not say what the model contains. A settings file that
declares a semantic field is rejected with a message naming the native
construct that replaced it — it is never merged, compared, or used as a
fallback.

## Layout

```text
model/
  catalog/
    project.sysml                       identity and method binding — the entrypoint
    architecture/
      operational/  functional/  logical/  implementation/  realization/
      decisions/
    assurance/
      requirements/  safety_risk/  cybersecurity/  human_factors/
      verification_validation/
    viewpoints/
      <viewpointName>/
        viewpoint.sysml                 defines or binds a viewpoint
        views/<viewName>.sysml          views it governs
    artifacts/
      assets/       catalog.sysml + payload files
      reviews/      comments.sysml, notes.sysml, rationales.sysml
      documents/    templates/  analyses/  configuration_management/
    traces.sysml                        cross-namespace relationships
memo.package.yaml                       optional locator (identity + sysmlDir)
memo.lock.yaml                          optional generated resolution record
.memo/architect/                        optional transient workspace state
```

Only the `model/catalog/` root and the namespace mirroring are normative.
Filenames are a default starting layout; parsed package ownership decides
origin, so nothing depends on a file being called `activities.sysml`.

## The entrypoint

`model/catalog/project.sysml` imports what the project uses and declares its
binding:

```sysml
package infusion_pump_catalog {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_methodology_core::*;
    private import memo_methodology_profiles::*;

    private import infusion_pump_architecture::*;
    private import infusion_pump_assurance::*;

    part projectMethodBinding : ProjectMethodBinding {
        attribute :>> id = "PMB-001";
        attribute :>> name = "InfusionPumpProjectMethodBinding";
        attribute :>> projectName = "Infusion Pump";
        ref :>> selectedMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
    }
}
```

`selectedMethodology` is a typed SysML reference, not a string. There is no
`methodologyId` to keep in sync with anything.

## Selection

Two native facts decide what a project contains:

1. **The import graph.** Starting at the entrypoint's package, imports are
   followed transitively. A package the graph does not reach is not in the
   model, however many manifests point at it. An import naming a package no
   resolved source declares is a diagnostic.
2. **The method binding.** It names one methodology. That methodology, and its
   base chain, declare what is selected.

A resolved package is resolved in full: everything it supplies is loaded, and
effective scope then decides what is *active*. Loading and selecting are
different questions with different answers.

## Scope

`MethodologyDefinition` carries the selection directly:

```sysml
part gpcaMethodDefinition : MethodologyDefinition {
    attribute :>> id = "METH-GPCA-001";
    ref :>> baseMethodology = mdDefaultDefinition;
    attribute :>> scopeMode = ScopeModeKind::explicit;

    attribute :>> includedLayer = ("memo_architecture_operational", …);
    attribute :>> includedModule = ("memo_assurance_safety_risk", …);
    attribute :>> includedStandard = ("ISO 14971", …);
    attribute :>> includedArtifactKind = ("RiskManagementPlan");
    attribute :>> includedViewpoint = ("VP-CTX", "VP-LOG", "VP-RISK");
}
```

`scopeMode` makes the empty case unambiguous:

| Mode | Meaning |
| --- | --- |
| `explicit` | Only what is listed. **An empty list selects nothing.** |
| `allAvailable` | Everything the resolved packages provide. The lists must be empty. |

`allAvailable` is spelled that way because SysML v2 reserves `all` as a keyword.

A methodology specializes at most one base — `ref baseMethodology :
MethodologyDefinition[0..1]` — so single inheritance is a multiplicity, not a
convention. The resolver walks base-first and then applies the child; a base
cannot widen a child's scope mode.

## Rule tailoring

Every rule is a `constraint def` specializing `MemoConsistencyRule`, carrying a
stable ID and a tailoring class:

```sysml
constraint def ThreatMitigationRule :> MemoConsistencyRule {
    attribute id = "CR-MED-040";
    attribute tailoring = RuleTailoringKind::assurance;
    attribute appliesTo = "Threat";
    attribute severity = RuleSeverityKind::error;
    …
}
```

| Class | Can disable? | Can replace? |
| --- | --- | --- |
| `invariant` | No | Only in an ontology release |
| `assurance` | Yes, with rationale | Yes, through explicit replacement |
| `methodology` | Yes in a child methodology | Yes, through explicit replacement |

A methodology tailors a rule with a nested `RulePolicy`:

```sysml
part disableThreatMitigation : RulePolicy :> rulePolicy {
    ref :>> targetRule : ThreatMitigationRule;
    attribute :>> disposition = RuleDispositionKind::disabled;
    attribute :>> rationaleText = "the prototype has no network interface";
    attribute :>> authority = "GPCA Systems Engineering Lead";
    attribute :>> approvalReference = "GPCA-DHF-CR-0007";
}
```

The rule is named by narrowing the reference's *type*. Session 1 verified this
form in the MEMO grammar, SysIDE, and Sysand; there is deliberately no
`targetRuleId : String`, because a qualified SysML reference already identifies
the rule and a parallel string namespace would be a MEMO-specific identifier
where the language has one. The stable rule ID survives on the rule, for audit
records and diagnostics — a different job from being the reference mechanism.

Binding a *value* to a `constraint def` is not portable: SysIDE rejects it,
because a value must be a feature. Narrowing the type is the portable form.

Refusals the resolver makes, all with a source diagnostic:

- a policy whose target is not in the resolved rule set;
- a policy that disables or replaces an `invariant`;
- a replacement that does not exist, or a `replaced` disposition naming none;
- a tailoring decision with no rationale;
- two rules sharing one stable ID.

There is no "last duplicate wins". Replacement happens only through a
`RulePolicy`.

## What is not enforcement

Under the section 4.1 Option P verdict, `predicateExpression` remains the
executable form of a rule. This layer governs a rule's **identity and
disposition** — which rules are in the effective set, at what severity, under
whose authority — and is deterministic and auditable in that sense. It is not
evidence that a model was validated. Native constraint-body evaluation is a
separately scoped follow-on with its own KerML-subset conformance work.

## Application settings

Permitted, and read only for these purposes:

| File | Purpose |
| --- | --- |
| `memo.package.yaml` | Locator: `name`, `version`, `description`, `license`, `tags`, `sysmlDir` |
| `memo.tools.yaml` | Compiler/packager selection, executable paths, watch and export behaviour |
| `memo.architect.yaml` | Server, browser lifecycle, UI, renderer defaults |
| `memo.lock.yaml` | Generated: the packages, versions, and hashes the imports resolved to |
| `syside.toml`, `.project.json` | External tool adapters |
| `.memo/architect/` | Transient, regenerable workspace state |

Rejected, with the native replacement named in the message:

| Removed | Replaced by |
| --- | --- |
| `memo.config.yaml` | `model/catalog/project.sysml` |
| `memo.rules.yaml` | `constraint def` plus `RulePolicy` |
| `memo.viewpoints.yaml` | native viewpoint/view packages |
| `memo.rendering.yaml` | `LayerRendering` and `ExplorerClassification` usages |
| `methodology:` | `ProjectMethodBinding.selectedMethodology` |
| `extends:`, `ontologies:` | native `private import` |
| `modules:` | `includedModule` on the methodology or binding |
| `type:`, `projectType:`, `usage:` | nothing — authority comes from the resolved root a file sits under |
| `kinds:`, `relationshipTypes:` | ontology `part def` / `connection def` declarations |
| `architectureLayers:` | `LayerRendering` usages |
| `viewpoints:` | native `viewpoint def` / `view def` packages |

The boundary is enforced structurally, not by search:
`memo-tools/scripts/check-config-boundary.mjs` walks the import graph from every
semantic module and fails the build if one reaches the settings layer.

## Verifying a project

```bash
memo/scripts/check-project-portability.sh <project-dir>
```

Checks that the project carries no semantic YAML, has a native entrypoint, and
parses cleanly in both SysIDE (`syside check`) and Sensmetry `sysand`.
