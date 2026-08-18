// Ontology-level viewpoint catalog (§22). Rendering-independent: each
// viewpoint states the concern it frames and the SysML v2 standard view kind
// it resolves to (general | interconnection | actionflow | statetransition |
// sequence | grid | browser | geometry). No renderer semantics here.
package memo_viewpoints_catalog {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_viewpoints_definitions::*;

    private import memo_core_common::MemoIdentity;
    // A cataloged viewpoint: the Viewpoint descriptor plus its default
    // resolution to a standard SysML v2 view kind.

    // ── Content and context ─────────────────────────────────────
    viewpoint vpModelContent : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-CAT-001"; } attribute :>> name = "ModelContentViewpoint";
        attribute :>> purpose = "Browse the model tree and package structure.";
        attribute :>> defaultViewKind = DiagramViewKind::browser;
    }
    viewpoint vpSystemContext : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-CAT-002"; } attribute :>> name = "SystemContextViewpoint";
        attribute :>> purpose = "System of interest, actors, external systems, and context exchanges.";
        attribute :>> defaultViewKind = DiagramViewKind::general;
    }
    // ── Operational world ───────────────────────────────────────
    viewpoint vpUseCase : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-CAT-003"; } attribute :>> name = "UseCaseViewpoint";
        attribute :>> purpose = "Use cases, initiating users, supporting actors, and motivating needs.";
        attribute :>> defaultViewKind = DiagramViewKind::general;
    }
    viewpoint vpClinicalWorkflow : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-CAT-004"; } attribute :>> name = "ClinicalWorkflowViewpoint";
        attribute :>> purpose = "Workflow steps, decisions, parallel work, handoffs, and roles.";
        attribute :>> defaultViewKind = DiagramViewKind::actionflow;
    }
    viewpoint vpScenario : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-CAT-005"; } attribute :>> name = "ScenarioViewpoint";
        attribute :>> purpose = "Selected paths through workflows: variants, conditions, variation points.";
        attribute :>> defaultViewKind = DiagramViewKind::actionflow;
    }
    // ── Functional ──────────────────────────────────────────────
    viewpoint vpFunctionalArchitecture : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-CAT-006"; } attribute :>> name = "FunctionalArchitectureViewpoint";
        attribute :>> purpose = "System functions, capabilities, and functional exchanges.";
        attribute :>> defaultViewKind = DiagramViewKind::general;
    }
    viewpoint vpFunctionalFlow : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-CAT-007"; } attribute :>> name = "FunctionalFlowViewpoint";
        attribute :>> purpose = "Ordered functional flows and their steps.";
        attribute :>> defaultViewKind = DiagramViewKind::actionflow;
    }
    // ── Logical ─────────────────────────────────────────────────
    viewpoint vpLogicalArchitecture : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-CAT-008"; } attribute :>> name = "LogicalArchitectureViewpoint";
        attribute :>> purpose = "Logical components, channels, and allocations.";
        attribute :>> defaultViewKind = DiagramViewKind::general;
    }
    viewpoint vpSystemDecomposition : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-CAT-009"; } attribute :>> name = "SystemDecompositionViewpoint";
        attribute :>> purpose = "Composition hierarchy of the system of interest.";
        attribute :>> defaultViewKind = DiagramViewKind::browser;
    }
    viewpoint vpInternalInterconnection : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-CAT-010"; } attribute :>> name = "InternalInterconnectionViewpoint";
        attribute :>> purpose = "Ports, connectors, and exchanges inside a component boundary.";
        attribute :>> defaultViewKind = DiagramViewKind::interconnection;
    }
    // ── Implementation ──────────────────────────────────────────
    viewpoint vpSoftwareModule : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-CAT-011"; } attribute :>> name = "SoftwareModuleViewpoint";
        attribute :>> purpose = "IEC 62304 module structure: systems, items, units, SOUP.";
        attribute :>> defaultViewKind = DiagramViewKind::general;
    }
    viewpoint vpSoftwareComponents : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-CAT-012"; } attribute :>> name = "SoftwareComponentViewpoint";
        attribute :>> purpose = "Runtime component-and-connector structure with concurrency and scheduling.";
        attribute :>> defaultViewKind = DiagramViewKind::interconnection;
    }
    viewpoint vpHardwareArchitecture : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-CAT-013"; } attribute :>> name = "HardwareArchitectureViewpoint";
        attribute :>> purpose = "Electronic/electrical structure and processing platform.";
        attribute :>> defaultViewKind = DiagramViewKind::general;
    }
    viewpoint vpPhysicalArchitecture : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-CAT-014"; } attribute :>> name = "PhysicalArchitectureViewpoint";
        attribute :>> purpose = "Mechanical, fluidic, optical, and other physical realization.";
        attribute :>> defaultViewKind = DiagramViewKind::general;
    }
    viewpoint vpDeviceComposition : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-CAT-015"; } attribute :>> name = "DeviceCompositionViewpoint";
        attribute :>> purpose = "Device definitions, instances, accessories, and consumables.";
        attribute :>> defaultViewKind = DiagramViewKind::browser;
    }
    viewpoint vpNetworkDeployment : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-CAT-016"; } attribute :>> name = "NetworkDeploymentViewpoint";
        attribute :>> purpose = "Deployment units on processing nodes and network topology.";
        attribute :>> defaultViewKind = DiagramViewKind::interconnection;
    }
    // ── Interaction and behavior ────────────────────────────────
    viewpoint vpUiFlow : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-CAT-017"; } attribute :>> name = "UiFlowViewpoint";
        attribute :>> purpose = "Interaction flows, UI states, and transitions.";
        attribute :>> defaultViewKind = DiagramViewKind::statetransition;
    }
    viewpoint vpStateMode : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-CAT-018"; } attribute :>> name = "StateModeViewpoint";
        attribute :>> purpose = "System states, device modes, and transitions.";
        attribute :>> defaultViewKind = DiagramViewKind::statetransition;
    }
    viewpoint vpSequenceInteraction : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-CAT-019"; } attribute :>> name = "SequenceInteractionViewpoint";
        attribute :>> purpose = "Ordered message exchanges between participants in a scenario.";
        attribute :>> defaultViewKind = DiagramViewKind::sequence;
    }
    // ── Assurance ───────────────────────────────────────────────
    viewpoint vpRequirementsTraceability : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-CAT-020"; } attribute :>> name = "RequirementsTraceabilityViewpoint";
        attribute :>> purpose = "Needs → requirements → architecture → verification trace matrix.";
        attribute :>> defaultViewKind = DiagramViewKind::grid;
    }
    viewpoint vpRiskChain : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-CAT-021"; } attribute :>> name = "RiskChainViewpoint";
        attribute :>> purpose = "ISO 14971 chain: hazard → hazardous situation → harm with controls.";
        attribute :>> defaultViewKind = DiagramViewKind::general;
    }
    viewpoint vpCybersecurity : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-CAT-022"; } attribute :>> name = "CybersecurityViewpoint";
        attribute :>> purpose = "Assets, threats, trust boundaries, and security controls.";
        attribute :>> defaultViewKind = DiagramViewKind::general;
    }
    viewpoint vpHumanFactors : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-CAT-023"; } attribute :>> name = "HumanFactorsViewpoint";
        attribute :>> purpose = "Users, tasks, use errors, and hazard-related use scenarios.";
        attribute :>> defaultViewKind = DiagramViewKind::grid;
    }
    viewpoint vpVerificationCoverage : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-CAT-024"; } attribute :>> name = "VerificationCoverageViewpoint";
        attribute :>> purpose = "Verification cases against requirements and functions.";
        attribute :>> defaultViewKind = DiagramViewKind::grid;
    }
    viewpoint vpValidationCoverage : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-CAT-025"; } attribute :>> name = "ValidationCoverageViewpoint";
        attribute :>> purpose = "Validation cases against use cases and critical tasks.";
        attribute :>> defaultViewKind = DiagramViewKind::grid;
    }
    viewpoint vpEvidenceTraceability : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-CAT-026"; } attribute :>> name = "EvidenceTraceabilityViewpoint";
        attribute :>> purpose = "Evidence records back to the cases and elements they support.";
        attribute :>> defaultViewKind = DiagramViewKind::grid;
    }
    // A software sequence diagram is a VIEW conforming to this viewpoint
    // (ISO/IEC/IEEE 42010): it frames the runtime message ordering between
    // SoftwareComponents realizing a functional OperativeScenario. The viewpoint is the
    // reusable spec; the diagram of a specific model is the view.
    viewpoint vpSoftwareSequence : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-CAT-027"; } attribute :>> name = "SoftwareSequenceViewpoint";
        attribute :>> purpose = "Runtime message ordering between software components along a functional scenario.";
        attribute :>> defaultViewKind = DiagramViewKind::sequence;
    }
    // The first cataloged viewpoint to resolve to `geometry`: screen regions
    // carry authored RegionBounds, so a geometry view draws modelled facts.
    viewpoint vpUILayout : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-CAT-028"; } attribute :>> name = "UILayoutViewpoint";
        attribute :>> purpose = "Captured screens with their marked regions and the UI elements those regions present.";
        attribute :>> defaultViewKind = DiagramViewKind::geometry;
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
