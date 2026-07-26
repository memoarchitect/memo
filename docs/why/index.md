# Why MEMO

A medical device is approved on the strength of an argument: this is what the
device is for, this is how it was designed, these are the ways it could harm
someone, this is what we did about them, here is the evidence. The argument is
assembled from requirements, architecture descriptions, risk files,
verification protocols, and test records.

That argument is usually correct on the day it is written. The problem is what
happens next.

## The problem

Design changes. Evidence does not follow it automatically.

The documents are traced — every programme has a traceability matrix — but the
links stop at identifiers. `SW-REQ-104 → TC-221` records that a requirement and
a test are related. It does not record which claim the test supports, which
design element implements the control, or which conditions the test actually
exercised.

So after a change, the matrix still resolves. Every identifier still points at
something. Nothing in it can say that the link no longer means what it meant
when it was written.

**The problem is not too few documents. It is that the links cannot be
checked.**

## Why it is hard to fix

Four forces hold the current situation in place, and none of them is
carelessness:

| | |
| --- | --- |
| **Devices got complex** | Connected, configurable, software-defined systems. Safety depends on how the whole system behaves, not on any single requirement text. [More →](evidence-drift.md) |
| **The links carry no meaning** | Requirements, risk, and verification each form an island that references the design informally and formally not at all. [More →](links-without-meaning.md) |
| **Medical standards are process-led** | Aerospace and automotive write architecture into their standards as the backbone of the safety case. Medical describes activities and records instead. [More →](industry-context.md) |
| **Architecture becomes a picture** | Drawn for a review, exported to a document, approved — and unable to prove that what was documented is what was built. [More →](architecture-gap.md) |

What all four produce is the same failure, stated four ways: controls float
free of design features, threats sit apart from behavior and interfaces, tests
miss the behavior they were meant to exercise, and the architecture drifts away
from the code.

## What is missing

Not another document format, and not another matrix. What is missing is a
shared ontology and a low-cost architecture model that connects design
behavior, implementation, risk, cybersecurity, V&V, and evidence — cheap enough
that a code-first team will keep it current.

[What a shared model has to provide →](shared-model.md)

## What MEMO does about it

MEMO makes the argument itself the artifact. Each real thing is recorded once,
with a type. Each link carries a specific meaning: *mitigates*, *satisfied by*,
*verified by*, *produces evidence*. Because both are computable, the questions
a reviewer asks are answered by the model rather than by someone's memory of
it — and the checks can run in CI.

[What MEMO is →](../what/index.md) · [See one thread end to end →](../what/closed-thread.md)
