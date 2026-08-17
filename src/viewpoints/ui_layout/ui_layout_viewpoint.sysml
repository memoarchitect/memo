package memo_viewpoints_ui_layout_ui_layout_viewpoint {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;

    viewpoint uiLayoutViewpoint : MemoViewpoint {
        attribute :>> id = "VP-UIL";
        attribute :>> name = "UILayoutViewpoint";
        attribute :>> shortDescription = "Shows screen captures with the UI element tree laid out over them.";
        attribute :>> description = "Frames the user interface spatially: a captured rendering of a screen, and the UIElement tree laid out over it by each element's bounds. Supports IEC 62366-1 use-related design review and the UI description in the software design specification, by making 'which control is this, and what does it do' answerable from the picture. There is one tree, not two — the elements carrying the geometry are the same elements carrying the requirements, functions, use errors, and risk controls.";
        attribute :>> purpose = "Review the interface as the user sees it, with every functional area backed by a design record.";
        attribute :>> audience = (AudienceKind::usabilityEngineer, AudienceKind::softwareArchitect, AudienceKind::safetyEngineer);
        attribute :>> stage = WorkflowStageKind::architecture;
        attribute :>> abstractionLevel = "implementation";
        attribute :>> outputKind = (ViewOutputKind::diagram, ViewOutputKind::documentSection);
        attribute :>> presentationKind = (PresentationKind::screenLayout);
        attribute :>> concernKinds = (ConcernKind::usability, ConcernKind::safety);
        attribute :>> includedLayers = ("implementation");
        attribute :>> explorerLane = "architecture";
        attribute :>> explorerOrder = 4;
        attribute :>> allowedElementKinds = ("ScreenCapture", "UIElement", "UserInterface");
        attribute :>> allowedRelationshipKinds = ("CapturesScreen", "NavigatesTo", "Composes", "satisfy", "ElementTriggersAction");
        attribute :>> defaultViewKind = DiagramViewKind::geometry;
        attribute :>> userExtensible = true;
    }
}
