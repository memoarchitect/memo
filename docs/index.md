<div class="memo-hero" markdown>

<p class="memo-kicker">Medical Engineering Modeling Ontology</p>

# Make the engineering argument visible

MEMO is a portable SysML v2 library for medical-device engineering. It gives a
team one shared vocabulary for the clinical work, the device, its risks, and
the evidence used to review it — from a reusable forceps to a surgical robot,
without forcing either through the other's layers.

<p class="memo-hero-path"><span>Use case</span><i>→</i><span>Workflow</span><i>→</i><span>Scenarios</span><i>→</i><span>Functions</span><i>→</i><span>Architecture</span><i>→</i><span>Evidence</span></p>

</div>

## Start with something that can go wrong

A patient presses the dose button on an infusion pump for pain relief. The pump
may deliver one extra dose — a bolus — but only if the lockout timer says
enough time has passed. Otherwise it must block the dose, or the patient is
overdosed.

Every discipline in the building has a record of that situation. Risk has a
hazard. Requirements has an obligation. Architecture has a component. V&V has a
test. Each record is real, each is reviewed, and each lives in a different
document.

Now change the lockout interval. **Which of those records is now wrong?**

Traceability answers by identifier: `HZ-001` relates to `REQ-025`, which
relates to `TC-221`. Every pointer still resolves. None of them can tell you
whether the test still exercises the behavior the hazard describes.

## MEMO records the same situation as one thread

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

Each node is typed. Each arrow is a typed relationship that states a claim —
not a pointer that happens to connect two identifiers. `REQ-025` records
`source = risk`, so the model itself knows that requirement exists *because of*
a hazard.

That is enough to ask the question directly: change `HZ-001`, and the model
returns the requirement, the component, the control, the test, and the evidence
that must be re-reviewed.

## And enough to check it mechanically

Because the rules are part of the model, review questions execute:

```text
$ memo validate

CR-MED-001  Hazard must have ≥1 risk control        (ISO 14971)
            Missing mitigation: hazAirInLine

CR-MED-003  Risk control must be verified           (ISO 14971 §7.4)
            Missing verification: rcDoorOpenAlarm

Result: 2 errors · 1 warning · thread HZ-001 closed
```

Gaps surface before the design review, not during it. The rules run in CI, so
compliance becomes a build step.

This does not prove the device is safe and it does not replace review. It makes
review gaps visible early enough for engineers, safety, and V&V to act on them.
The clinical, risk-acceptance, and approval decisions stay with the people
qualified to make them.

## What MEMO actually is

A SysML v2 library — typed elements, typed relationships, and closure rules for
medical-device engineering. It is content, not a tool: plain SysML v2 text that
any conformant editor can read, so adopting it does not mean adopting a vendor.

<div class="memo-card-grid" markdown>

<div class="memo-card memo-card-purple" markdown>

### Why this problem is hard

Four forces keep safety evidence drifting, and none of them is carelessness.

[Read the problem →](why/index.md)

</div>

<div class="memo-card memo-card-blue" markdown>

### How the library is built

Typed elements, typed links, closure rules — and the two modelling ideas the
whole structure follows from.

[Read the overview →](what/index.md)

</div>

<div class="memo-card memo-card-teal" markdown>

### Build one yourself

A temperature alarm, from clinical need to verification evidence, in about
twenty minutes.

[Start the tutorial →](tutorials/first-model.md)

</div>

<div class="memo-card memo-card-orange" markdown>

### See a whole device

The GPCA pump — the model the thread above comes from — documented as an
ISO/IEC/IEEE 42010 architecture description.

[Open the case study →](case-studies/gpca/index.md)

</div>

</div>

---

`memo::` · open source · SysML v2 · ISO 14971 · IEC 62304 · ISO/IEC/IEEE 42010
