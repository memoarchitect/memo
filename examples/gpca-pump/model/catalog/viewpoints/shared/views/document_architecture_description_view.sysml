package memo_examples_gpca_pump_viewpoints_shared_views_document_architecture_description_view {
    private import memo::*;
    private import ScalarValues::*;


    view architectureDescriptionView : MemoDocumentView {
        expose memo_examples_gpca_pump_viewpoints_shared_views_document_architecture_description_view::*;
        @MemoIdentity { :>> providedId = "DOC-005"; :>> label = "Architecture description view"; :>> shortDescription = "ISO/IEC/IEEE 42010 architecture description across all layers."; }
        doc /* Aggregates context, operational, functional, logical, software, and physical layers with their views and correspondences for the system architecture description. */
        attribute :>> version = "0.1.0";
        attribute :>> lifecycleState = LifecycleStateKind::development;
        attribute :>> viewKind = DocumentViewKind::architectureDescription;
        attribute :>> generationRule = "Include all architecture layers, functional chains, interfaces, and the physical BOM with cross-layer allocations";
        attribute :>> marketScope = "generic";
        ref vpLogicalArchitecture :> viewpointDefinition = logicalArchitectureViewpoint;
        ref vpSoftware :> viewpointDefinition = softwareViewpoint;
        ref vpPhysical :> viewpointDefinition = physicalViewpoint;
        part :>> selectionQuery {
            @MemoIdentity { :>> providedId = "QRY-DOC-005"; :>> label = "Architecture description view query"; }
            attribute :>> includeElementKinds = ("LogicalComponent", "SystemFunction", "ComponentExchange", "SoftwareSystem", "SoftwareModule", "HardwareAssembly", "ProcessingNode", "PhysicalPort", "FunctionalFlow");
            attribute :>> includeRelationshipKinds = ("Composes", "AllocatedTo", "Realizes", "BindsToInterface", "Performs", "Succession", "DeploysTo", "HostedBy");
            attribute :>> rationaleText = "Declares what this document-backed view renders; the web renderer is presentation-only.";
        }
    }
}
