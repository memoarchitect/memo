# Functional layer

!!! question "The question this layer answers"
    **What must the system do?**

The functional layer states the system's responsibilities without choosing how to meet them. A function here is technology-independent: software, electronics, mechanics or a human procedure may carry it out, and choosing which is a later layer's decision. Its heart is a chain: a **system function** (`SystemFunction`) decomposes into **component functions** (`ComponentFunction`), each the responsibility of exactly one component. Everything else on this page supports that chain.

**Namespace:** `memo::architecture::functional` · **Source:** `src/architecture/functional/`

[![The functional layer: system function and component function at the centre, with exchanges, obligations and behaviour around them](../assets/ontology/functional.svg){ .memo-presentation-graphic }](../assets/ontology/functional.svg){ title="Open full size" }

The colours say which part of MEMO an element belongs to: **blue** is
architecture, **red** is assurance. A solid line is one of MEMO's own
relationships, a dashed line is native SysML, a diamond is containment, and a
dotted line is a reference. [How to read the figures](index.md#how-to-read-the-figures)

## Building it up

### Step 1 · The chain

[![Step 1: SystemFunction, ComponentFunction](../assets/ontology/functional-step1.svg){ .memo-presentation-graphic }](../assets/ontology/functional-step1.svg){ title="Open full size" }

A `SystemFunction` is a responsibility of the system as a whole. Allocating it is optional: a system function that no single component owns is a normal intermediate state, and it may be realised by several components, by a human, or by a mechanism. A `ComponentFunction` is a responsibility of exactly one component, so it must be allocated, and to one component only. A function decomposes by native nesting: it owns its sub-functions. Both specialise `MemoFunction`, which carries `actionKind` (the verb, such as sense, compute, actuate or route) and `functionCategory` (the domain the project argues in, such as therapy, alarm or protection).

### Step 2 · Exchanges

[![Step 2: a second ComponentFunction](../assets/ontology/functional-step2.svg){ .memo-presentation-graphic }](../assets/ontology/functional-step2.svg){ title="Open full size" }

Functions pass things to each other. An exchange (`FunctionalExchange`) is written as a typed, named SysML `flow` from one function's `out` parameter to another's `in` parameter, so the edge is the exchange, and it carries the budgets and assurance attributes of the transfer.

### Step 3 · Obligations

[![Step 3: BehaviorProperty, TimingConstraint](../assets/ontology/functional-step3.svg){ .memo-presentation-graphic }](../assets/ontology/functional-step3.svg){ title="Open full size" }

A `BehaviorProperty` is a behavioural obligation: an invariant, a transition rule, a temporal claim, an assumption or a guarantee. It is a `requirement def`, so the design must meet it (native `satisfy`) and a verification case can check it. `Contract` and `TimingConstraint` are requirement definitions of the same kind.

### Step 4 · Behaviour and reuse

[![Step 4: StateMachine, ModeConfiguration, FunctionalFlow](../assets/ontology/functional-step4.svg){ .memo-presentation-graphic }](../assets/ontology/functional-step4.svg){ title="Open full size" }

A `StateMachine` and its mode states are native SysML states, with native `transition`s inside them. A `ModeConfiguration` is the selection made at a `variation` choice point: which mode and elements are active in one arrangement. A `FunctionalFlow` is a reusable route through several responsibilities. `ActivityAction` and `ActivityFlow` describe activity-style behaviour.

## Where it leads

- **Up to [Operational](operational.md):** an operative action, or a UI action in the implementation layer, `perform`s a function. The operational layer asks the question; this one answers it.
- **Down to [Logical](logical.md):** functions are allocated to components with native `allocate`. A component function is allocated to exactly one.
- **Across to assurance:** requirements are satisfied by functions with native `satisfy` ([Requirements](requirements.md)), and a verification case names a function as its `subject` ([Verification and validation](verification-validation.md)).

## In the running example

*Detect temperature deviation* is a high-criticality system function. The
comment in the example makes the layering explicit: the function's safety and
verification character are relationships to assurance elements, not tags on
the function.

```sysml
--8<-- "examples/temperature-alarm/model/catalog/temperature_alarm.sysml:functional"
```

<details markdown="1">
<summary><strong>Every element and relationship in this layer</strong> (generated from <code>src/architecture/functional/</code>)</summary>

--8<-- "docs/ontology/_generated/functional.md"

</details>

<details markdown="1">
<summary><strong>The detail behind the steps</strong>: every attribute and kind the layer defines</summary>

### Every element in detail

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

</details>

## Go deeper

- The GPCA infusion pump: [functional analysis](../layers/operations-system.md).
- [Naming and native constructs](../reference/naming-and-native-constructs.md):
  why an exchange is a `flow`, and when a hop is a `binding` instead.
- [The functional API](../sysml-api/index.md#architecture).
