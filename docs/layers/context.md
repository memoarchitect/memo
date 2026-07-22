# Context and Use

The context layer establishes the boundary of the engineering argument. It
answers who has a stake in the device, who interacts with it, the intended
use, and the situations in which use occurs. MEMO follows ISO/IEC/IEEE 42010
here: a *stakeholder* has concerns; an *actor* interacts; the same entity may
play both roles, and the model links them rather than merging them.

## Core elements

| Element | Use it for | Example |
|---|---|---|
| `Stakeholder`, `Concern` | Interests the architecture must answer | Hospital biomedical department; infection control |
| `IntendedUse` | Assurance-owned medical purpose and patient population governing this context | Patient-controlled analgesia in a hospital ward |
| `ReasonablyForeseeableMisuse` | Foreseeable departure from intended use included in risk analysis | Bolus activation by someone other than the patient |
| `Actor` → `User`, `NonHumanActor` | Anything interacting with the system | Pharmacy system, mains power, nurse |
| `User` → `ClinicalUser`, `PatientUser`, `CaregiverUser`, `TechnicianUser` | Human actors who interact with the device | Nurse, patient, biomedical technician |
| `UseContext`, `UseEnvironment` | Situational and physical conditions of use | Hospital ward; sterile field lighting and noise |

“User” is reserved for humans: it is the population that IEC 62366-1 usability
engineering is accountable for. Use errors, tasks, and usability validation
attach to users — never to external systems.

## Core relationships

| Relationship | Meaning |
|---|---|
| `HasConcern` | A stakeholder holds a concern the architecture must frame |
| `ActsAsActor` | The same entity plays both stakeholder and actor roles |
| `InteractsWith` | An actor interacts with a target at the boundary |
| `ExchangesWith` | Information or material crosses the context boundary |
| `ConnectsPhysically` | A physical path connects two context participants |
| `GovernsUse` | An intended-use statement governs a subject |
| `AppliesInContext` / `SituatedIn` | A use context applies; a context sits in an environment |

## Where to go next

Context flows directly into [The Operational World](operational-world.md):
users initiate use cases, needs motivate them, and workflows organize the
work. The GPCA example's `gpca_context.sysml` is the reference pattern.
