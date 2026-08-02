// Architecture-layer rendering and Model Explorer taxonomy.
//
// This content used to live in `ontology/memo.rendering.yaml`. Both halves of
// that file decided how MEMO's own kinds are grouped and presented, which makes
// them ontology metadata, not application settings: a project that received the
// ontology without the YAML got a different Explorer. They are SysML here so
// that the ontology carries its own taxonomy wherever it is resolved.
//
// The colours are the v12 Visual Map palette. They are the ontology's authored
// default; an application may still theme over them, but it no longer has to
// supply them for the model to be complete.
package memo_viewpoints_rendering {
    private import ScalarValues::*;

    private import memo_core_common::*;

    // The presentation identity of one architecture layer.
    part def LayerRendering :> MemoPart {
        attribute layerId : String;
        attribute layerLabel : String;
        attribute layerColor : String;
    }

    // Where a source namespace's kinds appear in the Model Explorer tree.
    // `sourceNamespace` names the ontology namespace or kind group the
    // classification applies to; `explorerDomain` and `explorerGroup` name its
    // place in MEMO's V-model taxonomy.
    part def ExplorerClassification :> MemoPart {
        attribute sourceNamespace : String;
        attribute explorerDomain : String;
        attribute explorerGroup : String;
    }

    part layerOperationalRendering : LayerRendering {
        attribute :>> id = "LAYER-OPERATIONAL";
        attribute :>> name = "OperationalLayerRendering";
        attribute :>> layerId = "operational";
        attribute :>> layerLabel = "Operational";
        attribute :>> layerColor = "#C0392B";
    }

    part layerBehavioralRendering : LayerRendering {
        attribute :>> id = "LAYER-BEHAVIORAL";
        attribute :>> name = "BehavioralLayerRendering";
        attribute :>> layerId = "behavioral";
        attribute :>> layerLabel = "Behavioral";
        attribute :>> layerColor = "#E74C3C";
    }

    part layerFunctionalRendering : LayerRendering {
        attribute :>> id = "LAYER-FUNCTIONAL";
        attribute :>> name = "FunctionalLayerRendering";
        attribute :>> layerId = "functional";
        attribute :>> layerLabel = "Functional";
        attribute :>> layerColor = "#E67E22";
    }

    part layerLogicalRendering : LayerRendering {
        attribute :>> id = "LAYER-LOGICAL";
        attribute :>> name = "LogicalLayerRendering";
        attribute :>> layerId = "logical";
        attribute :>> layerLabel = "Logical";
        attribute :>> layerColor = "#7B68EE";
    }

    part layerSoftwareRendering : LayerRendering {
        attribute :>> id = "LAYER-SOFTWARE";
        attribute :>> name = "SoftwareLayerRendering";
        attribute :>> layerId = "software";
        attribute :>> layerLabel = "Software";
        attribute :>> layerColor = "#F39C12";
    }

    part layerSoftwareExtensionRendering : LayerRendering {
        attribute :>> id = "LAYER-SOFTWARE-EXTENSION";
        attribute :>> name = "Software Extension (ROS)LayerRendering";
        attribute :>> layerId = "software-extension";
        attribute :>> layerLabel = "Software Extension (ROS)";
        attribute :>> layerColor = "#D4AC0D";
    }

    part layerHardwareRendering : LayerRendering {
        attribute :>> id = "LAYER-HARDWARE";
        attribute :>> name = "HardwareLayerRendering";
        attribute :>> layerId = "hardware";
        attribute :>> layerLabel = "Hardware";
        attribute :>> layerColor = "#95A5A6";
    }

    part layerSafetyRendering : LayerRendering {
        attribute :>> id = "LAYER-SAFETY";
        attribute :>> name = "SafetyLayerRendering";
        attribute :>> layerId = "safety";
        attribute :>> layerLabel = "Safety";
        attribute :>> layerColor = "#E74C3C";
    }

    part layerSecurityRendering : LayerRendering {
        attribute :>> id = "LAYER-SECURITY";
        attribute :>> name = "SecurityLayerRendering";
        attribute :>> layerId = "security";
        attribute :>> layerLabel = "Security";
        attribute :>> layerColor = "#2C3E50";
    }

    part layerPrivacyRendering : LayerRendering {
        attribute :>> id = "LAYER-PRIVACY";
        attribute :>> name = "PrivacyLayerRendering";
        attribute :>> layerId = "privacy";
        attribute :>> layerLabel = "Privacy";
        attribute :>> layerColor = "#8E44AD";
    }

    part layerVerificationRendering : LayerRendering {
        attribute :>> id = "LAYER-VERIFICATION";
        attribute :>> name = "VerificationLayerRendering";
        attribute :>> layerId = "verification";
        attribute :>> layerLabel = "Verification";
        attribute :>> layerColor = "#2ECC71";
    }

    part explorerActivitiesClassification : ExplorerClassification {
        attribute :>> id = "EXPL-001";
        attribute :>> name = "activitiesExplorerClassification";
        attribute :>> sourceNamespace = "activities";
        attribute :>> explorerDomain = "architecture";
        attribute :>> explorerGroup = "operational";
    }

    part explorerContextClassification : ExplorerClassification {
        attribute :>> id = "EXPL-002";
        attribute :>> name = "contextExplorerClassification";
        attribute :>> sourceNamespace = "context";
        attribute :>> explorerDomain = "architecture";
        attribute :>> explorerGroup = "operational";
    }

    part explorerActorsClassification : ExplorerClassification {
        attribute :>> id = "EXPL-003";
        attribute :>> name = "actorsExplorerClassification";
        attribute :>> sourceNamespace = "actors";
        attribute :>> explorerDomain = "architecture";
        attribute :>> explorerGroup = "operational";
    }

    part explorerUseContextClassification : ExplorerClassification {
        attribute :>> id = "EXPL-004";
        attribute :>> name = "use_contextExplorerClassification";
        attribute :>> sourceNamespace = "use_context";
        attribute :>> explorerDomain = "architecture";
        attribute :>> explorerGroup = "operational";
    }

    part explorerWorkflowsClassification : ExplorerClassification {
        attribute :>> id = "EXPL-005";
        attribute :>> name = "workflowsExplorerClassification";
        attribute :>> sourceNamespace = "workflows";
        attribute :>> explorerDomain = "architecture";
        attribute :>> explorerGroup = "operational";
    }

    part explorerScenariosClassification : ExplorerClassification {
        attribute :>> id = "EXPL-006";
        attribute :>> name = "scenariosExplorerClassification";
        attribute :>> sourceNamespace = "scenarios";
        attribute :>> explorerDomain = "architecture";
        attribute :>> explorerGroup = "operational";
    }

    part explorerUseCasesClassification : ExplorerClassification {
        attribute :>> id = "EXPL-007";
        attribute :>> name = "use_casesExplorerClassification";
        attribute :>> sourceNamespace = "use_cases";
        attribute :>> explorerDomain = "architecture";
        attribute :>> explorerGroup = "operational";
    }

    part explorerInteractionClassification : ExplorerClassification {
        attribute :>> id = "EXPL-008";
        attribute :>> name = "interactionExplorerClassification";
        attribute :>> sourceNamespace = "interaction";
        attribute :>> explorerDomain = "architecture";
        attribute :>> explorerGroup = "operational";
    }

    part explorerOperationalClassification : ExplorerClassification {
        attribute :>> id = "EXPL-009";
        attribute :>> name = "operationalExplorerClassification";
        attribute :>> sourceNamespace = "operational";
        attribute :>> explorerDomain = "architecture";
        attribute :>> explorerGroup = "operational";
    }

    part explorerFunctionsClassification : ExplorerClassification {
        attribute :>> id = "EXPL-010";
        attribute :>> name = "functionsExplorerClassification";
        attribute :>> sourceNamespace = "functions";
        attribute :>> explorerDomain = "architecture";
        attribute :>> explorerGroup = "functional";
    }

    part explorerBehaviorClassification : ExplorerClassification {
        attribute :>> id = "EXPL-011";
        attribute :>> name = "behaviorExplorerClassification";
        attribute :>> sourceNamespace = "behavior";
        attribute :>> explorerDomain = "architecture";
        attribute :>> explorerGroup = "functional";
    }

    part explorerConstraintsClassification : ExplorerClassification {
        attribute :>> id = "EXPL-012";
        attribute :>> name = "constraintsExplorerClassification";
        attribute :>> sourceNamespace = "constraints";
        attribute :>> explorerDomain = "architecture";
        attribute :>> explorerGroup = "functional";
    }

    part explorerLogicalStructureClassification : ExplorerClassification {
        attribute :>> id = "EXPL-013";
        attribute :>> name = "logical_structureExplorerClassification";
        attribute :>> sourceNamespace = "logical_structure";
        attribute :>> explorerDomain = "architecture";
        attribute :>> explorerGroup = "logical";
    }

    part explorerInterfacesClassification : ExplorerClassification {
        attribute :>> id = "EXPL-014";
        attribute :>> name = "interfacesExplorerClassification";
        attribute :>> sourceNamespace = "interfaces";
        attribute :>> explorerDomain = "architecture";
        attribute :>> explorerGroup = "logical";
    }

    part explorerHardwareStructureClassification : ExplorerClassification {
        attribute :>> id = "EXPL-015";
        attribute :>> name = "hardware_structureExplorerClassification";
        attribute :>> sourceNamespace = "hardware_structure";
        attribute :>> explorerDomain = "architecture";
        attribute :>> explorerGroup = "implementation";
    }

    part explorerImplementationClassification : ExplorerClassification {
        attribute :>> id = "EXPL-016";
        attribute :>> name = "implementationExplorerClassification";
        attribute :>> sourceNamespace = "implementation";
        attribute :>> explorerDomain = "architecture";
        attribute :>> explorerGroup = "implementation";
    }

    part explorerSoftwareStructureClassification : ExplorerClassification {
        attribute :>> id = "EXPL-017";
        attribute :>> name = "software_structureExplorerClassification";
        attribute :>> sourceNamespace = "software_structure";
        attribute :>> explorerDomain = "architecture";
        attribute :>> explorerGroup = "implementation";
    }

    part explorerSoftwareRuntimeClassification : ExplorerClassification {
        attribute :>> id = "EXPL-018";
        attribute :>> name = "software_runtimeExplorerClassification";
        attribute :>> sourceNamespace = "software_runtime";
        attribute :>> explorerDomain = "architecture";
        attribute :>> explorerGroup = "implementation";
    }

    part explorerPhysicalClassification : ExplorerClassification {
        attribute :>> id = "EXPL-019";
        attribute :>> name = "physicalExplorerClassification";
        attribute :>> sourceNamespace = "physical";
        attribute :>> explorerDomain = "architecture";
        attribute :>> explorerGroup = "realization";
    }

    part explorerDeploymentClassification : ExplorerClassification {
        attribute :>> id = "EXPL-020";
        attribute :>> name = "deploymentExplorerClassification";
        attribute :>> sourceNamespace = "deployment";
        attribute :>> explorerDomain = "architecture";
        attribute :>> explorerGroup = "realization";
    }

    part explorerNeedsClassification : ExplorerClassification {
        attribute :>> id = "EXPL-021";
        attribute :>> name = "needsExplorerClassification";
        attribute :>> sourceNamespace = "needs";
        attribute :>> explorerDomain = "assurance";
        attribute :>> explorerGroup = "requirements";
    }

    part explorerRequirementsClassification : ExplorerClassification {
        attribute :>> id = "EXPL-022";
        attribute :>> name = "requirementsExplorerClassification";
        attribute :>> sourceNamespace = "requirements";
        attribute :>> explorerDomain = "assurance";
        attribute :>> explorerGroup = "requirements";
    }

    part explorerSafetyClassification : ExplorerClassification {
        attribute :>> id = "EXPL-023";
        attribute :>> name = "safetyExplorerClassification";
        attribute :>> sourceNamespace = "safety";
        attribute :>> explorerDomain = "assurance";
        attribute :>> explorerGroup = "safety-risk";
    }

    part explorerSafetyAnalysisClassification : ExplorerClassification {
        attribute :>> id = "EXPL-024";
        attribute :>> name = "safety_analysisExplorerClassification";
        attribute :>> sourceNamespace = "safety_analysis";
        attribute :>> explorerDomain = "assurance";
        attribute :>> explorerGroup = "safety-risk";
    }

    part explorerCybersecurityClassification : ExplorerClassification {
        attribute :>> id = "EXPL-025";
        attribute :>> name = "cybersecurityExplorerClassification";
        attribute :>> sourceNamespace = "cybersecurity";
        attribute :>> explorerDomain = "assurance";
        attribute :>> explorerGroup = "cybersecurity";
    }

    part explorerHumanFactorsClassification : ExplorerClassification {
        attribute :>> id = "EXPL-026";
        attribute :>> name = "human_factorsExplorerClassification";
        attribute :>> sourceNamespace = "human_factors";
        attribute :>> explorerDomain = "assurance";
        attribute :>> explorerGroup = "human-factors";
    }

    part explorerVerificationClassification : ExplorerClassification {
        attribute :>> id = "EXPL-027";
        attribute :>> name = "verificationExplorerClassification";
        attribute :>> sourceNamespace = "verification";
        attribute :>> explorerDomain = "assurance";
        attribute :>> explorerGroup = "verification-validation";
    }

    part explorerCoreClassification : ExplorerClassification {
        attribute :>> id = "EXPL-028";
        attribute :>> name = "coreExplorerClassification";
        attribute :>> sourceNamespace = "core";
        attribute :>> explorerDomain = "assurance";
        attribute :>> explorerGroup = "evidence";
    }

    part explorerMethodologyClassification : ExplorerClassification {
        attribute :>> id = "EXPL-029";
        attribute :>> name = "methodologyExplorerClassification";
        attribute :>> sourceNamespace = "methodology";
        attribute :>> explorerDomain = "methodology";
        attribute :>> explorerGroup = "methodology";
    }

}
