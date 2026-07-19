# SysML source reference

This is the source-level reference for the current ontology. Read a row as you
would a Doxygen class entry: **file** is the source of truth, **package** is
the importable namespace, and **public definitions** are the types and links it
introduces. This reference documents the current source only; it does not
describe historical migrations.

## Core and operational model

| SysML file | Package | Public definitions |
| --- | --- | --- |
| `src/core/common/memo_common.sysml` | `memo_core_common` | `IdentifiedElement`, `TraceableElement`, `MemoPart`, `RequirementDriver` |
| `src/core/enumerations/memo_enumerations.sysml` | `memo_core_enumerations` | shared controlled value sets |
| `src/core/relationships/memo_relationships.sysml` | `memo_core_relationships` | `MemoRelationship`, `DerivesFrom`, `SatisfiedBy`, `MitigatesHazard`, `VerifiedBy` |
| `src/core/dimensions/dimensions.sysml` | `memo_core_dimensions` | perspectives, lifecycle stages, disciplines, and concerns |
| `src/context/actors/memo_actors.sysml` | `memo_context_actors` | `Actor`, `User`, `ClinicalUser`, `PatientUser`, `CaregiverUser`, `TechnicianUser`, `NonHumanActor` |
| `src/context/stakeholders/memo_stakeholders.sysml` | `memo_context_stakeholders` | `Stakeholder`, `Concern`, architecture-description concepts |
| `src/context/use_context/memo_use_context.sysml` | `memo_context_use_context` | `IntendedUse`, `UseContext`, `UseEnvironment` and context links |
| `src/assurance/needs/memo_needs.sysml` | `memo_assurance_needs` | needs hierarchy |
| `src/use_cases/memo_use_cases.sysml` | `memo_use_cases` | `UseCase`, `ClinicalUseCase`, `ServiceUseCase`, `ManufacturingUseCase`, `DevelopmentUseCase` |
| `src/clinical_procedures/memo_clinical_procedures.sysml` | `memo_clinical_procedures` | procedure, technique, variant, instrument-set concepts |
| `src/activities/memo_activities.sysml` | `memo_activities` | `OperationalActivity`, `UserTask`, `CriticalTask`, task steps |
| `src/workflows/memo_workflows.sysml` | `memo_workflows` | `OperationalWorkflow`, workflow steps, decisions, handoffs, workflow links |
| `src/scenarios/memo_scenarios.sysml` | `memo_scenarios` | `MemoScenario`, `OperationalScenario`, `ScenarioOccurrence`, scenario links |

## Architecture model

| SysML file | Package | Public definitions |
| --- | --- | --- |
| `src/architecture/functions/memo_functions.sysml` | `memo_architecture_functions` | `SystemFunction`, `SystemAction`, functional exchanges, data and control definitions |
| `src/architecture/system/memo_system_analysis.sysml` | `memo_architecture_system` | capabilities, functional flows, functional scenarios |
| `src/architecture/operational/memo_operational.sysml` | `memo_architecture_operational` | operational entities, capabilities, interactions |
| `src/architecture/logical_structure/memo_logical_structure.sysml` | `memo_architecture_logical_structure` | logical systems, components, channels, ports, interfaces, isolation |
| `src/architecture/interfaces/memo_interfaces.sysml` | `memo_architecture_interfaces` | physical, hardware, software, and digital interfaces |
| `src/architecture/software_structure/memo_software_structure.sysml` | `memo_architecture_software_structure` | software systems, components, items, units, modules |
| `src/architecture/software_runtime/memo_software_runtime.sysml` | `memo_architecture_software_runtime` | runtime components, processes, threads, tasks, services |
| `src/architecture/deployment/memo_deployment.sysml` | `memo_architecture_deployment` | deployment units, runtime environments, build/deploy links |
| `src/architecture/hardware_structure/memo_hardware_structure.sysml` | `memo_architecture_hardware_structure` | physical and hardware assemblies, components, sensors, actuators |
| `src/architecture/physical/memo_physical_architecture.sysml` | `memo_architecture_physical` | processing nodes, memory devices, physical ports |
| `src/architecture/behavior/memo_behavior.sysml` | `memo_architecture_behavior` | behavior machines, states, transitions, behavior properties |
| `src/architecture/constraints/memo_constraints.sysml` | `memo_architecture_constraints` | architecture constraints |
| `src/architecture/decisions/memo_decisions.sysml` | `memo_architecture_decisions` | `DesignDecision` |
| `src/assurance/requirements/memo_requirements.sysml` | `memo_assurance_requirements` | requirements and requirement drivers |
| `src/assurance/safety/memo_risk.sysml` | `memo_assurance_safety_risk` | risks, risk matrices, residual-risk concepts |
| `src/assurance/safety/memo_arch_risk.sysml` | `memo_assurance_safety_arch_risk` | architecture risk links |
| `src/assurance/safety_analysis/memo_fmea.sysml` | `memo_assurance_safety_analysis` | FMEA worksheet, failure mode, effect, cause |
| `src/assurance/verification/memo_assurance.sysml` | `memo_assurance_verification` | verification, validation, evidence, review cases |
| `src/assurance/cybersecurity/memo_cybersecurity.sysml` | `memo_assurance_cybersecurity` | assets, threats, vulnerabilities, mitigations |

## Supporting model modules

| SysML file | Package | Public definitions |
| --- | --- | --- |
| `src/medical_products/memo_product_definitions.sysml` | `memo_medical_products_definitions` | `MedicalDeviceDefinition`, `MedicalDevice`, `MedicalInstrument` |
| `src/medical_products/memo_product_lifecycle.sysml` | `memo_medical_products_lifecycle` | reuse and sterilization classifications |
| `src/medical_products/memo_product_usage.sysml` | `memo_medical_products_usage` | product roles, `UsesProduct`, `TaskUsesProduct` |
| `src/interaction/memo_interaction.sysml` | `memo_interaction` | user interfaces, interaction elements, flows, and scenarios |
| `src/assurance/human_factors/memo_human_factors.sysml` | `memo_assurance_human_factors` | `UseError`, `HazardRelatedUseScenario`, formative evaluation, usability validation |
| `src/compliance/artifacts/memo_artifacts.sysml` | `memo_compliance_artifacts` | `ControlledArtifact` |
| `src/compliance/change/memo_change.sysml` | `memo_compliance_change` | `ChangeRequest`, `ConfigurationItem` |
| `src/compliance/document_views/memo_document_views.sysml` | `memo_compliance_document_views` | document-view bindings |
| `src/compliance/iso14971/risk_management_file.sysml` | `memo_compliance_iso14971` | `RiskManagementFile` |
| `src/compliance/postmarket/memo_postmarket.sysml` | `memo_compliance_postmarket` | `ClinicalEvaluation`, `PostMarketSurveillance` |
| `src/core/consistency_rules/consistency_rules.sysml` | `memo_core_consistency_rules` | consistency-rule base types |
| `src/core/methodology_scope/methodology_scope.sysml` | `memo_core_methodology_scope` | methodology layer, standard, artifact, and viewpoint sets |
| `src/core/semantics/semantics.sysml` | `memo_core_semantics` | shared semantic annotations |
| `src/core/terminology/terminology.sysml` | `memo_core_terminology` | controlled terminology annotations |
| `src/core/stdlib/collections.sysml` | `memo_core_stdlib_collections` | collection utilities |
| `src/core/stdlib/functions.sysml` | `memo_core_stdlib_functions` | helper functions |
| `src/core/stdlib/scalars.sysml` | `memo_core_stdlib_scalars` | scalar utilities |
| `src/core/stdlib/time.sysml` | `memo_core_stdlib_time` | time utilities |
| `src/memo_namespaces.sysml` | `memo` | top-level namespace registrations |
| `src/medical_device_library.sysml` | `memo_medical_device_library` | library assembly and imports |

## Typed artifact modules

Each file below defines the named, typed document artifact. Use the type when
the artifact is part of the model; do not use the file name as a second model
concept.

| SysML file | Package | Public definition |
| --- | --- | --- |
| `src/artifacts/clinical_safety_report.sysml` | `memo_artifacts_clinical_safety_report` | `ClinicalSafetyReport` |
| `src/artifacts/cybersecurity_assessment_report.sysml` | `memo_artifacts_cybersecurity_assessment_report` | `CybersecurityAssessmentReport` |
| `src/artifacts/definitions/memo_artifact_definitions.sysml` | `memo_artifacts_definitions` | `ArtifactKindDef` |
| `src/artifacts/design_change_log.sysml` | `memo_artifacts_design_change_log` | `DesignChangeLog` |
| `src/artifacts/design_history_file_index.sysml` | `memo_artifacts_design_history_file_index` | `DesignHistoryFileIndex` |
| `src/artifacts/design_input_plan.sysml` | `memo_artifacts_design_input_plan` | `DesignInputPlan` |
| `src/artifacts/design_output_plan.sysml` | `memo_artifacts_design_output_plan` | `DesignOutputPlan` |
| `src/artifacts/evidence_record.sysml` | `memo_artifacts_evidence_record` | `EvidenceRecord` |
| `src/artifacts/failure_mode_effects_analysis.sysml` | `memo_artifacts_failure_mode_effects_analysis` | `FailureModeEffectsAnalysisReport` |
| `src/artifacts/hazard_analysis_report.sysml` | `memo_artifacts_hazard_analysis_report` | `HazardAnalysisReport` |
| `src/artifacts/labeling_specification.sysml` | `memo_artifacts_labeling_specification` | `LabelingSpecification` |
| `src/artifacts/requirements_specification.sysml` | `memo_artifacts_requirements_specification` | `RequirementsSpecification` |
| `src/artifacts/requirements_traceability_matrix.sysml` | `memo_artifacts_requirements_traceability_matrix` | `RequirementsTraceabilityMatrix` |
| `src/artifacts/risk_management_plan.sysml` | `memo_artifacts_risk_management_plan` | `RiskManagementPlan` |
| `src/artifacts/software_design_description.sysml` | `memo_artifacts_software_design_description` | `SoftwareDesignDescription` |
| `src/artifacts/software_development_plan.sysml` | `memo_artifacts_software_development_plan` | `SoftwareDevelopmentPlan` |
| `src/artifacts/soup_list.sysml` | `memo_artifacts_soup_list` | `SoupList` |
| `src/artifacts/system_architecture_description.sysml` | `memo_artifacts_system_architecture_description` | `SystemArchitectureDescription` |
| `src/artifacts/test_protocol.sysml` | `memo_artifacts_test_protocol` | `TestProtocol` |
| `src/artifacts/test_report.sysml` | `memo_artifacts_test_report` | `TestReport` |
| `src/artifacts/threat_model_report.sysml` | `memo_artifacts_threat_model_report` | `ThreatModelReport` |
| `src/artifacts/usability_engineering_report.sysml` | `memo_artifacts_usability_engineering_report` | `UsabilityEngineeringReport` |

## Rules, methodology, and viewpoints

| SysML file | Package | Public definitions or review presentation |
| --- | --- | --- |
| `src/rules/closure/closure_rules.sysml` | `memo_rules_closure` | required relationship closure rules |
| `src/rules/coverage/coverage_rules.sysml` | `memo_rules_coverage` | coverage rules |
| `src/rules/crosslayer/cross_layer_rules.sysml` | `memo_rules_crosslayer` | operational-to-architecture consistency rules |
| `src/rules/lifecycle/lifecycle_rules.sysml` | `memo_rules_lifecycle` | lifecycle consistency rules |
| `src/rules/ontology/ontology_invariants.sysml` | `memo_rules_ontology` | ontology invariants |
| `src/rules/quantitative/quantitative_rules.sysml` | `memo_rules_quantitative` | quantitative constraint rules |
| `src/methodology/memo_archetypes.sysml` | `memo_methodology_archetypes` | project archetype selections |
| `src/methodology/memo_core.sysml` | `memo_methodology_core` | methodology library and project binding |
| `src/methodology/memo_gates.sysml` | `memo_methodology_gates` | `QualityGate` |
| `src/methodology/memo_patterns.sysml` | `memo_methodology_patterns` | `ModelingPattern` |
| `src/methodology/memo_profiles.sysml` | `memo_methodology_profiles` | profile selections |
| `src/methodology/memo_rules.sysml` | `memo_methodology_rules` | element and relationship usage rules |
| `src/methodology/memo_viewpoints.sysml` | `memo_methodology_viewpoints` | methodology viewpoint selections |
| `src/methodology/memo_workflow.sysml` | `memo_methodology_workflow` | methodology workflow steps |
| `src/viewpoints/definitions/memo_viewpoint_definitions.sysml` | `memo_viewpoints_definitions` | `Viewpoint`, `ViewRule`, `ViewSelectionQuery`, `MemoView` |
| `src/viewpoints/catalog/memo_viewpoint_catalog.sysml` | `memo_viewpoints_catalog` | catalog viewpoint and diagram-intent mapping |
| `src/viewpoints/operational/operational_viewpoint.sysml` | `memo_viewpoints_operational_operational_viewpoint` | operational viewpoint |
| `src/viewpoints/operational/use_case_view.sysml` | `memo_viewpoints_operational_use_case_view` | use-case view |
| `src/viewpoints/context/context_viewpoint.sysml` | `memo_viewpoints_context_context_viewpoint` | context viewpoint |
| `src/viewpoints/context/system_context_view.sysml` | `memo_viewpoints_context_system_context_view` | system-context view |
| `src/viewpoints/functional/functional_viewpoint.sysml` | `memo_viewpoints_functional_functional_viewpoint` | functional viewpoint |
| `src/viewpoints/functional/function_allocation_view.sysml` | `memo_viewpoints_functional_function_allocation_view` | function-allocation view |
| `src/viewpoints/functional/system_functional_tree_view.sysml` | `memo_viewpoints_functional_system_functional_tree_view` | system functional-tree view |
| `src/viewpoints/logical/logical_viewpoint.sysml` | `memo_viewpoints_logical_logical_viewpoint` | logical viewpoint |
| `src/viewpoints/logical/logical_architecture_view.sysml` | `memo_viewpoints_logical_logical_architecture_view` | logical-architecture view |
| `src/viewpoints/physical/physical_viewpoint.sysml` | `memo_viewpoints_physical_physical_viewpoint` | physical viewpoint |
| `src/viewpoints/physical/network_topology_view.sysml` | `memo_viewpoints_physical_network_topology_view` | network-topology view |
| `src/viewpoints/physical/physical_bom_view.sysml` | `memo_viewpoints_physical_physical_bom_view` | physical bill-of-materials view |
| `src/viewpoints/software/software_viewpoint.sysml` | `memo_viewpoints_software_software_viewpoint` | software viewpoint |
| `src/viewpoints/software/software_architecture_view.sysml` | `memo_viewpoints_software_software_architecture_view` | software-architecture view |
| `src/viewpoints/requirements/requirements_viewpoint.sysml` | `memo_viewpoints_requirements_requirements_viewpoint` | requirements viewpoint |
| `src/viewpoints/requirements/requirements_traceability_view.sysml` | `memo_viewpoints_requirements_requirements_traceability_view` | requirements-traceability view |
| `src/viewpoints/risk/risk_viewpoint.sysml` | `memo_viewpoints_risk_risk_viewpoint` | risk viewpoint |
| `src/viewpoints/risk/risk_chain_view.sysml` | `memo_viewpoints_risk_risk_chain_view` | risk-chain view |
| `src/viewpoints/verification/verification_viewpoint.sysml` | `memo_viewpoints_verification_verification_viewpoint` | verification viewpoint |
| `src/viewpoints/verification/verification_coverage_view.sysml` | `memo_viewpoints_verification_verification_coverage_view` | verification-coverage view |
| `src/viewpoints/usability/usability_viewpoint.sysml` | `memo_viewpoints_usability_usability_viewpoint` | usability viewpoint |
| `src/viewpoints/usability/usability_engineering_view.sysml` | `memo_viewpoints_usability_usability_engineering_view` | `MemoUsabilityEngineeringView` |
| `src/viewpoints/clinical/clinical_viewpoint.sysml` | `memo_viewpoints_clinical_clinical_viewpoint` | clinical viewpoint |
| `src/viewpoints/clinical/clinical_evidence_view.sysml` | `memo_viewpoints_clinical_clinical_evidence_view` | `MemoClinicalEvidenceView` |
| `src/viewpoints/cybersecurity/cybersecurity_viewpoint.sysml` | `memo_viewpoints_cybersecurity_cybersecurity_viewpoint` | cybersecurity viewpoint |
| `src/viewpoints/cybersecurity/cybersecurity_assessment_view.sysml` | `memo_viewpoints_cybersecurity_cybersecurity_assessment_view` | `MemoCybersecurityAssessmentView` |
| `src/viewpoints/cybersecurity/threat_model_view.sysml` | `memo_viewpoints_cybersecurity_threat_model_view` | `MemoCybersecurityThreatModelView` |

## Source conventions

- A `part def`, `action def`, `requirement def`, `use case def`, or `connection def` introduces a reusable type.
- A `part`, `action`, `requirement`, or `use case` creates a usage of that type in a project or example.
- A `connection def` names a relationship with typed ends; read the end names as a sentence.
- `view def` and `view` define what a review presentation selects; they do not create duplicate engineering elements.

For every file, open the cited SysML source when you need its complete
attributes, multiplicities, imports, and relationship ends. The source is the
authoritative class-level API.
