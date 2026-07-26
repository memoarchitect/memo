# The artifacts are linked, but the links lack meaning

Every regulated programme has traceability. Requirements trace to tests,
hazards to controls, controls to requirements. The matrices exist, they are
reviewed, and they are maintained.

The problem is not their existence. It is what they claim.

## Three islands and one missing middle

Specialised teams and a document-heavy process produce three artifact islands.
Each is internally consistent. Each references the design informally — by name,
in prose, in a diagram pasted into a document — and formally not at all.

| Island | The link it records | The gap |
| --- | --- | --- |
| **Requirements** | Traced to tests | The link does not carry the safety claim it is meant to support |
| **Risk** | Hazards and controls in a risk file | The control is named, but not anchored to the design feature that implements it |
| **Verification** | Test linked to requirement | The test is linked to a requirement, not to the behavior or design element it verifies |

The middle they are all missing is the same one: **the architecture**.

## What this costs, concretely

Consider a test that passes. Three different things could be true, and the
matrix cannot distinguish them:

- The test exercised the failure path the hazard describes, under the load and
  the mode where the hazard occurs. The evidence is real.
- The test exercised the nominal path. It passes, and it says nothing about the
  hazard.
- The test exercised a path that existed two design revisions ago. It passes
  against an implementation that has since changed.

An identifier link reports all three as "verified". This is the *wrong path,
wrong load, wrong assumption* failure, and it is invisible by construction —
which is why it survives review.

## Typed links state their claim

A typed link is a different kind of record. It names what it asserts, and its
ends constrain what may legally sit on either side:

| Link | Asserts |
| --- | --- |
| `Mitigates` | This risk control reduces this hazard |
| `SatisfiedBy` | This requirement is satisfied by this design element |
| `AllocatedTo` | This function is the responsibility of this component |
| `VerifiedBy` | This element is checked by this verification case |
| `ProducesEvidence` | This verification case produced this record |

`Mitigates` and `SatisfiedBy` are not interchangeable. They have different
legal endpoints and different rules, so a tool can report a hazard with no
`Mitigates` reaching it, or a control with no `VerifiedBy`. That is the whole
difference: **a claim that a machine can check.**

See [one closed thread](../what/closed-thread.md) for the same six links
carrying a real scenario, and the validator output when one of them is missing.

[Next: safety-critical domains lean on architecture →](industry-context.md)
