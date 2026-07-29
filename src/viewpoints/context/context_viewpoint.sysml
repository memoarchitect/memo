package memo_viewpoints_context_context_viewpoint {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;

    part contextViewpoint : Viewpoint {
        attribute :>> id = "VP-CTX";
        attribute :>> name = "ContextViewpoint";
        attribute :>> title = "System Context Viewpoint";
        attribute :>> shortDescription = "Shows actors, use context, and system boundary.";
        attribute :>> longDescription = "Default viewpoint derived from the context layer to communicate who interacts with the device, under which use conditions, and where trust or safety boundaries exist.";
        attribute :>> purpose = "Communicate operational context and boundaries.";
        attribute :>> audience = (AudienceKind::systemArchitect);
        attribute :>> stage = WorkflowStageKind::context;
        attribute :>> abstractionLevel = "system";
        attribute :>> outputKind = (ViewOutputKind::diagram);
        attribute :>> presentationKind = (PresentationKind::blockDiagram);
        attribute :>> concernKinds = (ConcernKind::safety, ConcernKind::interoperability);
        attribute :>> includedLayers = ("context");
        // UseEnvironment (IEC 62366-1 3.20) is what the device sits inside —
        // facility, procedure area, ambient conditions. A context view that
        // cannot show it is missing half of "where is this used".
        attribute :>> allowedElementKinds = ("Actor", "UseContext", "UseEnvironment", "IntendedUse", "ReasonablyForeseeableMisuse", "OperationalEntity", "TrustBoundary", "LogicalComponent");
        // InteractsInContext is the context relation: a context view draws it
        // and nothing else, so general-purpose model edges cannot leak into the
        // boundary picture. Projects derive their own verbs from it and are
        // picked up through the specialization closure. The three older
        // relations remain for models authored before it existed.
        attribute :>> allowedRelationshipKinds = ("InteractsInContext", "InteractsWith", "ExchangesWith", "ConnectsPhysically");
        attribute :>> userExtensible = true;
    }
}
