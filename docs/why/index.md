# Why MEMO

A medical device is approved on the strength of an argument: this is what the
device is for, this is how it was designed, these are the ways it could harm
someone, this is what we did about them, and here is the evidence. The argument
is assembled from requirements, architecture descriptions, risk files,
verification protocols, and test records.

That argument is usually correct on the day it is written. The problem is what
happens next.

## The problem in one paragraph

Design changes. Evidence does not follow it automatically. The links between
the documents are recorded as identifiers, not as meaning, so nothing in the
process can tell you which parts of the safety argument a design change just
invalidated. Teams compensate with review effort, spreadsheets, and
institutional memory — and the argument still drifts.

## Five things that make this hard

<div class="memo-card-grid" markdown>

<div class="memo-card memo-card-purple" markdown>

### Devices got complex

Connected, configurable, software-defined systems. Safety now depends on how
the whole system behaves, not on any single requirement.

[Read more](evidence-drift.md)

</div>

<div class="memo-card memo-card-blue" markdown>

### Links carry no meaning

A requirement is "traced to" a test. The link does not say what claim the test
supports, or which design element implements the control.

[Read more](links-without-meaning.md)

</div>

<div class="memo-card memo-card-teal" markdown>

### Other domains lean on architecture

Aerospace and automotive write architecture into their standards as the
backbone of the safety case. Medical has strong standards, less architecture.

[Read more](industry-context.md)

</div>

<div class="memo-card memo-card-orange" markdown>

### Architecture becomes a picture

Useful for review, weak at proving that the documented architecture matches
what was implemented.

[Read more](architecture-gap.md)

</div>

</div>

The fifth is the conclusion the others lead to: what is missing is not another
document format or another traceability matrix, but **one shared model** that
every discipline can use and a machine can check.

[What a shared model has to provide →](shared-model.md)

## What MEMO does about it

MEMO makes the argument itself the artifact. Each real thing — a hazard, a
requirement, a component, a test — is recorded once, with a type. Each link
between them carries a specific meaning: *mitigates*, *satisfied by*,
*verified by*, *produces evidence*. Because the types and the links are
computable, the questions a reviewer asks can be answered by the model rather
than by a person's memory of it.

That is the whole idea. [What MEMO is →](../what/index.md)
