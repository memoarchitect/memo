package memo_examples_gpca_pump_model_views_logical_device_interconnect_view {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_context_context_viewpoint::*;
    private import memo_viewpoints_operational_operational_viewpoint::*;
    private import memo_viewpoints_functional_functional_viewpoint::*;
    private import memo_viewpoints_logical_logical_viewpoint::*;
    private import memo_viewpoints_software_software_viewpoint::*;
    private import memo_viewpoints_physical_physical_viewpoint::*;
    private import memo_viewpoints_requirements_requirements_viewpoint::*;
    private import memo_viewpoints_risk_risk_viewpoint::*;
    private import memo_viewpoints_verification_verification_viewpoint::*;
    private import memo_viewpoints_cybersecurity_cybersecurity_viewpoint::*;
    private import memo_viewpoints_cybersecurity_threat_model_view::*;
    private import memo_viewpoints_cybersecurity_cybersecurity_assessment_view::*;
    private import memo_core_enumerations::*;

    part gpcaDeviceInterconnectView : DiagramView {
        attribute id = "VIEW-LOG-003";
        attribute name = "GPCA_DeviceInterconnectView";
        attribute title = "GPCA Device Interconnect View";
        attribute shortDescription = "Device-level interconnection: hardware assemblies wired to the software system's boundary ports.";
        attribute longDescription = "Interconnection-kind view of the GPCA device per GPCA_Device.aadl: sensor and actuator assemblies, the GPCA software system with its seven AADL boundary ports (OP_CMD_IN, PRES_IN, PATIENT_IN, SENSOR_IN, CONST_IN, DB_IN, GPCA_SW_OUT) pinned on its boundary, the eight software subcomponents nested inside, and the ExchangesWith connection topology (device-boundary CE-001..004 plus the GPCA_SW.Impl internal connections). Rendered through the KK-3 Interconnection view template.";
        attribute outputKind = (ViewOutputKind::diagram);
        attribute presentationKind = (PresentationKind::internalDiagram);
        attribute viewKind = DiagramViewKind::interconnection;
        attribute diagramType = "ibd";
        attribute dataSourceDescription = "GPCA hardware assemblies, software system, software components, boundary ports, and the ExchangesWith/Composes topology";
        attribute autoPopulate = true;
        attribute queryDescription = "Include hardware assemblies, the software system with its components and boundary ports, and the exchange topology between them.";
        attribute documentUsage = ("SDD", "Architecture Description", "QMSR");
        part selectionQuery {
            attribute id = "QRY-LOG-003";
            attribute name = "GPCA_DeviceInterconnectQuery";
            attribute includeElementKinds = ("HardwareAssembly", "SoftwareSystem", "SoftwareComponent", "SoftwarePort");
            attribute includeRelationshipKinds = ("ExchangesWith", "Composes");
            attribute includeLayers = ("logical_structure", "software_structure", "interfaces");
            attribute selectionExpression = "product == 'GPCA'";
            attribute rationaleText = "Render the device interconnect: parts with boundary ports as nodes, AADL connections as typed connectors, composition as nesting.";
        }
        part :>> viewpointDefinition = logicalArchitectureViewpoint;
    }
}
