package memo_examples_software_only_medical_device_viewpoints_logical_views_software_only_medical_device_overview {
    private import memo::*;
    private import memo_examples_software_only_medical_device::*;

    view softwareOnlyMedicalDeviceOverview : MemoDiagramView {
        expose memo_examples_software_only_medical_device::*;
        attribute depth = 2;
        attribute :>> viewKind = DiagramViewKind::general;
        attribute :>> diagramType = "bdd";
        ref :>> viewpointDefinition = logicalArchitectureViewpoint;
    }
}
