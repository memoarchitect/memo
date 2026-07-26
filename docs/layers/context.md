# Layer 1 — Context and use

!!! abstract "Running example"

    Every layer page uses the same device: the **GPCA infusion pump**, a
    patient-controlled analgesia pump. The complete model is
    [`examples/gpca-pump`](https://github.com/memoarchitect/memo/tree/main/examples/gpca-pump),
    and its architecture description is the
    [GPCA case study](../case-studies/gpca/index.md). Each layer page shows the
    same device one level further down, so the vocabulary accumulates rather
    than restarting.

## The question this layer answers

*Who is involved, where does the work happen, and what is the device for?*

Context is the first layer because every later statement is conditional upon
it. A hazard is hazardous to somebody, in some setting; a requirement is a
requirement of a device with a stated purpose. Recording the context first
means those conditions are written once and referenced thereafter, rather than
assumed differently by each discipline.

MEMO follows ISO/IEC/IEEE 42010 in separating two roles that are often
conflated. A *stakeholder* holds concerns that the architecture description
must address. An *actor* interacts with the device. The same person frequently
occupies both roles, and the model relates them by `ActsAsActor` rather than
merging them into one element.

## What is established before this layer

Nothing. Context is the base of the model, so its content is asserted rather
than derived. One consequence is worth stating plainly: the context layer is
where unexamined assumptions enter a model, and it is the layer most usefully
reviewed with clinical staff rather than with engineers.

## Assumptions and constraints

The GPCA model records the following. Every later layer inherits them.

| | Value in the running example |
| --- | --- |
| Care setting | Acute-care hospital ward and post-anaesthesia care unit |
| Environment | Indoor, mains power with battery backup, pole or bed-rail mounted |
| Patient population | Adult in-patients under clinical supervision |
| Mobility | Fixed location; the device is not ambulatory |
| Jurisdiction | Generic FDA/EU reference model |
| Classification | FDA Class II infusion pump; IEC 62304 software safety class C |

The exclusions matter as much as the inclusions. Because the device is not
ambulatory, the model carries no transport use context; an earlier `UC-002` was
removed for that reason. Because the population is adult in-patients, no
paediatric dose logic appears at any later layer. A programme that needs those
cases alters them here, not in the architecture.

## The running example at this layer

### Intended use

`IntendedUse` states what the device is for. It is a single element from which
several standards read.

```sysml
part gpcaIntendedUse : IntendedUse {
    attribute :>> id = "IU-001";
    attribute :>> indication =
        "Management of acute post-operative or chronic pain requiring "
        "titrated intravenous opioid analgesia.";
    attribute :>> contraindication =
        "Patients unable to comprehend or operate the bolus request mechanism.";
    attribute :>> patientPopulation = "Adult in-patients under clinical supervision.";
    attribute :>> regulatoryClassification =
        "FDA Class II infusion pump (21 CFR 880.5725); IEC 62304 software safety class C.";
}
```

### Use context

`UseContext` states where that purpose is exercised. `UC-001` references
`IU-001` through `intendedUseReference`, so the setting is bound to the purpose
rather than recorded alongside it.

### Actors

The GPCA model records five actors, each a `User` carrying an `actorKind` drawn
from a closed value set.

| Actor | `actorKind` | Training level |
| --- | --- | --- |
| `actorPatient` (ACT-001) | `patient` | Instructed on the bolus request button only |
| `actorNurse` (ACT-002) | `clinician` | Trained on programming and alarms |
| `actorPrescriber` | `clinician` | Prescribes the drug and dose regime |
| `actorPharmacist` | `clinician` | Maintains the drug library |
| `actorTechnician` | `technician` | Maintains and services the device |

The `trainingLevel` recorded on `actorPatient` performs real work in later
layers. A patient instructed only on one control cannot be assumed to recognise
an alarm condition, and that assumption is inherited by the hazard analysis.

`User` is reserved for humans, because it is the population for which IEC
62366-1 usability engineering is accountable. Use errors, tasks, and usability
validation attach to a `User` and never to an external system, which is
recorded as a `NonHumanActor`.

### Reasonably foreseeable misuse

Misuse is recorded at this layer rather than at the risk layer, because it is a
fact about people in a setting rather than a property of the design.

```sysml
part bolusByProxyMisuse : ReasonablyForeseeableMisuse {
    attribute :>> id = "RFM-001";
    attribute :>> title = "Bolus by proxy";
    attribute :>> longDescription =
        "A person other than the patient activates the bolus request control, "
        "bypassing the intended patient self-limiting behavior.";
    attribute :>> affectedUseContext = "UC-001";
}
```

Patient-controlled analgesia is safe in part because a sedated patient ceases
to press the button. `RFM-001` records the case in which that self-limiting
property is defeated. Every later layer that reasons about overdose depends on
this element being present here.

## What this layer hands to the next

The use case layer takes the actors and the use context and asks what those
people are trying to achieve. It inherits:

- the five actors, as parties that can initiate or participate in a use case;
- `UC-001`, as the setting in which every use case is performed;
- `IU-001`, as the purpose each use case must serve;
- `RFM-001`, as a known deviation the later scenarios must account for.

Consistency between the layers is expressed by typed relationships rather than
by narrative. An actor is bound to a use case by `Initiates` or
`ParticipatesIn`; a use case is bound to its setting by `AppliesInContext`.

[Next: Layer 2 — Use cases](use-cases.md)

## Element and relationship types

| Type | Records |
| --- | --- |
| [`IntendedUse`](../reference/elements/assurance.md#intendeduse) | The stated purpose, indications, and contraindications |
| [`UseContext`](../reference/elements/operational.md#usecontext) | The setting in which the device is used |
| [`UseEnvironment`](../reference/elements/operational.md#useenvironment) | Physical and operational conditions of that setting |
| [`User`](../reference/elements/operational.md#user) | A person who interacts with the device |
| [`NonHumanActor`](../reference/elements/operational.md#nonhumanactor) | An external system that interacts with the device |
| [`Stakeholder`](../reference/elements/operational.md#stakeholder) | A party holding a concern in the architecture description |
| [`Concern`](../reference/elements/operational.md#concern) | An interest a stakeholder holds |
| [`ReasonablyForeseeableMisuse`](../reference/elements/assurance.md#reasonablyforeseeablemisuse) | Predictable use outside the intended use |

| Relationship | Asserts |
| --- | --- |
| [`HasConcern`](../reference/relationships.md#hasconcern) | A stakeholder holds a concern the architecture must frame |
| [`ActsAsActor`](../reference/relationships.md#actsasactor) | One entity occupies both stakeholder and actor roles |
| [`InteractsWith`](../reference/relationships.md#interactswith) | An actor interacts with a target at the boundary |
| [`ExchangesWith`](../reference/relationships.md#exchangeswith) | Information or material crosses the context boundary |
| [`ConnectsPhysically`](../reference/relationships.md#connectsphysically) | A physical path connects two context participants |
| [`AppliesInContext`](../reference/relationships.md#appliesincontext) | A use context applies to a subject |
| [`SituatedIn`](../reference/relationships.md#situatedin) | A use context sits within an environment |
