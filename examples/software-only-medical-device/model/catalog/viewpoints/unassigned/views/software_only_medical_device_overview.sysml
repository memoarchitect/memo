package memo_examples_software_only_medical_device_viewpoints_unassigned_views_software_only_medical_device_overview {
    private import memo_examples_software_only_medical_device::*;
    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;

    view softwareOnlyMedicalDeviceOverview : MemoDiagramView {
        expose memo_examples_software_only_medical_device::*;
        attribute depth = 2;
        attribute :>> title = "Software-only Medical Device Overview";
        attribute :>> viewKind = DiagramViewKind::general;
        attribute :>> diagramType = "bdd";
    }
}
