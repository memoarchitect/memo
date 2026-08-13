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
specialize `MemoRelationship`:

| `MemoRelationship` attribute | Native form |
|---|---|
| `status` | standard `StatusInfo` metadata with `StatusKind` |
| `rationale` | standard `Rationale` metadata |
| `name`, `description` | native element name and `doc` |

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
