package memo_viewpoints_cybersecurity_cybersecurity_assessment_view {
    private import ScalarValues::*;

                private import memo_viewpoints_definitions::*;
                private import memo_core_enumerations::*;

                part def CybersecurityAssessmentView specializes DocumentView {
    attribute :>> viewKind = DocumentViewKind::CybersecurityAssessment;
    attribute :>> generationRule = "Include cyber risks, exploitability, mitigations, security requirements, verification, residual risk, and postmarket evidence references.";
    attribute :>> outputKind = (ViewOutputKind::documentSection);
    attribute :>> presentationKind = (PresentationKind::riskTable);
                }
}
