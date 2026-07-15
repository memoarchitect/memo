package memo_viewpoints_operational_operational_viewpoint {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;

    part operationalViewpoint : Viewpoint {
        attribute :>> id = "VP-OPS";
        attribute :>> name = "OperationalViewpoint";
        attribute :>> title = "Operational & Use-Case Viewpoint";
        attribute :>> shortDescription = "Shows actors, use contexts, operational scenarios, and system capabilities.";
        attribute :>> longDescription = "Default viewpoint derived from the context, operational, and system layers for how actors use the device — operational scenarios, capabilities, and the functional chains that realize them.";
        attribute :>> purpose = "Communicate how actors interact with the system and which capabilities they invoke.";
        attribute :>> audience = (AudienceKind::projectLead, AudienceKind::systemArchitect);
        attribute :>> stage = WorkflowStageKind::context;
        attribute :>> abstractionLevel = "operational";
        attribute :>> outputKind = (ViewOutputKind::diagram);
        attribute :>> presentationKind = (PresentationKind::custom);
        attribute :>> concernKinds = (ConcernKind::performance, ConcernKind::interoperability);
        attribute :>> includedLayers = ("context", "operational", "system");
        attribute :>> allowedElementKinds = ("Actor", "UseContext", "OperationalActivity", "OperationalScenario", "SystemCapability", "FunctionalChain");
        attribute :>> methodologyReference = ("default-layer-viewpoint");
        attribute :>> userExtensible = true;
    }
}
