# Native model format

A MEMO model's meaning is in its SysML. Nothing else is read.

This is the contract as of the native semantic flip (2026-08-01). It replaces
ADR-1-8, which specified `memo.config.yaml` as the model format.

## The one rule

> Delete every YAML file in a model and the model still means exactly what it
> meant before.

Application settings may say *where* a package's source lives and *how* a
command runs. They may not say what the model contains. A settings file that
declares a semantic field is rejected with a message naming the native
construct that replaced it — it is never merged, compared, or used as a
fallback.

## Layout

```text
model/
  methodology/
    project.sysml                       identity and method binding — the entrypoint
  catalog/
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
memo.package.yaml                       REQUIRED locator (identity + entrypoint + include)
memo.lock.yaml                          optional generated resolution record
.memo/architect/                        optional transient workspace state
```

Only the namespace mirroring is normative. Filenames and directories are a
default starting layout; parsed package ownership decides origin, so nothing
depends on a file being called `activities.sysml` — or on the entrypoint being
called `model/methodology/project.sysml`.

## The entrypoint

The entrypoint is named by `entrypoint` in `memo.package.yaml`. It is a
locator, not semantics: it says WHERE identity and import scope start, and the
SysML file it names still says WHAT they are.

```yaml
name: my-project
entrypoint: model/methodology/project.sysml
include: [model]
```

**There is no conventional fallback.** A directory holding a
`model/methodology/project.sysml` with no `entrypoint` naming it is not a model,
and MEMO commands report a missing locator rather than a missing file — the
file is usually present. `model/methodology/project.sysml` is what `memo-architect init`
scaffolds and what most models keep, but it is a default, not a rule; a
model rooted at `src/project.sysml` is equally valid and is found the same
way.

`include` names the directories holding model source. A model that omits it
resolves no packages of its own.

**`model/` is the default, `src/` is a choice.** A project's SysML lives under `model/`, and so does the
source of a reusable package made from the extension template (`extensions/template/`, `sysmlDir: ./model`).
Nothing requires it: `include` (a project) and `sysmlDir` (a package) name any directory, and the ontology
repository itself keeps its source under `src/` by setting `sysmlDir: ./src`. When a project sits inside a
repository that also holds an ontology, a package found in two places resolves to the first: `MEMO_ONTOLOGY_PATH`,
then the nearest repository, then the installation. A skipped copy is reported once as `library-root-shadowed`.

## Depending on another package

A model can build on a package of its own, such as the parts every product of a
family shares, and keep that package versioned apart from the model. The model
lists it under `dependencies` in `memo.package.yaml`, with the versions it
accepts:

```yaml
dependencies:
  robot-platform: "^1.0.0"
```

`memo-architect install` writes the entry and puts the package under
`memo_packages/` (cloned from git, linked from a local path, or installed by
npm). `*`, an exact version, `^`, `~` and `>=` are understood. A listed package
that is not found, or whose version the range does not accept, is an error.

The model imports what it uses from the package as it does from its own sources,
and that is what selects it: a dependency's package that nothing imports adds no
element to the model. Those elements that are imported are in the model, so a
link can name them and a part can be typed by them, but they belong to the
package: they are read-only here, they keep the identity the package gives them,
and the rules judge the model's own content, not theirs. To change one, change
the package and take the new version.

The entrypoint file imports what the model uses and declares its binding:

```sysml
package infusion_pump_catalog {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_methodology_core::*;
    private import memo_methodology_profiles::*;

    private import infusion_pump_architecture::*;
    private import infusion_pump_assurance::*;

    part projectMethodBinding : ModelMethodBinding {
        attribute :>> id = "PMB-001";
        @MemoIdentity { :>> label = "InfusionPumpModelMethodBinding"; }
        attribute :>> modelName = "Infusion Pump";
        ref :>> selectedMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
    }
}
```

`selectedMethodology` is a typed SysML reference, not a string. There is no
`methodologyId` to keep in sync with anything.

Until 0.15.0 a model written with the former spelling, `ProjectMethodBinding`
and `projectName`, still binds; `memo validate` reports
`deprecated-binding-spelling` and names the replacement. 0.15.0 deletes it.

## Selection

Two native facts decide what a model contains:

1. **The import graph.** Starting at the entrypoint's package, imports are
   followed transitively. A package the graph does not reach is not in the
   model, however many manifests point at it. An import naming a package no
   resolved source declares is a diagnostic.
2. **The method binding.** It names one methodology. What the packages
   declaring that methodology and its base chain publicly import, and what the
   binding's own package publicly imports, is what is selected.

A resolved package is resolved in full: everything it supplies is loaded, and
effective scope then decides what is *active*. Loading and selecting are
different questions with different answers.

## Scope

A methodology selects packages by **publicly importing** them in the package
that declares it. Nothing else lists them:

```sysml
package gpca_methodology {
    private import memo_methodology_core::*;
    private import memo_methodology_profiles::*;

    public import memo_architecture_operational::*;   // a layer
    public import memo_assurance_safety_risk::*;      // one package
    public import memo_rules_closure::*;              // the rules it runs

    part gpcaMethodDefinition : MethodologyDefinition {
        ref :>> baseMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
        ref :>> includedStandard = (iso14971, iec62304, …);
        attribute :>> includedArtifactKind = (ArtifactKind::plan, …);
        ref :>> includedViewpoint = (contextViewpoint, riskViewpoint, …);
    }
}
```

The selection is the transitive closure of public imports from the packages
that declare the selected methodology and its base chain. A public import is
SysML's statement that a package passes the imported members on
(`Import = visibility = VisibilityIndicator 'import' …`,
`SysML-textual-bnf.kebnf` 149–153); a private import is the package's own
business and selects nothing. Because the package is the selection, a package
declares one methodology. A misspelled package is an import the compiler
rejects, so a selection cannot silently name nothing.

- **A layer** is selected through its layer package: each architecture layer
  has one (`memo_architecture_operational`, `…_functional`, `…_logical`,
  `…_implementation`, `…_realization`) that publicly imports every package in
  the layer's namespace, and a test keeps it that way.
- **An extension** is selected through its facade, `memo_extension_<name>`,
  which publicly imports the extension's packages and the extensions it builds
  on (see `extensions/README.md`).
- **A model** adds to the selection the same way: a public import in the
  package that declares its `ModelMethodBinding`.

```sysml
package ros_mobile_robot_project {
    public import memo_extension_ros::*;

    part projectBinding : ModelMethodBinding {
        ref :>> selectedMethodology = mdDefaultDefinition;
    }
}
```

`scopeMode` makes the empty case unambiguous:

| Mode | Meaning |
| --- | --- |
| `explicit` | Only what is selected. **A package that publicly imports nothing selects nothing.** |
| `allAvailable` | Everything the resolved packages provide. The methodology's package imports nothing publicly. |

`allAvailable` is spelled that way because SysML v2 reserves `all` as a keyword.

A methodology specializes at most one base — `ref baseMethodology :
MethodologyDefinition[0..1]` — so single inheritance is a multiplicity, not a
convention. The resolver walks base-first and then applies the child; a base
cannot widen a child's scope mode.

What stays a value: standards, viewpoints and artifact kinds are typed
references, and a `RulePolicy`'s `targetCategory` names a layer namespace as a
string, because a value cannot reference a package.

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
form in MEMO's grammar and the external tools; there is deliberately no
`targetRuleId : String`, because a qualified SysML reference already identifies
the rule and a parallel string namespace would be a MEMO-specific identifier
where the language has one. The stable rule ID survives on the rule, for audit
records and diagnostics — a different job from being the reference mechanism.

Binding a *value* to a `constraint def` is not portable: a SysML v2 compiler rejects it,
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
| `memo.package.yaml` | Locator: `name`, `entrypoint`, `include`, `version`, `description`, `license`, `tags`, `sysmlDir`. `entrypoint` and `include` are required for a model; `sysmlDir` is the library-package equivalent |
| `memo.tools.yaml` | Compiler/packager selection, executable paths, watch and export behaviour |
| `memo.architect.yaml` | Server, browser lifecycle, UI, renderer defaults |
| `memo.lock.yaml` | Generated: the packages, versions, and hashes the imports resolved to |
| `syside.toml`, `.project.json` | External tool adapters |
| `.memo/architect/` | Transient, regenerable workspace state |
| `memo.user.yaml` | One person's own choices in Architect for this model (the role); listed in the model's `.gitignore`, never committed |

Rejected, with the native replacement named in the message:

| Removed | Replaced by |
| --- | --- |
| `memo.config.yaml` | `model/methodology/project.sysml` |
| `memo.rules.yaml` | `constraint def` plus `RulePolicy` |
| `memo.viewpoints.yaml` | native viewpoint/view packages |
| `memo.rendering.yaml` | `LayerRendering` and `ExplorerClassification` usages |
| `methodology:` | `ModelMethodBinding.selectedMethodology` |
| `extends:`, `ontologies:` | native `private import` |
| `modules:` | a `public import` of the package in the methodology's package or the binding's |
| `type:`, `projectType:`, `usage:` | nothing — authority comes from the resolved root a file sits under |
| `kinds:`, `relationshipTypes:` | ontology `part def` / `connection def` declarations |
| `architectureLayers:` | `LayerRendering` usages |
| `viewpoints:` | native `viewpoint def` / `view def` packages |

The boundary is enforced structurally, not by search:
`memo-tools/scripts/check-config-boundary.mjs` walks the import graph from every
semantic module and fails the build if one reaches the settings layer.

## Verifying a model

```bash
node memo/scripts/check-project-portability.mjs <model-dir>
```

Checks that the model carries no semantic YAML, has a native entrypoint, and
parses cleanly with the selected compiler and the package manager.
