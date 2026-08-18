package memo_examples_gpca_pump_viewpoints_risk_views_document_hazard_analysis_view {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_risk_risk_viewpoint::*;
    private import memo_core_enumerations::*;
    private import memo_examples_gpca_pump_gpca_analysis::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    view hazardAnalysisView : MemoDocumentView {
        expose memo_examples_gpca_pump_viewpoints_risk_views_document_hazard_analysis_view::*;
        expose fmeaDelivery;
        expose ftaOverdose;
        @MemoIdentity { :>> providedId = "DOC-009"; }
        attribute :>> name = "HazardAnalysisReportView";
        @MemoIdentity { :>> shortDescription = "Hazard analysis report aligned to the UMN CriSys GPCA hazard tables."; }
        attribute :>> description = "Aggregates the five hazard chains, the FMEA worksheet, and the overdose fault tree with their controls and verification pointers.";
        attribute :>> version = "0.1";
        attribute :>> lifecycleState = LifecycleStateKind::development;
        attribute :>> viewKind = DocumentViewKind::RMF;
        attribute :>> generationRule = "Include hazards, sequences of events, situations, harms, FMEA rows, fault tree, and controls";
        attribute :>> marketScope = "generic";
        ref :>> viewpointDefinition = riskViewpoint;
        part :>> selectionQuery {
            @MemoIdentity { :>> providedId = "QRY-DOC-003"; }
            attribute :>> name = "hazardAnalysisViewQuery";
            attribute :>> includeElementKinds = ("FMEAWorksheet", "FailureMode", "FailureCause", "FailureEffect", "DetectionMethod", "FMEAAction", "FaultTree", "FaultTreeNode", "MinimalCutSet", "Hazard", "HazardCause", "SequenceOfEvents");
            attribute :>> includeRelationshipKinds = ("HasFailureMode", "Causes", "DetectedBy", "Mitigates", "InputToGate", "ContainsEvent", "Mitigates");
            attribute :>> rationaleText = "Declares what this document-backed view renders; the web renderer is presentation-only.";
        }
    }
}
