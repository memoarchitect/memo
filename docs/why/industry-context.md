# Safety-critical domains lean on architecture

Medical devices are not the first safety-critical industry to face this. Two
others solved a version of it, and both solved it the same way: by making
architecture a first-class part of the safety case, written into the standards
rather than left to team preference.

## How three industries approach it

<div class="memo-card-grid" markdown>

<div class="memo-card memo-card-blue" markdown>

### Aerospace — architecture-led

Architecture and allocation chains tie function, safety analysis, and
verification evidence together. The allocation of a function to an item is the
thing the safety analysis is performed against.

`ARP4754A` · `ARP4761` · `DO-178C`

</div>

<div class="memo-card memo-card-teal" markdown>

### Automotive — platform-led

Platforms and contracts standardise safety mechanisms, interfaces, and reuse
across product lines. Safety requirements are decomposed onto an architecture
that is shared between programmes.

`ISO 26262` · `AUTOSAR` · `ISO 21434`

</div>

<div class="memo-card memo-card-orange" markdown>

### Medical devices — process-led

Strong process, risk management, electrical safety, and cybersecurity
standards. The architecture model that would connect them is the part left
mostly to each manufacturer.

`ISO 14971` · `IEC 62304` · `IEC 62366`

</div>

</div>

## The difference is not rigour

This is not a claim that medical device standards are weaker. ISO 14971 is a
more demanding risk standard than most industries have. IEC 62304 is explicit
about software lifecycle and safety classification. IEC 62366 takes usability
seriously as a safety concern.

The difference is **where the standards put the centre of gravity**. Aerospace
and automotive standards describe an architecture that the other activities
attach to. Medical standards describe activities and records, and leave the
architecture that would connect them under-specified.

The result is that each medical manufacturer invents its own connective
tissue — usually as document conventions and review discipline rather than as a
model. It works, and it does not survive change or scale.

## What MEMO borrows

MEMO takes the architecture-led idea and applies it to the medical standards as
they already are:

- functions are **allocated** to architecture elements, as in aerospace;
- risk controls are anchored to the element that implements them, so an
  ISO 14971 control is a design fact rather than a row in a file;
- verification attaches to the behavior it exercises, not only to requirement
  text.

None of that replaces the standards. It gives them a shared model to attach to.

[Next: why medical architecture stays weak →](architecture-gap.md)
