# Naming and native constructs

Two rules govern every addition to the ontology, and both exist because
breaking them fails silently rather than loudly.

1. **Name things the way SysML v2 names them** — the casing is not cosmetic; a
   miscased name stops matching the built model.
2. **Before you define a `connection def`, check that SysML v2 does not already
   have the construct.** A reinvented edge does not merely duplicate the native
   one — it suppresses the checking the native construct would have performed,
   and the model looks green until the day the MEMO edge is removed.

## Casing

MEMO follows the SysML v2 convention exactly. There is one spelling for each
kind of name; there are no accepted variants.

| Kind | Casing | Examples |
|---|---|---|
| Definitions | `PascalCase` | `Composes`, `Mitigates`, `DataPort` |
| Usages and features | `lowerCamelCase` | `fuelTankPort`, `takePicture` |
| Keywords | `lowercase` | `flow`, `bind`, `connect` |

**No `snake_case`.** The tree was measured on 2026-08-12: 859 PascalCase
definitions against 2 exceptions, and 398 lowerCamelCase usages against 26
`snake_case` names — and those 26 are variant suffixes such as `driver_a`, a
disambiguating tag on a single element, not a naming convention. Do not add to
them.

An initialism keeps its trailing capitals: `DecisionRecordedInADR`, not
`DecisionRecordedInAdr`.

## Source spelling versus model key

A name is written one way in SysML source and stored another way in the built
model. The two are not interchangeable, and the conversion is defined once, in the memo-tools
`naming.ts` (`packages/tools/src/model/naming.ts`) — never re-derive it at a
call site.

- **Source** writes the definition name: `connection : Composes …` declares an
  edge whose type is the definition `Composes`.
- **The model** stores that type as a lowerCamelCase key: `composes`. A native
  `flow` builds an edge of type `flow`.
- **Consumers normalize** with `toModelType` before comparing. `toModelType`
  lowercases only the first character (`Composes` → `composes`,
  `DerivesFrom` → `derivesFrom`), because a full `.toLowerCase()` would collapse
  `derivesFrom` onto `derivesfrom` and stop matching, and an initialism must
  keep its trailing capitals.

A view that selects relationships names them the way source spells them —
`("Composes", "flow")` — so every consumer has to normalize before it can
match. A filter that silently matches nothing looks exactly like a filter with
nothing to match; that is why a casing slip stays invisible until someone
notices a diagram is empty.

## Check the corpus before defining a `connection def`

**This is a hard rule.** Before adding any `connection def`, grep the pinned
SysML v2 corpus in memo-tools (`corpus/sysml-v2-release/`) for a native
construct that already says what you mean. A typed edge with no
attributes is either a domain concept the language lacks — in which case it
belongs to MEMO — or a re-spelling of one the language already has, in which
case it must not exist.

The audit below was measured on 2026-08-12 against that corpus and **re-measured
2026-08-18**. Each MEMO construct in the left column duplicates the native form
on its right. The status column is the point: without it the table read as a
backlog long after most of it had been done, and 12 of the 17 rows were stale.

| MEMO construct | Native form | Status (2026-08-18) |
|---|---|---|
| `Composes` | nesting (native containment) | removed |
| `IncludedIn` | `expose` | removed |
| `Initiates`, `ParticipatesIn` | `actor` | removed |
| `Includes` | `include use case` | removed |
| `PresentsState` | `exhibit state` | removed |
| `InvolvesFunction`, `ActionInvokesFunction` | `perform action` | removed |
| `Precedes` | `succession` / `first … then` | removed |
| `ModuleUses`, `MonitorsChannel` | `dependency` | removed |
| `Realizes` | `#refinement` metadata | removed |
| `InteractsWith` | `connect` | removed |
| `Enables` | `dependency` | removed |
| `ExecutesScenario` | `perform` (`OperativeScenario` is an `action def`) | removed |
| `CommentsOn`, `NotesOn`, `RationaleFor` | `comment` / `doc` + standard `Rationale`, `Issue` metadata | **present** |
| `ConnectsPhysically` | `connect` | removed |

**Four rows left this table on per-row scrutiny (2026-08-18) — they are NOT
duplicates.** A family-level judgement is a hypothesis; the per-row grep is the
measurement, and four of them failed it:

| Kept | Why the native form does not cover it |
|---|---|
| `DerivesFrom` | The standard `Derivation` connection requires **requirement usages on both ends**. 22 of 37 distinct source drivers are parts, items or actions — hazards, threats, components. Migrating produced 143 type errors. |
| `Validates` | Native `verify` requires a requirement usage as the verified element, and IEC 62304 separates validation from verification. Renaming would paraphrase a regulated term. |
| `Causes` | Carries `causeKind : CauseKind`, which `#cause` drops. |
| `TracesToDocument` | Carries `sectionReference` — the granularity that makes the trace auditable. |

**Migrating to `dependency` costs the end typing.** `Enables` had
`CR-ONT-069` constraining its source end; a generic `dependency` cannot be
selected without firing on every dependency in the model, so the rule was
deleted with the relation rather than left to pass vacuously. This is the real
price of the native form, and it is the same trade already made for `Supports`,
`ModuleUses` and `MonitorsChannel`.

**A deleted relation leaves stale filters behind.** Removing these three broke
nothing that failed loudly — but four view `includeRelationshipKinds` lists, a
DHF document query, and the Architect `CONTEXT_RELATIONSHIPS` set all still
named them, and a filter that matches nothing looks exactly like a filter with
nothing to match. Two of those (`exchangesWith`, `connectsPhysically`) had been
dead since 2026-08-12 and nobody noticed. **Grep the view filters, the DHF
queries and the Architect templates every time a relation is deleted.**

**This table is prose and therefore drifts in both directions** — rows stay after
they are done, and duplicates found later never reach it. A full audit of all 73
relation definitions and all 360 element definitions against the corpus is in
`plans/reference/memo-vs-sysml-audit-2026-08-18.md`; it identifies roughly 24
relations to delete and 23 to convert to typed native constructs, of which only
the five marked *present* above were previously written down.

Base-type duplication lands on every relationship at once, because all of them
specialize `MemoRelationship`. Deleted in R10-S5 (2026-08-13):

| `MemoRelationship` attribute | Native form |
|---|---|
| `status` | standard `StatusInfo` metadata with `StatusKind` |
| `rationale` | standard `Rationale` metadata |
| `name`, `description` | native element name and `doc` |

**Measured, not assumed:** the epic estimated 147 usages of `status` across
`src/`/`examples/` before deleting it. A tree measurement scoped to connection
usages specifically (876 of them, 77 with a body) found the 147 were all on
`requirement`/`verification` usages — an unrelated `status : ElementStatusKind`
declared per-family in `memo_core_common.sysml`, out of scope for this change.
On an actual relationship, the count was 0 for `status`, `name`, `description`,
and 1 for `rationale`. Trust a scoped grep over an epic's carried-forward
number — this is the same lesson AGENTS.md already states about plan status
lines.

**`name`/`description`:** no relationship anywhere sets them, so the decision
is a straight deletion, not a migration. Use the connection usage's own
declared name (`connection linkFoo : Bar …`) and a `doc` comment — both were
already available on every usage before this change; nothing native was
missing.

> **This reasoning is specific to relationships and does NOT generalise.**
> Measured 2026-08-18: parts set `name` **1311** times, and there the MEMO
> attribute and the native name are different strings carrying different
> information — `part entityPharmacy` (lowerCamelCase identifier) versus
> `attribute :>> name = "HospitalPharmacy"` (display label). The casing
> convention above guarantees they differ. On parts, `name` is a display label,
> not a duplicate; deleting it would destroy the labels or force every
> identifier to become its label. Treat the relationship row as closed and the
> part case as a separate, open question.

**`rationale` → `@Rationale { :>> text = "…"; }`:**

```sysml
private import ModelingMetadata::*;

connection linkFoo : SomeRelation connect a to b {
    @Rationale {
        :>> text = "…";
    }
}
```

`private import ModelingMetadata::*;` (already the exact form used for
`#refinement`, see above) brings `Rationale` into scope. Inside a metadata
body, member redefinition is `:>> name = value;`, never `attribute :>> name =
value;` — the reverse of every other body in this grammar (comment at
`memo-sysml.langium:160`, measured against `syside check`). `builder.ts`'s
`extractRelationshipMetadata` reads `Rationale.text` into
`rel.attributes.rationale`, the same key the deleted attribute used to
occupy — a downstream reader (e.g. `dhf/query-executor.ts`'s generic
`rel.attributes?.status` fallback) does not need to change.

**`status` → `@StatusInfo { :>> status = StatusKind::…; }`:** `StatusKind`
(`open`/`tbd`/`tbr`/`tbc`/`done`/`closed`) is a **different vocabulary** from
MEMO's `ElementStatusKind`
(`proposed`/`draft`/`inReview`/`approved`/`released`/`deprecated`/`retired`) —
one is issue-resolution state, the other editorial lifecycle. There is no
lossless translation; a relationship that needs `status` today writes a
`StatusKind` value directly; there is no legacy value anywhere in this
workspace to convert (0 usages, above), so no conversion code exists or was
added. For anyone who does need to carry an `ElementStatusKind` judgement over,
this is the explicit correspondence — every member has one, so nothing is
silently dropped, and the "fail loudly on no counterpart" the epic asked for is
now enforced by SysIDE's own type checker: writing a value `StatusKind` does
not declare is a compile error, not a silent miss.

| `ElementStatusKind` | `StatusKind` | Why |
|---|---|---|
| `proposed` | `tbd` | not yet decided — "to be determined" is the literal reading |
| `draft` | `open` | actively being authored |
| `inReview` | `tbr` | under review — open comments "to be resolved" |
| `approved` | `tbc` | signed off, but release is pending — "to be confirmed" |
| `released` | `done` | shipped — but see the grammar note below |
| `deprecated` | `closed` | no longer the active answer |
| `retired` | `closed` | out of service |

**Grammar note:** `StatusKind::done` does not parse in MEMO source today.
`done` is a reserved keyword — the terminal marker in a succession (`first x
then done;`, `memo-sysml.langium:527`) — and at the position after `::` the
grammar's token set does not accept it as a member name (measured: `syside`
and the Langium parser both reject `status = StatusKind::done;`, expecting an
`ID`). This is a grammar limitation, not a modelling one; if `released` status
is ever actually needed on a relationship, either fix the grammar production to
accept `done` there (the same class of fix R10-S1's short-name productions
made) or use `closed` as a practical stand-in and say so at the call site. No
example in this workspace currently needs it, so the story does not fix the
grammar.

### `flow` transports, `bind` delegates — they are not interchangeable

Two native constructs cover what an untyped connection cannot, and confusing
them is a modelling error:

- **`flow`** says *what moves* between two points. `of <ItemDef>` names the item
  that flows; two untyped connection ends cannot, which is why `flow` is
  strictly stronger than a bare typed edge.
- **`bind`** delegates a port to a nested port — it makes an outer boundary and
  an inner port the same thing. A delegation is not a transport, so **a
  delegation cannot be a `flow`.**

The normative statement is chapters 12 and 13 of
`memo-tools/corpus/sysml-v2-release/sysml/src/training/`.

### Constructs parse but do not build

A grammar production without a builder handler **parses and silently vanishes
from the model.** This has happened three times in this codebase: `BindingUsage`,
`ExposeMember`, and the untyped flow. Before you trust that a native construct
works, grep the memo-tools `builder.ts`
(`packages/tools/src/model/builder.ts`) for a handler that consumes it. A green
parse is not a built model.

## The grammar bends to SysML, never the reverse

Migrating `InteractsWith` produced `connection connect a to b;` — the normative
binary-connector shorthand. SysIDE accepted it; the Langium grammar rejected it,
because `ConnectionEnd` required `endName '::>' ref`. The fix is **always** to
widen the grammar, not to re-spell the model into whatever the grammar happens
to accept. `endName` is now optional, and the builder defaults an omitted end to
the inherited `source`/`target` participants.

Two things this exposed, both worth repeating:

- **The spawned `sysmlc` transport runs the compiled build.** After a grammar
  change, `sysmlc-transport.test.ts` fails with the in-process and spawned IRs
  disagreeing — six edges present in one and absent in the other. That is a
  stale `lib/`, not a logic bug. Run the build before believing the diff.
- **Diff the IRs structurally.** The raw assertion output is an 11MB string
  comparison that says nothing. A ten-line first-difference walk named the
  exact six relationships in one run.

## The extension pattern: type a native relationship

When SysML v2 supplies the relationship but MEMO must attach regulated
attributes, do not reinvent the relationship — **type the native one with a MEMO
`connection def`.** This is already in the codebase:

```sysml
allocation runtimeImageDeployment : DeploysTo allocate swImage to node;
```

Here `allocation` is native — the language provides the relationship and its
direction checking — and `DeploysTo` is a MEMO **`allocation def`** rooted on
`Allocations::Allocation` that carries the regulated semantics and attributes.
Every duplicate in the table above should end up either deleted in favour of its
native form, or rewritten into this shape.

**`connection : LogicalConnector connect a to b;` is already this pattern.** It
is the `connect` case of it, not a "bare connection". A 2026-08-18 audit
listed 23 relations as needing conversion; 17 of them were already in the
pattern and had nothing to convert. Read the spelling before scheduling work.

**Only `allocate` and `connect` can carry a MEMO `def` today.** `BindingUsage`
is `'bind' ref '=' ref ';'` and `SuccessionUsage` takes no `: Type`, so a
relation whose semantics need `bind`, `succession` or `flow` stays a
`connection def` until the grammar gains the production. Do not "convert" it by
dropping to the untyped native form — that trades the definition's attributes
and end typing for nothing.

### End names are decoration; position is the edge

```sysml
connection : HostedBy connect hostAssembly ::> a to processingNode ::> b;
```

This reads as if each reference binds to the end it names. **It does not.** The
builder binds by position, and `HostedBy` declares `processingNode` as its
source — so this usage produces an edge pointing the opposite way from how it
reads. Nothing catches it on its own: the type is right, both references
resolve, and `syside check` passes because SysML has no opinion about which end
you write first.

Measured 2026-08-18: 3 of ~880 usages were reversed this way — two `HostedBy`,
one `Validates`. `reversed-end-names.test.ts` in memo-tools now fails the build
on a fourth. **Write the ends in declaration order.**

## What is genuinely MEMO's

Roughly forty relationships encode ISO 14971 / IEC 62304 / IEC 62366 semantics
with no SysML v2 equivalent — `Mitigates`, `Causes`, `HasFailureMode`,
`IdentifiesHazard`, `TracesRisk`, `AssessedAgainst`, `ProducesEvidence`,
`ConformsTo`, `ImpactsSafety`, `CommitsUseError`, and so on. These are the
reason MEMO exists. The corpus check protects them: a construct that survives it
is one the language genuinely lacks.

## Do not put rationale above a definition

The SysML API doc generator treats the comment block immediately preceding a
definition as that definition's published description. A rationale comment left
above a `connection def` therefore becomes the API documentation for it. Put
reasoning in the **file header**, not directly above the definition.
