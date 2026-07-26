# Getting started

MEMO brings clinical intent, system behavior, architecture, risk,
verification, and evidence into one connected SysML v2 model. The documentation
introduces those ideas in the same order that a team encounters them.

## Start with the idea

Begin with the [home page](index.md). It explains:

1. why document-level traceability loses meaning as a design changes;
2. why assurance needs a shared, architecture-backed model; and
3. how MEMO supplies that model through typed elements, semantic
   relationships, and closure rules.

This is the foundation for everything that follows.

## Learn the modeling progression

Once the purpose is clear, learn how MEMO builds a model from intent to
evidence:

1. **Context and use** — who uses the device, where, and for what purpose.
2. **Use cases** — the goals those people need to achieve.
3. **Workflows and scenarios** — how the work proceeds and how it can fail.
4. **Functions** — what the system must do on each scenario path.
5. **Architecture** — which components and interfaces carry those functions.
6. **Assurance** — how requirements, risks, controls, verification, and
   evidence connect across every layer.

Read the [layer map](layers/index.md) for the complete progression. The
[scenario-driven](what/scenario-driven.md) and
[function-centered](what/function-centered.md) explanations show the two ideas
that connect the layers.

## Build one small thread

Do not begin by trying to model an entire device. Start with one use case, one
scenario, the functions needed on that path, the responsible architecture, and
the evidence that closes the thread.

The [first-model tutorial](tutorials/first-model.md) walks through that process.
The remaining [tutorials and worked examples](examples/index.md) then expand the
same pattern to different kinds of medical devices.

## Grow the model when you need to

After the first thread is clear:

- Use the [how-to guides](how-to/index.md) for installation and specific
  modeling tasks.
- Use the [reference](reference/index.md) when you need an exact element,
  relationship, enumeration, or rule definition.
- Read the [explanation](why/index.md) for the reasoning behind the ontology.
- Follow the [GPCA case study](case-studies/gpca/index.md) to see a complete
  device model organized around several assurance threads.

That order is deliberate: understand the problem, learn the model, build one
thread, then use the detailed reference.

## Public repository

MEMO is developed in public at
[**github.com/memoarchitect/memo**](https://github.com/memoarchitect/memo).

MEMO Tools and MEMO Architect are separate products with their own
documentation. They are not required to use the ontology.
