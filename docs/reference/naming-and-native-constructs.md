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

The audit below was measured on 2026-08-12 against that corpus. Each MEMO
construct in the left column duplicates the native form on its right.

| MEMO construct | Native form |
|---|---|
| `Composes` | nesting (native containment) |
| `IncludedIn` | `expose` |
| `Initiates`, `ParticipatesIn` | `actor` |
| `Includes` | `include use case` |
| `PresentsState` | `exhibit state` |
| `InvolvesFunction`, `ActionInvokesFunction` | `perform action` |
| `Precedes` | `succession` / `first … then` |
| `ModuleUses`, `MonitorsChannel` | `dependency` |
| `Realizes` | `#refinement` metadata |
| `DerivesFrom` | `#derivation` metadata |
| `CommentsOn`, `NotesOn`, `RationaleFor` | `comment` / `doc` + standard `Rationale`, `Issue` metadata |
| `ConnectsPhysically` | `connect` |

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

## The extension pattern: type a native relationship

When SysML v2 supplies the relationship but MEMO must attach regulated
attributes, do not reinvent the relationship — **type the native one with a MEMO
`connection def`.** This is already in the codebase:

```sysml
allocation runtimeImageDeployment : DeploysTo allocate swImage to node;
```

Here `allocation` is native — the language provides the relationship and its
direction checking — and `DeploysTo` is a MEMO `connection def` that carries the
regulated semantics and attributes. Every duplicate in the table above should
end up either deleted in favour of its native form, or rewritten into this
shape.

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
