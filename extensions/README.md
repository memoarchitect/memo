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
- plus a `MethodologyDefinition` naming `baseMethodology`, `scopeMode`, and its
  own `includedModule`.

`template/` is the skeleton. The build round-trips every extension into its own
KPAR and resolves it with `syside check`, exactly as it does the base.

## Composition happens at the project binding

`MethodologyDefinition.baseMethodology` is `[0..1]` — single inheritance, and
deliberate. Extensions therefore **do not chain**. Both
`MethodologyDefinition.includedModule` and `ProjectMethodBinding.includedModule`
are `String[0..*]`, so a project combines any number of independent extensions
by listing their modules in its own binding. That is *the* composition
mechanism; nothing else is supported.

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
`RosReliabilityKind::reliable`, not `RosReliabilityKind::rosReliable`.

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
`plans/memo-arcadia-native-coverage.md` §10 and §22.
