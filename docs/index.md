<div class="memo-hero" markdown>

<p class="memo-kicker">Medical Engineering Modeling Ontology</p>

# MEMO

A SysML v2 library that supplies a typed vocabulary for medical-device
engineering: the clinical work, the device, its risks, and the evidence used to
review it.

</div>

## Scope

MEMO is an ontology in the engineering sense: a set of definitions that fixes
what the terms of a domain mean and how they may be combined. It provides three
things.

First, **element definitions**. A hazard is declared as a `Hazard`, a risk
control as a `RiskControlMeasure`, a software item as a `SoftwareComponent`.
Each definition carries the attributes its governing standard expects — a
`Risk`, for instance, holds `probabilityEstimate`, `severityEstimate`,
`riskLevel`, and `acceptability`, typed against closed value sets rather than
free text.

Second, **relationship definitions**. Links between elements are themselves
typed, and their ends are constrained. `Mitigates` connects a control to a
hazard; `SatisfiedBy` connects a requirement to a design element; `VerifiedBy`
connects an element to a verification case. Because each link states what it
asserts, the assertion can be examined by a tool rather than inferred by a
reader.

Third, **constraint definitions**. Questions asked during design review —
whether every hazard has a control, whether every control is verified — are
expressed as native SysML v2 constraints within the library, and are therefore
evaluated by any conformant tool.

## Rationale

A device's safety argument is distributed across requirements specifications,
architecture descriptions, risk files, verification protocols, and test
records. Conventional traceability records the association between these
artifacts as pairs of identifiers. An identifier association is preserved when
the design changes, because nothing in it depends on the design; consequently
it cannot indicate which of the associated records has become inconsistent.

The following thread illustrates the alternative. It is taken from the
[GPCA reference model](case-studies/gpca/index.md), in which a patient-
controlled analgesia pump must suppress a bolus dose during a lockout interval.

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

Each node is an instance of a defined type and each edge is an instance of a
defined relationship. `REQ-025` records `source = risk` as a typed attribute,
so the model itself represents the fact that the requirement exists in response
to a hazard. Given a change to `HZ-001`, the set of elements requiring
re-review is obtained by traversing these relationships.

The same typing allows the constraints to be evaluated:

```text
$ memo validate

CR-MED-001  Hazard must have ≥1 risk control        (ISO 14971)
            Missing mitigation: hazAirInLine

CR-MED-003  Risk control must be verified           (ISO 14971 §7.4)
            Missing verification: rcDoorOpenAlarm

Result: 2 errors · 1 warning · thread HZ-001 closed
```

This procedure identifies gaps in the recorded argument. It does not establish
that a device is safe, and it does not substitute for review. Clinical
judgement, risk acceptance, and approval remain with the personnel responsible
for them.

## Distribution

The library is SysML v2 source text. It has no runtime and depends on no
particular tool, and can be consumed as an npm package, as a KerML project
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
