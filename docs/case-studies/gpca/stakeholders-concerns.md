# GPCA — Stakeholders and Concerns

ISO/IEC/IEEE 42010 starts an architecture description with the people it has
to satisfy and what each of them needs to be convinced of. Everything
downstream — viewpoints, views, documents — exists to answer a concern held by
someone on this page.

## Stakeholders in the model

MEMO records the reviewing audience on the viewpoint (`audience`), and the
people and roles *in the clinical world* as model elements. The two are
different populations and it is worth keeping them apart.

### Reviewing audience

These are the `AudienceKind` values the GPCA viewpoints declare. Each one is a
role that reads the model and signs something.

| Audience | Reads GPCA through |
|---|---|
| System architect | Context, Operational, Functional, Logical, Requirements |
| Safety engineer | Risk |
| Software architect | Software |
| Hardware engineer | Physical |
| Security engineer | Cybersecurity |
| Verification engineer | Verification |
| Regulatory engineer | Requirements |
| Project lead | Operational |

### Clinical actors

These are modelled elements in `gpca_context.sysml`, not reviewers — they
appear *inside* the views:

| Actor | Role in therapy |
|---|---|
| `actorPatient` | Requests boluses within programmed limits |
| `actorNurse` | Programs, starts, and monitors therapy; responds to alarms |
| `actorPrescriber` | Sets the prescription the pump enforces |
| `actorPharmacist` | Prepares and verifies the drug container |
| `actorTechnician` | Services and configures the device |

The model also names the intended use (`gpcaIntendedUse`), the use context
(`hospitalWardContext`), and — importantly for IEC 62366 — the use errors and
foreseeable misuse it must survive: `ueBolusByProxy`, `ueMisprogrammedRate`,
`ueWrongDrugLoaded`, `ueAlarmDisregard`, and `bolusByProxyMisuse`.

!!! note "Bolus-by-proxy is modelled twice on purpose"
    It appears as a use error *and* as a reasonably foreseeable misuse. The
    first drives usability engineering; the second drives risk analysis. They
    are different obligations under different standards, so MEMO keeps them as
    separate elements rather than one shared "hazard".

## Concerns

MEMO's `ConcernKind` is the vocabulary a viewpoint uses to declare what it
frames. The concerns exercised in GPCA:

| Concern | The question it stands for | Framed by |
|---|---|---|
| Safety | Can the device harm the patient, and where is that bounded? | Context, Functional, Logical, Requirements, Risk, Software, Cybersecurity |
| Regulatory | Can we show a reviewer the obligation is met? | Requirements, Risk, Verification |
| Performance | Does it do the job well enough to be clinically useful? | Operational, Functional, Logical |
| Interoperability | Does it behave correctly with what it is connected to? | Context, Operational, Physical |
| Reliability | Does it keep working over its service life? | Physical, Software |
| Cybersecurity | Can it be made to misbehave by an attacker? | Cybersecurity |
| Privacy | Is patient data protected? | Cybersecurity |
| Usability | Will a tired clinician use it correctly? | Usability |
| Clinical | Is the clinical rationale sound? | Clinical |

## Reading the coverage

The chain to check is: **every concern is framed by at least one viewpoint,
and every viewpoint has a declared audience.** Two observations from the model
as it stands:

- *Safety* is framed by seven of the ten viewpoints in use. That is expected
  for an infusion pump — it is the concern the device exists to bound.
- *Usability* and *Clinical* are declared as concerns and have viewpoints
  defined in the ontology, but GPCA's diagram views do not currently name
  those viewpoints. Their content reaches reviewers through the document
  views instead — the Usability Engineering File is assembled from
  `document_usability_view`. This is a real gap in the diagram-level
  conformance chain, and it is stated here rather than smoothed over.

Continue to [Viewpoints](viewpoints.md).
