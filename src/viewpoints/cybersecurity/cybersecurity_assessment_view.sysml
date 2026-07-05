package memo {
    package viewpoints {
        package cybersecurity {
                package cybersecurity_assessment_view {
            private import memo::viewpoints::definitions::*;
            private import memo::core::enumerations::*;

            part def CybersecurityAssessmentView specializes DocumentView {
                attribute viewKind = DocumentViewKind::CybersecurityAssessment;
                attribute generationRule = "Include cyber risks, exploitability, mitigations, security requirements, verification, residual risk, and postmarket evidence references.";
                attribute outputKind = {ViewOutputKind::documentSection};
                attribute presentationKind = {PresentationKind::riskTable};
            }
            }
        }
    }
}
