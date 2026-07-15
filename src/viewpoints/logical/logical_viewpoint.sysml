package memo_viewpoints_logical_logical_viewpoint {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;

    part logicalArchitectureViewpoint : Viewpoint {
        attribute :>> id = "VP-LOG";
        attribute :>> name = "LogicalArchitectureViewpoint";
        attribute :>> title = "Logical Viewpoint";
        attribute :>> shortDescription = "Shows logical decomposition and interfaces.";
        attribute :>> longDescription = "Default viewpoint derived from the logical architecture layer for subsystem structure, responsibilities, and major interactions, independent of physical realization.";
        attribute :>> purpose = "Describe the system's logical decomposition.";
        attribute :>> audience = (AudienceKind::systemArchitect);
        attribute :>> stage = WorkflowStageKind::architecture;
        attribute :>> abstractionLevel = "logical";
        attribute :>> outputKind = (ViewOutputKind::diagram);
        attribute :>> presentationKind = (PresentationKind::blockDiagram);
        attribute :>> concernKinds = (ConcernKind::safety, ConcernKind::performance);
        attribute :>> includedLayers = ("logical_structure", "interfaces");
        attribute :>> allowedElementKinds = ("LogicalComponent", "Interface");
        attribute :>> methodologyReference = ("default-layer-viewpoint");
        attribute :>> userExtensible = true;
    }
}
