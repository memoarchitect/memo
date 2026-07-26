# Case Studies

A case study is a **complete** MEMO model of one device, documented the way
ISO/IEC/IEEE 42010 asks an architecture description to be documented: by
naming the stakeholders, the concerns they hold, the viewpoints that frame
those concerns, and the views that conform to them.

This is deliberately different from the [tutorials](../examples/index.md).
A tutorial teaches one modelling move on a small model. A case study is a
whole device you can interrogate: pick a review question, find the viewpoint
that frames it, open the views governed by that viewpoint, and follow the
typed links back into the catalog.

## Available case studies

| Case study | Device | Coverage | Model |
|---|---|---|---|
| [GPCA Pump](gpca/index.md) | Generic Patient-Controlled Analgesia infusion pump | Complete — every layer populated | [`examples/gpca-pump`](https://github.com/memoarchitect/memo/tree/main/examples/gpca-pump) |

GPCA is the reference model. It is not a partial teaching example: the model is
populated across operational, functional, logical, and implementation layers
and across every assurance discipline, which is what makes it usable as a
conformance target for your own model.

## How a case study is organised

Every case study uses the same four pages, in 42010's own order. The standard
is about *conformance*, so the pages are arranged so each one can be checked
against the one before it:

| Page | 42010 concept | Answers |
|---|---|---|
| Stakeholders & Concerns | Stakeholder, Concern | Who reviews this model, and what do they need to be convinced of? |
| Viewpoints | Architecture Viewpoint | Which conventions frame each concern? |
| Views | Architecture View | Which views exist, and which viewpoint governs each? |
| Correspondences | Correspondence, Correspondence Rule | How do the views agree with each other, and which regulatory document consumes each? |

The overview page for each case study carries the device narrative — what it
does, where the design came from, and how to read the model.

## Why 42010 and not just "a list of diagrams"

A diagram list tells you what exists. It does not tell you whether anything is
*missing*. 42010's contribution is the conformance chain: an architecture
description is complete when every identified concern is framed by at least one
viewpoint, and every view conforms to a viewpoint. That gives a reviewable
question — *which concern has no viewpoint?* — instead of an aesthetic one.

MEMO encodes this directly. A `Viewpoint` carries `audience` (the stakeholders)
and `concernKinds` (the concerns it frames); a `MemoDiagramView` carries a
`viewpointDefinition` naming the viewpoint it conforms to. The tables in each
case study are read out of the model, not maintained by hand.

## Adding a case study

Case studies are not scaffolded from a template — a partial model would defeat
the point. A model qualifies when it has:

1. a real device with a public or clearly documented design basis, so claims
   can be cited rather than invented;
2. coverage across the layer map, not just structure;
3. views carrying an explicit `viewpointDefinition`;
4. `documentUsage` on views that feed a regulatory document.

Add the model under `examples/<name>/`, then a `docs/case-studies/<name>/`
folder with the four pages above, and register the pages in `mkdocs.yml`.
