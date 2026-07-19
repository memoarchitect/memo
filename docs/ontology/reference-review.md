# Reference-Methodology Review

Primary sources reviewed before the 0.5 ontology rework, and what MEMO takes
from each. Decisions per concept are recorded in the
[provenance matrix](provenance-matrix.md). MEMO reuses established
*distinctions*; it does not copy complete external metamodels.

## Systems architecture

**SysML v2 (OMG ptc/2025 specification + systems library).** MEMO is written in
portable SysML v2 textual notation only: `part def`, `action def`,
`interface def`, `port def` (with conjugation), `item def`, `requirement def`,
`connection def`, `view def`, `enum def`, `metadata def`, `constraint def`.
The eight standard view kinds (general, interconnection, actionflow,
statetransition, sequence, grid, browser, geometry) are the rendering targets
of every MEMO viewpoint. Behavior uses native actions, successions, decisions,
forks/joins where portable; where a construct is not yet portable across
SysIDE/SysON/sysand, MEMO falls back to declared attributes and records the
fallback in an ADR.

**ISO/IEC/IEEE 42010:2022.** Source of the stakeholder/concern/viewpoint/view/
model-kind/correspondence vocabulary and of the rule that a stakeholder *has
concerns* while an actor *interacts* — the two roles may coincide but are
distinct types. MEMO adopts `Stakeholder`, `Concern`, `ArchitectureDescription`,
`ModelKind`, `CorrespondenceRule` with 42010 semantics.

**Arcadia (Roques/Voirin, Capella).** Source of the perspective ladder
(operational → system/functional → logical → physical), of
operational-activity vs. system-function separation, of functional chains, and
of capability. MEMO adapts: the ladder becomes one of four *orthogonal*
dimensions rather than a containment hierarchy; `FunctionalChain` becomes
`FunctionalFlow`; Capella's "physical" splits into software/hardware/physical
realization under one `implementation` perspective.

**SEI viewtypes (Documenting Software Architectures; Clements et al.).**
Module vs. component-and-connector vs. allocation viewtypes justify the
software split: `software_structure` (module), `software_runtime` (C&C),
`deployment` (allocation). A module *builds into* a deployment unit; a runtime
component *is hosted by* a processing node.

**AADL (SAE AS5506D) / OSATE.** Reference for typed features/ports/connections,
flows, modes, processor/memory/bus/process/thread categories, scheduling
properties (period, deadline, WCET), and the Error Model Annex. MEMO keeps a
small neutral core (RuntimeComponent, Process, Thread, ProcessingNode, timing
attributes) and leaves the full category system to an AADL correspondence
profile (`examples/aadl-mapping`); AGREE-style assume/guarantee contracts
already existed in `behavior` and are kept.

**C4 (Brown).** Context/Container/Component/Code is treated purely as an
optional viewpoint mapping onto MEMO's context/logical/software levels
(`examples/c4-mapping`); it contributes no foundational concepts.

## Medical-device lifecycle

**ISO 13485:2016 / FDA QMSR (21 CFR 820 as amended 2024).** Design controls
motivate the design-input/output, DHF, and change-control artifacts (already
present); realization stages (specified → designed → built → …) align with
design transfer and production.

**ISO 14971:2019 + ISO/TR 24971.** The risk chain (hazard, sequence of events,
hazardous situation, harm), risk control hierarchy, residual risk, and
benefit-risk vocabulary — retained from 0.4 and linked to use errors and
security events per TR 24971 guidance.

**IEC 62366-1:2015+A1:2020 and FDA HF guidance (2016).** Intended user / use /
environment triplet, user task, *critical task* (FDA), use error,
hazard-related use scenario, formative vs. summative (usability validation)
evaluation. Grounds the `activities`, `interaction`, and human-factors
assurance packages, and the task-difficulty assessment (difficulty belongs to
task-in-context, not to an instrument).

**IEC 62304:2006+A1:2015.** Software system/item/unit decomposition, safety
classes A–C, SOUP. Grounds the module view of `software_structure` (kept from
0.4, now separated from runtime concerns).

**IEC 60601-1 family.** Basic safety/essential performance vocabulary informs
`Essential`-performance flags, applied parts (patient-contact interfaces), and
electrical interface properties; the ontology stays clause-neutral.

**IEC 81001-5-1:2021 and FDA cybersecurity guidance (2023).** Asset, threat,
vulnerability, attack scenario, trust boundary, security control, SBOM —
retained from 0.4 `cybersecurity` and connected to interfaces
(`crossesTrustBoundary`) and to safety impact.

**IMDRF SaMD N10/N12/N23.** Software-only devices must not be forced through
hardware layers: MEMO makes every architecture layer optional per product
(no mandatory pipeline; §20 traceability is a graph).

**Sterilization/reprocessing (ISO 17665, ISO 15883, AAMI ST79; FDA reprocessing
guidance 2015).** Grounds the reuse-lifecycle attributes: supplied sterile,
sterilization method, reprocessing/cleaning/disinfection requirements, maximum
reuse count. **Biocompatibility (ISO 10993-1)** grounds patient-contact
characteristics (contact nature/duration). **UDI (IMDRF UDI guidance, FDA
GUDID)** grounds the DI-on-definition / PI-on-instance split.

## Clinical interoperability

**HL7 FHIR (R5).** `DeviceDefinition` vs. `Device` is the direct precedent for
`MedicalDeviceDefinition` vs. `MedicalDeviceInstance` (UDI-DI on the
definition, serial/lot/expiry on the instance). `Procedure` informs
`ClinicalProcedure` performance records; `Observation`/`DeviceMetric` inform
measurement exchange items. The `Coding` datatype (system/version/code/display)
is adopted as `TerminologyCode`.

**SNOMED CT, GMDN, EMDN, ISO/IEEE 11073, DICOM, IHE device profiles.** All are
*bindings*, not base classes: any MEMO element carries `codes :
TerminologyCode[0..*]`, so a procedure can be SNOMED-coded while a device type
is GMDN- and EMDN-coded, and an 11073 nomenclature or DICOM SOP class can be
attached to interfaces without new metamodel surface.

## Analysis methods

FMEA/FMECA (IEC 60812), FTA (IEC 61025), STPA (Leveson/Thomas handbook), HAZOP
guide words, task analysis and use-related risk analysis (FDA HF guidance),
timing/schedulability (AADL properties): the 0.4 `analysis` package already
carried FMEA/FTA/HAZOP structures; STPA-style control-flaw analysis maps onto
`LogicalControlElement` + monitor-channel roles and is left to a future
profile (recorded in the handoff list). Scenario/variation analysis follows
ADR-0003 (workflow = definition, scenario = path, occurrence = execution).
