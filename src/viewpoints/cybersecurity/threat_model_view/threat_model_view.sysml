package memo_viewpoints_cybersecurity_threat_model_view {
    private import ScalarValues::*;

                private import memo_viewpoints_definitions::*;
                private import memo_core_enumerations::*;

                view def MemoCybersecurityThreatModelView :> MemoDocumentView {
    attribute :>> viewKind = DocumentViewKind::ThreatModel;
    attribute :>> generationRule = "Include assets, trust boundaries, threat scenarios, vulnerabilities, mitigations, and trace links to safety/privacy concerns.";
    attribute :>> outputKind = (ViewOutputKind::documentSection);
    attribute :>> presentationKind = (PresentationKind::narrativeSection);
                }
}
