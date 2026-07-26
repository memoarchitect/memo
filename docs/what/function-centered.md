# Function-centered traceability

Once a scenario tells you *what has to happen*, the functions on that path
become the hub of the whole argument. Requirements motivate them, risk
classifies them, architecture implements them, and verification exercises
them — so the function is where four disciplines meet on one element.

![Function-centered traceability: needs, requirements, and risks constrain functions; functions allocate to logical architecture and realization; FMEA identifies hazards; tests verify implemented units](../assets/function-centered-traceability.png)

## Read the arrows as meanings, not as a sequence

This is the part that is easy to get wrong. The picture looks like a waterfall
from "risk" to "test". It is not. Each arrow is a different typed relationship,
and several of them point backwards:

| Relationship | Reads as |
| --- | --- |
| `Motivates` | A need or use case motivates a function's existence |
| `SatisfiedBy` | A requirement is satisfied by a design element |
| `AllocatedTo` | A function is allocated to a logical or physical element |
| `AnalyzedBy` | A function is analyzed by an FMEA or fault tree |
| `IdentifiesHazard` | An analysis identifies a hazard |
| `Mitigates` | A risk control mitigates a hazard |
| `VerifiedBy` | An element is verified by a verification case |
| `ProducesEvidence` | A verification case produces evidence |

A hazard found during analysis can create a **new requirement** at any time. A
failed verification can send you back to the **design**. The model is a
connected argument that you traverse in whichever direction the question runs,
not a phase order you march through.

## The four questions it answers

Because the function is the hub, a reviewer can start anywhere and arrive
somewhere useful:

- *Why does this function exist?* → follow `Motivates` back to a use case or
  need.
- *Which part is responsible for it?* → follow `AllocatedTo` forward into the
  logical and physical architecture.
- *What could go wrong with it?* → follow `AnalyzedBy` into the safety analysis
  and on to hazards and controls.
- *How do we know it works?* → follow `VerifiedBy` to the verification case and
  `ProducesEvidence` to the record.

Those four traversals are the reason the ontology is typed. An identifier-only
matrix can answer none of them.

## Impact analysis falls out of it

The practical payoff is change. When a function changes, the elements that
depend on it are reachable: the requirements that motivate it, the components
it is allocated to, the hazards its failure modes identify, the controls that
mitigate them, and the verification cases that would need to be re-run.

That set is computed from the model rather than reconstructed from memory,
which is the difference between an argument that survives change and one that
drifts.

## In the model

| Concept | MEMO type | Package |
| --- | --- | --- |
| Function | `SystemFunction`, `SystemAction` | `architecture/functions` |
| Functional flow | `FunctionalFlow`, `FunctionalFlowStep` | `architecture/functions` |
| Logical element | `LogicalComponent`, `LogicalInterface` | `architecture/logical_structure` |
| Safety analysis | `FMEAWorksheet`, `FaultTree`, `FailureMode` | `assurance/safety_analysis` |
| Verification | `VerificationCase`, `Evidence` | `assurance/verification` |

See [Functional Analysis](../layers/operations-system.md) for the full
treatment and [Relationships](../reference/relationships.md) for every link
type and its legal endpoints.
