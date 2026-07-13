package memo {
    package viewpoints {
        package usability {
                package usability_engineering_view {
            private import memo::viewpoints::definitions::*;
            private import memo::core::enumerations::*;

            part def UsabilityEngineeringView specializes DocumentView {
                attribute viewKind = DocumentViewKind::Usability;
                attribute generationRule = "Include actors, use contexts, use errors, and requirements tagged with the usability concern to support the Usability Engineering Report.";
                attribute outputKind = {ViewOutputKind::documentSection};
                attribute presentationKind = {PresentationKind::narrativeSection};
            }
            }
        }
    }
}
