package memo_viewpoints_usability_usability_engineering_view {
    private import ScalarValues::*;

                private import memo_viewpoints_definitions::*;
                private import memo_core_enumerations::*;

                part def UsabilityEngineeringView specializes DocumentView {
    attribute viewKind = DocumentViewKind::Usability;
    attribute generationRule = "Include actors, use contexts, use errors, and requirements tagged with the usability concern to support the Usability Engineering Report.";
    attribute outputKind = (ViewOutputKind::documentSection);
    attribute presentationKind = (PresentationKind::narrativeSection);
                }
}
