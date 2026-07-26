# Layer 2 — Use cases

!!! abstract "Running example"

    The **GPCA infusion pump**, continued from
    [Layer 1 — Context and use](context.md).

## The question this layer answers

*What are those people trying to achieve?*

A use case names a goal held by an actor, in a context, that the device exists
to serve. It is not yet a description of work, and it is certainly not a
description of behaviour. It fixes the objective against which later work is
judged adequate.

## What is established before this layer

Layer 1 recorded the parties, the setting, and the purpose. In brief:

- Five actors, of which `actorPatient` is instructed on one control only and
  `actorNurse` is trained on programming and alarms.
- `UC-001` hospital ward: acute care, mains power with battery backup, adult
  in-patients under clinical supervision, not ambulatory.
- `IU-001` intended use: patient-controlled intravenous opioid analgesia.
- `RFM-001` bolus by proxy, recorded as foreseeable misuse.

A use case is only meaningful relative to these. "Deliver analgesia" means
something different in an ambulatory home-care setting, and the model would
differ from this layer downward.

## Assumptions and constraints

Two constraints are introduced here, and both narrow what later layers may
assume.

**The primary user is the nurse, not the patient.** The patient requests
boluses, but the therapy is programmed, started, and supervised clinically.
Later layers may therefore assume a trained operator for configuration, and may
not assume one for bolus requests.

**The goal statement bounds success.** `UC-001` succeeds when the patient
receives prescribed analgesia *without exceeding dose, lockout, or safety
limits*. Adequate pain relief alone is not success, and this is what makes the
lockout logic a matter of the primary goal rather than an added safety feature.

## The running example at this layer

The GPCA model records one clinical use case.

```sysml
use case ucDeliverPcaTherapy : UseCase {
    attribute :>> useCaseKind = UseCaseKind::clinical;
    attribute :>> id = "UC-001";
    attribute :>> name = "DeliverPatientControlledAnalgesia";
    attribute :>> goalStatement =
        "Deliver prescribed analgesia safely while allowing patient-controlled "
        "bolus requests within configured limits.";
    attribute :>> trigger =
        "A clinician starts prescribed patient-controlled analgesia therapy.";
    attribute :>> successOutcome =
        "The patient receives prescribed analgesia without exceeding dose, "
        "lockout, or safety limits.";
    ref :>> primaryUser = actorNurse;
    ref :>> supportingActors = (actorPatient, actorPrescriber, actorPharmacist);
    ref :>> useContext = hospitalWardContext;
}
```

Three of its attributes are references to Layer 1 rather than restatements of
it. `primaryUser` and `supportingActors` point at the actor elements;
`useContext` points at `hospitalWardContext`. Renaming or re-scoping an actor
therefore propagates, and cannot leave a stale copy behind in the use case.

Note also `trigger` and `successOutcome`. A use case with a trigger but no
success outcome cannot be verified, because nothing states what the device was
supposed to achieve. Both are recorded here so that the verification layer has
something to attach to.

## Why one use case and not twelve

A common failure is to record every interaction as a use case: *program the
pump*, *change the reservoir*, *silence an alarm*, *review the log*. These are
tasks within the therapy, not independent goals. Modelling them as peers
produces a flat list with no statement of what the device is for, and gives
the risk analysis no situation to attach to.

MEMO's structure pushes that detail one layer down. The therapy is the goal;
the work of achieving it belongs to workflows, and the paths through that work
belong to scenarios. The rule of thumb: if a candidate use case would be
abandoned halfway through without anyone considering the therapy to have
failed, it is a step and not a goal.

## What this layer hands to the next

The workflow and scenario layer takes `UC-001` and asks how the goal is
actually pursued, including the ways it goes wrong. It inherits:

- the goal statement, as the criterion for a nominal path;
- the success outcome, as the condition an exception path fails to reach;
- `actorNurse` as operator and `actorPatient` as bolus requester, which
  determines who acts at each step;
- `RFM-001`, which the scenario set must cover.

Consistency is expressed by `Motivates` from a need to a use case, `Initiates`
and `ParticipatesIn` from actors, and `Supports` from a workflow to the use
case it serves.

[Next: Layer 3 — Workflows and scenarios](operational-world.md)

## Element and relationship types

| Type | Records |
| --- | --- |
| [`UseCase`](../reference/elements/operational.md#usecase) | A goal an actor pursues in a context |
| [`UseCaseKind`](../reference/enumerations.md#usecasekind) | The classification of a use case, such as `clinical` |
| [`Need`](../reference/elements/assurance.md#need) | A stakeholder requirement motivating a use case |

| Relationship | Asserts |
| --- | --- |
| [`Motivates`](../reference/relationships.md#motivates) | A need motivates a use case |
| [`Initiates`](../reference/relationships.md#initiates) | An actor initiates a use case |
| [`ParticipatesIn`](../reference/relationships.md#participatesin) | An actor takes part in a use case |
| [`Includes`](../reference/relationships.md#includes) | A use case includes another unconditionally |
| [`Extends`](../reference/relationships.md#extends) | A use case extends another conditionally |
| [`AppliesInContext`](../reference/relationships.md#appliesincontext) | A use case applies in a use context |
