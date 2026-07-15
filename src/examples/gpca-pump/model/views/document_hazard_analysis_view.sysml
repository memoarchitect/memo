package memo_examples_gpca_pump_model_views_document_hazard_analysis_view {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_cybersecurity_cybersecurity_viewpoint::*;
    private import memo_viewpoints_cybersecurity_threat_model_view::*;
    private import memo_viewpoints_cybersecurity_cybersecurity_assessment_view::*;
    private import memo_viewpoints_usability_usability_engineering_view::*;
    private import memo_core_enumerations::*;

    part hazardAnalysisView : DocumentView {
        attribute :>> id = "DOC-009";
        attribute :>> name = "HazardAnalysisReportView";
        attribute :>> title = "GPCA Hazard Analysis Report View";
        attribute :>> shortDescription = "Hazard analysis report aligned to the UMN CriSys GPCA hazard tables.";
        attribute :>> longDescription = "Aggregates the five hazard chains, the FMEA worksheet, and the overdose fault tree with their controls and verification pointers.";
        attribute :>> version = "0.1";
        attribute :>> lifecycleState = LifecycleStateKind::development;
        attribute :>> viewKind = DocumentViewKind::RMF;
        attribute :>> generationRule = "Include hazards, sequences of events, situations, harms, FMEA rows, fault tree, and controls";
        attribute :>> marketScope = "generic";
        attribute :>> documentUsage = ("Hazard Analysis Report", "RMF");
        attribute :>> sectionIdentifier = "HAZ";
        part :>> selectionQuery {
            attribute :>> id = "QRY-DOC-003";
            attribute :>> name = "hazardAnalysisViewQuery";
            attribute :>> includeElementKinds = ("FMEAWorksheet", "FailureMode", "FailureCause", "FailureEffect", "DetectionMethod", "FMEAAction", "FaultTree", "FaultTreeEvent", "FaultTreeGate", "MinimalCutSet", "Hazard", "HazardCause", "SequenceOfEvents");
            attribute :>> includeRelationshipKinds = ("HasFailureMode", "CausedBy", "CausesEffect", "DetectedBy", "AddressedByAction", "InputToGate", "ContainsEvent", "OriginatesFrom", "ContributesToHazard", "BrokenByControl", "IncludedIn");
            attribute :>> rationaleText = "Declares what this document-backed view renders; the web renderer is presentation-only.";
        }
    }
}
