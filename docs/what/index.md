# What is MEMO

MEMO is the **Medical Engineering Modeling Ontology**: a portable SysML v2
library that gives a medical-device team one shared, typed vocabulary for the
clinical work, the device, its risks, and the evidence used to review it.

It is content, not a tool. The model is plain SysML v2 text that any conformant
tool can read, so adopting MEMO does not mean adopting a vendor.

## The missing semantic layer

Between a general modelling language and a specific device model there is a gap.
SysML v2 gives you `part`, `action`, `requirement`, and `connection`. Your
device model needs `Hazard`, `RiskControlMeasure`, `LogicalComponent`, and
`VerificationCase`. MEMO is that layer, and it supplies three things:

<div class="memo-card-grid" markdown>

<div class="memo-card memo-card-purple" markdown>

### Typed elements

A hazard is a `Hazard`, not a part named "hazard". The type carries the
attributes ISO 14971 expects and the rules that apply to it.

[Elements by layer](../reference/elements/index.md)

</div>

<div class="memo-card memo-card-blue" markdown>

### Typed relationships

A link states its meaning: *mitigates*, *satisfied by*, *verified by*,
*produces evidence*. Each has its own legal endpoints.

[Relationships](../reference/relationships.md)

</div>

<div class="memo-card memo-card-teal" markdown>

### Closure rules

Native SysML constraints that check the argument: an unmitigated hazard, an
unverified risk control, a requirement with no design response.

[Rules](../reference/rules.md)

</div>

</div>

Because all three are expressed in SysML v2 itself, the checks run in any
conformant tool — they are not engine configuration living outside the model.

## Two ideas do most of the work

MEMO's structure follows from two modelling ideas. Everything else is detail.

- **[Scenario-driven modelling](scenario-driven.md)** — behavior is reached
  through the path a real user takes, so hazards attach to situations rather
  than to abstractions.
- **[Function-centered traceability](function-centered.md)** — functions are
  the hub that requirements, risk, architecture, and verification all attach
  to, which is what keeps the argument connected.

## Where to go next

| You want to | Read |
| --- | --- |
| Understand the shape of the whole library | [The mental model](mental-model.md) |
| Know what you actually install | [The four products](products.md) |
| See how the packages are named | [How `memo::` is organised](namespace-map.md) |
| Meet the layers in detail | [Layer Map](../layers/index.md) |
| Build something | [First model tutorial](../tutorials/first-model.md) |
