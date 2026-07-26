<div class="memo-hero" markdown>

<p class="memo-kicker">Medical Engineering Modeling Ontology</p>

# MEMO

A ready-made vocabulary for medical-device models. Instead of inventing new
terms for hazards, requirements, components, and tests on every programme, a
team uses the same definitions — and a SysML validator can check whether the
recorded safety argument is complete and connected.

</div>

## A short story

A nurse sets up an infusion pump. The patient presses a button asking for more
pain relief. The pump refuses, because a lockout timer is still running.

That refusal is a safety feature, and four teams have recorded part of it:

- **Risk** recorded the overdose hazard.
- **Requirements** wrote the six-minute lockout rule.
- **Software** built the component that enforces the rule.
- **V&V** tested the six-minute boundary.

Six months later, a design review changes the lockout from six minutes to ten.
The software is updated.

**What else must be reviewed?**

Everyone's traceability matrix still looks fine. `HZ-001` still points at
`REQ-025`, which still points at the test. Every link resolves. Not one of them
can tell you whether the test still tests the right thing.

That is the problem MEMO exists to fix.

## Why the links don't help

A normal trace link is just two IDs sitting next to each other:

![A conventional trace joins a hazard, requirement, and test with generic related-to links. Every link still resolves after the lockout interval changes.](assets/home-generic-trace.svg)

The link says *these two things are connected*. It doesn't say how, so it can't
notice when the connection stops being true. Change the design and the link
survives unharmed, because nothing in it ever depended on the design.

You see the results everywhere:

- Risk controls named in a risk file, but not attached to anything in the design.
- Threats listed separately from the interfaces they actually threaten.
- Tests that pass without ever exercising the failure they were written for.
- Architecture diagrams that quietly stop matching the code.

These look like four different problems. They're one problem: **nothing joins
the design to the claims made about it.**

## What MEMO does instead

MEMO gives every element a type and every link a meaning:

![A semantic model records that the overdose hazard drives the lockout requirement, the infusion manager satisfies that requirement, the lockout control mitigates the hazard, and verification produces evidence.](assets/home-semantic-thread.svg)

Now the chain says something. `REQ-025` isn't just "related to" the hazard — it
records that it **exists because of** it. So when `HZ-001` changes, you can ask
the model what to re-review, and get an answer instead of a search.

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
