# One closed thread

The ontology becomes concrete when one engineering concern is followed from
clinical intent to evidence. This infusion-pump lockout thread is small enough
to read in a minute and complete enough to show how the layers connect.

## The scenario in plain language

A patient presses the dose button for pain relief. The pump may deliver one
extra dose — a **bolus** — but only if the lockout timer says enough time has
passed. Otherwise the pump must block the dose, to prevent overdose.

That is the whole clinical situation. Everything below is that sentence,
recorded as typed model elements.

## The thread

| Step | Element | What it holds |
| --- | --- | --- |
| Use case / need | `needSafeTherapy` | The clinical intent: patient-controlled therapy stays safe in normal use and in fault handling |
| Requirement | `reqLockout` | A typed obligation derived from the safety scenario, carrying its class and its source |
| Architecture | `infusionMgr` | The software item responsible for implementing it |
| Behavior | lockout prevents bolus | The mode and guard that must hold when the scenario executes |
| Risk control | prevent overdose during lockout | The ISO 14971 control that reduces the hazardous situation |
| Verification | `vcLockout` | The case and acceptance criteria that check the control under this scenario |
| Evidence | `evidenceLockout` | The test result, tied to the reviewed baseline |
| Document view | `rmfView` | The generated risk-management view produced from the same thread |

Each step is a typed element, and each arrow between them is a typed
relationship carrying a status and the meaning between its two ends.

## The same thread with real identifiers

In the GPCA model the thread is populated and addressable:

```text
HZ-001    Overdose            drug delivery error · catastrophic
  ↓
REQ-025   Ignore bolus        SW requirement · source = risk
  ↓
SW-005    Infusion_Manager    responsible · Class C
  ↓
RC-001    Lockout             inherent safe design
  ↓
VER-002   Verify lockout      test · acceptance criteria
  ↓
EVD-001   Lockout evidence    tied to baseline
```

**Each row of a traceability table becomes an object you can inspect and
query.** The risk management file view, the V&V matrix, and change-impact
analysis all read this one thread rather than maintaining three parallel copies
of it.

Note what `REQ-025` carries: `source = risk`. The requirement records *why it
exists* as typed data. That is the difference between a matrix that says
`HZ-001 → REQ-025` and a model that can answer "which requirements exist only
because of a hazard, and would need re-review if that hazard's severity
changed?"

## Compiling the argument

We compile code. We should be able to compile the safety argument.

Because the elements and links are typed, review questions become executable
checks. Running the rules over an incomplete model produces this:

```text
$ memo validate

CR-MED-001  Hazard must have ≥1 risk control              (ISO 14971)
            Missing mitigation: hazAirInLine

CR-MED-003  Risk control must be verified                 (ISO 14971 §7.4)
            Missing verification: rcDoorOpenAlarm

CR-MED-004  Pre-mitigation risk must be assessed
            against a risk matrix                         (ISO 14971)

Result: 2 errors · 1 warning · thread HZ-001 closed
```

Four things follow from that output:

- Gaps surface early enough for correction ahead of design review or audit.
- Closure is visible to software, systems, risk, and V&V at the same time,
  from the same run.
- The rules run in CI, before merge or release — compliance becomes a build
  step.
- Each change produces a defined set of elements to re-check.

!!! note "What validation establishes"

    Validation establishes structural completeness against the encoded rules
    and makes review gaps visible to engineering, safety, and V&V. Qualified
    people retain responsibility for clinical judgement, risk acceptance, and
    approval decisions.

## Why this thread works

The thread holds together because every step is typed and every link states
what it claims. Change the lockout interval and the model can tell you that
`REQ-025` derives from `HZ-001`, that `SW-005` is responsible, and that
`VER-002` must be re-run before `EVD-001` is valid again.

That is the whole argument for MEMO, in one scenario.

## Next

- [Adopting MEMO](../how-to/adopt.md) — start with one thread like this one
- [GPCA Pump case study](../case-studies/gpca/index.md) — the complete model this thread comes from
- [Relationships](../reference/relationships.md) — every link type and its legal ends
