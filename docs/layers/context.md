# Context and Use

The context layer establishes the boundary of the engineering argument. It
answers who interacts with the device, what surrounds it, the intended use, and
the situations in which use occurs.

## Core elements

| Element | Use it for | Example |
|---|---|---|
| `IntendedUse` | Medical purpose, patient population, and intended setting | Patient-controlled analgesia in a hospital ward |
| `Actor` | A person or external role interacting with the system | Patient, nurse, pharmacist, technician |
| `UseContext` | Environmental and situational conditions | Hospital ward, transport, home use |
| `UseError` | Foreseeable user action or omission | Incorrect dose programming |

## Core relationships

| Relationship | Meaning |
|---|---|
| `InteractsWith` | An actor or context participant interacts with a target |
| `ExchangesWith` | Information or material crosses the context boundary |
| `ConnectsPhysically` | A physical path connects two context participants |
| `GovernsUse` | An intended-use statement governs a subject |
| `AppliesInContext` | A use context applies to a subject |

## Example

```sysml
part patient : Actor {
    attribute :>> id = "ACT-001";
    attribute :>> name = "Patient";
}

part ward : UseContext {
    attribute :>> id = "CTX-001";
    attribute :>> name = "HospitalWard";
}

connection : InteractsWith
    connect contextParticipant ::> patient
    to target ::> pump;

connection : AppliesInContext
    connect useContext ::> ward
    to subjectElement ::> pump;
```

!!! tip "Model the boundary before decomposing the device"
    If an external system, clinician, consumable, or infrastructure service
    crosses the boundary, record it here before deciding which internal
    component handles the interaction.
