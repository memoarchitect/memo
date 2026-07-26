# What is MEMO

MEMO is the **Medical Engineering Modeling Ontology**: a SysML v2 library that
supplies the medical-device domain model and assurance rules that SysML v2
itself deliberately leaves open.

SysML is the language. MEMO is the vocabulary and the rules you would otherwise
have to invent for every programme.

## The division of labour

| SysML v2 provides | MEMO specializes it into | The engineering result |
| --- | --- | --- |
| `part`, `action`, `item`, `port` | `Hazard`, `RiskControlMeasure`, `SystemFunction`, `LogicalComponent` | Elements that mean something to a reviewer, and carry the attributes their standard expects |
| `connection def` | `Mitigates`, `SatisfiedBy`, `AllocatedTo`, `VerifiedBy` | Links that state a claim, with typed ends that constrain what may legally connect |
| `constraint def` | Closure and coverage rules | Review questions that execute — see [one closed thread](closed-thread.md) |
| Views and viewpoints | Risk, architecture, DHF, and cybersecurity viewpoints | Each reader gets a projection of one model, not a separate document |

The consequence is the point: **design review questions become model queries.**
*Which requirements exist only because of a hazard? Which controls are not yet
verified? What does this interface change reach?* Each is a traversal of typed
links rather than a search through documents.

## Three things it adds

<div class="memo-card-grid" markdown>

<div class="memo-card memo-card-purple" markdown>

### Typed elements

Well-defined artifacts. A hazard is a `Hazard`, not a part named "hazard", so
the attributes ISO 14971 expects are structural rather than conventional.

[Elements by layer](../reference/elements/index.md)

</div>

<div class="memo-card memo-card-blue" markdown>

### Typed relationships

Meaningful connections. `Mitigates` and `SatisfiedBy` are different facts with
different legal endpoints — a tool that knows the difference can tell you when
one is missing.

[Relationships](../reference/relationships.md)

</div>

<div class="memo-card memo-card-teal" markdown>

### Closure rules

Logical checks. Native SysML constraints that walk the required links and
report what is missing, in any conformant tool.

[Rules](../reference/rules.md)

</div>

</div>

All three are expressed in SysML v2 itself. They are model content, not engine
configuration, which is why the checks are portable and why `memo validate` is
a runner rather than the authority on legality.

## See it work

The fastest way to understand MEMO is to follow one thread from a patient
pressing a dose button to the evidence that the lockout works — and then watch
the rules report what is missing.

[One closed thread →](closed-thread.md)

## Two ideas do most of the work

MEMO's structure follows from two modelling decisions:

- **[Scenario-driven modelling](scenario-driven.md)** — behavior is reached
  through the path a real user takes, so hazards attach to situations rather
  than to abstractions.
- **[Function-centered traceability](function-centered.md)** — functions are
  the hub that requirements, risk, architecture, and verification attach to,
  which is what keeps the argument connected under change.

## Where to go next

| You want to | Read |
| --- | --- |
| Follow a concrete thread end to end | [One closed thread](closed-thread.md) |
| Know what you actually install | [The four products](products.md) |
| Understand the shape of the library | [The mental model](mental-model.md) |
| See how the packages are named | [How `memo::` is organised](namespace-map.md) |
| Start using it on a real project | [Adopting MEMO](../how-to/adopt.md) |
