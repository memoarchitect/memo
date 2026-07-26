# Why MEMO

A medical device is approved on the strength of an argument: this is what the
device is for, this is how it behaves, these are the ways it could cause harm,
this is what the design does about them, and this is the evidence.

That argument is distributed across requirements, architecture descriptions,
risk files, verification protocols, and test records. It may be sound when it
is written. The difficulty is keeping it sound after the design changes.

## Change breaks meaning before it breaks links

Most traceability connects identifiers. A requirement still points to a test
after the behavior changes; a control still points to a requirement after its
implementation moves; a test report remains a valid file after the tested
baseline is obsolete.

Every link resolves, but the claim behind the link may no longer be true.

That is the central problem MEMO addresses. The pages below develop it in one
sequence.

## The argument, step by step

1. **[Safety evidence drifts](evidence-drift.md).** Connected, configurable,
   software-intensive devices accumulate change faster than document-based
   evidence can follow it.
2. **[Links lack meaning](links-without-meaning.md).** Identifier pairs record
   association, not the behavior, design responsibility, or test conditions
   that make an assurance claim valid.
3. **[Other safety-critical domains lean on architecture](industry-context.md).**
   Aerospace and automotive attach assurance work to an explicit architecture;
   medical-device standards leave more of that connective model to each
   manufacturer.
4. **[Medical architecture stays weak](architecture-gap.md).** Team boundaries,
   document-heavy evidence, code-first product histories, and adoption cost
   turn architecture into a review picture that ages separately from the
   implementation.
5. **[A shared model has specific requirements](shared-model.md).** It must be
   versionable, architecture-backed, typed, checkable, viewpoint-driven, and
   practical enough to remain current.

## The conclusion

The missing artifact is not another matrix or document format. It is a shared
semantic model in which:

- each engineering fact is recorded once;
- each relationship states the claim it makes;
- architecture connects intent to implementation;
- assurance disciplines refer to that same design; and
- completeness and change impact can be computed from the model.

MEMO is that model, expressed as a SysML v2 ontology.

[Continue to What MEMO is →](../what/index.md)
