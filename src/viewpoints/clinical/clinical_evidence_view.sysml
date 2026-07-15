package memo_viewpoints_clinical_clinical_evidence_view {
    private import ScalarValues::*;

                private import memo_viewpoints_definitions::*;
                private import memo_core_enumerations::*;

                part def ClinicalEvidenceView specializes DocumentView {
    attribute viewKind = DocumentViewKind::Clinical;
    attribute generationRule = "Include use contexts, actors, and clinical evidence supporting the device's intended use, filtered to clinical concern.";
    attribute outputKind = (ViewOutputKind::documentSection);
    attribute presentationKind = (PresentationKind::narrativeSection);
                }
}
