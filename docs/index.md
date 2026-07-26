<div class="memo-hero" markdown>

<p class="memo-kicker">Medical Engineering Modeling Ontology</p>

# MEMO

MEMO is a SysML v2-native ontology for medical-device engineering. It connects
clinical intent, behavior, architecture, requirements, risk controls,
verification, and evidence in one semantic model — and defines the rules that
make those connections checkable.

</div>

## The problem: assurance is split across artifacts

A medical device is reviewed through many different artifacts:

- **Clinical and systems engineering** describe the intended use and behavior.
- **Architecture teams** describe the functions, components, and interfaces.
- **Risk and cybersecurity** identify hazards, threats, and controls.
- **Verification** produces tests, results, and evidence.

Those artifacts may be traced, but most trace links say only that two IDs are
related. They do not record the engineering claim: which behavior creates the
risk, which design element implements the control, or which conditions the test
actually exercised.

![A conventional trace joins a hazard, requirement, and test with generic related-to links. Every link still resolves after the lockout interval changes.](assets/home-generic-trace.svg)

When the design changes, every link can still resolve while the evidence behind
it has become stale. That is why risk controls float away from the design,
tests miss changed behavior, and architecture descriptions drift from the
implementation.

## What MEMO contributes

SysML v2 supplies the modeling language. MEMO specializes it with the medical
engineering meaning needed to build and review a safety argument.

<div class="memo-card-grid" markdown>

<div class="memo-card memo-card-purple" markdown>

### Domain model

First-class concepts for clinical use, medical products, requirements, risks,
controls, architecture, verification, and evidence.

</div>

<div class="memo-card memo-card-blue" markdown>

### Architecture structure

Layers that carry a device from context and scenarios through functions,
logical architecture, and implementation.

</div>

<div class="memo-card memo-card-teal" markdown>

### Semantic relationships

Directed, typed claims with legal ends: a requirement is satisfied by a design
element; a control mitigates a risk; a verification case produces evidence.

</div>

<div class="memo-card memo-card-orange" markdown>

### Closure rules

Model constraints for review questions such as whether every hazard is
controlled and every control is verified.

</div>

</div>

MEMO is therefore more than a vocabulary. It is an importable model library:
domain definitions, architecture structure, relationship semantics, and
computable rules packaged together as SysML v2 source.

## One connected assurance model

![A semantic model records that the overdose hazard drives the lockout requirement, the infusion manager satisfies that requirement, the lockout control mitigates the hazard, and verification produces evidence.](assets/home-semantic-thread.svg)

Here the links carry claims. The requirement exists because of a known hazard;
the component satisfies that requirement; the control mitigates the hazard;
and the verification result belongs to a specific evidence baseline. A change
can therefore follow the model's meaning instead of stopping at a list of IDs.

The library also carries rules that a tool can check:

```text
CR-MED-001  Hazard must have ≥1 risk control        (ISO 14971)
            Missing mitigation: hazAirInLine

CR-MED-003  Risk control must be verified           (ISO 14971 §7.4)
            Missing verification: rcDoorOpenAlarm

Result: 2 errors · 1 warning · thread HZ-001 closed
```

That lets gaps surface before a design review instead of being discovered in it.

!!! warning "What this does not do"

    It finds holes in what you wrote down. It does not decide whether the
    device is safe, and it does not replace review. Those judgements stay with
    the people qualified to make them.

## How a model is built up

You describe the device in six steps, each one answering a question and setting
up the next:

| | Step | The question |
| --- | --- | --- |
| 1 | [Context and use](layers/context.md) | Who's involved, where, and what's the device for? |
| 2 | [Use cases](layers/use-cases.md) | What are they trying to achieve? |
| 3 | [Workflows and scenarios](layers/operational-world.md) | How does that go — and how does it go wrong? |
| 4 | [Functional analysis](layers/operations-system.md) | What must the system do? |
| 5 | [Logical architecture](layers/requirements-architecture.md) | Which component is responsible? |
| 6 | [Implementation](layers/requirements-architecture.md) | How is it actually built? |

Risk, cybersecurity, requirements, human factors and V&V aren't a seventh step.
They hook into all six, which is how a hazard can point at both the exact
scenario where it happens and the component that controls it.

You don't have to fill in every step. A manual surgical instrument has no
software architecture, and that's a finished model, not a half-done one.

## Getting it

MEMO is distributed as SysML v2 source text and has no runtime of its own.
Install it [with npm](how-to/install/npm.md),
[as a .kpar archive](how-to/install/kpar.md), or
[from a checkout](how-to/install/source.md).

## Where to go next

| If you want to | Go to |
| --- | --- |
| Build something and learn by doing | [Tutorials](examples/index.md) |
| Get a specific job done | [How-to guides](how-to/index.md) |
| Look up a type, attribute or rule | [Reference](reference/index.md) |
| Understand why it's built this way | [Explanation](why/index.md) |
| Read a complete device model | [GPCA case study](case-studies/gpca/index.md) |

---

`memo::` · open source · SysML v2 · ISO 14971 · IEC 62304 · ISO/IEC/IEEE 42010
