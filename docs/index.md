<div class="memo-hero" markdown>

<p class="memo-kicker">Medical Engineering Modeling Ontology</p>

# MEMO

A SysML v2 library that supplies a typed vocabulary for medical-device
engineering: the clinical work, the device, its risks, and the evidence used to
review it.

</div>

## What MEMO is

MEMO is an ontology in the engineering sense: a set of definitions that fixes
what the terms of a domain mean and how they may be combined. It supplies the
medical-device vocabulary that SysML v2 deliberately leaves open, so that a
team writes `Hazard`, `RiskControlMeasure`, and `VerificationCase` rather than
inventing an equivalent for each programme.

It is content rather than a tool: plain SysML v2 source text, readable by any
conformant editor, with no runtime of its own.

## The problem it addresses

A medical device is approved on the strength of an argument. This is what the
device is for; this is how it was designed; these are the ways it could cause
harm; this is what was done about them; here is the evidence. The argument is
assembled from requirements specifications, architecture descriptions, risk
files, verification protocols, and test records.

The argument is generally sound when written. The difficulty arises afterwards,
because the design changes and the evidence does not follow it automatically.

Traceability exists in every regulated programme, but it records the
association between artifacts as pairs of identifiers. An identifier
association survives a design change, because nothing within it depends on the
design. It therefore cannot indicate which of the associated records has become
inconsistent. A test remains linked to its requirement whether or not it still
exercises the behaviour the hazard describes.

The consequence is familiar: controls that are named in a risk file but not
anchored to a design feature, threats held apart from the interfaces they
concern, tests that pass without exercising the failure path, and architecture
documents that drift from the implementation. These are usually treated as four
problems. They are one problem observed from four positions — nothing connects
the design to the claims made about it.

[Why MEMO exists, at length](why/index.md)

## What MEMO does about it

MEMO records the argument itself. Elements are typed, so a hazard is a
`Hazard` and carries the attributes ISO 14971 expects of one. Links between
elements are typed as well, so a link states what it asserts rather than merely
connecting two identifiers. Review questions are expressed as constraints
within the library, and are therefore evaluated by a tool rather than by
recollection.

The following thread illustrates the result. It is drawn from the
[GPCA reference model](case-studies/gpca/index.md), a patient-controlled
analgesia pump that must suppress a bolus dose during a lockout interval.

```text
HZ-001    Overdose            drug delivery error · catastrophic
  ↓ identifies
REQ-025   Ignore bolus        SW requirement · source = risk
  ↓ satisfied by
SW-005    Infusion_Manager    responsible · Class C
  ↓ mitigated by
RC-001    Lockout             inherent safe design
  ↓ verified by
VER-002   Verify lockout      test · acceptance criteria
  ↓ produces
EVD-001   Lockout evidence    tied to baseline
```

`REQ-025` records `source = risk` as a typed attribute, so the model itself
represents the fact that the requirement exists in response to a hazard. Given
a change to `HZ-001`, the set of elements requiring re-review is obtained by
traversing these relationships rather than by searching documents.

The same typing allows the constraints to be evaluated:

```text
$ memo validate

CR-MED-001  Hazard must have ≥1 risk control        (ISO 14971)
            Missing mitigation: hazAirInLine

CR-MED-003  Risk control must be verified           (ISO 14971 §7.4)
            Missing verification: rcDoorOpenAlarm

Result: 2 errors · 1 warning · thread HZ-001 closed
```

This identifies gaps in the recorded argument. It does not establish that a
device is safe, and it does not substitute for review. Clinical judgement, risk
acceptance, and approval remain with the personnel responsible for them.

## How a model is organised

A MEMO model is arranged along two axes. The horizontal axis carries the
engineering account of the device and descends through six layers, each
answering one question and constraining the next.

| Layer | Question |
| --- | --- |
| 1. [Context and use](layers/context.md) | Who is involved, where, and what is the device for? |
| 2. [Use cases](layers/use-cases.md) | What are those people trying to achieve? |
| 3. [Workflows and scenarios](layers/operational-world.md) | How is that goal pursued, and how does it fail? |
| 4. [Functional analysis](layers/operations-system.md) | What must the system do on those paths? |
| 5. [Logical architecture](layers/requirements-architecture.md) | Which components hold which responsibilities? |
| 6. [Implementation](layers/requirements-architecture.md) | How is the solution built and deployed? |

The vertical axis carries the disciplines that must be satisfied about the
device: requirements, safety and risk, cybersecurity, human factors, and
verification and validation. These are not a seventh layer. They attach to
elements at every horizontal layer, which is why a hazard can be anchored both
to the scenario in which it arises and to the component whose behaviour
controls it.

Populating every layer is not required. A manual instrument has no software
architecture, and the ontology treats such a model as complete rather than
unfinished.

## Distribution

The library is SysML v2 source text with no runtime and no dependency on a
particular tool. It may be consumed as an npm package, as a KerML project
archive, or from a source checkout. Two further products exist and are
documented separately: [Tools](https://github.com/memoarchitect/memo-tools),
which provides the `memo` command-line interface, and
[Architect](https://github.com/memoarchitect/memo-architect), an optional
visual workbench. Neither is required.

## Organisation of this documentation

| Section | Purpose |
| --- | --- |
| [Tutorials](examples/index.md) | Lessons for readers new to MEMO, and worked examples of existing models |
| [How-to guides](how-to/index.md) | Directions for completing a specific task |
| [Reference](reference/index.md) | Definitions extracted from the library source |
| [Explanation](why/index.md) | The reasoning behind the ontology, and the layers it organises a model into |
| [Case studies](case-studies/index.md) | Complete device models documented per ISO/IEC/IEEE 42010 |

---

`memo::` · open source · SysML v2 · ISO 14971 · IEC 62304 · ISO/IEC/IEEE 42010
