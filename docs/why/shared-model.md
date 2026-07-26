# What a shared model has to provide

The missing layer is a low-cost, versionable, architecture-backed model that
carries engineering meaning across teams. "Low-cost" is part of the
requirement, not a nice-to-have: a model a code-first team will not maintain is
worse than no model, because it becomes another stale artifact to reconcile.

## Six requirements

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

<div class="memo-card memo-card-purple" markdown>

### Ready to start

A team can begin from a usable model structure instead of first inventing its
own ontology, package layout, and review pattern.

</div>

<div class="memo-card memo-card-blue" markdown>

### Able to produce review artifacts

Documents are generated as views of the model, so regulated deliverables do
not become parallel sources of engineering truth.

</div>

</div>

## One shared source of truth

What all six properties are protecting is a single place where meaning,
structure, and rules live together:

- responsibilities — which element is accountable for what;
- interfaces — where the assumptions actually are;
- scenarios — the paths through the work that hazards attach to;
- impact paths — what a change reaches.

When these are in one model, a change is followed rather than remembered.

## The goal

The target is the reasoning power of model-based engineering with the review
habits and low setup cost of a code-first workflow. That is why MEMO expresses
the model as versionable SysML v2 source rather than binding its meaning to one
application.

We compile code. We should be able to compile the safety argument.

[What MEMO is →](../what/index.md)
