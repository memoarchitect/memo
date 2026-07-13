package memo {
    package viewpoints {
        package cybersecurity {
                package threat_model_view {
            private import memo::viewpoints::definitions::*;
            private import memo::core::enumerations::*;

            part def CybersecurityThreatModelView specializes DocumentView {
                attribute viewKind = DocumentViewKind::ThreatModel;
                attribute generationRule = "Include assets, trust boundaries, threat scenarios, vulnerabilities, mitigations, and trace links to safety/privacy concerns.";
                attribute outputKind = {ViewOutputKind::documentSection};
                attribute presentationKind = {PresentationKind::narrativeSection};
            }
            }
        }
    }
}
