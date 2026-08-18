package memo_examples_gpca_pump_viewpoints_logical_views_document_architecture_description_view {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_logical_logical_viewpoint::*;
    private import memo_viewpoints_software_software_viewpoint::*;
    private import memo_viewpoints_physical_physical_viewpoint::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    view architectureDescriptionView : MemoDocumentView {
        expose memo_examples_gpca_pump_viewpoints_logical_views_document_architecture_description_view::*;
        @MemoIdentity { :>> providedId = "DOC-005"; }
        attribute :>> name = "ArchitectureDescriptionView";
        @MemoIdentity { :>> shortDescription = "ISO/IEC/IEEE 42010 architecture description across all layers."; }
        attribute :>> description = "Aggregates context, operational, functional, logical, software, and physical layers with their views and correspondences for the system architecture description.";
        attribute :>> version = "0.1";
        attribute :>> lifecycleState = LifecycleStateKind::development;
        attribute :>> viewKind = DocumentViewKind::architectureDescription;
        attribute :>> generationRule = "Include all architecture layers, functional chains, interfaces, and the physical BOM with cross-layer allocations";
        attribute :>> marketScope = "generic";
        ref vpLogicalArchitecture :> viewpointDefinition = logicalArchitectureViewpoint;
        ref vpSoftware :> viewpointDefinition = softwareViewpoint;
        ref vpPhysical :> viewpointDefinition = physicalViewpoint;
        part :>> selectionQuery {
            @MemoIdentity { :>> providedId = "QRY-DOC-005"; }
            attribute :>> name = "architectureDescriptionViewQuery";
            attribute :>> includeElementKinds = ("LogicalComponent", "SystemFunction", "ComponentExchange", "SoftwareSystem", "SoftwareModule", "HardwareAssembly", "ProcessingNode", "PhysicalPort", "FunctionalFlow", "FunctionalFlowStep");
            attribute :>> includeRelationshipKinds = ("Composes", "AllocatedTo", "Realizes", "BindsToInterface", "Performs", "Succession", "DeploysTo", "HostedBy");
            attribute :>> rationaleText = "Declares what this document-backed view renders; the web renderer is presentation-only.";
        }
    }
}
