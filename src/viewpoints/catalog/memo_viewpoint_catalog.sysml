// Ontology-level viewpoint catalog (§22). Rendering-independent: each
// viewpoint states the concern it frames and the SysML v2 standard view kind
// it resolves to (general | interconnection | actionflow | statetransition |
// sequence | grid | browser | geometry). No renderer semantics here.
package memo_viewpoints_catalog {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_viewpoints_definitions::*;

    // A cataloged viewpoint: the Viewpoint descriptor plus its default
    // resolution to a standard SysML v2 view kind.

    // ── Content and context ─────────────────────────────────────
    part vpModelContent : Viewpoint {
        attribute :>> id = "VP-CAT-001"; attribute :>> name = "ModelContentViewpoint";
        attribute :>> purpose = "Browse the model tree and package structure.";
        attribute :>> defaultViewKind = DiagramViewKind::browser;
    }
    part vpSystemContext : Viewpoint {
        attribute :>> id = "VP-CAT-002"; attribute :>> name = "SystemContextViewpoint";
        attribute :>> purpose = "System of interest, actors, external systems, and context exchanges.";
        attribute :>> defaultViewKind = DiagramViewKind::general;
    }
    // ── Operational world ───────────────────────────────────────
    part vpUseCase : Viewpoint {
        attribute :>> id = "VP-CAT-003"; attribute :>> name = "UseCaseViewpoint";
        attribute :>> purpose = "Use cases, initiating users, supporting actors, and motivating needs.";
        attribute :>> defaultViewKind = DiagramViewKind::general;
    }
    part vpClinicalWorkflow : Viewpoint {
        attribute :>> id = "VP-CAT-004"; attribute :>> name = "ClinicalWorkflowViewpoint";
        attribute :>> purpose = "Workflow steps, decisions, parallel work, handoffs, and roles.";
        attribute :>> defaultViewKind = DiagramViewKind::actionflow;
    }
    part vpOperativeScenario : Viewpoint {
        attribute :>> id = "VP-CAT-005"; attribute :>> name = "OperativeScenarioViewpoint";
        attribute :>> purpose = "Selected paths through workflows: variants, conditions, variation points.";
        attribute :>> defaultViewKind = DiagramViewKind::actionflow;
    }
    // ── Functional ──────────────────────────────────────────────
    part vpFunctionalArchitecture : Viewpoint {
        attribute :>> id = "VP-CAT-006"; attribute :>> name = "FunctionalArchitectureViewpoint";
        attribute :>> purpose = "System functions, capabilities, and functional exchanges.";
        attribute :>> defaultViewKind = DiagramViewKind::general;
    }
    part vpFunctionalFlow : Viewpoint {
        attribute :>> id = "VP-CAT-007"; attribute :>> name = "FunctionalFlowViewpoint";
        attribute :>> purpose = "Ordered functional flows and their steps.";
        attribute :>> defaultViewKind = DiagramViewKind::actionflow;
    }
    // ── Logical ─────────────────────────────────────────────────
    part vpLogicalArchitecture : Viewpoint {
        attribute :>> id = "VP-CAT-008"; attribute :>> name = "LogicalArchitectureViewpoint";
        attribute :>> purpose = "Logical components, channels, and allocations.";
        attribute :>> defaultViewKind = DiagramViewKind::general;
    }
    part vpSystemDecomposition : Viewpoint {
        attribute :>> id = "VP-CAT-009"; attribute :>> name = "SystemDecompositionViewpoint";
        attribute :>> purpose = "Composition hierarchy of the system of interest.";
        attribute :>> defaultViewKind = DiagramViewKind::browser;
    }
    part vpInternalInterconnection : Viewpoint {
        attribute :>> id = "VP-CAT-010"; attribute :>> name = "InternalInterconnectionViewpoint";
        attribute :>> purpose = "Ports, connectors, and exchanges inside a component boundary.";
        attribute :>> defaultViewKind = DiagramViewKind::interconnection;
    }
    // ── Implementation ──────────────────────────────────────────
    part vpSoftwareModule : Viewpoint {
        attribute :>> id = "VP-CAT-011"; attribute :>> name = "SoftwareModuleViewpoint";
        attribute :>> purpose = "IEC 62304 module structure: systems, items, units, SOUP.";
        attribute :>> defaultViewKind = DiagramViewKind::general;
    }
    part vpSoftwareComponents : Viewpoint {
        attribute :>> id = "VP-CAT-012"; attribute :>> name = "SoftwareComponentViewpoint";
        attribute :>> purpose = "Runtime component-and-connector structure with concurrency and scheduling.";
        attribute :>> defaultViewKind = DiagramViewKind::interconnection;
    }
    part vpHardwareArchitecture : Viewpoint {
        attribute :>> id = "VP-CAT-013"; attribute :>> name = "HardwareArchitectureViewpoint";
        attribute :>> purpose = "Electronic/electrical structure and processing platform.";
        attribute :>> defaultViewKind = DiagramViewKind::general;
    }
    part vpPhysicalArchitecture : Viewpoint {
        attribute :>> id = "VP-CAT-014"; attribute :>> name = "PhysicalArchitectureViewpoint";
        attribute :>> purpose = "Mechanical, fluidic, optical, and other physical realization.";
        attribute :>> defaultViewKind = DiagramViewKind::general;
    }
    part vpDeviceComposition : Viewpoint {
        attribute :>> id = "VP-CAT-015"; attribute :>> name = "DeviceCompositionViewpoint";
        attribute :>> purpose = "Device definitions, instances, accessories, and consumables.";
        attribute :>> defaultViewKind = DiagramViewKind::browser;
    }
    part vpNetworkDeployment : Viewpoint {
        attribute :>> id = "VP-CAT-016"; attribute :>> name = "NetworkDeploymentViewpoint";
        attribute :>> purpose = "Deployment units on processing nodes and network topology.";
        attribute :>> defaultViewKind = DiagramViewKind::interconnection;
    }
    // ── Interaction and behavior ────────────────────────────────
    part vpUiFlow : Viewpoint {
        attribute :>> id = "VP-CAT-017"; attribute :>> name = "UiFlowViewpoint";
        attribute :>> purpose = "Interaction flows, UI states, and transitions.";
        attribute :>> defaultViewKind = DiagramViewKind::statetransition;
    }
    part vpStateMode : Viewpoint {
        attribute :>> id = "VP-CAT-018"; attribute :>> name = "StateModeViewpoint";
        attribute :>> purpose = "System states, device modes, and transitions.";
        attribute :>> defaultViewKind = DiagramViewKind::statetransition;
    }
    part vpSequenceInteraction : Viewpoint {
        attribute :>> id = "VP-CAT-019"; attribute :>> name = "SequenceInteractionViewpoint";
        attribute :>> purpose = "Ordered message exchanges between participants in a scenario.";
        attribute :>> defaultViewKind = DiagramViewKind::sequence;
    }
    // ── Assurance ───────────────────────────────────────────────
    part vpRequirementsTraceability : Viewpoint {
        attribute :>> id = "VP-CAT-020"; attribute :>> name = "RequirementsTraceabilityViewpoint";
        attribute :>> purpose = "Needs → requirements → architecture → verification trace matrix.";
        attribute :>> defaultViewKind = DiagramViewKind::grid;
    }
    part vpRiskChain : Viewpoint {
        attribute :>> id = "VP-CAT-021"; attribute :>> name = "RiskChainViewpoint";
        attribute :>> purpose = "ISO 14971 chain: hazard → hazardous situation → harm with controls.";
        attribute :>> defaultViewKind = DiagramViewKind::general;
    }
    part vpCybersecurity : Viewpoint {
        attribute :>> id = "VP-CAT-022"; attribute :>> name = "CybersecurityViewpoint";
        attribute :>> purpose = "Assets, threats, trust boundaries, and security controls.";
        attribute :>> defaultViewKind = DiagramViewKind::general;
    }
    part vpHumanFactors : Viewpoint {
        attribute :>> id = "VP-CAT-023"; attribute :>> name = "HumanFactorsViewpoint";
        attribute :>> purpose = "Users, tasks, use errors, and hazard-related use scenarios.";
        attribute :>> defaultViewKind = DiagramViewKind::grid;
    }
    part vpVerificationCoverage : Viewpoint {
        attribute :>> id = "VP-CAT-024"; attribute :>> name = "VerificationCoverageViewpoint";
        attribute :>> purpose = "Verification cases against requirements and functions.";
        attribute :>> defaultViewKind = DiagramViewKind::grid;
    }
    part vpValidationCoverage : Viewpoint {
        attribute :>> id = "VP-CAT-025"; attribute :>> name = "ValidationCoverageViewpoint";
        attribute :>> purpose = "Validation cases against use cases and critical tasks.";
        attribute :>> defaultViewKind = DiagramViewKind::grid;
    }
    part vpEvidenceTraceability : Viewpoint {
        attribute :>> id = "VP-CAT-026"; attribute :>> name = "EvidenceTraceabilityViewpoint";
        attribute :>> purpose = "Evidence records back to the cases and elements they support.";
        attribute :>> defaultViewKind = DiagramViewKind::grid;
    }
    // A software sequence diagram is a VIEW conforming to this viewpoint
    // (ISO/IEC/IEEE 42010): it frames the runtime message ordering between
    // SoftwareComponents realizing a FunctionalScenario. The viewpoint is the
    // reusable spec; the diagram of a specific model is the view.
    part vpSoftwareSequence : Viewpoint {
        attribute :>> id = "VP-CAT-027"; attribute :>> name = "SoftwareSequenceViewpoint";
        attribute :>> purpose = "Runtime message ordering between software components along a functional scenario.";
        attribute :>> defaultViewKind = DiagramViewKind::sequence;
    }

    // ── Compatibility mappings (§22): legacy diagram intents resolve to
    //     standard view kinds; C4 and AADL stay in examples/ mappings. ──
    part def DiagramIntentMapping specializes MemoPart {
        attribute legacyIntent : String;
        attribute resolvesTo : DiagramViewKind;
    }
    part mapBdd : DiagramIntentMapping {
        attribute :>> legacyIntent = "BDD"; attribute :>> resolvesTo = DiagramViewKind::general;
    }
    part mapIbd : DiagramIntentMapping {
        attribute :>> legacyIntent = "IBD"; attribute :>> resolvesTo = DiagramViewKind::interconnection;
    }
    part mapActivity : DiagramIntentMapping {
        attribute :>> legacyIntent = "activity/operational/functional flow"; attribute :>> resolvesTo = DiagramViewKind::actionflow;
    }
    part mapStateMachine : DiagramIntentMapping {
        attribute :>> legacyIntent = "state machine"; attribute :>> resolvesTo = DiagramViewKind::statetransition;
    }
    part mapSequence : DiagramIntentMapping {
        attribute :>> legacyIntent = "sequence"; attribute :>> resolvesTo = DiagramViewKind::sequence;
    }
    part mapAllocationMatrix : DiagramIntentMapping {
        attribute :>> legacyIntent = "allocation/traceability/FMEA"; attribute :>> resolvesTo = DiagramViewKind::grid;
    }
    part mapHierarchy : DiagramIntentMapping {
        attribute :>> legacyIntent = "hierarchy/content"; attribute :>> resolvesTo = DiagramViewKind::browser;
    }
}
