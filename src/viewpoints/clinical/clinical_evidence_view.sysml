package memo {
    package viewpoints {
        package clinical {
                package clinical_evidence_view {
            private import memo::viewpoints::definitions::*;
            private import memo::core::enumerations::*;

            part def ClinicalEvidenceView specializes DocumentView {
                attribute viewKind = DocumentViewKind::Clinical;
                attribute generationRule = "Include use contexts, actors, and clinical evidence supporting the device's intended use, filtered to clinical concern.";
                attribute outputKind = {ViewOutputKind::documentSection};
                attribute presentationKind = {PresentationKind::narrativeSection};
            }
            }
        }
    }
}
