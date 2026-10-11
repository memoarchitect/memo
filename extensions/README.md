# Extensions

An extension is a **way to model**, not a sample. It is a reusable ontology
package that specializes the base and is selected by a methodology or a project
binding — so extensions live here, beside `src/`, and not under `examples/`.
Examples *use* extensions; `examples/ros-mobile-robot` demonstrates one.

MEMO defines no extension metaclass. An extension is a plain SysML package:

- outside `src/` and outside the `memo::` namespace;
- with a `memo.package.yaml` carrying identity and `sysmlDir` only (the semantic
  fields `type` / `extends` / `usage` / `ontologies` / `methodology` / `modules`
  are rejected);
- whose SysML **specializes** base types;
- plus a `MethodologyDefinition` naming `baseMethodology`, `scopeMode`, every
  package the extension ships in `includedModule`, and the extensions it builds
  on in `includedExtension`.

That methodology usage **is** the extension as the model sees it: a project
names it, another extension names it, and nothing else identifies an extension.
A metaclass would restate what the methodology already carries — a version, a
domain, an inclusion set — so there is none.

`template/` is the skeleton. The build round-trips every extension into its own
KPAR (`memo-extension-<directory>`) and resolves the whole tree with `syside check`,
exactly as it does the base.

## Each extension is its own package

An extension is built, versioned and depended on by itself. Its KPAR declares
what it uses: the base ontology and default methodology, the SysML libraries,
and **every other extension its source imports** (`import memo_extension_<name>`
is read from the files, not listed twice). `ros` therefore declares
`memo-extension-messaging` and `memo-extension-container`; `clinical` declares
neither. Add an `import` of another extension and the next build records the
dependency; remove it and the dependency goes.

## An extension's packages are listed once, by the extension

An extension usually ships several packages — `aadl` has a facade,
`memo_extension_aadl_runtime` and `memo_extension_aadl_correspondence`. Its
methodology's `includedModule` lists **every one of them except the methodology
package itself**, by exact name. Module matching is exact on purpose (a module
may name a package outside MEMO, where a prefix test would capture a
neighbour), so a facade alone does not select the packages it re-exports: the
packages that declare the definitions and rules have to be listed, and the
extension is the one place that knows them. A test holds the list equal to the
packages the directory declares.

## Composition: a project names extensions, not packages

```sysml
private import memo_extension_ros_methodology::rosExtensionMethod;

part projectBinding : ProjectMethodBinding {
    ref :>> selectedMethodology = mdDefaultDefinition;
    attribute :>> scopeMode = ScopeModeKind::explicit;
    ref :>> includedExtension = rosExtensionMethod;
}
```

`includedExtension` is a `MethodologyDefinition[0..*]` reference on both the
binding and a methodology. The resolver adds each included methodology's own
selection — its inclusion lists, and transitively the extensions *it* includes —
to the project's scope. It does **not** follow the included methodology's
`baseMethodology` (single inheritance, `[0..1]`, stays the only chain, and
including an extension must not widen a narrow methodology to whatever the
extension's base selects), and it does not apply its rule policies. A misspelled
reference is a reference error from the compiler (SysIDE and OpenSysML both
report it); a reference the resolver cannot match to a loaded methodology is a
`missing-extension` diagnostic. Either fails `memo validate`. Extensions that
include each other contribute once each.

**A dependency between extensions is declared once and derived once, and the
two are held equal.** `ros` declares
`ref :>> includedExtension = (messagingExtensionMethod, containerExtensionMethod);`.
That reference needs an import of each methodology, and the import is what the
KPAR build reads, so the declared dependency always appears in the KPAR usage.
The other direction — an extension that imports another but does not include
it, which would leave the dependency's packages out of an explicit scope — is
caught by a test that compares the extensions a directory imports with the ones
its methodology includes.

`ProjectMethodBinding.includedModule` stays, for a project's or a supplier's own
packages outside MEMO. A MEMO extension's package names do not go there.

## Rule 1 — use native mechanisms first; extension relations specialize base ones

An extension **may** declare `connection def`s and `allocation def`s when the
domain adds a relationship SysML does not already express. It must first use
native ports, interfaces, flows, messages, allocations, and dependencies. ROS
is the worked example: publisher/subscriber roles are directional ports, the
message is an item definition, the named topic is an item usage, and native
interfaces/flows connect them. No ROS publish/subscribe relation exists.
The OMG's own `Domain Libraries/Requirement Derivation` ships a `connection def`
next to a `metadata def :> SemanticMetadata` — domain relations are the
sanctioned extension mechanism in SysML v2 too.

The constraint is on where they root:

> **A relation declared by an extension specializes a base MEMO relation. It
> never roots independently.**

For a genuinely new relation, `connection def DomainRelation :> MemoLink` is
correct; `connection def DomainRelation { … }` is not. Rooting independently would give
the relation no identification core, no place in the relationship registry, and
no ends the base can reason about — a conforming tool would read it as opaque,
which is the same defect §2 of the plan names in the base itself. Give each one
a `metadata def <keyword> … :> SemanticMetadata` as well, for the same reason
every base relation has one.

The previous guard here was `assert.doesNotMatch(clinical, /connection def/)` —
a regression check on one example that had grown into an apparent rule. The
test now enforces the rule written above instead of the accident it was
guarding.

## Rule 2 — every definition carries the extension's prefix

> **An extension's definition names all begin with the PascalCase form of its
> directory name.**

`clinical/` gives `ClinicalProcedureWorkflow`, `ros/` gives `RosNode`, `aadl/`
gives `AadlThread`. Definition names share one flat namespace with the base and
with every other extension, so without a prefix two independent extensions could
both declare `Node` and a project could not include both. The uniqueness check
compares each extension against the base *and* against every other extension;
the prefix is what makes that check something an author can satisfy by
construction rather than by luck.

Enumeration literals are not definitions and are not prefixed —
`RosDurabilityKind::transientLocal`, not `RosDurabilityKind::rosTransientLocal`.

## What an extension must not do

- Redefine or restate what the base already expresses — specialize it.
- Declare a definition name the base or another extension declares.
- Carry semantic YAML. Identity and `sysmlDir` are the whole descriptor.

## The extensions that ship

| Directory | Prefix | What it adds |
| --- | --- | --- |
| `template/` | `Template` | The skeleton to copy. |
| `clinical/` | `Clinical` | Clinical-procedure data on the base operational workflow. |
| `aadl/` | `Aadl` | The AADL (SAE AS5506) correspondence profile: MEMO names mapped to AADL categories, plus the process / thread / virtual-processor component families. |
| `cloud/` | `Cloud` | Networked services and managed data stores. |
| `ros/` | `Ros` | ROS 2: nodes, messages, directional ports, topic/service/action interfaces, QoS, and containerized deployment. |

`aadl`, `cloud`, and `ros` between them are where the twelve runtime-technology
attributes that used to sit on `SoftwareComponent` now live — see
`plans/reference/memo-r1-arcadia-residue.md`.
