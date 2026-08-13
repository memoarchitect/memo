---
name: memo-modeling
description: Add or change a relationship, connection, port, flow, or any construct in the MEMO SysML v2 ontology under src/, extensions/, or examples/. Use whenever a task would add a `connection def`, wire two elements together, model containment or delegation, or edit the memo-tools builder — it enforces native-first modelling and the gates that catch silent failures.
---

# MEMO modeling

MEMO **extends** SysML v2; it does not re-spell it. The failures below are all
silent — the model looks green while it is wrong — so the checks are not
optional.

## Before you write a `connection def`, check the corpus

**Do this first, unprompted.** A typed edge with no attributes is almost always
a construct SysML v2 already has, and a reinvented edge *suppresses the checking
the native one performs* — it stays invisible until the day the MEMO edge is
removed.

```bash
grep -rn "<the thing you mean>" memo-tools/corpus/sysml-v2-release/
```

Grep for the native form before proposing a new relationship. The known
duplicates and their native forms are tabulated in
`memo/docs/reference/naming-and-native-constructs.md` — read it. In short:

| You want to say… | Native construct |
|---|---|
| this contains that | nesting (not a relationship) |
| this actor pursues that | `actor` |
| this use case includes that | `include use case` |
| this exhibits that state | `exhibit state` |
| this performs that function | `perform action` |
| this precedes that | `succession` / `first … then` |
| this depends on that | `dependency` |
| this is exposed in a view | `expose` |
| something moves between two points | `flow` |
| a port delegates to a nested port | `bind` |

Only define a `connection def` when the corpus has no equivalent — the ~40
ISO 14971 / IEC 62304 / IEC 62366 relationships (`Mitigates`, `Causes`,
`HasFailureMode`, …) are the reason MEMO exists. When SysML supplies the
relationship but MEMO needs regulated attributes, **type the native one**:
`allocation x : DeploysTo allocate a to b;`.

## `flow` transports, `bind` delegates

They are not interchangeable. `flow of <ItemDef>` says *what moves*. `bind`
makes an outer port and a nested inner port the same thing. **A delegation
cannot be a `flow`** — from outside a part an `in` port is a sink. Chapters 12
and 13 of `memo-tools/corpus/sysml-v2-release/sysml/src/training/` are the
normative statement.

## A construct that parses may not build

A grammar production without a builder handler **parses and silently vanishes
from the model.** It has happened three times here: `BindingUsage`,
`ExposeMember`, the untyped flow. Before trusting any construct works:

```bash
grep -n "<ConstructName>" memo-tools/packages/tools/src/model/builder.ts
```

No handler means no model contribution, with no diagnostic.

## Gates — run these, do not trust the test suite

- **`syside check src extensions examples`** (in `memo/`) is *the* gate. SysIDE
  is the compiler of record; the Langium grammar is more permissive, so green
  `pnpm test` does **not** mean a green model. Run it.
- **`pnpm build`** in `memo-tools` after any builder change, *before* running
  the tests. The `process` transport spawns compiled `lib/`, not `src/`, and
  `sysmlc-transport.test.ts` fails with the two transports disagreeing if you
  skip it.

## Never put rationale directly above a definition

The docs generator publishes the comment block immediately preceding a
definition as that definition's API description. A rationale comment above a
`connection def` becomes its published docs. **Put reasoning in the file
header**, never directly above the definition.
