# Extensions

An extension is a **way to model**, not a sample. It is a reusable ontology
package that specializes the base and is brought into a project by importing
it — so extensions live here, beside `src/`, and not under `examples/`.
Examples *use* extensions; `examples/ros-mobile-robot` demonstrates one.

MEMO defines no extension metaclass and no extension methodology. An extension
is plain SysML packages:

- outside `src/` and outside the `memo::` namespace;
- with a `memo.package.yaml` carrying identity and `sysmlDir` only (the semantic
  fields `type` / `extends` / `usage` / `ontologies` / `methodology` / `modules`
  are rejected);
- whose SysML **specializes** base types;
- with one **facade** package, `memo_extension_<directory>`, that publicly
  imports every other package the extension ships and every extension it builds
  on.

The facade **is** the extension as the model sees it: a project imports it,
another extension imports it, and nothing else identifies an extension.

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

## One import brings an extension in

```sysml
package memo_examples_ros_mobile_robot_project {
    public import memo_extension_ros::*;

    part projectBinding : ProjectMethodBinding {
        ref :>> selectedMethodology = mdDefaultDefinition;
    }
}
```

A methodology selects the packages that the package declaring it **publicly
imports**, followed through their public imports in turn; a project adds to that
selection the same way, from the package that declares its binding. That is
SysML's own meaning of a public import — it passes the imported members on to
whoever imports the importing package — so there is no list of package names
beside it, and a misspelled package is an import the compiler rejects. A
private import makes the names visible to the importing package and selects
nothing: the ROS package privately imports the architecture packages it
specializes, and selecting ROS does not select them.

So an extension's facade publicly imports what selecting the extension has to
select:

- **its own packages.** `aadl`'s facade publicly imports
  `memo_extension_aadl_runtime` and `memo_extension_aadl_correspondence`, the
  packages that declare its definitions and rules. A facade that left one out
  would leave it out of every project that imports the extension.
- **the extensions it builds on.** `ros` publicly imports `memo_extension_messaging`
  and `memo_extension_container`. The dependency is declared once, by that
  import, and it is the same line the KPAR build reads to record the dependency,
  so the two cannot disagree.

A test holds each facade's public imports equal to the packages the directory
declares plus the extensions it imports, and checks that every example using an
extension's definitions publicly imports its facade from the entrypoint, or one
whose facade imports it.

A project's or a supplier's own packages outside MEMO are added the same way: a
public import in the binding's package.

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
