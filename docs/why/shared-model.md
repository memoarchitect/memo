# What a shared model has to provide

The missing layer is a low-cost, versionable, architecture-backed model that
carries engineering meaning across teams. "Low-cost" is part of the
requirement, not a nice-to-have: a model a code-first team will not maintain is
worse than no model, because it becomes another stale artifact to reconcile.

## Six properties

<div class="memo-card-grid" markdown>

<div class="memo-card memo-card-purple" markdown>

### Text-first

Diffable, reviewable, versioned. It lives in the repository beside the code and
goes through the same review as the code.

</div>

<div class="memo-card memo-card-blue" markdown>

### Architecture-backed

Risk, requirements, behavior, and evidence all attach to the same architecture
elements, so they can be reasoned about together.

</div>

<div class="memo-card memo-card-teal" markdown>

### Typed and checkable

A compiler-style pass reports warnings, errors, and closure gaps — an
unmitigated hazard, an unverified control, a requirement with no design.

</div>

<div class="memo-card memo-card-orange" markdown>

### Viewpoint-driven

Risk, architecture, DHF, and cybersecurity readers each get a view of the same
model rather than a separate document to keep in sync.

</div>

</div>

Two more that matter as much:

- **A starter scaffold.** A shared vocabulary is only useful if a team can
  begin without designing one. The model has to ship with a usable default.
- **Document export.** Regulated review consumes documents. The model has to
  generate them, so the document becomes a rendering of the model rather than a
  parallel copy of it.

## One shared source of truth

What all six properties are protecting is a single place where meaning,
structure, and rules live together:

- responsibilities — which element is accountable for what;
- interfaces — where the assumptions actually are;
- scenarios — the paths through the work that hazards attach to;
- impact paths — what a change reaches.

When these are in one model, a change is followed rather than remembered.

## The goal

MBSE's benefits with code-first adoption cost and lower setup friction. That is
the target MEMO is built against, and it is why MEMO is a **library and a
methodology** rather than a tool you have to buy: the model is plain SysML v2
text that any conformant tool can read.

We compile code. We should be able to compile the safety argument.

[What MEMO is →](../what/index.md)
