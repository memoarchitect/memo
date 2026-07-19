# Concept-Provenance Matrix

Every concept introduced or changed in the 0.5 rework, its grounding, and the
reuse decision (**adopt** = take semantics as defined; **adapt** = reuse the
distinction, adjust shape; **map** = keep MEMO-neutral, provide binding;
**replace** = supersede an existing MEMO concept; **reject** = considered and
not taken). Existing-concept column names the 0.4 element affected, if any.

| Proposed MEMO concept | Existing concept | Reference concept | Source | Decision | Rationale |
|---|---|---|---|---|---|
| MemoPart / construct bases | IdentifiedElement/TraceableElement | metaclass-aligned library bases | SysML v2 spec | adapt | One base per metaclass family; cross-metaclass inheritance is not portable (ADR-0002). |
| Orthogonal dimensions | ArchitectureElementKind.archLayer | perspectives; viewtypes | Arcadia; SEI; 42010 | replace | Scalar layer string could not express multi-dimension participation (ADR-0001). |
| ArchitecturePerspectiveKind | ArcadiaLayerKind | OA/SA/LA/PA layers | Arcadia | adapt | `system` renamed `functional`; `physical` generalized to `implementation`. |
| RealizationStageKind | LifecycleStateKind (partial) | design transfer/production stages | ISO 13485 7.3; QMSR | adapt | Element identity persists across specified…retired stages. |
| TerminologyCode | free `code`/`partNumber` strings | Coding | HL7 FHIR R5 | adopt | system/version/code/display tuple; multiple codes per element. |
| UdiCarrier | — | UDI-DI/PI | IMDRF UDI; FDA GUDID | adopt | DI on definition, PI on instance. |
| Stakeholder / Concern | — | stakeholder, concern | ISO/IEC/IEEE 42010 | adopt | Distinct from Actor; linked by concerns, not interaction. |
| ArchitectureDescription / ModelKind / CorrespondenceRule | — | same | ISO/IEC/IEEE 42010 | adopt | Completes the 42010 core. |
| Actor hierarchy (Human/NonHuman, User…) | Actor + ActorKind enum | actor; intended user | UML/SysML use-case practice; IEC 62366-1 | adapt | "User" reserved for humans interacting with the device. |
| Need hierarchy (StakeholderNeed, UserNeed…) | StakeholderNeed | design input sources | ISO 13485 7.3.3; IEC 62366-1 | adapt | Typed hierarchy; regulatory/operational needs distinct from stakeholder needs. |
| MedicalUseCase | — | use case as user goal | Cockburn/UML; IEC 62366-1 use specification | adapt | Goal folded into use case — no separate Goal class (governing principle). |
| ClinicalProcedure | — | Procedure | HL7 FHIR; SNOMED CT procedure hierarchy | map | MEMO-neutral definition; SNOMED binding via TerminologyCode. |
| OperationalWorkflow | — | operational process; care pathway | Arcadia OA; BPMN practice; IHE profiles | adapt | First-class, device-independent; as-is/to-be/contingency variants with transforms/replaces relations. |
| WorkflowStep/Decision/Handoff | — | activity nodes, gateways | SysML v2 actions; BPMN | adapt | Native action/succession semantics where portable. |
| MemoScenario + variant/condition/purpose dims | OperationalScenario, ScenarioKind | scenario; operating modes | Arcadia; ISO 14971 (misuse); STPA contexts | replace | Single `ScenarioKind` mixed variant with condition; now three typed dimensions (ADR-0003). |
| ScenarioOccurrence | — | execution/trace | SysML v2 occurrences | adapt | Workflow=definition, scenario=path, occurrence=execution. |
| OperationalActivity (typed) | OperationalActivity (strings) | operational activity | Arcadia OA | replace | Now a MemoAction with typed relations to tasks, products, functions. |
| UserTask / CriticalTask / ClinicalTaskStep | — | task, critical task | IEC 62366-1; FDA HF guidance 2016 | adopt | Critical task = failure could cause serious harm; must trace to usability validation. |
| TaskDifficultyAssessment | — | task analysis, workload dimensions | FDA HF guidance; NASA-TLX-style demand factors | adapt | Difficulty attached to task-in-context, never to the instrument. |
| ProductUsage (role-typed) | — | device role in procedure | IHE/clinical practice; Arcadia resource allocation | adapt | Contextual relationship: role, quantity, sterile/calibration needs; product never duplicated as "tool". |
| SystemFunction | LogicalFunction | system function | Arcadia SA | replace | Functions are technology-independent, not "logical layer". |
| FunctionalFlow / FunctionalFlowStep / FunctionalExchange | FunctionalChain (string steps) | functional chain / exchange | Arcadia | replace | Typed references; flow reusable, scenario selects path. |
| SystemCapability | SystemCapability | capability | Arcadia | adopt | Kept, retyped onto SystemFunction. |
| Logical taxonomy (LogicalSystem/Subsystem/Component/Channel/DataStore/ControlElement/UserInterface/ExternalSystem) | LogicalComponent only | logical components; C&C roles | Arcadia LA; SEI | adapt | Channel/monitor/interlock roles for safety architecture; technology-independent. |
| Redundancy roles + independence | — | redundant/diverse channels | IEC 60601-1 (SFC); IEC 61508 practice | adapt | Typed roles + independence constraint, not name duplication. |
| Module view (SoftwareSystem/Item/Module/Unit/Package/Library/SOUP) | SoftwareSystem/Item/SOUP | software system/item/unit; SOUP | IEC 62304 5.3–5.4, 8.1.2 | adapt | 62304 decomposition kept; runtime attributes removed from module view. |
| Runtime view (RuntimeComponent/Process/Thread/Service/Container/Partition…) | (mixed into SoftwareComponent) | C&C viewtype; process/thread | SEI; AADL | replace | Separate runtime structure with concurrency/scheduling properties. |
| DeploymentUnit / ProcessingNode / RuntimeEnvironment | ProcessingNode | allocation viewtype; processor/binding | SEI; AADL | adapt | Builds-into / deploys-to / hosted-by backbone. |
| Physical taxonomy (Sensor, Actuator, PowerSupply, Enclosure, Fluidic/Optical/… components) | HardwareAssembly | ECS categories | AADL; IEC 60601 practice | adapt | Physical ⊃ hardware: mechanical, fluidic, optical, acoustic, thermal realization. |
| MedicalDeviceDefinition / MedicalDeviceInstance | — | DeviceDefinition / Device | HL7 FHIR R5 | adopt | Definition/instance split; identity invariants in rules. |
| Product kinds (Instrument, Equipment, Accessory, Consumable, Supply, Implant) | — | device categories | EU MDR Art. 2; FDA classification; GMDN | adapt | Small set of semantic kinds; fine classification via codes. |
| TechnologyDomainKind (multivalued) | — | device technology characterization | IMDRF SaMD N10 (software-only); 60601 (ME equipment) | adapt | Multivalued set, not combinatorial enums; electromechanical derived. |
| Reuse lifecycle (singleUse/reusable/reprocessable…) | — | single-use / reprocessing | FDA reprocessing guidance 2015; ISO 17665; AAMI ST79 | adopt | Property cluster, not inheritance; invariants forbid single-use + reprocessing lifecycle. |
| Patient-contact characteristics | — | contact nature/duration | ISO 10993-1 | adopt | Required for patient-contact components (invariant). |
| Interface property extensions (isolation, patient contact, protocol, timing) | Interface taxonomy | features/connections; applied parts | AADL; IEC 60601-1 | adapt | Typed ports/interfaces kept; strings replaced by typed references where portable. |
| UI hierarchy (UserInterface, UIContainer, UIElement subtypes, UIState/Event/Action/Transition, DataBinding) | — | UI task/element models | IEC 62366-1; HF practice | adapt | Concrete widget forms are enum classifications, not classes. |
| InteractionFlow / InteractionScenario | InteractionScenario (behavior pkg) | dialogue/sequence | IEC 62366-1; SysML sequence | adapt | UI state distinct from system state and device mode. |
| Hazard-related use scenario, Formative/Summative evaluation | — | same | IEC 62366-1 3.9/5.7–5.9 | adopt | Human-factors assurance package. |
| Threat/Asset/TrustBoundary links to interfaces | cybersecurity pkg | threat modeling; 81001-5-1 | FDA cyber guidance 2023; IEC 81001-5-1 | adapt | Kept 0.4 concepts; typed connection to ports/boundaries. |
| V-model as view (not hierarchy) | — | V&V stages | IEC 62304; ISO 13485 | adopt | Verification/validation cases + coverage viewpoints over the trace graph. |
| C4 mapping | — | Context/Container/Component | C4 model | map | Optional viewpoint correspondence only. |
| AADL mapping | — | AADL categories/properties | SAE AS5506D | map | Correspondence profile for analyzable embedded architecture. |
| Separate Goal class | — | goal modeling (KAOS/i*) | goal-oriented RE | reject | UseCase *is* the user's goal; a Goal class would duplicate it. |
| Full BPMN metamodel | — | BPMN 2.0 | OMG BPMN | reject | Native SysML actions/successions/decisions suffice; BPMN import is tooling work (handoff). |
| Full AADL/FHIR metamodel import | — | — | — | reject | Kept behind mappings/profiles; MEMO core stays small. |
| `disposable : Boolean` as primary split | — | — | — | reject | Reuse lifecycle is a property cluster with invariants, not a boolean or type split. |
