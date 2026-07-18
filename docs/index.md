<div class="memo-hero" markdown>

<p class="memo-kicker">Medical Engineering Modeling Ontology</p>

# Make the engineering argument visible

MEMO is a portable SysML v2 library for medical-device engineering. It gives a
team a shared vocabulary for the device, its context, its risks, and the
evidence used to review it.

<p class="memo-hero-path"><span>Need</span><i>→</i><span>Requirement</span><i>→</i><span>Design</span><i>→</i><span>Risk control</span><i>→</i><span>Evidence</span></p>

</div>

## What MEMO provides

<div class="memo-card-grid" markdown>

<div class="memo-card memo-card-teal" markdown>

### A shared vocabulary

Element kinds make the difference between a need, a requirement, a function,
a hazard, a control, and evidence explicit.

</div>

<div class="memo-card memo-card-blue" markdown>

### Reviewable relationships

Typed links record why one engineering claim leads to another, so a reviewer
can follow a trace instead of reconstructing intent from files.

</div>

<div class="memo-card memo-card-purple" markdown>

### A modeling method

Layers, viewpoints, patterns, and workflow gates help a team choose the next
useful slice of the model without creating a second source of truth.

</div>

</div>

## Choose where to begin

<div class="memo-start-grid" markdown>

<a class="memo-start-card" href="start/mental-model/">
<strong>01 · Understand the model</strong>
<span>Learn how layers, elements, and relationships work together.</span>
</a>

<a class="memo-start-card" href="start/first-model/">
<strong>02 · Model one complete slice</strong>
<span>Build a small thread from need to evidence in SysML v2.</span>
</a>

<a class="memo-start-card" href="layers/">
<strong>03 · Place existing material</strong>
<span>Map requirements, risks, architecture, and tests to their right home.</span>
</a>

<a class="memo-start-card" href="examples/gpca-walkthrough/">
<strong>04 · Learn from GPCA</strong>
<span>Follow a real example across the connected layers.</span>
</a>

</div>

## The modeling path

Start small. Use the first-model tutorial to create one connected slice, then
grow it only when the engineering question requires another layer:

`context → need → requirement → design response → risk/control → verification evidence`

This is a reading and modeling order, not a mandated lifecycle. A risk review
may lead you back to the requirement; an implementation decision may expose a
new need for evidence. The point is that each change stays connected and
reviewable.

!!! note "MEMO complements engineering judgment"
    The ontology helps structure claims and expose gaps. It does not decide
    clinical acceptability, regulatory strategy, or risk acceptability for you.
