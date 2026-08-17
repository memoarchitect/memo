package memo_viewpoints_functional_functional_viewpoint {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;

    viewpoint functionalViewpoint : MemoViewpoint {
        attribute :>> id = "VP-FUNC";
        attribute :>> name = "FunctionalViewpoint";
        attribute :>> shortDescription = "Shows system functions, their decomposition, and allocation.";
        attribute :>> description = "Default viewpoint derived from the functions layer for what the system does, independent of how it is structured — function trees, function allocation, and behavior triggers.";
        attribute :>> purpose = "Describe the system's functional decomposition and behavior.";
        attribute :>> audience = (AudienceKind::systemArchitect);
        attribute :>> stage = WorkflowStageKind::architecture;
        attribute :>> abstractionLevel = "functional";
        attribute :>> outputKind = (ViewOutputKind::diagram);
        attribute :>> presentationKind = (PresentationKind::activityDiagram);
        attribute :>> concernKinds = (ConcernKind::safety, ConcernKind::performance);
        attribute :>> includedLayers = ("functions");
        attribute :>> explorerLane = "architecture";
        attribute :>> explorerOrder = 2;
        attribute :>> allowedElementKinds = ("SystemFunction", "ComponentFunction", "FunctionalFlow", "FunctionalFlowStep", "MemoScenario[scenarioKind=functional]", "FunctionalExchange");
        attribute :>> userExtensible = true;
    }
}
