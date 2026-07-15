package memo_examples_gpca_pump_model_views_document_architecture_description_view {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_cybersecurity_cybersecurity_viewpoint::*;
    private import memo_viewpoints_cybersecurity_threat_model_view::*;
    private import memo_viewpoints_cybersecurity_cybersecurity_assessment_view::*;
    private import memo_viewpoints_usability_usability_engineering_view::*;
    private import memo_core_enumerations::*;

    part architectureDescriptionView : DocumentView {
        attribute :>> id = "DOC-005";
        attribute :>> name = "ArchitectureDescriptionView";
        attribute :>> title = "GPCA System Architecture Description View";
        attribute :>> shortDescription = "ISO/IEC/IEEE 42010 architecture description across all layers.";
        attribute :>> longDescription = "Aggregates context, operational, functional, logical, software, and physical layers with their views and correspondences for the system architecture description.";
        attribute :>> version = "0.1";
        attribute :>> lifecycleState = LifecycleStateKind::development;
        attribute :>> viewKind = DocumentViewKind::ArchitectureDescription;
        attribute :>> generationRule = "Include all architecture layers, functional chains, interfaces, and the physical BOM with cross-layer allocations";
        attribute :>> marketScope = "generic";
        attribute :>> documentUsage = ("Architecture Description", "DHF");
        attribute :>> sectionIdentifier = "AD";
        part :>> selectionQuery {
            attribute :>> id = "QRY-DOC-005";
            attribute :>> name = "architectureDescriptionViewQuery";
            attribute :>> includeElementKinds = ("LogicalComponent", "LogicalFunction", "ComponentExchange", "SoftwareSystem", "SoftwareComponent", "HardwareAssembly", "ProcessingNode", "PhysicalPort", "FunctionalChain", "FunctionalChainStep");
            attribute :>> includeRelationshipKinds = ("Composes", "AllocatedTo", "AllocatesExchange", "RealizesInterface", "BindsToInterface", "InvolvesFunction", "SequencesStep", "DeploysOnto", "HostedBy");
            attribute :>> rationaleText = "Declares what this document-backed view renders; the web renderer is presentation-only.";
        }
    }
}
