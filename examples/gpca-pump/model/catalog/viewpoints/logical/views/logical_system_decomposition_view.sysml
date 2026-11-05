package memo_examples_gpca_pump_viewpoints_logical_views_logical_system_decomposition_view {
    private import memo::*;
    private import ScalarValues::*;


    view gpcaSystemDecompositionView : MemoDiagramView {
        expose memo_examples_gpca_pump_viewpoints_logical_views_logical_system_decomposition_view::*;
        attribute depth = 2;
        @MemoIdentity { :>> providedId = "VIEW-LOG-002"; :>> label = "GPCA_SystemDecompositionView"; :>> shortDescription = "Nested containment of the GPCA device: hardware assemblies and the software system."; }
        doc /* General-kind membership structure of the GPCA device per the AADL GPCA_Device.Impl decomposition: sensor and actuator assemblies with their subcomponents, supporting hardware, and the GPCA software system with its eight AADL subcomponents. Rendered through the KK-2 General view template in containment mode (nested blocks with expand/collapse; the tree mode shows the same hierarchy as a decomposition tree). */
        attribute :>> outputKind = (ViewOutputKind::diagram);
        attribute :>> presentationKind = (PresentationKind::blockDiagram);
        attribute :>> viewKind = DiagramViewKind::general;
        attribute :>> diagramType = "bdd";
        attribute :>> layoutHint = "containment";
        attribute :>> dataSourceDescription = "GPCA hardware assemblies, software system, and software components with their Composes hierarchy";
        attribute :>> autoPopulate = true;
        attribute :>> queryDescription = "Include hardware assemblies, the software system, and software components; the Composes topology supplies the nesting.";
        part :>> selectionQuery {
            @MemoIdentity { :>> providedId = "QRY-LOG-002"; :>> label = "GPCA_SystemDecompositionQuery"; }
            attribute :>> includeElementKinds = ("HardwareAssembly", "SoftwareSystem", "SoftwareModule");
            attribute :>> includeRelationshipKinds = ("Composes");
            attribute :>> includeLayers = ("logical_structure", "software_structure");
            attribute :>> selectionExpression = "product == 'GPCA'";
            attribute :>> rationaleText = "Populate the decomposition from the device structure; composition edges drive the containment nesting.";
        }
        ref :>> viewpointDefinition = logicalArchitectureViewpoint;
    }
}
