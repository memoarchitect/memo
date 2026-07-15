package memo_viewpoints_usability_usability_viewpoint {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;

    part usabilityViewpoint : Viewpoint {
        attribute id = "VP-USE";
        attribute name = "UsabilityViewpoint";
        attribute title = "Usability Viewpoint";
        attribute shortDescription = "Shows use contexts, actors, use errors, and usability requirements.";
        attribute longDescription = "Default viewpoint derived from the context and requirements layers for IEC 62366-1 usability engineering — actors, use contexts, identified use errors, and requirements tagged with the usability concern. Reuses existing context-layer elements (Actor, UseContext, UseError) rather than a separate usability layer.";
        attribute purpose = "Communicate use-related hazards and usability requirements for the device.";
        attribute audience = (AudienceKind::usabilityEngineer, AudienceKind::safetyEngineer);
        attribute stage = WorkflowStageKind::requirements;
        attribute abstractionLevel = "usability";
        attribute outputKind = (ViewOutputKind::documentSection);
        attribute presentationKind = (PresentationKind::narrativeSection);
        attribute concernKinds = (ConcernKind::usability, ConcernKind::safety);
        attribute includedLayers = ("context", "requirements");
        attribute allowedElementKinds = ("Actor", "UseContext", "UseError", "Requirement");
        attribute methodologyReference = ("default-layer-viewpoint");
        attribute userExtensible = true;
    }
}
