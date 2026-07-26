# What is MEMO

MEMO is the **Medical Engineering Modeling Ontology**: an importable SysML v2
model library for describing a medical device and the assurance argument around
it in one connected model.

SysML v2 supplies the general modeling language. MEMO supplies the
medical-device semantics: what the elements mean, which relationships are
legal, how architecture and assurance connect, and which conditions make a
model complete enough to review.

## What MEMO adds to SysML v2

<div class="memo-card-grid" markdown>

<div class="memo-card memo-card-purple" markdown>

### Domain elements

Clinical use, products, functions, architecture, requirements, hazards,
controls, verification, and evidence become first-class model elements with
defined properties.

[Elements by layer](../reference/elements/index.md)

</div>

<div class="memo-card memo-card-blue" markdown>

### Semantic relationships

Links state a claim. `Mitigates`, `SatisfiedBy`, `AllocatedTo`, and
`VerifiedBy` have different meanings and different legal endpoints.

[Relationships](../reference/relationships.md)

</div>

<div class="memo-card memo-card-teal" markdown>

### Closure rules

Native model constraints express review questions such as whether every hazard
has a control and every control has verification.

[Rules](../reference/rules.md)

</div>

<div class="memo-card memo-card-orange" markdown>

### Shared viewpoints

Architecture, risk, cybersecurity, human factors, and evidence views project
the same source model instead of creating parallel copies.

[Views and evidence](../modeling/views-evidence.md)

</div>

</div>

Together, these turn review questions into traversals of the model: *Which
requirements exist because of this hazard? Which component implements the
control? Which verification must be repeated after this interface changes?*

## The mental model

MEMO records an engineering argument from intent to evidence:

**clinical context → goal → scenario → function → architecture → evidence**

Requirements, risk, cybersecurity, human factors, and verification connect
across that path. They do not create separate copies of the device.

[The mental model](mental-model.md) explains this structure first. The
[layers](../layers/index.md) then show where each kind of engineering fact
belongs and how the assurance disciplines cross the architecture path.

## Two ideas hold the model together

- **[Scenario-driven modeling](scenario-driven.md)** reaches behavior through
  a real path taken by a user or system, giving hazards and verification a
  concrete situation to refer to.
- **[Function-centered traceability](function-centered.md)** uses functions as
  the meeting point for requirements, risk, architecture, and verification.

These are complementary: scenarios establish the path; functions state the
system responsibilities on that path.

## See the ontology as one argument

[One closed thread](closed-thread.md) follows an infusion-pump lockout from its
clinical purpose through requirement, behavior, architecture, risk control,
verification, and evidence.

After that example, use [How `memo::` is organized](namespace-map.md) to
understand the package structure or go to [Reference](../reference/index.md)
for exact definitions.
