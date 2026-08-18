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

    // The display identity of one enumeration value.
    //
    // `enumValue` is the FULLY QUALIFIED value as the model stores it
    // ("StatusKind::tbd"), which is the only spelling that identifies a member
    // unambiguously. A consumer matches on that and reads the label; it must
    // never parse the string, because a suffix test like `endsWith("resolved")`
    // silently mismatches the moment a member is renamed or a new member ends
    // in the same word.
    //
    // Labels live here rather than in an application for the same reason layer
    // colours do: a consumer that received the ontology without them would
    // render different text for the same model. The static HTML export, the DHF
    // workbench and a report generator all resolve the same label from here.
    part def EnumRendering :> MemoPart {
        attribute enumValue : String;
        attribute label : String;
        attribute shortLabel : String[0..1];
        attribute enumColor : String[0..1];
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

    // ── Enumeration labels ───────────────────────────────────────
    // Seeded with the three status enums. `StatusKind` is the standard
    // ModelingMetadata one and is seeded first because its members are
    // abbreviations no reader expands on sight; it tracks whether a
    // question about an element is settled, which is orthogonal to
    // `ElementStatusKind` tracking where the element sits in its
    // controlled lifecycle. An element can be released and still carry a
    // tbr on one unresolved value.


    part enumStatusOpen : EnumRendering {
        attribute :>> id = "ENUM-STATUS-001";
        attribute :>> name = "EnumStatusOpen";
        attribute :>> enumValue = "StatusKind::open";
        attribute :>> label = "Open";
        attribute :>> shortLabel = "Open";
        attribute :>> enumColor = "#6B7280";
    }

    part enumStatusTbd : EnumRendering {
        attribute :>> id = "ENUM-STATUS-002";
        attribute :>> name = "EnumStatusTbd";
        attribute :>> enumValue = "StatusKind::tbd";
        attribute :>> label = "To Be Determined";
        attribute :>> shortLabel = "TBD";
        attribute :>> enumColor = "#D97706";
    }

    part enumStatusTbr : EnumRendering {
        attribute :>> id = "ENUM-STATUS-003";
        attribute :>> name = "EnumStatusTbr";
        attribute :>> enumValue = "StatusKind::tbr";
        attribute :>> label = "To Be Resolved";
        attribute :>> shortLabel = "TBR";
        attribute :>> enumColor = "#D97706";
    }

    part enumStatusTbc : EnumRendering {
        attribute :>> id = "ENUM-STATUS-004";
        attribute :>> name = "EnumStatusTbc";
        attribute :>> enumValue = "StatusKind::tbc";
        attribute :>> label = "To Be Confirmed";
        attribute :>> shortLabel = "TBC";
        attribute :>> enumColor = "#D97706";
    }

    part enumStatusDone : EnumRendering {
        attribute :>> id = "ENUM-STATUS-005";
        attribute :>> name = "EnumStatusDone";
        attribute :>> enumValue = "StatusKind::done";
        attribute :>> label = "Done";
        attribute :>> shortLabel = "Done";
        attribute :>> enumColor = "#0F766E";
    }

    part enumStatusClosed : EnumRendering {
        attribute :>> id = "ENUM-STATUS-006";
        attribute :>> name = "EnumStatusClosed";
        attribute :>> enumValue = "StatusKind::closed";
        attribute :>> label = "Closed";
        attribute :>> shortLabel = "Closed";
        attribute :>> enumColor = "#0F766E";
    }

    part enumElementProposed : EnumRendering {
        attribute :>> id = "ENUM-ELEM-001";
        attribute :>> name = "EnumElementProposed";
        attribute :>> enumValue = "ElementStatusKind::proposed";
        attribute :>> label = "Proposed";
        attribute :>> enumColor = "#6B7280";
    }

    part enumElementDraft : EnumRendering {
        attribute :>> id = "ENUM-ELEM-002";
        attribute :>> name = "EnumElementDraft";
        attribute :>> enumValue = "ElementStatusKind::draft";
        attribute :>> label = "Draft";
        attribute :>> enumColor = "#6B7280";
    }

    part enumElementInReview : EnumRendering {
        attribute :>> id = "ENUM-ELEM-003";
        attribute :>> name = "EnumElementInReview";
        attribute :>> enumValue = "ElementStatusKind::inReview";
        attribute :>> label = "In Review";
        attribute :>> enumColor = "#D97706";
    }

    part enumElementApproved : EnumRendering {
        attribute :>> id = "ENUM-ELEM-004";
        attribute :>> name = "EnumElementApproved";
        attribute :>> enumValue = "ElementStatusKind::approved";
        attribute :>> label = "Approved";
        attribute :>> enumColor = "#0F766E";
    }

    part enumElementReleased : EnumRendering {
        attribute :>> id = "ENUM-ELEM-005";
        attribute :>> name = "EnumElementReleased";
        attribute :>> enumValue = "ElementStatusKind::released";
        attribute :>> label = "Released";
        attribute :>> enumColor = "#0F766E";
    }

    part enumElementDeprecated : EnumRendering {
        attribute :>> id = "ENUM-ELEM-006";
        attribute :>> name = "EnumElementDeprecated";
        attribute :>> enumValue = "ElementStatusKind::deprecated";
        attribute :>> label = "Deprecated";
        attribute :>> enumColor = "#B45309";
    }

    part enumElementRetired : EnumRendering {
        attribute :>> id = "ENUM-ELEM-007";
        attribute :>> name = "EnumElementRetired";
        attribute :>> enumValue = "ElementStatusKind::retired";
        attribute :>> label = "Retired";
        attribute :>> enumColor = "#991B1B";
    }

    part enumCommentOpen : EnumRendering {
        attribute :>> id = "ENUM-CMT-001";
        attribute :>> name = "EnumCommentOpen";
        attribute :>> enumValue = "CommentStatusKind::open";
        attribute :>> label = "Open";
        attribute :>> enumColor = "#2563EB";
    }

    part enumCommentAcknowledged : EnumRendering {
        attribute :>> id = "ENUM-CMT-002";
        attribute :>> name = "EnumCommentAcknowledged";
        attribute :>> enumValue = "CommentStatusKind::acknowledged";
        attribute :>> label = "Acknowledged";
        attribute :>> enumColor = "#2563EB";
    }

    part enumCommentAddressed : EnumRendering {
        attribute :>> id = "ENUM-CMT-003";
        attribute :>> name = "EnumCommentAddressed";
        attribute :>> enumValue = "CommentStatusKind::addressed";
        attribute :>> label = "Addressed";
        attribute :>> enumColor = "#0F766E";
    }

    part enumCommentResolved : EnumRendering {
        attribute :>> id = "ENUM-CMT-004";
        attribute :>> name = "EnumCommentResolved";
        attribute :>> enumValue = "CommentStatusKind::resolved";
        attribute :>> label = "Resolved";
        attribute :>> enumColor = "#0F766E";
    }

    part enumCommentRejected : EnumRendering {
        attribute :>> id = "ENUM-CMT-005";
        attribute :>> name = "EnumCommentRejected";
        attribute :>> enumValue = "CommentStatusKind::rejected";
        attribute :>> label = "Rejected";
        attribute :>> enumColor = "#991B1B";
    }
}
