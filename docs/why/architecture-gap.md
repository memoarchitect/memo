# Why medical architecture stays weak

The standards ask for architecture, risk, cybersecurity, and verification.
Teams produce all four. What is usually missing is one shared model that all
four activities can use — and the reasons are structural, not a matter of
effort or skill.

## Four forces working against it

| Force | What it looks like in practice |
| --- | --- |
| **Team reality** | Work is sliced across systems, software, risk, cyber, V&V, and quality. Each slice owns its own artifacts and its own tool. |
| **Process gravity** | Evidence is document-heavy by regulation — DHF, specs, risk files, protocols, reports. The document is the deliverable, so the document is what gets maintained. |
| **Product history** | Many products were code-first startups or acquisitions. The architecture lives in the code and in the people who wrote it. |
| **Adoption barrier** | Even with a modelling tool bought and installed, the ontology and the team workflow are still missing. The tool does not tell you what to model. |

## The failure mode this produces

Architecture becomes a picture. It is drawn for a design review, exported to a
document, and approved. It is genuinely useful for that review.

What it cannot do is prove that the documented architecture matches what was
implemented. There is no mechanical relationship between the diagram and the
code, the risk file, or the test suite — so the diagram ages at a different
rate than the thing it describes, and nobody finds out until an audit or an
incident.

That single weakness shows up as four separate symptoms, one per discipline:

| Discipline | Symptom | Because |
| --- | --- | --- |
| **Risk** | Controls float | They are not anchored to design features |
| **Cybersecurity** | Threats sit apart | They are not tied to behavior and interfaces |
| **Verification** | Tests miss behavior | Wrong path, wrong load, wrong assumption |
| **Implementation** | Architecture drifts | Code and architecture documents do not stay aligned |

Teams usually treat these as four problems and staff them separately. They are
one problem seen from four sides: nothing connects the design to the claims
made about it.

## Code-first is fast, until assurance needs architecture

The common alternative is to skip the model and let the implementation be the
architecture. This is a rational choice and it buys real things:

- a fast path to working software, with immediate feedback;
- concrete behavior — the implementation is executable proof that something
  works;
- low ceremony, so a small team moves without heavy process up front;
- visible momentum for product, clinical, and leadership stakeholders.

Then the assurance question arrives: *it works, but is it safe, and how do you
show that?* Answering it requires exactly what was skipped — a statement of
what the system is supposed to do, which element is responsible, which hazards
were considered, and what evidence closes each one.

Medical devices are cyber-physical systems. Safety depends on software,
hardware, interfaces, timing, sensors, actuators, and the impact of change.
Code is necessary and it is not sufficient as the primary architecture
artifact, because code does not record intent, hazard reasoning, or the
argument that connects them.

## The conclusion

The gap is not a missing document type and not a missing diagram. What is
missing is **a shared ontology and a low-cost architecture model** that
connects design behavior, implementation, risk, cybersecurity, V&V, and
evidence — and that is cheap enough for a code-first team to keep current.

[Next: what a shared model has to provide →](shared-model.md)
