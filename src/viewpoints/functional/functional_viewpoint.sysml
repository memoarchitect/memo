package memo_viewpoints_functional_functional_viewpoint {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;

    part functionalViewpoint : Viewpoint {
        attribute :>> id = "VP-FUNC";
        attribute :>> name = "FunctionalViewpoint";
        attribute :>> title = "Functional Viewpoint";
        attribute :>> shortDescription = "Shows system functions, their decomposition, and allocation.";
        attribute :>> longDescription = "Default viewpoint derived from the functions layer for what the system does, independent of how it is structured — function trees, function allocation, and behavior triggers.";
        attribute :>> purpose = "Describe the system's functional decomposition and behavior.";
        attribute :>> audience = (AudienceKind::systemArchitect);
        attribute :>> stage = WorkflowStageKind::architecture;
        attribute :>> abstractionLevel = "functional";
        attribute :>> outputKind = (ViewOutputKind::diagram);
        attribute :>> presentationKind = (PresentationKind::activityDiagram);
        attribute :>> concernKinds = (ConcernKind::safety, ConcernKind::performance);
        attribute :>> includedLayers = ("functions", "behavior");
        attribute :>> allowedElementKinds = ("LogicalFunction", "LogicalFlow", "ModeState");
        attribute :>> methodologyReference = ("default-layer-viewpoint");
        attribute :>> userExtensible = true;
    }
}
