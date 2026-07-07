package memo {
    package viewpoints {
        package context {
            private import memo::viewpoints::definitions::*;
            private import memo::core::enumerations::*;

            part contextViewpoint : Viewpoint {
                attribute id = "VP-CTX";
                attribute name = "ContextViewpoint";
                attribute title = "System Context Viewpoint";
                attribute shortDescription = "Shows actors, use context, and system boundary.";
                attribute longDescription = "Default viewpoint derived from the context layer to communicate who interacts with the device, under which use conditions, and where trust or safety boundaries exist.";
                attribute purpose = "Communicate operational context and boundaries.";
                attribute audience = {AudienceKind::systemArchitect};
                attribute stage = WorkflowStageKind::context;
                attribute abstractionLevel = "system";
                attribute outputKind = {ViewOutputKind::diagram};
                attribute presentationKind = {PresentationKind::blockDiagram};
                attribute concern = {ConcernKind::safety, ConcernKind::interoperability};
                attribute includedLayers = {"context"};
                attribute allowedElementKinds = {"Actor", "UseContext", "IntendedUse", "OperationalEntity", "TrustBoundary", "LogicalComponent"};
                attribute methodologyReference = {"default-layer-viewpoint"};
                attribute userExtensible = true;
            }
        }
    }
}
