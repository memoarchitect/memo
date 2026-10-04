# Functional layer

!!! question "The question this layer answers"
    **What must the system do?**

The functional layer states the system's responsibilities without choosing how
to meet them. A function here is technology-independent. Software,
electronics, mechanics or a human procedure may carry it out, and choosing which
is a later layer's decision.

Following ARCADIA, functions form a chain. Functions of the whole system
decompose until each piece is the responsibility of exactly one component. MEMO
names the two ends of that chain because they obey different rules.

**Namespace:** `memo::architecture::functional` · **Source:** `src/architecture/functional/`

## Key elements

**Functions.** A `SystemFunction` is a responsibility of the system as a whole.
Allocating it is optional: a system function that no single component owns is a
normal intermediate state of the chain, and it may be realised by several
components, by a human, or by a mechanism. A `ComponentFunction` is a
responsibility of exactly one component, so it must be allocated, and to one
component only. Both specialise `MemoFunction`, which carries:

- `actionKind`, the verb, such as sense, compute, actuate or route;
- `functionCategory`, the domain the project argues in, such as therapy, alarm
  or protection.

**Exchanges and flows.** A `FunctionalExchange` is a transfer between two
functions. It is written as a typed, named SysML `flow` from one function's
`out` parameter to another's `in` parameter, so the edge is the exchange, and
it carries the budgets and assurance attributes of the transfer. A
`FunctionalFlow` is a reusable route through several responsibilities.

**Behaviour.** A `StateMachine` and its mode states are native SysML states.
Transitions are native `transition`s inside them. A `ModeConfiguration` is the
selection made at a `variation` choice point: which mode and elements are active
in one arrangement. `ActivityAction` and `ActivityFlow` describe activity-style
behaviour.

**Obligations on behaviour.** A `BehaviorProperty` is a behavioural obligation:
an invariant, a transition rule, a temporal claim, an assumption, or a
guarantee. It is a `requirement def`, so the design must meet it and a
verification case can check it. `Contract` and `TimingConstraint` are
requirement definitions of the same kind.

## How it connects

**Within the layer.** Functions decompose by native nesting: a function owns
its sub-functions. Exchanges connect function parameters with typed `flow`s.

**To other layers and disciplines:**

- **Operational work is carried out by functions.** An operative action, or a
  UI action in the implementation layer, `perform`s a function. See
  [Operational](operational.md).
- **Functions are allocated to components** with native `allocate`. A component
  function is allocated to exactly one. See [Logical](logical.md).
- **Requirements** are satisfied by functions with native `satisfy`, and a
  `BehaviorProperty` is itself a requirement. See [Requirements](requirements.md).
- **Verification** names a function as the `subject` of a verification case. See
  [Verification and validation](verification-validation.md).

## In the running example

*Detect temperature deviation* is a high-criticality system function. The
comment in the example makes the layering explicit: the function's safety and
verification character are relationships to assurance elements, not tags on
the function.

```sysml
--8<-- "examples/temperature-alarm/model/catalog/temperature_alarm.sysml:functional"
```

## The full inventory

Generated from `src/architecture/functional/`.

--8<-- "docs/ontology/_generated/functional.md"

## Go deeper

- The GPCA infusion pump: [functional analysis](../layers/operations-system.md).
- [Naming and native constructs](../reference/naming-and-native-constructs.md):
  why an exchange is a `flow`, and when a hop is a `binding` instead.
- [The functional API](../sysml-api/index.md#architecture).
