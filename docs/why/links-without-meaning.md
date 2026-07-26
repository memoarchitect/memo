# The artifacts are linked, but the links lack meaning

Most regulated programmes already have traceability. Requirements trace to
tests, hazards trace to controls, controls trace to requirements. The matrices
exist and they are maintained.

The problem is what the links say. They stop at identifiers.

## What an identifier link does not tell you

`SW-REQ-104 → TC-221` records that a requirement and a test case are related.
It does not record:

- **which claim** the test supports — that this requirement is met, or that a
  specific hazard is controlled, or both;
- **which design element** implements the behavior being verified;
- **under what conditions** the test exercised it — which mode, which
  configuration, which clinical context.

So when the design changes, the matrix still resolves. Every identifier still
points at something. Nothing in it is able to say that the link no longer means
what it meant when it was written.

## Three islands, one missing middle

In practice the artifacts settle into islands, each internally consistent and
externally vague:

| Island | What it holds | What the link to the design is missing |
| --- | --- | --- |
| Requirements | User needs, system requirements, software requirements | Traced to tests, but the link does not carry the safety claim it supports |
| Risk | Hazards, hazardous situations, risk controls | Controls are named in a risk file, not anchored to the element that implements them |
| Verification | Protocols, test cases, reports | Linked to a requirement, not to the behavior or design element it verifies |

The gap between them is always the same gap: **the architecture**. Each island
references the design informally — by name, in prose, in a diagram pasted into
a document — and formally not at all.

## Typed links close the gap

A typed link states its own meaning, so the model can be queried and checked:

- a risk control **mitigates** a hazard;
- a requirement is **satisfied by** a design element;
- a design element is **verified by** a verification case;
- a verification case **produces evidence**.

Each of these is a different fact with different rules. `mitigates` and
`satisfied by` are not interchangeable, and a tool that knows the difference
can tell you when one is missing. That is what MEMO's
[relationships](../reference/relationships.md) are for.

[Next: safety-critical domains lean on architecture →](industry-context.md)
