<div class="memo-hero" markdown>

<p class="memo-kicker">Medical Engineering Modeling Ontology</p>

# Make the engineering argument visible

MEMO is a portable SysML v2 library for medical-device engineering. It gives a
team one shared vocabulary for the clinical work, the device, its risks, and
the evidence used to review it — from a reusable forceps to a surgical robot,
without forcing either through the other's layers.

<p class="memo-hero-path"><span>Use case</span><i>→</i><span>Workflow</span><i>→</i><span>Function</span><i>→</i><span>Architecture</span><i>→</i><span>Evidence</span></p>

</div>

## Why an ontology at all

A device file already contains needs, requirements, architecture, risks, and
test results — usually in different tools, written by different disciplines,
connected by memory. When a reviewer asks *"why does this alarm exist?"* or
*"which test covers this critical task?"*, someone reconstructs the answer by
hand. MEMO's premise is that these connections are the engineering argument,
and the argument should be a model: every claim has a type, every connection
is a typed relationship, and every question is answerable by following links
instead of folklore.

![The MEMO ontology map: architecture perspectives, assurance disciplines, and the V of definition and integration](assets/ontology-map.svg)

## What MEMO provides

<div class="memo-card-grid" markdown>

<div class="memo-card memo-card-purple" markdown>

### The operational world, first-class

Stakeholders, users, needs, medical use cases, clinical procedures, workflows,
scenarios, and tasks exist *before* any device is selected — so you can model
the work you are improving, not just the box you are building.

</div>

<div class="memo-card memo-card-blue" markdown>

### Four architecture perspectives

Operational, functional, logical, and implementation are independent
dimensions of one model. Simple devices skip the layers they do not need;
complex devices keep software, hardware, and physical semantics distinct.

</div>

<div class="memo-card memo-card-teal" markdown>

### Assurance woven through every layer

Safety, cybersecurity, human factors, and V&V claim elements without
duplicating them. Typed relationships carry the trace from clinical intent to
postmarket evidence, and conformance rules check the graph.

</div>

</div>

## Choose where to begin

<div class="memo-start-grid" markdown>

<a class="memo-start-card" href="start/mental-model/">
<strong>01 · Understand the model</strong>
<span>Perspectives, dimensions, elements, and relationships in one page.</span>
</a>

<a class="memo-start-card" href="tutorials/first-model/">
<strong>02 · Model one complete slice</strong>
<span>Build a small thread from need to evidence in SysML v2.</span>
</a>

<a class="memo-start-card" href="examples/">
<strong>03 · Learn from the examples</strong>
<span>Fourteen focused models, each answering one modeling question.</span>
</a>

<a class="memo-start-card" href="examples/gpca-walkthrough/">
<strong>04 · Study GPCA end to end</strong>
<span>A complete infusion-pump model built from public research artifacts.</span>
</a>

</div>

## The modeling path

Start small. Model one vertical slice — a use case, the workflow that supports
it, the function that enables the work, and the evidence that closes the claim
— then grow the model only when an engineering question requires another
layer:

`use case → workflow → activity → function → logical → implementation → verification evidence`

This is a reading order, not a mandated lifecycle, and not every product walks
every step: a manual instrument goes from activity straight to physical parts;
a software-only device has no hardware layer at all. The point is that each
change stays connected and reviewable.

!!! note "MEMO complements engineering judgment"
    The ontology helps structure claims and expose gaps. It does not decide
    clinical acceptability, regulatory strategy, or risk acceptability for you.
