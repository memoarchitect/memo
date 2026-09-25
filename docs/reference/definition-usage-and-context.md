# Definition, usage, and context

A model says one engineering fact once. Deciding *where* that fact lives is
three separate questions, and MEMO has been answering them as if they were one.

| Axis | The question it answers | What settles it |
|---|---|---|
| **Library namespace** | Who owns this contract's API? | The package the `def` is declared in |
| **Project context** | Which engineering perspective is this reasoning from? | The package the element is authored in |
| **Native containment** | Which structure or behaviour owns this occurrence? | The `{ … }` body the usage sits in |

They are related. They are not identical, and nothing in SysML makes one imply
another. A logical component can be typed by a definition the operational
package owns, be authored under `architecture/logical/`, and be contained in a
subsystem part — three different answers, all correct.

## 1. A `def` is a contract; a usage is a fact about one system

Declare a definition when a **second, different usage could legitimately be
typed by it without lying**. Declare a usage for the particular pump, the
particular step, the particular port on this device.

The test is not how many usages exist today. A public library exists to serve
uses that are not in the tree — see
[Naming and native constructs](naming-and-native-constructs.md) for the same
argument applied to relationships. The test is whether the contract is
*sayable* about more than one thing.

Definitions live in two places, and both are legitimate:

| Where | What its definitions are |
|---|---|
| `src/` | the medical-device library — the public contract |
| `examples/` | project-owned contracts, declared by the project that reuses them |

A project declaring its own `def` is not a smell. `gpca-pump` declares
`action def AcquireSensorData :> FunctionalAction` because the GPCA pump's
sensor-acquisition contract is not the library's business and is reused inside
that project. That is the pattern working.

## 2. Classification follows the definition, not the usage's location

This is a property of the code, not an aspiration. In memo-tools'
`builder.ts`, a part usage takes `finalKindDef?.layer` — the layer of the
**definition it is typed by** — and an action usage takes
`ontologyKind?.kindDef?.layer ?? authoredLayer(filePath)`. The authored
location is a *fallback*, reached only when the type resolves to no ontology
kind.

Two consequences an author has to live with:

- **Typing a usage with a definition from another layer reclassifies it.** A
  part in `architecture/logical/` typed by an operational definition is
  reported as operational. Nothing warns.
- **An untyped usage is classified by where it is written.** MEMO keeps
  namespace and folder path aligned, so `authoredLayer` reads the directory —
  but a file outside the convention yields `unknown`, which is reported as
  `unknown` rather than dressed up as a layer.

There is no `layer` attribute on any domain element, and there must not be:
`grep -rn "attribute layer" src` finds only `layerId`/`layerLabel`/`layerColor`
in `memo_rendering.sysml`, which are presentation. Classification is single-axis
and derived. Do not add a second authority for it.

## 3. A view exposes; it never owns

A view selects and presents. It does not declare definitions, and it does not
declare the usages it draws.

**Measured 2026-09-20 — this is being violated now.** One bundled example,
`sysml-diagram-samples`, declares definitions inside its view files:

- `…/views/functional_flow_view.sysml`
- `…/views/action_flow_view.sysml`
- `…/views/operational_behaviour_view.sysml`
- `…/views/use_case_view.sysml`

Two distinct failures are mixed in there. The `use_case_view.sysml` one is a
genuine reusable contract in the wrong place —

```sysml
connection def Specialization :> MemoRelationship {
    end specialized :>> source;
    end general :>> target;
}
```

— a relationship definition any use-case model could want, stranded in a
presentation file where nothing else can import it sensibly.

The rest are worse: they are **per-layer copies of one behaviour**. The
same acquire/compute/enforce chain appears as `FxAcquire`, `FxCompute`,
`FxEnforce` in the functional view and again as `ReceiveInput`,
`ValidateInput`, `ProcessInput` in the action view, with parallel `Fx*`/`Op*`
item definitions beside them. A layer does not need its own copy of a payload,
and a diagram arrow does not justify a separately stored relationship. If a
view needs to show a function at a different altitude, it selects the one
function; it does not clone it.

## 4. A context-owned usage is identified by its owner chain

An element's id is its qualified path — `package::owner::…::shortName` — built
one hop at a time by `qualifiedId` in memo-tools' `element-index.ts`. Two
scenarios may each own a step called `evaluate` and remain two elements.

Probed 2026-09-20, building this source through `buildMemoModel`:

```sysml
action buttonPath      { action evaluate : EvaluateRequest; }
action touchscreenPath { action evaluate : EvaluateRequest; }
```

```text
P::buttonPath::evaluate
P::touchscreenPath::evaluate
```

**So do not uniquify step names by prefixing them.** The `Fx`/`Op`/`os`/`oa`
prefixes in the examples were never needed to keep elements apart; the owner
chain already does that. A collision is only a collision when two elements want
the same name *under the same owner*, which SysML forbids, SysIDE rejects, and
`ElementIndex` reports as an `ElementCollision` rather than silently keeping
one.

### A named relationship is identified the same way

A `flow`, a `connect` or any other named connection usage carries the **same
qualified id an element of that name would get** — `package::exDose`, or the
owner chain when it is declared inside an action body. It used to be the bare
declared name, so two packages that each declared `exDose` produced two
relationships under one identity and a reference meant for one reached the
other.

That id is also what a named relationship is **targeted** by. An `allocate`, a
`satisfy`, a `verify` or a risk-control connection may name a flow, and it
resolves to the flow:

```sysml
flow exDose of Data from emit.p to recv.q;
allocate exDose to linkCanBus;
satisfy reqDoseAccuracy by exDose;
```

The declared name stays on the relationship's `shortName`, because that is what
the source file says and what a writer editing or deleting the declaration
matches on; the qualified id appears in no file.

A flow is an **edge**, not an element, and it is not in the elements map — so
nothing that counts parts counts it as one. Two named relationships competing
for one qualified name are reported as a `relationship-name-collision`: both
edges stay in the model, because an edge is a fact about its endpoints, but
only the first answers to the name.

## 5. A repeated step is two usages of one definition

Never one usage reached twice. Two scenario positions are two coverage targets,
and evidence attaches to the **usage**, never to the definition — a test run
that exercised the button path has said nothing about the touchscreen path.

```sysml
action def EvaluateRequest {
    in item request : Request;
    out item decision : Decision;
}

part controller : Controller {
    perform action buttonEvaluation      references buttonPath.evaluate;
    perform action touchscreenEvaluation references touchscreenPath.evaluate;
}
```

Both usages share the contract. Both are separately addressable.

### Write the named `perform` form — the shorthand does not compile

**Measured 2026-09-20 on `syside 0.10.2` and memo-tools' builder.** The two
spellings do not agree, and the disagreement is the dangerous direction:

| Form | memo-tools builder | `syside check --diagnose all` |
|---|---|---|
| `perform buttonPath.evaluate;` ×2 | exit 0, both edges correct | **exit 1**, `namespace-distinguishability` |
| `perform action n references …;` ×2 | exit 0, both edges correct | exit 0 |

The shorthand fails because both statements introduce the effective member name
`evaluate` into the one controller namespace. MEMO's builder never creates that
member — it emits the edge and nothing else — so it has no collision to find
and reports success on source the compiler of record rejects. This is the
green-suite/red-build gap in miniature. **Write the named form.**

The local name is not stored as an element, and is not meant to be. Its only
job is to keep the two `perform` members apart in the performer's namespace;
the identity lives in the edge's target, which resolves to the distinct
scenario-local usage.

**`perform action <name> : <Type>;` is silently dropped.** With no
`references`, `resolveOwnerRootedUsage` returns before building anything — no
element, no edge — while `syside check` exits 0. Do not write it. This is
tracked as a board row; until it is fixed, a performance without a target has
nowhere to go.

## 6. Untyped is a claim, not a default

An untyped usage says *this has no reusable contract*. That is often true and
is a legitimate thing to write.

Across `examples/*/model`, a share of the action usages are bare
`action <name>;` steps — the scenario bodies in `gpca_operational.sysml` and
friends. Each of those says the step is one-off.

The moment a second scenario performs the same step, that claim is false.
Promote it to a definition and type both usages — do not copy the step, and do
not reach across into the other scenario's usage.

## 7. What this does not change

No filesystem reorganization, no renamed packages, and no change to the five
architecture layers. `memo::architecture`, `memo::assurance`, `memo::core`,
`memo::artifacts`, `memo::methodology`, `memo::rules` and `memo::viewpoints`
stay exactly where they are. This page is the rule for what goes *into* them.
