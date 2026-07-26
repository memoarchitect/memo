<div class="memo-hero" markdown>

<p class="memo-kicker">Medical Engineering Modeling Ontology</p>

# Make the engineering argument visible

MEMO is a portable SysML v2 library for medical-device engineering. It gives a
team one shared vocabulary for the clinical work, the device, its risks, and
the evidence used to review it — from a reusable forceps to a surgical robot,
without forcing either through the other's layers.

<p class="memo-hero-path"><span>Use case</span><i>→</i><span>Workflow</span><i>→</i><span>Scenarios</span><i>→</i><span>Functions</span><i>→</i><span>Architecture</span><i>→</i><span>Evidence</span></p>

</div>

## Start here

<div class="memo-card-grid" markdown>

<div class="memo-card memo-card-purple" markdown>

### Why MEMO

Safety evidence drifts as the design changes, and identifier-only traceability
cannot tell you what a change invalidated.

[Read the problem →](why/index.md)

</div>

<div class="memo-card memo-card-blue" markdown>

### What is MEMO

A typed semantic layer over SysML v2: typed elements, typed relationships, and
closure rules that a tool can check.

[Read the overview →](what/index.md)

</div>

<div class="memo-card memo-card-teal" markdown>

### Build something

Install the library and model one complete thread — a temperature alarm from
clinical need to verification evidence.

[Start the tutorial →](tutorials/first-model.md)

</div>

<div class="memo-card memo-card-orange" markdown>

### See a whole device

The GPCA infusion pump: a complete model documented as an ISO/IEC/IEEE 42010
architecture description.

[Open the case study →](case-studies/gpca/index.md)

</div>

</div>

## The idea in four links

One device is described in several places: intended use, requirements,
architecture, risk analysis, and test records. The same alarm appears in all of
them. When each record is separate, a change leaves one of them out of date —
and nothing tells you which.

MEMO keeps one record for each real thing and gives each link a specific
meaning:

- a need **motivates** a use case;
- a requirement is **satisfied by** a design element;
- a risk control **mitigates** a hazard;
- a verification case **produces evidence**.

That is enough for a reviewer to ask the model directly: *Why does this
requirement exist? Which part is responsible? Which hazard does it affect?
Which test supports it?* When something changes, the same links find what must
be reviewed.

The model supports that check. The engineering team still makes the clinical,
risk-acceptance, and approval decisions.

## Where things are

| Section | Use it when |
| --- | --- |
| [Why MEMO](why/index.md) | You are deciding whether this problem is your problem |
| [What is MEMO](what/index.md) | You want the shape of the thing before the detail |
| [Concepts](layers/index.md) | You are learning the layers and what belongs in each |
| [Tutorials](examples/index.md) | You learn by building |
| [How-to guides](how-to/index.md) | You know the concepts and need to get a task done |
| [Reference](reference/index.md) | You need the exact type, supertype, or attribute |
| [Case studies](case-studies/index.md) | You want to interrogate a complete device model |

---

`memo::` · open source · SysML v2 · ISO 14971 · IEC 62304 · ISO/IEC/IEEE 42010
